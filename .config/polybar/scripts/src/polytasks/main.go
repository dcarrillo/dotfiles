package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
	"time"

	"github.com/godbus/dbus/v5"
)

var iconMap = map[string]string{
	"brave-browser":        "",
	"chromium":             "",
	"code":                 "",
	"firefox":              "",
	"glrnvim":              "",
	"keepassxc":            "",
	"info":                 "",
	"kitty":                "",
	"nuclear":              "󰋋",
	"nvim":                 "",
	"org.gnome.calculator": "",
	"org.gnome.calendar":   "",
	"org.gnome.console":    "",
	"org.gnome.eog":        "",
	"org.gnome.evince":     "",
	"org.gnome.fileroller": "",
	"org.gnome.nautilus":   "",
	"org.gnome.papers":     "",
	"org.gnome.settings":   "",
	"org.telegram.desktop": "",
	"seahorse":             "",
	"slack":                "",
	"spotube":              "󰋋",
	"steam":                "",
	"thunderbird":          "",
	"vpn":                  "",
	"tor-browser":          "",
	"vivaldi-stable":       "",
}

var blacklistedClasses = map[string]bool{
	"":        true,
	"polybar": true,
}

var whatIsMyPath string

const (
	activeTextColor = "#F5A70A"
	activeLeft      = "%{F" + activeTextColor + "}"
	activeRight     = "%{F-}"
)

type WindowInfo struct {
	ID    int    `json:"id"`
	Class string `json:"class"`
}

func evalJS(conn *dbus.Conn, js string) (bool, string, error) {
	obj := conn.Object("org.gnome.Shell", "/org/gnome/Shell")

	call := obj.Call("org.gnome.Shell.Eval", 0, js)
	if call.Err != nil {
		return false, "", call.Err
	}

	var success bool
	var value string
	if err := call.Store(&success, &value); err != nil {
		return false, "", err
	}

	return success, value, nil
}

func checkUnsafeMode(conn *dbus.Conn) (bool, error) {
	js := `global.context ? global.context.unsafe_mode : false`

	success, value, err := evalJS(conn, js)
	if err != nil {
		return false, fmt.Errorf("failed to check unsafe mode: %w", err)
	}

	if success {
		var unsafeMode bool
		if err := json.Unmarshal([]byte(value), &unsafeMode); err != nil {
			return false, fmt.Errorf("failed to parse unsafe mode value: %w", err)
		}
		return unsafeMode, nil
	}

	return false, fmt.Errorf("failed to execute unsafe mode check")
}

func getWindowList(conn *dbus.Conn) ([]WindowInfo, error) {
	js := `
         global
             .get_window_actors()
             .map(a => a.meta_window)
             .map(w => ({id: w.get_id(), class: w.get_wm_class()}))
     `

	success, value, err := evalJS(conn, js)
	if err != nil {
		return nil, fmt.Errorf("failed to eval for getting window list: %w", err)
	}

	var allWindows []WindowInfo
	if success {
		if err := json.Unmarshal([]byte(value), &allWindows); err != nil {
			return nil, fmt.Errorf("failed to parse window list: %w", err)
		}
	}

	var result []WindowInfo
	for _, win := range allWindows {
		if win.Class != "" && !blacklistedClasses[strings.ToLower(win.Class)] {
			result = append(result, win)
		}
	}

	sort.Slice(result, func(i, j int) bool {
		return result[i].Class < result[j].Class
	})

	return result, nil
}

func getActiveWindow(conn *dbus.Conn) (int, error) {
	js := `global.get_window_actors().find(a => a.meta_window.has_focus())?.meta_window.get_id()`

	success, value, err := evalJS(conn, js)
	if err != nil {
		return 0, fmt.Errorf("failed to eval for getting active window: %w", err)
	}

	if success && value != "" {
		var id int
		if err := json.Unmarshal([]byte(value), &id); err != nil {
			return 0, fmt.Errorf("failed to parse active window ID: %w", err)
		}
		return id, nil
	}

	return 0, nil
}

