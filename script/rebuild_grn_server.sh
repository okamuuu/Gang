mkdir -p groonga/db
rm -fr groonga/db/*
groonga -n --port 10041 groonga/db/test.db < groonga/schema.grn
groonga --port 10041 groonga/db/test.db < groonga/data.grn
groonga -s --port 10041 --protocol http groonga/db/test.db

