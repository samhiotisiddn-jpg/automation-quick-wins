#!/usr/bin/env bash
# watchdog.sh — keep your background processes alive. Cron every 15 min.
#   */15 * * * * /path/watchdog.sh >> watchdog.log 2>&1
# Works with pm2 (Node) or a plain pidfile list.

# --- pm2 mode ---
if command -v pm2 >/dev/null 2>&1; then
  pm2 jlist 2>/dev/null | python3 -c "
import json, subprocess, sys
try: apps = json.load(sys.stdin)
except Exception: sys.exit(0)
for a in apps:
    if a.get('name') and a.get('pm2_env', {}).get('status') != 'online':
        print('reviving', a['name'])
        subprocess.call(['pm2', 'restart', a['name']],
                        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
"
  pm2 save >/dev/null 2>&1
fi

# --- pidfile mode ---
# one "name pidfile start-command" per line in $HOME/.watchdog.list:
#   myapp /tmp/myapp.pid "python3 /path/app.py"
[ -f "$HOME/.watchdog.list" ] || exit 0
while read -r name pidfile cmd; do
  [ -z "$name" ] && continue
  if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
    : # alive
  else
    echo "$(date '+%F %T') restarting $name"
    nohup $cmd >/dev/null 2>&1 & echo $! > "$pidfile"
  fi
done < "$HOME/.watchdog.list"