func closeWindow(conn *dbus.Conn, windowID int) error {
	js := fmt.Sprintf(`
		const window = global.get_window_actors()
			.map(a => a.meta_window)
			.find(w => w.get_id() === %d);
		if (window) {
			window.delete(global.get_current_time());
		}
	`, windowID)

	success, _, err := evalJS(conn, js)
	if err != nil {
		return fmt.Errorf("failed to execute close window script: %w", err)
	}

	if !success {
		return fmt.Errorf("failed to close window with ID %d", windowID)
	}

	return nil
}

func focusOrMinimize(conn *dbus.Conn, windowID int) error {
	js := fmt.Sprintf(`
		const window = global.get_window_actors()
			.map(a => a.meta_window)
			.find(w => w.get_id() === %d);

		if (window) {
			if (window.has_focus()) {
				window.minimize();
			} else {
				window.activate(global.get_current_time());
			}
		}
	`, windowID)

	success, _, err := evalJS(conn, js)
	if err != nil {
		return fmt.Errorf("failed to execute raise or minimize window script: %w", err)
	}

	if !success {
		return fmt.Errorf("failed to raise or minimize window with ID %d", windowID)
	}

	return nil
}

func polyPrintWindowList(windows []WindowInfo, activeID int) {
	if len(windows) > 0 {
		fmt.Print("%{T4}Tasks: %{T-}")
	}
	for _, win := range windows {
		icon := getIcon(win.Class)
		if win.ID == activeID {
			icon = fmt.Sprintf("%s%s%s", activeLeft, icon, activeRight)
		}
		fmt.Printf(" %%{A1:%s focus_or_minimize %d:}", whatIsMyPath, win.ID)
		fmt.Printf("%%{A2:%s close %d:}", whatIsMyPath, win.ID)
		fmt.Printf("%%{T6}%s%%{T-}%%{A}%%{A}", icon)
	}
	fmt.Println()
}

func handleCLICommands(conn *dbus.Conn, args []string) error {
	if len(args) != 3 {
		return fmt.Errorf("invalid number of arguments, expected: <command> <window_id>")
	}

	command := args[1]
	windowIDStr := args[2]

	windowID, err := strconv.Atoi(windowIDStr)
	if err != nil {
		return fmt.Errorf("invalid window ID '%s': %w", windowIDStr, err)
	}

	switch command {
	case "close":
		return closeWindow(conn, windowID)
	case "focus_or_minimize":
		return focusOrMinimize(conn, windowID)
	default:
		return fmt.Errorf("unknown command '%s', supported commands: close, focus", command)
	}
}

func getIcon(class string) string {
	if icon, exists := iconMap[strings.ReplaceAll(strings.ToLower(class), " ", "-")]; exists {
		return icon
	}
	return strings.ToUpper(class[:1])
}

func main() {
	var err error
	whatIsMyPath, err = os.Executable()
	if err != nil {
		log.Fatalf("Failed to get executable path: %v", err)
	}

	conn, err := dbus.SessionBus()
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	if len(os.Args) > 1 {
		if err := handleCLICommands(conn, os.Args); err != nil {
			log.Fatal(err)
		}
		return
	}

	ticker := time.NewTicker(500 * time.Millisecond)
	defer ticker.Stop()

	var lastWindowCount int
	var lastActiveWindow int
	for range ticker.C {
		if safe, err := checkUnsafeMode(conn); err != nil || !safe {
			fmt.Println("GNOME Shell unsafe mode is not enabled.")
			continue
		}

		windows, err := getWindowList(conn)
		if err != nil {
			fmt.Println("Error getting window list:", err)
			continue
		}

		activeID, err := getActiveWindow(conn)
		if err != nil {
			fmt.Println("Error getting active window:", err)
			continue
		}

		if len(windows) != lastWindowCount || activeID != lastActiveWindow {
			polyPrintWindowList(windows, activeID)
			lastWindowCount = len(windows)
			lastActiveWindow = activeID
		}
	}
}
