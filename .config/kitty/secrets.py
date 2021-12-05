from contextlib import closing

from typing import Dict, List

from simple_term_menu import TerminalMenu

import secretstorage

from kitty.boss import Boss


def main(args: List[str]) -> str:
    options = get_secret_names(args[1], args[2])
    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()

    if menu_entry_index is not None:
        return list(options.values())[menu_entry_index]

    return ''


def get_secret_names(attribute: str, value: str) -> Dict[str, str]:
    secrets = {}
    with closing(secretstorage.dbus_init()) as bus:
        for keyring in secretstorage.get_all_collections(bus):
            for item in keyring.get_all_items():
                if item.is_locked():
                    item.unlock()
                attr = item.get_attributes()
                if attr.get(attribute) == value:
                    secrets[item.get_label()] = item.get_secret().decode('utf-8')

    return secrets


def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    window = boss.window_id_map.get(target_window_id)
    if window is not None:
        window.paste(answer)
