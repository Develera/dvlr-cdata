#!/bin/bash

# Send Mongo Stats Data to Develera Custom Monitoring

#
# Develera Custom Monitoring key
#
key="NTM1NTdmYzg0NGMzYjE3MzNiNGU5NGYz"


#
# Set Mongo DB name
#
dbMongo="your-mongo-db-name"


#
# Get mongo data
#
dbRaw=$(echo -e "use $dbMongo\ndb.stats()" | mongo)


#
# Build query
#
query='?key='$key
query=$query'&size='$(echo -e "$dbRaw" | awk '/fileSize/ {print $3}' | sed 's/,//')
query=$query'&objects='$(echo -e "$dbRaw" | awk '/objects/ {print $3}' | sed 's/,//')
query=$query'&collections='$(echo -e "$dbRaw" | awk '/collections/ {print $3}' | sed 's/,//')
query=$query'&avgObjSize='$(echo -e "$dbRaw" | awk '/avgObjSize/ {print $3}' | sed 's/,//')
query=$query'&dataSize='$(echo -e "$dbRaw" | awk '/dataSize/ {print $3}' | sed 's/,//')
query=$query'&storageSize='$(echo -e "$dbRaw" | awk '/storageSize/ {print $3}' | sed 's/,//')
query=$query'&indexSize='$(echo -e "$dbRaw" | awk '/indexSize/ {print $3}' | sed 's/,//')
query=$query'&indexes='$(echo -e "$dbRaw" | awk '/indexes/ {print $3}' | sed 's/,//')


#
# Send data
#
curl 'http://cdata.develera.com/v1/data'$query
