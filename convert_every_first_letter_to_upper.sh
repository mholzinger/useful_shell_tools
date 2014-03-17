#!/bin/bash

_upr()
{
    _UPR=
    case $1 in
        a*) _UPR=A ;;        b*) _UPR=B ;;
        c*) _UPR=C ;;        d*) _UPR=D ;;
        e*) _UPR=E ;;        f*) _UPR=F ;;
        g*) _UPR=G ;;        h*) _UPR=H ;;
        i*) _UPR=I ;;        j*) _UPR=J ;;
        k*) _UPR=K ;;        l*) _UPR=L ;;
        m*) _UPR=M ;;        n*) _UPR=N ;;
        o*) _UPR=O ;;        p*) _UPR=P ;;
        q*) _UPR=Q ;;        r*) _UPR=R ;;
        s*) _UPR=S ;;        t*) _UPR=T ;;
        u*) _UPR=U ;;        v*) _UPR=V ;;
        w*) _UPR=W ;;        x*) _UPR=X ;;
        y*) _UPR=Y ;;        z*) _UPR=Z ;;
         *) _UPR=${1%${1#?}} ;;
    esac
}

_cap()
{
  _upr "$1"
  _CAP=$_UPR${1#?}
}

_capwords()
{
  unset _CAPWORDS
  set -f
  for word in $*
  do
    _cap "$word"
    _CAPWORDS="$_CAPWORDS${_CAPWORDS:+ }$_CAP"
  done
}

mp3_files=(*.mp3)
cnt=${#mp3_files[@]}
for (( idx = 0; idx < cnt; idx++ ))
do
    _capwords "${mp3_files[idx]}"
    echo Renaming file \""${mp3_files[idx]}"\" to \""$_CAPWORDS"\"
    mv "${mp3_files[idx]}" "$_CAPWORDS"
done

#_capwords the quick brown fox
#printf "%s\n" "$_CAPWORDS"
#The Quick Brown Fox
