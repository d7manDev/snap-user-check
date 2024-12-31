#!/usr/bin/env bash
cat << "EOF" 
.--------------------------------------------------------------------------------------------------.
|                                                           /$$                           /$$      |
|                                                          | $$                          | $$      |
|  /$$$$$$$ /$$$$$$$   /$$$$$$   /$$$$$$           /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$| $$   /$$|
| /$$_____/| $$__  $$ |____  $$ /$$__  $$ /$$$$$$ /$$_____/| $$__  $$ /$$__  $$ /$$_____/| $$  /$$/|
||  $$$$$$ | $$  \ $$  /$$$$$$$| $$  \ $$|______/| $$      | $$  \ $$| $$$$$$$$| $$      | $$$$$$/ |
| \____  $$| $$  | $$ /$$__  $$| $$  | $$        | $$      | $$  | $$| $$_____/| $$      | $$_  $$ |
| /$$$$$$$/| $$  | $$|  $$$$$$$| $$$$$$$/        |  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$| $$ \  $$|
||_______/ |__/  |__/ \_______/| $$____/          \_______/|__/  |__/ \_______/ \_______/|__/  \__/|
|                              | $$                                                                |
|                              | $$                                                                |
|                              |__/                                                                |
|   GitHub:@d7manDev                             twitter:@d7g_x                                    | 
'--------------------------------------------------------------------------------------------------'
EOF

check_username(){
read -p "enter username to check: " username
base_url="https://www.snapchat.com/add/"
url="${base_url}${username}" 
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0"
response=$(curl -s -H "User-Agent: $user_agent" -I "${url}")
status=$(echo "$response" | grep "HTTP/" | awk '{print $2}')
# handel 200 response 
if [[ "$status" -eq 200 ]]; then
  echo "'$username' is taken 😔"
# handel 304 redirect 
elif [[ "$status" -eq 304 ]]; then
    location=$(echo "$response" | grep "Location:" | awk '{print $2}')
    if [[ ! -z "$location" ]]; then
        echo "$username maybe not available"
    else
        echo "snapchat redirect the request but there is not no location"
        echo "'$username' maybe not available"
    fi
# user is available if response is 404
elif [[ "$status" -eq 404 ]]; then
  echo "'$username' is availabe"
else
  echo "there is an error $status"
fi
}
check_username
while true; do
    read -p "would you like to check another username (y,n) ? " answer 
    case "$answer" in
    y|Y)
    check_username
    ;;
    n|N)
    echo "bye"
    break
    ;;
    *)
    echo "wrong answer please answer with (y,n) "
    ;;
    esac
    done
