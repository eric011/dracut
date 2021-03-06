#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

# called by dracut
check() {
    local _init
    [[ $mount_needs ]] && return 1
    _init=$(readlink -f /sbin/init)
    [[ "$_init" == "${_init##/usr}" ]] && return 255
    return 0
}

# called by dracut
depends() {
    echo 'fs-lib'
}

# called by dracut
install() {
    if ! dracut_module_included "systemd"; then
        inst_hook pre-pivot 50 "$moddir/mount-usr.sh"
    fi
    :
}

