#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

docker compose --env-file .env config --quiet
docker compose --env-file .env exec -T nginx nginx -t

check_http() {
    local name="$1"
    local expected="$2"
    shift 2

    local code=""
    for attempt in {1..15}; do
        code="$(curl -ksS --max-time 5 -o /dev/null -w '%{http_code}' "$@" 2>/dev/null || true)"
        if [ "$code" = "$expected" ]; then
            echo "$name: HTTP $code — OK"
            return 0
        fi
        sleep 2
    done

    echo "$name: ожидали HTTP $expected, получили ${code:-нет ответа}" >&2
    return 1
}

check_http "WordPress" 200 \
    --resolve site.local:443:127.0.0.1 https://site.local/

check_http "Grafana" 302 \
    -H 'Host: metrics.local' http://127.0.0.1/

echo "Проверки стека пройдены"