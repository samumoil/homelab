#!/bin/bash

#Tähän scriptiin tulee se rclone-komento, jota halutaan ajettavan vaikka 1h välein

#Mistä tieto haetaan = pilvestä
#SOURCE=pcloud:
SOURCE=~/.config/

#Mihin tieto laitetaan = serverin levylle = containerin sisälle määritelty volume
#eli debianserverillä /samu/pcloud -> containerin /data (tämä tulee suoraan valmiista rclone imagesta)
#DESTINATION=/samu/smb-cloud/pcloud
DESTINATION=/samu/temp/

timestamp=`date +%Y-%m-%d_%H:%M:%S`
stampfile=${DESTINATION}/backup_$timestamp

#Luodaan leimatiedosto, jotta nähdään, että backup-skripti on ajanut.
touch $stampfile

#Käytetään flock-lukitsemista, jotta ei tule päällekäisiä ajoja.
#Ohjataan sekä standard output että error output leimatiedostoon ( &> ).
#Näin voi jälkikäteen tarkistaa, miten skripti sujui.
flock -n /tmp/pcloud_sync.lock /usr/bin/rclone copy --transfers 10 --retries 5 ${SOURCE} ${DESTINATION} &> $stampfile

echo "Backup succesful $timestamp"
