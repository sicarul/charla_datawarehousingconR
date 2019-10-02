#!/bin/bash
docker run --name local-postgres -e POSTGRES_PASSWORD=dwh -p 54320:5432 -d postgres 
