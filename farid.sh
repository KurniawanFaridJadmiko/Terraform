#!/bin/bash

# Nama file
FILE_NAME="farid.txt"
FILE_CONTENT="Ini adalah konten dari file farid."

# Membuat atau menulis ke file
echo "$FILE_CONTENT" > "$FILE_NAME"
echo "File $FILE_NAME telah dibuat dengan konten: $FILE_CONTENT"

# Menampilkan isi file
echo "Isi dari $FILE_NAME:"
cat "$FILE_NAME"
