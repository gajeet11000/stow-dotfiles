#!/usr/bin/bash

echo "Backup completed on: $(date)"

cd ~/.config/BraveSoftware/Brave-Browser/Default/

7z a -mx7 Backup.zip Bookmarks Extension\ Rules/ Extension\ State/ Extensions/ Preferences Shortcuts

mv Backup.zip ~/Dropbox/Brave-Browser/
