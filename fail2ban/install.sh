#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "Запустите скрипт через sudo" >&2
    exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source_file="$script_dir/jail.local"
target_file="/etc/fail2ban/jail.d/rocketdev-sshd.local"

if ! command -v fail2ban-client >/dev/null 2>&1; then
    apt-get update
    apt-get install -y fail2ban
fi

if ! cmp -s "$source_file" "$target_file"; then
    install -D -m 0644 "$source_file" "$target_file"
    config_changed=1
else
    config_changed=0
fi

systemctl enable --now fail2ban

if [ "$config_changed" -eq 1 ]; then
    systemctl restart fail2ban
fi

for attempt in {1..10}; do
    if fail2ban-client ping >/dev/null 2>&1; then
        fail2ban-client status sshd
        exit 0
    fi
    sleep 1
done

echo "Fail2ban не стал готов за 10 секунд" >&2
exit 1