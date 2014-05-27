
export MAX_ATOM=$((2**17)) #131072

CONFIG_FILE_LAYOUT="config.pl.layout"
CONFIG_FILE="config.pl"

ID=${1}
SCO=`echo "${2}"|sed -e "s/\./::/g"`

if [ -z "${3}" ]; then
       OUTPUTFILENAME=""
       TMP_OUTPUTFILENAME=""
       cat ${CONFIG_FILE_LAYOUT}  \
       | sed -e "s/#SCO#/${SCO}/"   \
       | sed -e "s/#OUTPUTFILENAME#/none/"  \
       > ${CONFIG_FILE}
else
       OUTPUTFILENAME="${3}"
       TMP_OUTPUTFILENAME=`echo $OUTPUTFILENAME| sed -e "s/\\\\//\\\\\\\\\//"`
       cat ${CONFIG_FILE_LAYOUT}  \
       | sed -e "s/#SCO#/${SCO}/"   \
       | sed -e "s/#OUTPUTFILENAME#/${TMP_OUTPUTFILENAME}/"  \
       > ${CONFIG_FILE}
fi

LOADFILE="load.pl"
GOAL="derive_dtfs"
EXIT="halt"

COMMAND="gprolog --init-goal ['${LOADFILE}'],['${CONFIG_FILE}'] --entry-goal ${GOAL} --query-goal ${EXIT}"

LOG="log/${ID}_$$.log"
echo "${date}\c"
echo "   PERFORMING: "$ID 
time="$(time (${COMMAND}) 2>&1 >/dev/null)"
time="$(time (${COMMAND} | tee ${LOG}) 2>&1 >/dev/null)"
echo "  OUTPUT FILE: "${OUTPUTFILENAME} 
echo "          LOG: ${LOG}"

