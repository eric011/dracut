#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

check() {
    arch=$(uname -m)
    [ "$arch" = "s390" -o "$arch" = "s390x" ] || return 1
    return 0
}

depends() {
    return 0
}

installkernel() {
    instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
}

install() {
    inst_hook cmdline 30 "$moddir/parse-dasd.sh"
    dracut_install tr dasdinfo dasdconf.sh
    if [[ $hostonly ]]; then
        inst /etc/dasd.conf
    fi
    inst_rules 56-dasd.rules
    inst_rules 59-dasd.rules
}
