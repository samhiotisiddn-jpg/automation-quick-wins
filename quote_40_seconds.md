# Quote-to-Cash in 40 Seconds

The pipeline that takes a warm lead from "interested" to paid without you touching a keyboard.

## The manual version you're replacing

Open Word → find last quote → edit → export PDF → attach → write email → wait → check bank → write welcome email → add to spreadsheet. ~25 minutes, three days of latency, two dropped steps.

## The 40-second pipeline

1. **Intake (10s)** — one form, three fields: name, email, what they need. A $0 Google Form works. The entry lands in a spreadsheet/inbox.
2. **Proposal (10s)** — template with three slots: their name, their problem in their words (paste from intake), one of three fixed tiers. Fixed tiers beat custom pricing: no negotiation loop, no scope creep.
3. **Payment link (5s)** — paste the matching Stripe payment link. Payment links need no website, no invoice system, no code. The buyer pays by card in under a minute.
4. **Auto-welcome (0s)** — the `payment_ping.sh` cron catches the charge; your welcome email template goes out while you're still on the phone with them.

## Rules that make it work

- **Three tiers max.** Audit / build / full engagement. Choice paralysis kills more deals than price.
- **The middle tier is the product.** Anchor high, entry low, sell the middle.
- **Speed-to-lead beats copy.** A mediocre proposal in 5 minutes beats a perfect one tomorrow.
- **Every paid charge gets a human-sounding welcome within 60 seconds.** That's the entire retention strategy at small scale.
