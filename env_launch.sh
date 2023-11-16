#!/usr/bin/env fish

function remove_container
    set container_name $argv[1]

    set container_id (docker ps -q -f "name=$container_name")
    if test -n "$container_id"
        docker-compose down --rmi all
        echo "コンテナ $container_name を削除しました"
    else
        echo "コンテナ $container_name は存在しません"
    end
end

function start_container
    set container_name $argv[1]

    if docker-compose build --no-cache
        docker-compose up -d
        echo "コンテナ $container_name を正常に起動しました"
        exec_container $container_name
    else
        set error_code $status
        echo "エラーコード: $error_code"
    end
end

function exec_container
    set container_name $argv[1]
    set container_id (docker ps -q -f "name=$container_name")

    if test -n "$container_id"
        docker exec -it $container_id bash
    else
        echo "コンテナ $container_name は存在しません。"
    end
end

set container_name ""

for arg in $argv
    switch $arg
        case "-d"
            set container_name $argv[2]
            remove_container $container_name
            break
        case "-s"
            set container_name $argv[2]
            start_container $container_name
            break
        case "-e"
            set container_name $argv[2]
            exec_container $container_name
            break
    end
end

