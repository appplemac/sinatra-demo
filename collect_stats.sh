#!/bin/bash
#
# A script that collects basic usage stats inside a running CircleCI job.
# To collect the produced metrics add the following steps to your CircleCI job:
#
# - run:
#     command: "bash collect_stats.sh"
#     background: true
# < body of the job >
# - store_artifacts:
#     path: /tmp/stats
#     prefix: stats
#
# Copyright 2018 © Circle Internet Services, Inc.

export DEST_DIR='/tmp/stats'
mkdir -p "$DEST_DIR"

function collect_process_list {
  date;
  ps aux;
  echo "---";
}

function collect_free_memory {
  date;
  free;
  echo "---";
}

function collect_cpu_usage {
  date;
  grep cpu /proc/stat;
  echo "---";
}

while true; do
  collect_process_list >> "$DEST_DIR/process.txt";
  collect_free_memory >> "$DEST_DIR/memory.txt";
  collect_cpu_usage >> "$DEST_DIR/cpu.txt";
  sleep 5;
done
