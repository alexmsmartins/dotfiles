#!/bin/bash

USER="root"
PASSWORD="root"
OUTPUT="/Users/amartins/development/db_dumps"

#rm "$OUTPUTDIR/*gz" > /dev/null 2>&1

databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
				date=`date +%Y%m%d%H%m%S`
        mysqldump -u $USER -p$PASSWORD --databases $db > $date.$db.sql
				cp $date.$db.sql $OUTPUT/$date.$db.sql
        gzip $OUTPUT/$date.$db.sql
				echo "A copy of the dump is saved in $OUTPUT/$date.$db.sql.gz"
    fi
done
