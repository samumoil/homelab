#!/bin/bash
docker-compose pull
docker-compose up -d --force-recreate
docker system prune -af --volumes
