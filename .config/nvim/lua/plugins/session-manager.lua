local status_ok, session_manager = pcall(require, "session_manager")
if not status_ok then
	return
end

session_manager.setup({
	autosave_only_in_session = false,
})
