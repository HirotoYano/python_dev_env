#!/usr/bin/env fish

set container_name "$1"

set container_id (docker ps -q -f "name=$container_name")

if test -n "$container_id"
    docker-compose down --rmi all
    echo "コンテナ$container_nameを削除しました"
end

if docker-compose build --no-cache
    docker-compose up -d
    echo "コンテナ$container_nameを正常に起動しました"
    set container_id (docker ps -q -f "name=$container_name")
    docker exec -it $container_id bash
else
    set error_code $status
    echo $error_code
end

