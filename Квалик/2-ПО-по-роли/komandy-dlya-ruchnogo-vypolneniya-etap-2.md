# Команды для ручного выполнения — Этап 2 (Установка ПО по роли)
# Сортировка: от самых популярных (по количеству билетов) к нишевым
# Запускать от root: sudo -i или sudo перед каждой командой

> **Легенда:** 🔥 — топ популярности (нужен почти всем), 📌 — под конкретную роль

---

## 🔥 УЛЬТРА-ПОПУЛЯРНЫЕ (нужны во всех/почти всех билетах)

Эти программы ставь в первую очередь — они потребуются в любом сценарии.

```bash
# Git — система контроля версий (нужен во всех 29 билетах)
apt install -y git
git config --global user.name "Student"
git config --global user.email "student@example.com"
git config --global init.defaultBranch main

# curl + wget — скачивание файлов (все билеты)
apt install -y curl wget

# htop — мониторинг процессов (все билеты)
apt install -y htop

# vim + nano — текстовые редакторы (все билеты)
apt install -y vim nano

# p7zip-full — архиватор 7-Zip (все билеты)
apt install -y p7zip-full

# tree — дерево папок (все билеты)
apt install -y tree

# net-tools — ifconfig, netstat (все билеты)
apt install -y net-tools

# screen + tmux — мультиплексирование терминала (все билеты)
apt install -y screen tmux

# CUPS + cups-pdf — виртуальный PDF-принтер (все билеты)
apt install -y cups cups-pdf
systemctl enable cups --now

# Timeshift — точки восстановления системы (все билеты)
apt install -y timeshift

# hardinfo — аналог CPU-Z (все билеты)
apt install -y hardinfo

# lm-sensors + psensor — мониторинг температуры (все билеты)
apt install -y lm-sensors psensor

# LibreOffice — офисный пакет для документации (все билеты)
apt install -y libreoffice
```

**Преподу сказать:** Это база — без неё никуда. Git для версионирования, htop для мониторинга, CUPS для печати PDF, Timeshift для точек восстановления, LibreOffice для оформления документации по ГОСТ.

---

## 📦 1. IDE И РЕДАКТОРЫ КОДА

### 🔥 VS Code (19 билетов)
#1/#2/#4/#6/#7/#8/#10/#11/#14/#16/#17/#19/#20/#21/#22/#24/#25/#26/#28

```bash
wget -qO /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
dpkg -i /tmp/code.deb 2>/dev/null
apt install -f -y -qq
```

### PyCharm Community (8 билетов)
#1/#7/#14/#20/#21/#24/#26/#28
```bash
snap install pycharm-community --classic
```

### Eclipse IDE (6 билетов)
#4/#5/#10/#11/#27/#29
```bash
apt install -y eclipse 2>/dev/null || snap install eclipse --classic
```

### IntelliJ IDEA (4 билета)
#5/#18/#27/#29
```bash
snap install intellij-idea-community --classic
```

### CLion (4 билета)
#3/#19/#20/#25
```bash
snap install clion --classic
```

### WebStorm (3 билета)
#1/#6/#8
```bash
snap install webstorm --classic
```

### Code::Blocks (3 билета)
#11/#17/#25
```bash
apt install -y codeblocks 2>/dev/null || snap install codeblocks --classic
```

### NetBeans (3 билета)
#5/#18/#27
```bash
apt install -y netbeans 2>/dev/null || snap install netbeans --classic
```

### Arduino IDE (2 билета)
#10/#22
```bash
apt install -y arduino 2>/dev/null || snap install arduino
```

### Jupyter Lab (1 билет)
#7 (ML/AI)
```bash
pip3 install jupyterlab -q
```

### Android Studio (1 билет)
#2 (мобильная разработка)
```bash
snap install android-studio --classic
```

### Qt Creator (1 билет)
#25 (SCADA)
```bash
apt install -y qtcreator 2>/dev/null || snap install qtcreator --classic
```

### MonoDevelop (1 билет)
#9 (.NET) — проект устарел, альтернатива: VS Code + C# расширение
```bash
snap install monodevelop --classic 2>/dev/null || echo "Используй VS Code с C# расширением"
```

