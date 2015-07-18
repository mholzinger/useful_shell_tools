#show all indexing activity
#sudo fs_usage -w -f filesys mdworker

#only show open files
sudo fs_usage -w -f filesys mdworker | egrep "open"

#disable spotlight
sudo mdutil -a -i off

#enable spotlight
sudo mdutil -a -i on

