+++
categories = ["ubuntu", "systemd"]
date = "2015-06-27T11:40:15+03:00"
description = "Переход на systemd в Ubuntu 15.04 произошёл практически безболезненно, но это всё же не вся правда, через некоторое время я обнаружил что у меня не подрубается обратно WiFi когда ноут выходит из режима сна, без перезагрузки сервиса network-manager. Как пофиксить?"
keywords = ["Ubuntu", "15.04", "systemd", "network-manager", "wifi"]
title = "Fix искалеченного systemd-ом WiFi после suspend-а в Ubuntu 15.04"

+++
У меня такое ощущение что команда знала об этой проблеме до выпуска дистра, и тупо проигнорила её, так как не нашла правильного способа пофиксить этот баг. Пытаясь найти первопричину, порывшись в форумах, смутно пришло осознание, что это косяк на уровне интеграции systemd и network-manager-а и если систему откатить на использование upstart-а, всё работало отлично. Однако, я просто делал:
``` bash
sudo service network-manager restart
```
каждый раз после открытия крышки ноутбука, пока это меня просто не достало. Правильного фикса на момент написания этой заметки не было, только workaround. Так как проблема порождается systemd то workaround-ить мы будем для него и им же, за одно освоим практику написания простеньких сервисов для systemd, авось где-то пригодится. Решение было предложено где-то в бескрайних пустошах форумных-комьюнити. Идея простая, вырубать сеть или только устройство вайфай и врубать его и сразу врубать, делать это по хуку. Итак, пишем простой сервис для systemd:
``` bash
sudo vim /etc/systemd/system/wififix.service
```
Пихаем туда вот это содержимое:
``` ini
[Unit]
Description=Fix Wifi after suspend
After=suspend.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nmcli d disconnect wlan0 ; /usr/bin/nmcli d connect wlan0

[Install]
WantedBy=suspend.target
```
Объяснять, здесь, практически нечего, всё и так понятно. Далее активируем данный сервис:
``` bash
sudo systemctl enable wififix.service
```
Перезагружать компьютер не требуется. Можно сразу пробовать, или прежде проверить статус:
``` bash
sudo systemctl status wififix.service
```
Надеюсь это вам помогло, как и мне.