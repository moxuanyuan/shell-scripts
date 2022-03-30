#! /bin/sh
#
# Update Chnroute

# China IP Download Link
URL="https://ispip.clang.cn/all_cn.txt"

# Smartdns Config File Path
CONFIG_FLODER="/etc/smartdns"
WHITELIST_CONFIG_FILE="whitelist-chnroute.conf"
BLACKLIST_CONFIG_FILE="blacklist-chnroute.conf"

WHITELIST_OUTPUT_FILE="$CONFIG_FLODER/$WHITELIST_CONFIG_FILE"
BLACKLIST_OUTPUT_FILE="$CONFIG_FLODER/$BLACKLIST_CONFIG_FILE"
INPUT_FILE=$(mktemp)
if [ "$1" != "" ]; then
	URL="$1"
fi

wget -O $INPUT_FILE $URL
if [ $? -eq 0 ]
then
	echo "Download successful, updating..."
	mkdir -p $CONFIG_FLODER
	cat /dev/null > $WHITELIST_OUTPUT_FILE
	cat /dev/null > $BLACKLIST_OUTPUT_FILE

	cat $INPUT_FILE | while read line
	do
		echo "whitelist-ip $line" >> $WHITELIST_OUTPUT_FILE
		echo "blacklist-ip $line" >> $BLACKLIST_OUTPUT_FILE
	done
fi

rm $INPUT_FILE