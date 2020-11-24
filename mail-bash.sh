#!/bin/bash

username="jakubb.mackowiak@gmail.com"  # from this email script is reading bash commands
password=""

mail=$(curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | grep -oPm1 "(?<=<title>)[^</]+" | sed '1d' | head -1)

commands=()

for word in $mail
do
	commands+=("$word")
done

if [ "${commands[0]}" = "####" ]; then
  #safety third- begin ur message with #### -> example "#### ls" as email title
  unset commands[0]
  last=$( cat ./last_skrypt.txt )
  new="${commands[@]}"
  echo "$last"
  
  if [ "$last" != "$new" ]; then
    echo "${commands[@]}" > last_skrypt.txt
    x=$("${commands[@]}") #to basha
    echo "$x" | sendmail -t mocnysm2@gmail.com  # response to this email
  fi
fi

# add this line to crontab -l "#*/1 * * * * /bin/bash /path/to/this/script.sh" then run crontab -e