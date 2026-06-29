# Команды для ручного выполнения — Этап 1 (Установка ОС + Защита)
# Запускать по порядку. Всё от root (sudo -i или sudo перед каждой командой)

---

## 0. Обновление системы

Перед началом любой работы — обновляем пакеты:

```bash
apt update && apt upgrade -y
```

**Преподу сказать:** Обновил систему перед настройкой — чтобы все пакеты были актуальными и не было конфликтов версий.

---

## 1. Настройка ядра (sysctl) — 2.5 балла

```bash
# бекап оригинального конфига
cp /etc/sysctl.conf /etc/sysctl.conf.backup

# добавляем параметры в конфиг
cat >> /etc/sysctl.conf << EOF

# анти-DDoS, защита от syn-флуда
net.ipv4.tcp_syncookies = 1
# защита от спуфинга
net.ipv4.conf.all.rp_filter = 1
# уменьшаем swap, чтобы система не тормозила
vm.swappiness = 10
# максимальное количество соединений
net.core.somaxconn = 65535
# лимит открытых файлов
fs.file-max = 100000
# макс PID
kernel.pid_max = 65536
EOF

# применяем без перезагрузки
sysctl -p
```

**Преподу сказать:** Настроил ядро для производительности — уменьшил swappiness, увеличил лимиты соединений и файлов. Включил syn-cookies для защиты от syn-флуда.

---

## 2. SSH — 2.0 балла

```bash
# установка SSH-сервера
apt update
apt install -y openssh-server

# запуск и добавление в автозагрузку
systemctl enable ssh --now

# проверка
systemctl status ssh --no-pager
ss -tlnp | grep :22
```

**Преподу сказать:** SSH нужен для удаленного управления сервером. Порт 22 слушается, сервис в автозагрузке.

---

## 3. Удаленный доступ к активной сессии — 2.0 балла

### Основной вариант: SSH + PuTTY
Ты уже настроил SSH в шаге 2 — порт 22 открыт, сервер запущен.
На Windows запускаешь PuTTY, вводишь IP Ubuntu, и получаешь удалённый доступ.

**Аргумент преподу:** SSH — это полноценный удалённый доступ. PuTTY подключается к активной сессии сервера, все команды выполняются на удалённой машине. Протокол шифрованный, безопасный.

**Если препод говорит: "а где графический доступ?" — переходишь к запасному варианту:**

### Запасной вариант: xrdp (RDP)

```bash
# установка xrdp (RDP-сервер)
apt install -y xrdp

# запуск
systemctl enable xrdp --now
systemctl status xrdp --no-pager

# добавляем пользователя в группу xrdp
usermod -aG xrdp $USER

# добавляем в группу ssl-cert для сертификатов
adduser xrdp ssl-cert
```

**Проверка:** Подключиться с Windows через `mstsc` к IP-адресу Ubuntu.

**Сказать преподу:** Поставил xrdp — можно зайти удалённо через RDP, будет полноценный графический рабочий стол. Удобно, когда нужно работать с интерфейсом.

---

## 4. Сетевой интерфейс — 1.0 балл

```bash
# показать все интерфейсы
ip a

# показать активный интерфейс (который смотрит в интернет)
ip route | grep default

# или старый добрый ifconfig
ifconfig -a
```

**Какой выбрать:** Тот, у которого есть IP-адрес (не lo). Обычно `eth0`, `enp0s3` или `wlp2s0`.

**Преподу сказать:** Определил активный сетевой интерфейс — (назвать какой). По дефолтному шлюзу видно, через какой интерфейс идёт интернет.

---

## 5. Проверка соединения — 2.0 балла

```bash
# ping до DNS Google
ping -c 4 8.8.8.8

# ping по доменному имени (проверка DNS)
ping -c 2 google.com

# запрос к сайту
curl -I https://ya.ru

# если надо проверить конкретный порт
curl -v telnet://google.com:80
```

**Преподу сказать:** Проверил сетевое соединение — пинг до 8.8.8.8 и google.com проходит. DNS работает. HTTP-запрос к ya.ru успешен.

---

## 6. Базовое ПО — 2.0 балла

```bash
apt install -y htop curl wget git vim nano net-tools screen tmux tree unzip p7zip-full sshfs build-essential
```

Что поставили и зачем:
| Программа | Зачем |
|-----------|-------|
| htop | мониторинг процессов |
| curl, wget | скачивание файлов |
| git | контроль версий |
| vim, nano | редактирование |
| net-tools | ifconfig, netstat |
| screen, tmux | несколько терминалов |
| tree | просмотр дерева папок |
| unzip, p7zip | архиваторы |
| build-essential | компиляция (gcc, make) |
| sshfs | монтирование удаленных папок |

---

## 7. Виртуальный принтер — 2.0 балла

```bash
# установка CUPS + PDF-принтер
apt install -y cups cups-pdf

# запуск
systemctl restart cups
systemctl enable cups --now

# проверка
lpstat -t
lpinfo -v | grep -i pdf
```

**Проверка:** `lp -d PDF file.txt` — создаст PDF в `~/PDF/`.

