    # Get the application information currently listening on port 5244
    listening_apps=$(netstat -tuln | grep 5244 | grep -v "LISTEN")
    # Determine if there is an application listening on port 5244
    if [ -z "$listening_apps" ]; then
    echo "No application is listening on port 5244."
            # Wechat message push:
            curl --location --request POST 'https://api.anpush.com/push/ZUM0GJE81YZJGOEWOQZ0TWTXAT1JFD' \
                  --header 'Content-Type: application/x-www-form-urlencoded' \
                  --data-urlencode 'title=Port Err:' \
                  --data-urlencode 'content=## Alist Port 5244 Error... ' \
                  --data-urlencode 'channel=18965'
            # Wechat message push.
    else
    echo "The following application is listening on port 5244:"
    echo "$listening_apps"
    fi
    
