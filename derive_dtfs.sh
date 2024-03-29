FILE="scos.txt"

counter=0

IS_COMMENTED=0
while read line
do           
    counter=$((counter+1))
    n=$((counter%3))
    case $n in
       1)  ID=$line
          if echo $ID|grep --quiet "^#"; then
              IS_COMMENTED=1
          else
                 DASHES=""
                 #COLS_NUM=`tput cols`
                 COLS_NUM=$((`tput cols`-${#ID}))
                 for i in $(seq 1 $COLS_NUM); do
                     DASHES=`echo "${DASHES}-"`
                 done
	       echo "$ID$DASHES"
          fi
	;;
       2) SCO=`echo $line | sed -e "s/\./::/g"`
         #if [ "$IS_COMMENTED" -eq 0 ]; then
	  #     echo $SCO
         #fi
	;;
       0) 
              if [ "$IS_COMMENTED" -eq 0 ]; then
                     sh run.sh $ID "$SCO" "output/${ID}_dtfs.txt"
                     #sh run.sh "$SCO" 
                     #SEL=member    ; SAFE=unsafe ; NO_RED=false  ; COM=global; MEM=memoization;  FLOW=df; WEIGHTING=cost; STATS=`sh run.sh $ID "$SCO" true $SEL $SAFE $NO_RED $COM $MEM $FLOW $WEIGHTING | grep -v LOG | awk -F "$ID" '{print$3}'|tr '\n' ' '`; echo "$ID\t$SEL\t$SAFE\t$NO_RED\t$COM\t$MEM\t$FLOW\t$WEIGHTING $STATS"

              fi
              IS_COMMENTED=0
	;; #SCO
    esac
done <$FILE