---

## 🧰 2. ЯЗЫКИ ПРОГРАММИРОВАНИЯ И SDK

### 🔥 Python 3 + pip (12 билетов)
#1/#7/#10/#14/#16/#19/#20/#21/#22/#24/#26/#28
```bash
apt install -y python3-pip python3-venv python3-dev -qq
```

### OpenJDK 17 (5 билетов)
#5/#14/#18/#27/#29
```bash
apt install -y openjdk-17-jdk -qq
```

### build-essential (5 билетов)
#3/#10/#11/#19/#25
```bash
apt install -y build-essential -qq
```

### Node.js LTS (3 билета)
#1/#6/#8
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs -qq
```

### OpenJDK 8 (2 билета)
#5/#18 (для старого Java-ПО)
```bash
apt install -y openjdk-8-jdk -qq
```

### Go (1 билет)
#4 (DevOps)
```bash
apt install -y golang -qq
```

### Rust (1 билет)
#4 (DevOps)
```bash
su -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y' $USER
```

### Flutter SDK (1 билет)
#2 (кроссплатформенная мобильная разработка)
```bash
snap install flutter --classic
```

### .NET SDK (1 билет)
#9 (корпоративные решения)
```bash
wget -qO /tmp/packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
dpkg -i /tmp/packages-microsoft-prod.deb
apt update -qq && apt install -y dotnet-sdk-8.0 -qq
```

---

## 🗄️ 3. СУБД И БАЗЫ ДАННЫХ

### 🔥 PostgreSQL (7 билетов)
#1/#5/#8/#16/#18/#27/#28
```bash
apt install -y postgresql postgresql-contrib -qq
```

### MySQL Server (5 билетов)
#1/#5/#8/#18/#27
```bash
apt install -y mysql-server -qq
```

### SQLite (5 билетов)
#1/#6/#8/#10/#27
```bash
apt install -y sqlite3 -qq
```

### phpMyAdmin (5 билетов)
#1/#5/#8/#18/#27
```bash
apt install -y phpmyadmin -qq
```

### Redis (3 билета)
#8/#19/#24
```bash
apt install -y redis -qq
```

### MariaDB (2 билета)
#9/#14
```bash
apt install -y mariadb-server -qq
```

### MongoDB (1 билет)
#8 (SPA)
```bash
wget -qO /tmp/mongo.asc "https://www.mongodb.org/static/pgp/server-7.0.asc"
gpg --dearmor -o /usr/share/keyrings/mongodb.gpg /tmp/mongo.asc 2>/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mongodb.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" > /etc/apt/sources.list.d/mongodb.list
apt update -qq && apt install -y mongodb-org -qq
```

### InfluxDB (1 билет)
#25 (телеметрия энергетики)
```bash
wget -qO /tmp/influxdb.deb "https://dl.influxdata.com/influxdb/releases/influxdb2-2.7.11-linux-amd64.deb"
dpkg -i /tmp/influxdb.deb 2>/dev/null || snap install influxdb
```

---

## 🎨 4. ГРАФИЧЕСКИЕ РЕДАКТОРЫ

### 🔥 GIMP (7 билетов)
#3/#12/#16/#20/#21/#23/#26
```bash
apt install -y gimp -qq
```

### Inkscape (4 билета)
#3/#12/#21/#23
```bash
apt install -y inkscape -qq
```

### Blender (4 билета)
#3/#12/#19/#23
```bash
snap install blender --classic
```

### Krita (2 билета)
#3/#21
```bash
apt install -y krita -qq
```

---

## 🌐 5. ВЕБ-ФРЕЙМВОРКИ

### Express.js (2 билета)
#1/#8
```bash
npm install -g express-generator -s 2>/dev/null
```

### Django (1 билет)
#1 (веб-сервисы)
```bash
pip3 install django -q
```

### Flask (1 билет)
#1 (веб-сервисы)
```bash
pip3 install flask -q
```

### Electron (1 билет)
#6 (десктопные приложения)
```bash
npm install -g electron -s 2>/dev/null
```

### Angular CLI (1 билет)
#8 (SPA)
```bash
npm install -g @angular/cli -s 2>/dev/null
```

### React CLI (1 билет)
#8 (SPA)
```bash
npm install -g create-react-app -s 2>/dev/null
```

### Vue CLI (1 билет)
#8 (SPA)
```bash
npm install -g @vue/cli -s 2>/dev/null
```

---

## 🤖 6. ML/AI И DATA SCIENCE

### Pandas / NumPy (4 билета)
#7/#24/#28/#29
```bash
pip3 install pandas numpy -q
```

### scikit-learn (4 билета)
#7/#24/#28/#29
```bash
pip3 install scikit-learn -q
```

### PyTorch (4 билета)
#7/#20/#24/#26
```bash
pip3 install torch torchvision -q
```

### TensorFlow (3 билета)
#7/#20/#26
```bash
pip3 install tensorflow -q
```

### OpenCV (3 билета)
#20/#26/#28
```bash
pip3 install opencv-python -q
```

### Matplotlib / Seaborn (2 билета)
#7/#28
```bash
pip3 install matplotlib seaborn -q
```

### NLTK (2 билета)
#21/#24
```bash
pip3 install nltk -q
```

### spaCy (2 билета)
#21/#24
```bash
pip3 install spacy -q
```

### Ultralytics YOLO (2 билета)
#20/#26
```bash
pip3 install ultralytics -q
```

### Librosa (1 билет)
#21 (аудио)
```bash
pip3 install librosa -q
```

### HuggingFace Transformers (1 билет)
#24 (чат-боты)
```bash
pip3 install transformers -q
```

### GeoPandas (1 билет)
#28 (транспорт)
```bash
pip3 install geopandas -q
```

---

## 🧪 7. ТЕСТИРОВАНИЕ И API

### Postman (3 билета)
#1/#8/#14
```bash
snap install postman
```

### Insomnia (2 билета)
#1/#8
```bash
snap install insomnia
```

### JMeter (2 билета)
#14/#19
```bash
apt install -y jmeter -qq
```

### k6 (2 билета)
#14/#19
```bash
apt install -y k6 -qq 2>/dev/null || (curl -fsSL https://dl.k6.io/key.gpg | gpg --dearmor -o /usr/share/keyrings/k6.gpg 2>/dev/null && echo "deb [signed-by=/usr/share/keyrings/k6.gpg] https://dl.k6.io/deb stable main" > /etc/apt/sources.list.d/k6.list && apt update -qq && apt install -y k6 -qq)
```

### Locust (2 билета)
#14/#19
```bash
pip3 install locust -q
```

### Newman (2 билета)
#1/#8
```bash
npm install -g newman -s 2>/dev/null
```

### Swagger CLI (2 билета)
#1/#8
```bash
npm install -g swagger-cli -s 2>/dev/null
```

### OWASP ZAP (2 билета)
#13/#14
```bash
snap install zaproxy --classic
```

### Selenium (1 билет)
#14
```bash
pip3 install selenium -q
```

---

## 🐳 8. КОНТЕЙНЕРИЗАЦИЯ И ВИРТУАЛИЗАЦИЯ

### Docker (5 билетов)
#4/#9/#13/#15/#19
```bash
apt install -y docker.io -qq
systemctl enable docker --now
```

### Docker Compose (3 билета)
#4/#9/#13
```bash
apt install -y docker-compose -qq
```

### VirtualBox (2 билета)
#14/#15
```bash
apt install -y virtualbox -qq
```

### Vagrant (2 билета)
#4/#15
```bash
apt install -y vagrant -qq
```

### Minikube (2 билета)
#4/#13
```bash
wget -qO /tmp/minikube.deb "https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb"
dpkg -i /tmp/minikube.deb
```

### kubectl (2 билета)
#4/#13
```bash
snap install kubectl --classic
```

### QEMU (2 билета)
#11/#14
```bash
apt install -y qemu-system-x86 qemu-utils -qq
```

### KVM/libvirt (1 билет)
#15
```bash
apt install -y virt-manager libvirt-daemon-system -qq
```

---

## 📊 9. МОНИТОРИНГ И CI/CD

### Grafana (6 билетов)
#4/#10/#15/#19/#25/#28
```bash
wget -qO /tmp/grafana.deb "https://dl.grafana.com/oss/release/grafana_11.3.0_amd64.deb"
dpkg -i /tmp/grafana.deb 2>/dev/null
apt install -f -y -qq
```

### Prometheus (4 билета)
#4/#15/#19/#25
```bash
wget -qO /tmp/prometheus.tar.gz "https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz"
tar -xzf /tmp/prometheus.tar.gz -C /opt/ 2>/dev/null
ln -sf /opt/prometheus-*/prometheus /usr/local/bin/prometheus 2>/dev/null
```

### Netdata (3 билета)
#4/#15/#19
```bash
bash <(curl -Ss https://my-netdata.io/kickstart.sh) -y 2>/dev/null
```

### Jenkins (2 билета)
#4/#13
```bash
wget -qO /tmp/jenkins.deb "https://get.jenkins.io/debian-stable/jenkins_2.479.3_all.deb"
dpkg -i /tmp/jenkins.deb 2>/dev/null
apt install -f -y -qq
```

### HAProxy (2 билета)
#15/#19
```bash
apt install -y haproxy -qq
```

### Elasticsearch (2 билета)
#25/#28
```bash
wget -qO /tmp/es.deb "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.0-amd64.deb"
dpkg -i /tmp/es.deb 2>/dev/null || echo "Установи вручную: wget ... && dpkg -i"
```

---

## 🔒 10. БЕЗОПАСНОСТЬ

### 🔥 auditd (7 билетов)
#1/#4/#5/#13/#15/#16/#18
```bash
apt install -y auditd audispd-plugins -qq
auditctl -e 1
auditctl -w /etc/passwd -p wa -k passwd_changes
```

### 🔥 ufw (6 билетов)
#1/#4/#5/#13/#15/#18
```bash
apt install -y ufw -qq
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable
```

### Wireshark (5 билетов)
#1/#13/#18/#19/#25
```bash
apt install -y wireshark -qq
```

### nmap (4 билета)
#1/#4/#13/#15
```bash
apt install -y nmap -qq
```

### OpenSSL (4 билета)
#1/#10/#16/#18
```bash
apt install -y openssl -qq
```

### ClamAV (4 билета)
#5/#6/#16/#18
```bash
apt install -y clamav clamav-daemon -qq
```

### WireGuard (3 билета)
#1/#13/#15
```bash
apt install -y wireguard -qq
```

### Fail2ban (3 билета)
#1/#13/#19
```bash
apt install -y fail2ban -qq
```

### OpenVPN (2 билета)
#1/#15
```bash
apt install -y openvpn -qq
```

### SonarQube Scanner (2 билета)
#9/#13
```bash
wget -qO /tmp/sonar.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip"
unzip -qo /tmp/sonar.zip -d /opt/ 2>/dev/null
ln -sf /opt/sonar-scanner-*/bin/sonar-scanner /usr/local/bin/ 2>/dev/null
```

### Trivy (2 билета)
#9/#13
```bash
wget -qO /tmp/trivy.deb "https://github.com/aquasecurity/trivy/releases/download/v0.58.2/trivy_0.58.2_Linux-64bit.deb"
dpkg -i /tmp/trivy.deb 2>/dev/null || snap install trivy
```

---

## 🛠️ 11. УТИЛИТЫ

### FFmpeg (3 билета)
#20/#21/#26
```bash
apt install -y ffmpeg -qq
```

### sshfs (2 билета)
#4/#15
```bash
apt install -y sshfs -qq
```

---

## 🎯 12. СПЕЦИАЛИЗИРОВАННОЕ ПО

### Open3D (3 билета)
#3/#12/#23 (AR/VR, 3D)
```bash
pip3 install open3d -q
```

### Mosquitto MQTT (2 билета)
#10/#22 (IoT, умный дом)
```bash
apt install -y mosquitto mosquitto-clients -qq
```

### R + RStudio (2 билета)
#7/#16 (статистика, медицина)
```bash
apt install -y r-base -qq
```

### GStreamer (2 билета)
#20/#26 (комп. зрение, видео)
```bash
apt install -y gstreamer1.0-tools gstreamer1.0-plugins-good -qq
```

### Rasa (1 билет)
#24 (чат-боты)
```bash
pip3 install rasa -q
```

### Ansible (1 билет)
#15 (серверная инфраструктура)
```bash
apt install -y ansible -qq
```

### can-utils (1 билет)
#17 (автомобильные системы)
```bash
apt install -y can-utils -qq
```

### OpenOCD (1 билет)
#11 (микроконтроллеры)
```bash
apt install -y openocd -qq
```

---

## 📋 ЧЕК-ЛИСТ ПО БИЛЕТАМ

| Билет | Ключевое ПО (обязательно) |
|---|---|
| №1 Веб-сервисы | VS Code, Python, Node.js, PostgreSQL, Insomnia, Django, ufw, auditd |
| №2 Моб. приложения | Android Studio, Flutter, VS Code, антивирус |
| №3 3D игры | Blender, GIMP, Inkscape, CLion, build-essential, Open3D |
| №4 DevOps | VS Code, Docker, Jenkins, Prometheus, Grafana, nmap, ufw, Ansible, Go |
| №5 Java банк | IntelliJ IDEA, JDK 17, PostgreSQL, MySQL, ClamAV, ufw, auditd |
| №6 Десктоп | VS Code, WebStorm, Electron, Node.js, SQLite, ClamAV |
| №7 ML/AI | PyCharm, Python, TensorFlow, PyTorch, Jupyter, CUDA, Pandas |
| №8 SPA | VS Code, WebStorm, Node.js, MongoDB, Redis, React/Angular, Postman |
| №9 .NET | Rider/MonoDevelop, .NET SDK, MariaDB, MS SQL, SonarQube, Trivy |
| №10 IoT | VS Code, Arduino IDE, Mosquitto, Python, SQLite, OpenSSL |
| №11 Микроконтр. | STM32CubeIDE/VS Code, Code::Blocks, ARM GCC, OpenOCD, QEMU |
| №12 AR/VR | Blender, GIMP, Unity (через Wine), Open3D |
| №13 DevSecOps | Docker, Jenkins, SonarQube, OWASP ZAP, Trivy, nmap, auditd |
| №14 Тестирование | VS Code, PyCharm, Selenium, Postman, JMeter, OWASP ZAP, VirtualBox |
| №15 Серверы | Docker, KVM, Ansible, Prometheus, Grafana, Vagrant, ufw, WireGuard |
| №16 Медицина | VS Code, Python, PostgreSQL, GIMP, ClamAV, OpenSSL, auditd, R |
| №17 Авто | Code::Blocks, can-utils, КОМПАС/NanoCAD |
| №18 Финансы | IntelliJ IDEA, JDK, PostgreSQL, Oracle, ClamAV, OpenSSL, ufw, auditd |
| №19 Онлайн-игры | VS Code, CLion, Blender, Docker, Redis, HAProxy, Grafana, Locust |
| №20 Комп. зрение | PyCharm, CLion, OpenCV, YOLO, CUDA, FFmpeg, GStreamer |
| №21 Голосовое | PyCharm, Python, Librosa, GIMP, Krita, FFmpeg, NLTK |
| №22 Умный дом | VS Code, Arduino IDE, Mosquitto, Python, WireGuard |
| №23 Пром. AR | Blender, GIMP, Inkscape, Unity, Open3D |
| №24 Чат-боты | PyCharm, VS Code, Python, Rasa, HuggingFace, Redis, spaCy |
| №25 Энергетика | CLion, Qt Creator, Code::Blocks, Grafana, InfluxDB, Elastic, can-utils |
| №26 Биометрия | PyCharm, CLion, OpenCV, YOLO, CUDA, FFmpeg, GStreamer |
| №27 WMS | IntelliJ IDEA, NetBeans, Eclipse, PostgreSQL, SQLite, MySQL |
| №28 Транспорт | VS Code, PyCharm, Python, PostgreSQL, Grafana, GeoPandas, Elastic |
| №29 SCM | IntelliJ IDEA, Eclipse, Python, Java, scikit-learn, OR-Tools |
