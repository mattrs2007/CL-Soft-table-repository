#!/usr/bin/ksh 
# $Id: stage_nems.ksh,v 1.2 2016/01/14 00:30:45 m6sg Exp $
#==========================================================================
# Created:	m6sg
# Description:	Stage NEMS files for BBD in FSTE
#==========================================================================
#==========================================================================
# Modification:
#
#==========================================================================
SRC=/home/m6sg/temp/NEMS/SAVEFILE_SAchar
TGT=/home/m6sg/temp/NEMS/SAchar
TGTABS=/home/m6sg/temp/NEMS/SAcharABS
CPFILE="
bn_sachar_input.dat
bn_sachar_notify.dat
bn_sachar_source.dat
"
date=151231
YR=$(print $date | /usr/bin/cut -c 1-2)
MM=$(print $date | /usr/bin/cut -c 3-4)
DD=$(print $date | /usr/bin/cut -c 5-6)

print "DAY = $date"
 [ ! -d $TGT/$date ] && mkdir $TGT/$date
 [ ! -d $TGTABS/$date ] && mkdir $TGTABS/$date

if   [ $MM = 01 ] ; then MONTH=Jan
elif [ $MM = 02 ] ; then MONTH=Feb
elif [ $MM = 02 ] ; then MONTH=Feb
elif [ $MM = 03 ] ; then MONTH=Mar
elif [ $MM = 04 ] ; then MONTH=Apr
elif [ $MM = 05 ] ; then MONTH=May
elif [ $MM = 06 ] ; then MONTH=Jun
elif [ $MM = 07 ] ; then MONTH=Jul
elif [ $MM = 08 ] ; then MONTH=Aug
elif [ $MM = 09 ] ; then MONTH=Sep
elif [ $MM = 10 ] ; then MONTH=Oct
elif [ $MM = 11 ] ; then MONTH=Nov
elif [ $MM = 12 ] ; then MONTH=Dec
fi

#print $MONTH $DD
DAYCK="$MONTH $DD"

for FILE in $(ls -l $SRC/bn_sachar_input.dat* | grep "$DAYCK" | awk '{print $9}'); do
 if [ $(grep -c NEMTRAN $FILE) -gt 0 ]  ; then
 #   print "\n$FILE"
  BASE=$(basename $FILE)
  GDG=$(print $BASE | cut -c 26-30)
  for CPSHAR in $CPFILE; do
   print cp -p $SRC/${CPSHAR}.g0000${GDG} $TGT/$date
   cp -p $SRC/${CPSHAR}.g0000${GDG} $TGT/$date
  done 
 (( AGDG = $GDG + 1 ))
  for CPABS in $CPFILE; do
   print cp -p $SRC/${CPABS}.g0000${AGDG} $TGTABS/$date
   cp -p $SRC/${CPABS}.g0000${AGDG} $TGTABS/$date
  done 
 fi
done

