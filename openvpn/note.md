# steps
Suppose I'm using an vps from tokyo called myserver, a cert is issued to myclient. We can safely assume that CA machine and OpenVPN server machines are the same one, thus some of the steps from archwiki can be omitted (simplified). The major steps are described as below.

##  initialize PKI
easyrsa init-pki
##  issue a self-signed CA with 
easyrsa build-ca 
##  generate DH parameter 
openssl dhparam -out /etc/openvpn/server/dh.pem 2048

## generate HMAC key
openvpn --genkey --secret /etc/openvpn/server/ta.key

##  generate server/client requests and upload to CA machine
easyrsa gen-req myserver nopass
easyrsa gen-req myclient nopass

## import requests ( can be omitted if operating on the same machine as CA service)
easyrsa import-req /path/to/uploaded/myserver.req myserver
easyrsa import-req /path/to/uploaded/myclient.req myclient

## sign the requests above
easyrsa sign-req server myserver
easyrsa sign-req client myclient

## modify server's vpn config
port 443
proto tcp ## disguise as a HTTP server
TODO: some other routing rules

## enable routing
sysctl net.ipv4.ip_forward

## enable tun/tap forwarding
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE (is this needed?)

## copy issued certificates to server machine
copy /etc/easy-rsa/path/to/issued/cert.crt /etc/openvpn/server/ca.crt

## generate config file for Android/iOS/Windows clients
ovpngen myserver /etc/openvpn/server/ca.crt /etc/easy-rsa/pki/issued/myclient.crt /etc/easy-rsa/pki/private/myclient.key /etc/openvpn/server/ta.key > iphone.ovpn
