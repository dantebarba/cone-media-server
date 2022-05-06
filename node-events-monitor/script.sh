echo $(date -u) " DEBUG - running script.sh"
if ! command -v awake &> /dev/null
then
    echo $(date -u) " INFO - awake not installed. Installing it"
    apk add --no-cache awake
fi

if ! command -v dig &> /dev/null
then
    echo $(date -u) " INFO - dig not installed. Installing it"
    apk add --no-cache bind-tools
fi

IP=$(dig +short $WOL_DOMAIN)
awake -d $WOL_DOMAIN $WOL_MAC

exit 0
