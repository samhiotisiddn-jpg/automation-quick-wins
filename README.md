# Automation Quick Wins for Small Business

Five copy-paste scripts that each kill a real weekly time-drain. No frameworks, no SaaS subscriptions — Python standard library and one cron daemon.

Built and used in production by **IronVision Nexus** (Albury NSW, Australia).

---

## 1. `reply_sorter.py` — the follow-up leak fixer

Scans your Gmail inbox via IMAP every hour, classifies unread replies by intent (hot / question / not-now), and prints the ones that need you *today*. Leads answered in 5 minutes convert; at 5 hours they're gone.

```bash
python3 reply_sorter.py you@gmail.com your_app_password
```

## 2. `payment_ping.sh` — "did they pay?" killer

Polls Stripe every 5 minutes from cron. New paid charge → instant Telegram message to your phone + append-only money ledger. Buyers get acknowledged in 60 seconds, even at 2am.

## 3. `watchdog.sh` — the 2am restart you don't wake up for

Keeps every background process alive; messages you only when it *can't* fix something. Silence means green.

## 4. `quote_40_seconds.md` — quote-to-cash checklist

The exact pipeline that takes a lead from "interested" to paid invoice in 40 seconds: intake form → generated proposal → payment link → auto welcome email.

## 5. `cron_recipes.txt` — the autonomy layer

The three crontab lines that run all of the above on any Linux box (or an Android phone with Termux — my whole business runs on one).

---

## Want it done for you?

- **Automation Audit — $99 AUD**: your stack mapped, hours-burned found, fix plan in 48h → https://buy.stripe.com/9B69ATgC01Ln9dTequ3gm06
- **Systems Package — $499 AUD**: top 3 fixes built end-to-end → https://buy.stripe.com/4gMdR9clK0Hj3Tz5TY3gm00
- **Build Sprint — $1,999 AUD**: one week, your manual loop gone → https://buy.stripe.com/6oU8wP99y75H4XD2HM3gm04
- **Full Engagement — $4,999 AUD** → https://buy.stripe.com/3cIeVdgC075HfCh5TY3gm05

Questions: sam.hiotis@gmail.com

## License

MIT — use them, ship them, sell the time they save you.
