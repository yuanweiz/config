# run from command line
sudo mount -t cifs "//192.168.56.1/Users/yuanweiz/Documents/share" ~/samba -o "user=yuanweiz1113@gmail.com,password=Eraser1993,rw,uid=ywz,gid=ywz"

# auto mount at start-up
/etc/systemd/system/mnt-myshare.mount
/etc/samba/mount.conf
