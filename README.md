# IP2ASN 脚本

这个脚本用于将IP地址映射到其相应的自治系统号（ASN）。它使用了MaxMind的GeoLite2 ASN数据库。

## 使用方法

### 1. 下载脚本

使用以下命令下载脚本：

```bash
wget -N https://ghproxy.com/https://raw.githubusercontent.com/cmliu/IP2ASN/main/IP2ASN.sh && chmod +x IP2ASN.sh

```

### 2. 运行脚本

使用以下命令运行脚本，你可以选择提供一个包含IP地址的文本文件：

```bash
./IP2ASN.sh [file_ip.txt]
```
如果未提供文件名，默认使用 ip.txt。

### 3. 查看结果
脚本将生成一个CSV文件，其中包含每个IP地址及其对应的ASN。文件名类似于 ip.csv。

## 依赖

确保安装了 mmdb-bin，如果没有，脚本将尝试自动安装。

```bash
sudo apt update
sudo apt install mmdb-bin -y
```

## 注意事项
如果你在中国大陆，请确保使用了适当的代理地址以加速下载。
## 鸣谢
感谢 P3TERX 提供的GeoLite2 ASN数据库。

## 许可
此脚本遵循 MIT License。

