# mongo-sharding

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Заполняем и инициализируем шарды и реплики mongodb и заполняем данными (3000 записей)

```shell
sudo bash ./scripts/mongo-init.sh
```

Проверяем кол-во данных в 1 шарде
```shell
sudo bash ./scripts/mongo-shard1.sh
```

Проверяем кол-во данных в 2 шарде
```shell
sudo bash ./scripts/mongo-shard2.sh
```

Проверяем кол-во данных в 3 шарде
```shell
sudo bash ./scripts/mongo-shard3.sh
```

## Как проверить

### Проверка приложения

Откройте в браузере http://localhost:8080