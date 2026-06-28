# Квалификационный экзамен по ОС

**ОС:** Ubuntu 22.04  
**Время на экзамене:** 80 минут  
**Цель:** Оценка 5 (≥ 35.5 из 40 баллов)

---

## Структура

```
exam/
├── 1-os-install/           # Этап 1 — Установка и защита ОС (24.50 балла)
│   ├── setup.sh            # Скрипт автоматической настройки
│   ├── manual-install.md   # Пошаговые команды вручную
│   └── exam-guide.md       # Ответы для защиты
│
├── 2-role-software/        # Этап 2 — Установка ПО по роли (9.00 баллов)
│   ├── installer.sh        # Интерактивный установщик (12 категорий)
│   ├── compatibility-setup.sh  # Настройка совместимости (2.50 балла)
│   ├── manual-install.md   # Команды ручной установки
│   └── exam-guide.md       # Ответы для защиты
│
└── 3-documentation/        # Этап 3 — Документация (6.50 баллов)
    ├── generate-template.py     # Генератор .odt по ГОСТ Р 59795-2021
    ├── user-guide-template.md   # Шаблон документации
    ├── user-guide-template.odt  # Готовый файл для LibreOffice
    └── exam-guide.md            # Ответы для защиты
```

## Баллы

| Раздел | Баллы |
|--------|------:|
| Установка ОС | 15.50 |
| Защита ОС | 9.00 |
| Установка ПО | 9.00 |
| Документация | 6.50 |
| **Итого** | **40.00** |

## Быстрый старт

```bash
git clone https://github.com/JacksonSwich/OC.git
cd OC

# Этап 1 — всё одной командой
sudo bash exam/1-os-install/setup.sh

# Этап 2 — установка ПО + совместимость
sudo bash exam/2-role-software/installer.sh
sudo bash exam/2-role-software/compatibility-setup.sh

# Этап 3 — генерация документации
cd exam/3-documentation
python3 generate-template.py "Название ПО" --output user-guide.odt
```

---

**Автор:** JacksonSwich
