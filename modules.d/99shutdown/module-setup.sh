#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    echo base
    return 0
}

# called by dracut
install() {
    local _d
    inst_multiple umount poweroff reboot halt losetup
    inst_multiple -o kexec
    inst "$moddir/shutdown.sh" "$prefix/shutdown"
    [ -e "${initdir}/lib" ] || mkdir -m 0755 -p ${initdir}/lib
    mkdir -m 0755 -p ${initdir}/lib/dracut
    mkdir -m 0755 -p ${initdir}/lib/dracut/hooks
    for _d in $hookdirs shutdown shutdown-emergency; do
        mkdir -m 0755 -p ${initdir}/lib/dracut/hooks/$_d
    done
}

