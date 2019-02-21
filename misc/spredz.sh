# Simple bash for calculating incoming payments and outgoing charges
# on Chase.com and Capitalone.com exported spreadsheet files

spredz=$1

echo -n "Total incoming: "
incoming=$(mktemp)

for i in $(cat "$spredz" |\
            grep '^Payment\|Payment/Credit'|\
            tr ',' ' '|\
            awk '{print $NF}'|\
            sed $'s/\r//'|\
            sed 's/[^0-9.^0-9]*//g')
do
  echo "$i"
done > $incoming;paste -sd+ $incoming | bc


echo -n "Total outgoing: "
outgoing=$(mktemp)
for i in $(cat "$spredz" |\
             sed '/Payment/d'|\
             tr ',' ' '|\
             awk '{print $NF}'|\
             sed 's/-//g'|\
             sed $'s/\r//'|\
             sed 's/[^0-9.^0-9]*//g')
do
  echo "$i"
done > $outgoing;paste -sd+ $outgoing | bc
