#!/bin/bash

THIS_DIR=`dirname $0`
LOCK_FILE=$THIS_DIR/jbackup.lock

if [ "$1" == "v" ] 
	then 
		VERBOSE=true
	else
		VERBOSE=false
fi;

function print {
	if [ $VERBOSE == false ]
		then
			return
	fi;
	
	echo -ne $1
}

print "\n\n#########################################\n"
print "# JBacup - JoseRobinson.com (c) 2012\t#\n"
print "#########################################\n\n\n"

# Si el fichero de lock existe es por que ya se esta corriendo el proceso.
if [ -f $LOCK_FILE ]; 
then 
	print "El proceso ya esta corriendo.\n"
	exit;
else
	print "Iniciando el proceso.\n"
	touch $LOCK_FILE
fi;

print "\n"

	
# Se lee el listado de recursos que deben copiarse.
for item_to_bak in `cat $THIS_DIR/jbackup.csv`; 
do 
	path_source=`echo $item_to_bak | cut -d , -f 1`
	path_target=`echo $item_to_bak | cut -d , -f 2`
	
	print "• $path_source"
	rsync -au --delete $path_source $path_target
	print "\t\t\t\t\t\t\t\t\t\t[OK]\n"
	
done;


# Al finalizar eliminamos el fichero de lock.
rm $LOCK_FILE


print "\n"
print "Proceso finalizado exitosamente\n"
print "\n\n"

exit 0


# Para comprimir los archivos:
#zip -r0u b.zip a
