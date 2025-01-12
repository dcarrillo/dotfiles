from contextlib import closing

from typing import Dict, List, Optional

from prompt_toolkit.application.current import get_app
from prompt_toolkit import PromptSession
from prompt_toolkit.completion import WordCompleter

import secretstorage

from kitty.boss import Boss

#
# To add passwords to the Secret Service that can be retrieved for this kitten:
#    secret-tool store --label user1 description "Kitty password" id $(uuidgen)
#    secret-tool store --label user2 description "Kitty password" id $(uuidgen)
# Add map to kitty.conf:
#    map ctrl+alt+p      kitten secrets.py "description" "Kitty password"

def main(args: List[str]) -> Optional[str]:
    secrets = get_secret_names(args[1], args[2])
    entries = WordCompleter(list(secrets.keys()))
    session = PromptSession(completer=entries)
    try:
        entry = session.prompt('> ', pre_run=expand_prompt)
    except (KeyboardInterrupt, EOFError):
        pass
    else:
        return secrets[entry]

    return None


def expand_prompt() -> None:
    app = get_app()
    buffer = app.current_buffer
    if buffer.complete_state:
        buffer.complete_next()
    else:
        buffer.start_completion(select_first=True)


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


def handle_result(_: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    window = boss.window_id_map.get(target_window_id)
    if window is not None:
        window.paste(answer)
