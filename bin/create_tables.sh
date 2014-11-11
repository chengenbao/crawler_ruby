#!/bin/bash

TIMETAG=$(date +"%Y%m%d%H%M%S")
TABLENAME=$1

touch "db/migrate/${TIMETAG}_create_${TABLENAME}.rb"

