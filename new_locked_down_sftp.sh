# Use these commands to create a locked down sftp user

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z "$1" ]
  then
    echo "Supply a name for the new sftp user as the parameter to this script"
    exit
fi

USERNAME=$1

cd /home/
useradd -s /bin/false -m $USERNAME
mkdir /home/$USERNAME/files
chown $USERNAME: /home/$USERNAME/files
chown root:wheel /home/$USERNAME
chmod -R go-w /home/$USERNAME
chmod 755 /home/$USERNAME

cat >> /etc/ssh/sshd_config <<EOL
Match User $USERNAME
        ChrootDirectory /home/$USERNAME
      	X11Forwarding no
   	    AllowTcpForwarding no
        ForceCommand internal-sftp
EOL

NEW_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

echo Password for $USERNAME : $NEW_PASS

echo "$NEW_PASS" | passwd "$USERNAME" --stdin

/etc/init.d/sshd restart

IPADDY=$(curl -s icanhazip.com -4)

echo -------------------------
echo Credentials
echo Username: $USERNAME
echo password: $NEW_PASS
echo 
echo sftp command: sftp $USERNAME@$IPADDY
