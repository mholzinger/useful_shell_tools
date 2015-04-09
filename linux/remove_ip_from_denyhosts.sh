# Test for passed parameters
if [ "$#" -lt 1 ]; then
    echo "Usage: Pass IPv4 address as paramater to this script"
    exit
fi

# assign the known good ip variable
GOODIP=$1

# stop denyhosts
service denyhosts stop

# remove known good ip from denyhosts
for denyhosts_files in $(grep -lrs $GOODIP /var/lib/denyhosts); \
  do \
  echo removing $GOODIP from $denyhosts_files; \
  sed -i /$GOODIP/d $denyhosts_files; \
done

# add known good ip to allowed-hosts
echo $GOODIP >> /var/lib/denyhosts/allowed-hosts

# start denyhosts
service denyhosts start

