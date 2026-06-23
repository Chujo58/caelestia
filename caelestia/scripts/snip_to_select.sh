#!/usr/bin/env bash
qs -c caelestia ipc call picker openFreeze

# wait for a new file in /tmp
before=$(ls /tmp/*.png 2>/dev/null)

i=0
while true; do
    after=$(ls /tmp/*.png 2>/dev/null)
    if [[ "$before" != "$after" ]]; then
        break
    fi
    i=$((i + 1))
    if [ $i -gt 300 ]; then
        notify-send "OCR" "❌ Timed out waiting for snip"
        exit 1
    fi
    sleep 0.1
done

latest=$(ls /tmp/*.png | sort -nr | head -n 1)
cp "$latest" /tmp/image.png

tesseract /tmp/image.png /tmp/ocr_output -l eng+fra --psm 6
notify-send "OCR" "✅ Text extracted and copied to clipboard!"
wl-copy < /tmp/ocr_output.txt

rm /tmp/image.png
rm /tmp/ocr_output.txt