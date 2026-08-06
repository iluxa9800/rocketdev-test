
# RocketDev Test

Тестовое задание с использованием Docker Compose.

## Стек

- Docker Compose
- Nginx
- WordPress
- MySQL
- Prometheus
- Node Exporter
- Grafana

## Запуск

bash

docker compose up -d

## Доступ

| Сервис   | Адрес |

| WordPress| http://site.local |
| Grafana  | http://metrics.local |

## Мониторинг

Grafana подключена к Prometheus через provisioning.

Используется Node Exporter для сбора системных метрик.

## HTTPS

Для тестового задания используется самоподписанный SSL-сертификат.


\## Возможные проблемы
Если возникает ошибка:

permission denied while trying to connect to the docker.sock

Добавьте пользователя в группу docker:
sudo usermod -aG docker <username>

После этого переподключитесь к системе.
