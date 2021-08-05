#!/bin/sh
if [ -z "$CLIENTNAME" ];
then
    echo "CLIENTNAME is not set";
    exit 1;
fi
# with a passphrase (recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME;
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn;
