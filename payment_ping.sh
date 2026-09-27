#!/usr/bin/env bash
# payment_ping.sh — buzz your phone the moment money lands. Cron every 5 min.
#   */5 * * * * /path/payment_ping.sh >> money.log 2>&1
# Needs: curl, python3, a Telegram bot token (free from @BotFather).
STRIPE_SK="sk_live_REPLACE_ME"
TG_BOT="REPLACE_ME"
TG_CHAT="REPLACE_ME"   # message your bot once, then read chat id from:
                       # curl -s https://api.telegram.org/bot$TG_BOT/getUpdates
STATE="$HOME/.payment_ping_state"

NEW=$(curl -s -m 15 -u "$STRIPE_SK:" "https://api.stripe.com/v1/charges?limit=5" | python3 -c "
import json, sys, os
charges = json.load(sys.stdin).get('data', [])
state = os.path.expanduser('$STATE')
try: seen = set(json.load(open(state)))
except Exception: seen = set()
new = [c for c in charges if c.get('paid') and c['id'] not in seen]
for c in new:
    print('NEW MONEY: \$%.2f %s from %s' % (c['amount']/100, c['currency'].upper(),
          c.get('receipt_email') or 'buyer'))
seen |= {c['id'] for c in charges}
json.dump(list(seen)[-200:], open(state, 'w'))
")
[ -n "$NEW" ] && echo "$(date '+%F %T') $NEW" && \
  curl -s -m 10 -X POST "https://api.telegram.org/bot$TG_BOT/sendMessage" \
    -d chat_id="$TG_CHAT" --data-urlencode text="$NEW" >/dev/null
