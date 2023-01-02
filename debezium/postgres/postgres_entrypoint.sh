#!/bin/bash

set -e
set -u

SCHEMA_BASE_PATH='/etc/postgresql/schema'

SCHEMA_DIRS=()
ROOT_SCHEMA_SCRIPTS=()

for entry in "$SCHEMA_BASE_PATH"/*
do
  if [[ -d $entry ]]; then
    SCHEMA_DIRS+=("$entry")
  elif [[ -f $entry ]]; then
    ROOT_SCHEMA_SCRIPTS+=("$entry")
  else
    echo "$entry is not valid"
    exit 1
  fi
done

#run_scripts "${ROOT_SCHEMA_SCRIPTS[@]}"

SORTED_SCRIPTS=($(for l in "${ROOT_SCHEMA_SCRIPTS[@]}"; do echo "$l"; done | sort))
for value in "${SORTED_SCRIPTS[@]}"
do
  echo "Running script: ${value}"
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -f "$value"
done

for value in "${SCHEMA_DIRS[@]}"
do
  DB_NAME=$(echo "$value" | sed 's:.*/::')
  SORTED_SCRIPTS_IN_FOLDER=($(for l in "$value"/*; do echo "$l"; done | sort))
  echo "Running scripts in folder: ${value} which substitutes to DB_NAME: ${DB_NAME}"

  for script in "${SORTED_SCRIPTS_IN_FOLDER[@]}"
  do
      psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "$DB_NAME" -f "$script"
  done
done

