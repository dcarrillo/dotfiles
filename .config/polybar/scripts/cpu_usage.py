#!/usr/bin/env python3

import os
import subprocess

colors = {
    'us': '#FDD835',  # us, user    : time running un-niced user processes
    'sy': '#23A8F1',  # sy, system  : time running kernel processes
    'ni': '#FFFFFF',  # ni, nice    : time running niced user processes
    'wa': '#E53935',  # wa, IO-wait : time waiting for I/O completion
    'hi': '#66CDAA',  # hi : time spent servicing hardware interrupts
    'si': '#7FFFD4',  # si : time spent servicing software interrupts
    'st': '#7B2B4E',  # st : time stolen from this vm by the hypervisor
    'id': '#555555'
}


def show_cpu_usage():
    new_env = dict(os.environ)
    new_env['LANG'] = 'en_US.UTF-8'  # ensure that the decimal separator is a point
    top = subprocess.run(["top", "-bn1"], capture_output=True, env=new_env)

    raw_cpu_usages = top.stdout.decode("utf-8").split('\n')[2]
    cpu_usage = str.replace(raw_cpu_usages, '%Cpu(s):', '')

    bar = ''
    global_count = 0
    for usage in cpu_usage.split(','):
        values = str.lstrip(usage).split(' ')
        count = round(float(values[0]) / 10)
        if count > 0 and values[1] != 'id':
            global_count += count
            bar += '%{F' + colors[values[1]] + '}' + '_' * count + '%{F-}'

    padding = ''
    if global_count < 10:
        padding = '%{F' + colors['id'] + '}' + '_' * (10 - global_count) + '%{F-}'

    print("%{A1:$TERMINAL_CMD btop &:}%{T5}" + bar + padding + "%{T-}%{A}")


if __name__ == "__main__":
    show_cpu_usage()
