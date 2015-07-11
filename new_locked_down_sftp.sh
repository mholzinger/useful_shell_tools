# Use these commands to create a locked down sftp user
# todo: make this a script 

USERNAME=sftp_user
useradd -s /bin/false -m $USERNAME
mkdir /home/$USERNAME/public
chown $USERNAME: /home/$USERNAME/public
chown root:wheel /home/$USERNAME
chmod -R go-w /home/$USERNAME
chmod 755 sftp_user/

vi /etc/ssh/sshd_config

```
 Match User sftp_user
         ChrootDirectory /home/sftp_user
       	 X11Forwarding no
       	 AllowTcpForwarding no
         ForceCommand internal-sftp
```

passwd sftp_user
/etc/init.d/sshd restart

