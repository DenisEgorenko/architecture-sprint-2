#!/bin/bash

docker compose exec -T shard2 mongosh --port 27021 <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF