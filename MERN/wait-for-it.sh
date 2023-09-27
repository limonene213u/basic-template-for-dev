#!/bin/bash
# wait-for-it.sh

TIMEOUT=15
QUIET=0

echoerr() {
  if [[ $QUIET -ne 1 ]]; then echo "$@" 1>&2; fi
}

usage() {
  exitcode="$1"
  cat << USAGE >&2
Usage:
  $0 host:port [-t timeout] [-- command args]
  -h HOST | --host=HOST       Host or IP under test
  -p PORT | --port=PORT       TCP port under test
                              Alternatively, you specify the host and port as host:port
  -t TIMEOUT | --timeout=TIMEOUT
                              Timeout in seconds, zero for no timeout
  -- COMMAND ARGS             Execute command with args after the test finishes
USAGE
  exit "$exitcode"
}

wait_for() {
  if [[ $TIMEOUT -gt 0 ]]; then
    echoerr "$0: waiting $TIMEOUT seconds for $HOST:$PORT"
  else
    echoerr "$0: waiting for $HOST:$PORT without a timeout"
  fi
  start_ts=$(date +%s)
  while :
  do
    if [[ $TIMEOUT -gt 0 ]]; then
      now_ts=$(date +%s)
      if [[ $now_ts -gt $((start_ts + TIMEOUT)) ]]; then
        echoerr "$0: timeout occurred after waiting $TIMEOUT seconds for $HOST:$PORT"
        return 1
      fi
    fi
    nc -z $HOST $PORT >/dev/null 2>&1
    result=$?
    if [[ $result -eq 0 ]]; then
      end_ts=$(date +%s)
      echoerr "$0: $HOST:$PORT is available after $((end_ts - start_ts)) seconds"
      return 0
    fi
    sleep 1
  done
  return 1
}

while [[ $# -gt 0 ]]
do
  case "$1" in
    *:* )
    hostport=(${1//:/ })
    HOST=${hostport[0]}
    PORT=${hostport[1]}
    shift 1
    ;;
    -h)
    HOST="$2"
    if [[ $HOST == "" ]]; then break; fi
    shift 2
    ;;
    --host=*)
    HOST="${1#*=}"
    shift 1
    ;;
    -p)
    PORT="$2"
    if [[ $PORT == "" ]]; then break; fi
    shift 2
    ;;
    --port=*)
    PORT="${1#*=}"
    shift 1
    ;;
    -q | --quiet)
    QUIET=1
    shift 1
    ;;
    -t)
    TIMEOUT="$2"
    if [[ $TIMEOUT == "" ]]; then break; fi
    shift 2
    ;;
    --timeout=*)
    TIMEOUT="${1#*=}"
    shift 1
    ;;
    --)
    shift
    CLI=("$@")
    break
    ;;
    --help)
    usage 0
    ;;
    *)
    echoerr "Unknown argument: $1"
    usage 1
    ;;
  esac
done

if [[ "$HOST" == "" || "$PORT" == "" ]]; then
  echoerr "Error: you need to provide a host and port to test."
  usage 2
fi

wait_for "$@"

RESULT=$?
if [[ $CLI != "" ]]; then
  if [[ $RESULT -ne 0 ]]; then
    echoerr "$0: strict mode, refusing to execute subprocess"
    exit $RESULT
  fi
  exec "${CLI[@]}"
else
  exit $RESULT
fi
