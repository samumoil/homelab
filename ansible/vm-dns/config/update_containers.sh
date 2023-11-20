#!/bin/bash
docker system prune -af --volumes
docker-compose pull
docker-compose up -d --force-recreate
docker system prune -af --volumes
