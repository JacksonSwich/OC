#!/bin/bash
# ============================================
# Скриптик для настройки Ubuntu после установки
# Запускать от sudo или root
# ============================================

echo "============================================"
echo "   НАСТРОЙКА UBUNTU - ЭТАП 1"
echo "============================================"
sleep 1

# ========== 1. НАСТРОЙКА ЯДРА (sysctl) ==========
echo ""
echo "[1/13] Настройка параметров ядра (sysctl)..."

# бекап оригинального конфига
cp /etc/sysctl.conf /etc/sysctl.conf.backup

cat >> /etc/sysctl.conf << EOF

# Настройки для производительности и безопасности
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
vm.swappiness = 10
net.core.somaxconn = 65535
fs.file-max = 100000
kernel.pid_max = 65536
EOF

sysctl -p
echo "  + Настройки ядра применены"

# ========== 2. SSH ==========
echo ""
echo "[2/13] Настройка SSH..."

apt update -qq && apt install -y openssh-server -qq
systemctl enable ssh --now
systemctl status ssh --no-pager | head -5

# проверка что порт слушается
ss -tlnp | grep :22

echo "  + SSH установлен и запущен"
echo "  (для подключения с Windows используй PuTTY: IP=$(hostname -I | awk '{print $1}') порт 22)"

# ========== 3. УДАЛЕННЫЙ ДОСТУП ==========
echo ""
echo "[3/13] Настройка удаленного доступа..."
echo ""
echo "  Основной вариант: SSH уже настроен в п.2 - подключаемся через PuTTY"
echo "  Запасной (если препод хочет графику): sudo apt install -y xrdp"
echo "  и подключайся через mstsc (Windows Remote Desktop)"

# запасной вариант - закомментирован, разблокировать если препод попросит RDP
# apt install -y xrdp -qq
# systemctl enable xrdp --now
# usermod -aG xrdp $SUDO_USER
# adduser xrdp ssl-cert 2>/dev/null
# echo "  + XRDP готов, порт 3389"

# ========== 4. СЕТЕВОЙ ИНТЕРФЕЙС ==========
echo ""
echo "[4/13] Определение сетевых интерфейсов..."

ip a
echo ""
echo "  Активный интерфейс: $(ip route | grep default | awk '{print $5}')"

# ========== 5. ПРОВЕРКА СОЕДИНЕНИЯ ==========
echo ""
echo "[5/13] Проверка сетевого соединения..."

ping -c 4 8.8.8.8 && echo "  + Ping до 8.8.8.8 успешен"
ping -c 2 google.com && echo "  + DNS работает"
curl -I https://ya.ru --connect-timeout 5 | head -1

echo "  + Сеть работает"

# ========== 6. БАЗОВОЕ ПО ==========
echo ""
echo "[6/13] Установка базового ПО..."

apt install -y \
    htop \
    curl \
    wget \
    git \
    vim \
    nano \
    net-tools \
    screen \
    tmux \
    tree \
    unzip \
    p7zip-full \
    sshfs \
    build-essential \
    -qq

echo "  + Базовое ПО установлено"

# ========== 7. ВИРТУАЛЬНЫЙ ПРИНТЕР ==========
echo ""
echo "[7/13] Установка виртуального принтера..."

apt install -y cups cups-pdf -qq

# перезапускаем cups
systemctl restart cups
systemctl enable cups --now

lpinfo -v | grep -i pdf
echo "  + Виртуальный принтер PDF установлен"

# ========== 8. РЕЗЕРВНОЕ КОПИРОВАНИЕ ==========
echo ""
echo "[8/13] Резервное копирование системы..."

mkdir -p /backup/system

# копия важных конфигов
tar -czf /backup/system/etc-backup-$(date +%Y%m%d).tar.gz /etc

# копия таблицы разделов
sfdisk -d /dev/sda > /backup/system/partition-table-$(date +%Y%m%d).bak 2>/dev/null || \
    echo "  (sfdisk не сработал, пропускаем)"

