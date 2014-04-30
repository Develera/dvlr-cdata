#!/bin/bash

# Script for Mongo DB size to CDATA
dbName="DEVELERA"
key="NTM1NTdmYzg0NGMzYjE3MzNiNGU5NGYz"
dbRaw=$(echo -e "use fullstack-dev\ndb.stats()" | mongo)
size=$(echo -e "$dbRaw" | awk '/fileSize/ {print $3}' | sed 's/,//')
objects=$(echo -e "$dbRaw" | awk '/objects/ {print $3}' | sed 's/,//')
collections=$(echo -e "$dbRaw" | awk '/collections/ {print $3}' | sed 's/,//')
avgObjSize=$(echo -e "$dbRaw" | awk '/avgObjSize/ {print $3}' | sed 's/,//')
dataSize=$(echo -e "$dbRaw" | awk '/dataSize/ {print $3}' | sed 's/,//')
storageSize=$(echo -e "$dbRaw" | awk '/storageSize/ {print $3}' | sed 's/,//')
indexSize=$(echo -e "$dbRaw" | awk '/indexSize/ {print $3}' | sed 's/,//')
indexes=$(echo -e "$dbRaw" | awk '/indexes/ {print $3}' | sed 's/,//')
curl 'http://cdata.develera.com/v1/data?key='$key'&dbName='$dbName'&size='$size'&objects='$objects'&collections='$collections'&avgObjSize='$avgObjSize'&dataSize='$dataSize'&storageSize='$storageSize'&indexSize='$indexSize'&indexes='$indexes
