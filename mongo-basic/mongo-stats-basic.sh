#!/bin/bash

# Script for Mongo DB size to CDATA

key="NTM1NTdmYzg0NGMzYjE3MzNiNGU5NGYz"
dbMongo="fullstack-dev"

dbRaw=$(echo -e "use $dbMongo\ndb.stats()" | mongo)

query='&dbName=DEVELERA'
query=$query'&size='$(echo -e "$dbRaw" | awk '/fileSize/ {print $3}' | sed 's/,//')
query=$query'&objects='$(echo -e "$dbRaw" | awk '/objects/ {print $3}' | sed 's/,//')
query=$query'&collections='$(echo -e "$dbRaw" | awk '/collections/ {print $3}' | sed 's/,//')
query=$query'&avgObjSize='$(echo -e "$dbRaw" | awk '/avgObjSize/ {print $3}' | sed 's/,//')
query=$query'&dataSize='$(echo -e "$dbRaw" | awk '/dataSize/ {print $3}' | sed 's/,//')
query=$query'&storageSize='$(echo -e "$dbRaw" | awk '/storageSize/ {print $3}' | sed 's/,//')
query=$query'&indexSize='$(echo -e "$dbRaw" | awk '/indexSize/ {print $3}' | sed 's/,//')
query=$query'&indexes='$(echo -e "$dbRaw" | awk '/indexes/ {print $3}' | sed 's/,//')

curl 'http://cdata.develera.com/v1/data?key='$key$query