#!/usr/bin/env python3

import dbus

bus_name = 'org.mpris.MediaPlayer2.spotify'


def get_spotify_song():
    output = ''

    try:
        session_bus = dbus.SessionBus()
        spotify_bus = session_bus.get_object(bus_name, '/org/mpris/MediaPlayer2')
        spotify_properties = dbus.Interface(spotify_bus, 'org.freedesktop.DBus.Properties')
        metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

        artist = metadata['xesam:artist'][0]
        title = metadata['xesam:title']

        window_title = artist + ' - ' + title

        output = "%{A1:$WM_CONTROL '" + window_title + "' &:}" + window_title + "%{A}"
    except dbus.DBusException as e:
        if (e.get_dbus_message() == f'The name {bus_name} was not provided by any .service files'):
            pass
        else:
            output = e.get_dbus_message()
    except Exception as e:
        output = str(e)

    print(output)


if __name__ == "__main__":
    get_spotify_song()
