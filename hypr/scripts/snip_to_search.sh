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
        notify-send "Snip to Search" "❌ Timed out waiting for snip"
        exit 1
    fi
    sleep 0.1
done

latest=$(ls /tmp/*.png | sort -nr | head -n 1)
cp "$latest" /tmp/image.png

# grim -g "$(slurp)" /tmp/image.png
imageLink=$(curl -sF files[]=@/tmp/image.png 'https://uguu.se/upload' | jq -r '.files[0].url')

if [ -z "$imageLink" ] || [ "$imageLink" = "null" ]; then
    notify-send "Snip to Search" "❌ Upload failed"
    exit 1
fi

notify-send "Snip to Search" "✅ Search opened in browser"
xdg-open "https://lens.google.com/uploadbyurl?url=${imageLink}"
rm /tmp/image.png
