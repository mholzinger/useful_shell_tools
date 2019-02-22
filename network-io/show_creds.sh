IPADD=$(curl -s whatismyip.akamai.com -4); echo `hostname -f` "($IPADD)" && echo Username: `whoami`
