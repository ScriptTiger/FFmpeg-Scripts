[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://docs.google.com/forms/d/e/1FAIpQLSfBEe5B_zo69OBk19l3hzvBmz3cOV6ol1ufjh0ER1q3-xd2Rg/viewform)

# FFmpeg Scripts
Collection of assorted FFmpeg scripts. Scripts prefixed with `DD_` support dragging and dropping a file over the script, meaning they accept a single file path as an argument.

# `DD_M4B-Combine.cmd`
Combine AAC-encoded M4A audio files into a single M4B audiobook.

1. Create a new directory and title it the name of the audiobook.  
2. Place all of the chapter files into the newly created directory from step 1.  
3. Conform the chapter file names to `<#>_<title>.m4a`, where `<#>` is the sequence order and `<title>` is the chapter title.  
4. OPTIONAL: You may also include an image file named `cover` (i.e. `cover.jpg`, `cover.png`, etc.).  
5. Drag and drop the directory over the `DD_M4B-Combine.cmd` for the audiobook to be encoded.

# `DD_M4B-Split.cmd`
Split an AAC-encoded M4B audiobook file into individual chapter M4A audio files.

# More About ScriptTiger

For more ScriptTiger scripts and goodies, check out ScriptTiger's GitHub Pages website:  
https://scripttiger.github.io/
