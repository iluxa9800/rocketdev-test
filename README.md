
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
- Fail2Ban

## Запуск

Перед запуском создайте самоподписанный сертификат или поместите свои сертификаты в каталог certs/

bash

docker compose up -d

## Доступ


 Сервис    Адрес 

 WordPress https://site.local 
 Grafana   http://metrics.local 


## Мониторинг

Используется Node Exporter для сбора системных метрик

Grafana автоматически подключается к Prometheus через provisioning

## Принятые решения

- Использован Docker Compose для развёртывания сервисов.
- Для `site.local` настроен HTTPS с самоподписанным сертификатом.
- Доступ к `/wp-admin` и `/wp-login.php` ограничен по списку разрешённых IP.
- Для защиты SSH настроен Fail2Ban.



## Трудозатраты

Тестовое задание было выполнено примерно за 28 часов
