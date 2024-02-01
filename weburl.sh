#!/bin/bash

if [ -z "$1" ]; then
  echo "Por favor, proporciona una URL como argumento."
  exit 1
fi

# Obtener el contenido HTML
url=$1
html=$(curl -s "$url")

# Extraer información 
title=$(echo "$html" | grep -oP '<title>\K.*?(?=<\/title>)')
meta_description=$(echo "$html" | grep -oP '<meta name="description" content="\K.*?(?=")')
h1_tags=$(echo "$html" | grep -oP '<h1.*?>(.*?)<\/h1>' | sed -e 's/<[^>]*>//g')
links=$(echo "$html" | grep -oP '<a[^>]*href="\K[^"]*' | grep -v '^#' | uniq)

# Mostrar la información 
echo "Título: $title"
echo "Descripción: $meta_description"
echo "Encabezados (H1): $h1_tags"
echo "Enlaces:"
echo "$links"

exit 0
