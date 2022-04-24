#!/bin/bash
docker build -t hometask-image .
docker run --rm -t -d -p 8080:80 --name dynamic hometask-image