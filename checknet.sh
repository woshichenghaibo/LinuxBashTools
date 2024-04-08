#!/bin/bash
# Usage:  bash /root/checknet.sh
# Ping times
count=0
# check the internet conneciton
while true; do
    #trying to ping baidu.com
    ping -c 1 baidu.com > /dev/null 2>&1
    # check the ping status
    if [ $? -eq 0 ]; then
        # exit while OK
        echo "Internet OK."
        exit 0
    else
        # count+1 while bad connection
        ((count++))
        # 10 times per minute
        if [ $count -gt 600 ]; then
            # reboot while bad connection for 10 minutes
            echo "Internet Connection Error,rebooting..."
            reboot
            # Wechat message push:
            curl --location --request POST 'https://api.anpush.com/push/ZUM0GJE81YZJGOEWOQZ0TWTXAT1JFD' \
                  --header 'Content-Type: application/x-www-form-urlencoded' \
                  --data-urlencode 'title=Bad Net' \
                  --data-urlencode 'content=## Bad connection!<br>Error when pinging baidu.com in 10 minutes.Rebooting now... ' \
                  --data-urlencode 'channel=18965'
            # Wechat message push.
            exit 0
        fi
        # ping per minute
        sleep 60
    fi
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
done
##*/10 * * * * bash /root/checkNet.sh
