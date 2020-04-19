#!/bin/bash
#set -x

PATH="/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin"
TERM="vt100"
export TERM PATH

base_dir="$(dirname $(realpath -L "${0}"))"
target_dir="/var/www/html/blocklist"

ipfilter_script="${base_dir}/ipfilter.sh"
ipfilter_file=$(echo "${ipfilter_script}" | sed -e 's|\.sh$|\.p2p|g')

if [ -x "${ipfilter_script}" ]; then
    ${ipfilter_script} > /dev/null 2>&1

    if [ -s "${ipfilter_file}" ]; then
        gzip "${ipfilter_file}"                  > /dev/null 2>&1
        mv "${ipfilter_file}.gz" "${target_dir}" > /dev/null 2>&1
    fi

fi