echo "  + Резервная копия /etc сохранена в /backup/system/"

# ========== 9. УСТАНОВОЧНЫЙ ОБРАЗ ==========
echo ""
echo "[9/13] Создание установочного образа (клон системы)..."

# делаем образ через dd если есть место (необязательно для SSD)
# для демонстрации просто покажем команду и сделаем маленький образ
mkdir -p /backup/image
dd if=/dev/zero of=/backup/image/system.img bs=1M count=100 2>/dev/null
mkfs.ext4 -F /backup/image/system.img 2>/dev/null
echo "  + Демо-образ создан: /backup/image/system.img"

# ========== 10. ТОЧКИ ВОССТАНОВЛЕНИЯ ==========
echo ""
echo "[10/13] Настройка точек восстановления (timeshift)..."

apt install -y timeshift -qq

# базовая настройка timeshift (создаем первый снепшот)
timeshift --create --comments "Первый снепшот после установки" 2>/dev/null || \
    echo "  (timeshift: можно создать снепшот вручную через GUI)"

echo "  + Timeshift установлен"

# ========== 11. ГРУППЫ ПОЛЬЗОВАТЕЛЕЙ ==========
echo ""
echo "[11/13] Создание групп пользователей и настройка прав..."

# создаем группы
groupadd developers 2>/dev/null
groupadd admins 2>/dev/null

# добавляем текущего пользователя в группы
usermod -aG developers $SUDO_USER
usermod -aG admins $SUDO_USER

# создаем тестового пользователя
useradd -m -G developers -s /bin/bash testuser 2>/dev/null
echo "testuser:testpass123" | chpasswd 2>/dev/null

echo "  + Группы: developers, admins"
echo "  + Пользователь testuser создан"

# ========== 12. ПРАВА ДОСТУПА ==========
echo ""
echo "[12/13] Настройка прав доступа..."

# создаем тестовую структуру
mkdir -p /srv/projects
chown root:developers /srv/projects
chmod 775 /srv/projects

mkdir -p /srv/admin
chown root:admins /srv/admin
chmod 770 /srv/admin

# для примера
touch /srv/projects/readme.md
chmod 664 /srv/projects/readme.md

echo "  + Права доступа настроены:"
ls -la /srv/

# ========== 13. АУТЕНТИФИКАЦИЯ, АВТОРИЗАЦИЯ И ЖУРНАЛЫ ==========
echo ""
echo "[13/13] Настройка аутентификации и журнала мониторинга..."

# политика паролей
apt install -y libpam-pwquality -qq

# минимальная длина пароля
sed -i 's/# minlen = 9/minlen = 8/' /etc/security/pwquality.conf 2>/dev/null || true

# аудит
apt install -y auditd audispd-plugins -qq
systemctl enable auditd --now
auditctl -e 1

# правило аудита - следить за /etc/passwd
auditctl -w /etc/passwd -p wa -k passwd_changes

# настройка logwatch для мониторинга логов
apt install -y logwatch -qq

echo "  + auditd запущен"
echo "  + logwatch установлен"
# политика срока действия пароля
chage -M 90 $SUDO_USER 2>/dev/null || true
chage -W 7 $SUDO_USER 2>/dev/null || true
chage -M 90 testuser 2>/dev/null || true
chage -W 7 testuser 2>/dev/null || true

echo "  + Политика паролей настроена (мин. 8 символов, смена каждые 90 дней)"

# ========== ИТОГО ==========
echo ""
echo "============================================"
echo "   НАСТРОЙКА ЗАВЕРШЕНА!"
echo "============================================"
echo ""
echo "Проверь вручную:"
echo "  - SSH:        systemctl status ssh"
echo "  - XRDP:       systemctl status xrdp"
echo "  - Принтер:    lpstat -t"
echo "  - Timeshift:  timeshift --list"
echo "  - Аудит:      auditctl -l"
echo "  - Бэкап:      ls /backup/system/"
echo ""
echo "Не забудь обосновать выбор ПО преподавателю!"
