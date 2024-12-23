#!/bin/bash

# Инициализация сервера конфигурации
docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);

EOF

# Инициализация 1-го шарда
docker compose exec -T shard1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1:27018" },
        { _id : 1, host : "shard1-1:27019" },
        { _id : 2, host : "shard1-2:27020" }
      ]
    }
);
EOF

# Инициализация 2-го шарда
docker compose exec -T shard2 mongosh --port 27021 <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 3, host : "shard2:27021" },
        { _id : 4, host : "shard2-1:27022" },
        { _id : 5, host : "shard2-2:27023" }
      ]
    }
  );
EOF

# Инициализация 3-го шарда
docker compose exec -T shard3 mongosh --port 27024 <<EOF
rs.initiate(
    {
      _id : "shard3",
      members: [
        { _id : 6, host : "shard3:27024" },
        { _id : 7, host : "shard3-1:27025" },
        { _id : 8, host : "shard3-2:27026" }
      ]
    }
  );
EOF

# Инициализация роутера и наполнение данными
docker compose exec -T mongos_router mongosh --port 27027 <<EOF
sh.addShard( "shard1/shard1:27018");
sh.addShard( "shard2/shard2:27021");
sh.addShard( "shard3/shard3:27024");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb
for(var i = 0; i < 3000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
db.helloDoc.countDocuments()
EOF
