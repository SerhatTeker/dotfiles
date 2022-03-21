#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:


# Restore i3 layouts
# Usage:
# exec ~/.config/i3/restore.sh


for layout in ${HOME}/.config/i3/layouts/* ; do
    i3-msg "workspace $(basename "${layout}" .json); append_layout ${layout}"
done