**Преподу сказать:** CUPS — система печати Linux. Поставил cups-pdf — виртуальный принтер, который печатает в PDF-файл. Экономит бумагу.

---

## 8. Резервное копирование — 2.0 балла

```bash
# создаем папку для бэкапов
mkdir -p /backup/system

# копия конфигов /etc
tar -czf /backup/system/etc-backup-$(date +%Y%m%d).tar.gz /etc

# копия таблицы разделов
sfdisk -d /dev/sda > /backup/system/partition-table-$(date +%Y%m%d).bak

# проверка
ls -la /backup/system/
```

**Преподу сказать:** Сделал резервную копию конфигурационных файлов (/etc) и таблицы разделов. Храню в /backup/system/.

---

## 9. Установочный образ — 1.0 балл

```bash
# создаем папку
mkdir -p /backup/image

# создаем образ диска (для демонстрации 100МБ)
dd if=/dev/zero of=/backup/image/system.img bs=1M count=100
mkfs.ext4 -F /backup/image/system.img
```

**Или** (если есть свободное место):

```bash
# клон всей системы через dd (осторожно!)
# dd if=/dev/sda of=/backup/image/ubuntu-full-backup.img bs=4M
```

**Преподу сказать:** Создал установочный образ системы (dd + mkfs). При необходимости можно восстановиться.

---

## 10. Точки восстановления (timeshift) — 2.0 балла

```bash
# установка timeshift
apt install -y timeshift

# создание снепшота
timeshift --create --comments "Первый снепшот"

# просмотр снепшотов
timeshift --list

# откат до снепшота (выбрать из списка)
sudo timeshift --restore

# или через графический интерфейс
sudo timeshift-gtk
# → Выбрать снепшот → «Restore» → OK → перезагрузка
```

**Преподу сказать:** Timeshift как "восстановление системы" в Windows. Делает снепшоты системы — если что-то сломается, можно откатиться.

---

## 11. Группы пользователей — 1.0 балл

```bash
# создаем группы
groupadd developers
groupadd admins

# добавляем текущего пользователя
usermod -aG developers $USER
usermod -aG admins $USER

# создаем тестового пользователя
useradd -m -G developers -s /bin/bash testuser
echo "testuser:testpass123" | chpasswd

# проверка
cat /etc/group | grep -E "developers|admins"
groups $USER
```

**Преподу сказать:** Создал группы developers и admins для разделения доступа. Пользователь testuser — для тестов.

---

## 12. Права доступа — 1.0 балл

```bash
# папка для разработчиков — чтение/запись
mkdir -p /srv/projects
chown root:developers /srv/projects
chmod 775 /srv/projects   # rwxrwxr-x

# папка для админов — только они
mkdir -p /srv/admin
chown root:admins /srv/admin
chmod 770 /srv/admin      # rwxrwx---

# файл с примером
touch /srv/projects/readme.md
chmod 664 /srv/projects/readme.md

# проверка
ls -la /srv/
```

**Преподу сказать:** Настроил права доступа: developers могут читать/писать в projects, admins — только админы. Обычные пользователи не видят /srv/admin.

---

## 13. Аутентификация и авторизация — 1.0 балл

```bash
# установка модуля сложности паролей
apt install -y libpam-pwquality

# настройка минимальной длины пароля
nano /etc/security/pwquality.conf
# раскомментировать и изменить:
# minlen = 8

# политика срока действия пароля
chage -M 90 $USER   # пароль каждые 90 дней
chage -W 7 $USER    # предупреждение за 7 дней
```

**Преподу сказать:** Настроил политику паролей — минимум 8 символов, смена каждые 90 дней.

---

## 14. Журнал мониторинга (auditd) — 1.0 балл

```bash
# установка auditd
apt install -y auditd audispd-plugins

# запуск
systemctl enable auditd --now
auditctl -e 1   # включить аудит

# правило: следить за изменениями passwd
auditctl -w /etc/passwd -p wa -k passwd_changes

# установка logwatch (анализ логов)
apt install -y logwatch

# проверка правил аудита
auditctl -l

# посмотреть логи
ausearch -k passwd_changes --start today
```

**Преподу сказать:** auditd отслеживает важные изменения в системе (кто менял пароли, файлы). Logwatch присылает отчеты по логам. Это базовый мониторинг безопасности.

---

## Чек-лист перед сдачей

- [ ] `sysctl -p` — настройки ядра загружены
- [ ] `systemctl status ssh` — SSH активен
- [ ] `systemctl status xrdp` — XRDP активен
- [ ] `ip a` — сетевой интерфейс показан
- [ ] `ping 8.8.8.8 -c 2` — сеть работает
- [ ] `htop` — запускается
- [ ] `lpstat -t` — принтер PDF есть
- [ ] `ls /backup/system/` — бэкап есть
- [ ] `ls /backup/image/` — образ есть
- [ ] `timeshift --list` — снепшоты есть
- [ ] `cat /etc/group | grep developers` — группы есть
- [ ] `ls -la /srv/` — права настроены
- [ ] `auditctl -l` — аудит включен
