#!/bin/bash
proxygithub="https://ghproxy.com/" #反代github加速地址，如果不需要可以将引号内容删除，如需修改请确保/结尾 例如"https://ghproxy.com/"

if [ -n "$1" ]; then 
    iptxt="$1"
else
    iptxt="ip.txt"
fi

ipcsv="${iptxt%.*}"

# 检测是否已经安装了mmdb-bin
if ! command -v mmdblookup &> /dev/null; then
    echo "mmdblookup 未安装，开始安装..."
    sudo apt update
    sudo apt install mmdb-bin -y
    echo "mmdblookup 安装完成！"
else
    echo "mmdblookup 已安装."
fi

# GeoLite2-ASN.mmdb的路径
ASN_DB="/usr/share/GeoIP/GeoLite2-ASN.mmdb"

# 检测GeoLite2-Country.mmdb文件是否存在
if [ ! -f $ASN_DB ]; then
    echo "文件 $ASN_DB 不存在。正在下载..."
    
    # 使用curl命令下载文件
    curl -L -o $ASN_DB "${proxygithub}https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-ASN.mmdb"
    
    # 检查下载是否成功
    if [ $? -eq 0 ]; then
        echo "下载完成。"
    else
        echo "下载失败。脚本终止。"
        exit 1
    fi
fi

# 输出文件名
OUTPUT_FILE="${ipcsv}.csv"

# 写入CSV文件头
echo "IP,ASN" > $OUTPUT_FILE

# 读取ip.txt文件中的每一行
while IFS= read -r line
do
  # 删除行尾的回车符
  IP=$(echo "$line" | tr -d '\r')
  
  # 打印出正在处理的IP地址
  #echo "Processing IP: $IP"
  
  # 使用mmdblookup查询ASN，并使用grep和cut提取ASN号
  ASN=$(mmdblookup --file $ASN_DB --ip "$IP" autonomous_system_number | grep -oP '(\d+)' | head -n 1)
  
  # 将结果写入CSV文件
  echo "$IP,AS$ASN" >> $OUTPUT_FILE
done < $iptxt
