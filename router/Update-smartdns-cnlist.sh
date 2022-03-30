#! /bin/sh
#
# Update China Domain
# source: https://raw.githubusercontent.com/huifukejian/test/master/update-china-list.sh

# China Domain Download Link
#URL="https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"
URL="https://dragonuniform.sg/cnlist.php"

# DNS Server Group
PROXYDNS_NAME="china"

# Smartdns Config File Path
CONFIG_FLODER="/etc/smartdns"
CONFIG_FILE="cnlist.conf"

INPUT_FILE=$(mktemp)
OUTPUT_FILE="$CONFIG_FLODER/$CONFIG_FILE"

if [ "$1" != "" ]; then
	PROXYDNS_NAME="$1"
fi

wget -O $INPUT_FILE $URL 
 
sed -i "s/^server=\/\(.*\)\/[^\/]*$/nameserver \/\1\/$PROXYDNS_NAME/g;/^nameserver/!d" $INPUT_FILE 2>/dev/null

mv -f $INPUT_FILE $OUTPUT_FILE