#!/bin/bash

# 脚本配置
DOMAIN="example.com"
SUBDOMAINS=("host1" "host2" "host3")
# get a token at https://app.netlify.com/user/applications
ACCESS_TOKEN="your_netlify_access_token"
API="https://api.netlify.com/api/v1"
DNS_ZONE="${DOMAIN//./_}"
URL="$API/dns_zones/$DNS_ZONE/dns_records?access_token=$ACCESS_TOKEN"
TTL_SECONDS="120"
CHECK_INTERVAL=60 # 每60秒检查一次IPv6地址

# 获取本机的IPv6地址
get_ipv6_address() {
    ip -6 addr show dev eth0 | grep 'inet6 ' | awk '{print $2}' | cut -d'/' -f1
}

# 更新Netlify上的DDNS记录
update_netlify_ddns() {
    local ipv6_address=$(get_ipv6_address)
    for subdomain in "${SUBDOMAINS[@]}"; do
        echo "Updating $subdomain.$DOMAIN with IPv6 $ipv6_address"
        # 使用curl发送POST请求创建或更新记录
        curl -X POST "$API/dns_zones/$DNS_ZONE/dns_records?access_token=$ACCESS_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"type\":\"AAAA\",\"subdomain\":\"$subdomain\",\"address\":\"$ipv6_address\",\"ttl\":$TTL_SECONDS}"
    done
}

# 主循环，检查IPv6地址变化并更新DDNS记录
main() {
    local last_ipv6_address=""
        local current_ipv6_address=$(get_ipv6_address)
        if [[ "$current_ipv6_address" != "$last_ipv6_address" ]]; then
            echo "IPv6 address changed. Updating DDNS records..."
            update_netlify_ddns
            last_ipv6_address=$current_ipv6_address
        fi
}

# 运行主函数
main
