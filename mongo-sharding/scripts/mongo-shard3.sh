#!/bin/bash

docker compose exec -T shard3 mongosh --port 27020 <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF