#!/bin/bash

./cdh-manager.sh zks start
./cdh-manager.sh jns start
./cdh-manager.sh nns start
./cdh-manager.sh dns start
./cdh-manager.sh httpfs start
./cdh-manager.sh rms start
./cdh-manager.sh nms start
./cdh-manager.sh zkfc start
./cdh-manager.sh jhs start
./cdh-manager.sh hivemetastore start
./cdh-manager.sh hiveserver2 start
./cdh-manager.sh hue start
