#! /bin/bash

#parametros
#$1 nombre de la base de datos
#$2 nombre usuario de la base de datos
#$3 contraseña de la base de datos
#$4 ontologia
#$5 consulta

#obtengo la ruta de los programas y archivos necesarios 
ubiAuto=$(find /home/ | grep /AutoMap | head -1)
ubiOntop=$(find /home/ | grep /Ontop | head -1)
ubiOwl=$(find /home/ | grep /$4 | head -1)
ubiQuery=$(find /home/ | grep /$5 | head -1)
ubiLABIA=$(find /home/ | grep /LABIA | head -1)

cd $ubiAuto

java -jar AutoMap.jar -db jdbc:postgresql://localhost:5432/$1 -schema public -driver org.postgresql.Driver -u $2 -p $3 -n $1 -d $ubiOwl -o maps >> $ubiLABIA/salida.txt

chmod 777 maps_automap4obda*
chmod 777 maps_ol_automap4obda*

cd $ubiOntop

#obtengo la ruta del mapeo
ubiR2ml=$(find /home/ | grep /maps_automap4obda.r2rml | head -1)

./ontop query -m $ubiR2ml -t $ubiOwl -o $ubiLABIA/s1.csv -l jdbc:postgresql://localhost:5432/$1 -u $2 -p $3 -d org.postgresql.Driver -q $ubiQuery  >> $ubiLABIA/salida.txt

cd $ubiLABIA

chmod 777 s1.csv

