
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
1. Создайте самоподписанный сертификат или поместите свои сертификаты в каталог certs/

   openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
     -keyout certs/site.local.key \
     -out certs/site.local.crt \
     -subj "/CN=site.local" \
     -addext "subjectAltName=DNS:site.local"

   chmod 600 certs/site.local.key

2. Создайте локальный .env по образцу .env.example и замените заглушки своими паролями.

3. Проверьте Compose и запустите сервисы:
docker compose config --quiet
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
- Для настройки защиты SSH на Ubuntu запустите из корня проекта:

```bash
sudo bash fail2ban/install.sh
sudo fail2ban-client status sshd

```
После запуска контейнеров выполните проверку: `bash scripts/check.sh`.

## Трудозатраты

Тестовое задание было выполнено примерно за 28 часов
