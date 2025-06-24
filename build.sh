#!/bin/bash
cd /resume  # Переходим в папку с резюме

# Запускаем сборку PDF (замените main.tex на ваш файл)
pdflatex -interaction=nonstopmode main.tex

# Удаляем временные файлы (опционально)
rm -f *.aux *.log *.out