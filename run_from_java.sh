export CONFIG_FILE=$1
cd /Users/aguacatin/Research/HADAS/PhD/Prolog/hyqoz_dtfsDerivator
/opt/local/bin/gprolog --init-goal "['load.pl','${CONFIG_FILE}']" --entry-goal "derive_dtfs_from_java(TYPES,DTFS),nl,write('TYPES = '),write(TYPES),nl,write('DTFS = '),write(DTFS), write(';'),nl,nl" --query-goal "halt" | egrep "TYPES|DTFS"
