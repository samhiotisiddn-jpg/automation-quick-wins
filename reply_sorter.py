#!/usr/bin/env python3
"""reply_sorter.py — classify unread Gmail replies by intent. Stdlib only.
Usage: python3 reply_sorter.py you@gmail.com your_app_password
Cron:  7 * * * * python3 /path/reply_sorter.py you@gmail.com app_pw >> leads.log
"""
import imaplib, re, sys

POS = ['interest', 'tell me more', 'more info', 'price', 'pricing', 'quote',
       'book', 'call me', 'sounds good', "let's", 'lets talk', 'send over',
       'proposal', 'keen', 'yes please']
NEG = ['unsubscribe', 'stop emailing', 'remove me', 'not interested']

def main():
    user, pw = sys.argv[1], sys.argv[2]
    M = imaplib.IMAP4_SSL('imap.gmail.com', 993)
    M.login(user, pw)
    M.select('INBOX')
    _, data = M.search(None, 'UNSEEN')
    hot, questions = [], []
    for num in (data[0] or b'').split()[-50:]:
        _, f = M.fetch(num, '(RFC822)')
        raw = f[0][1].decode('utf-8', 'ignore')
        subj = (re.search(r'Subject: (.*)', raw) or [None, '(no subject)'])[1].strip()
        frm = (re.search(r'From: (.*)', raw) or [None, ''])[1].strip()
        body = raw.lower()
        if any(n in body for n in NEG):
            continue
        if any(p in body for p in POS):
            hot.append((frm, subj))
        elif '?' in raw:
            questions.append((frm, subj))
    M.logout()
    print('=== HOT (answer first) ===')
    for f, s in hot: print(' *', f, '|', s)
    print('=== QUESTIONS ===')
    for f, s in questions: print(' ?', f, '|', s)
    print(f'scanned, {len(hot)} hot / {len(questions)} questions')

if __name__ == '__main__':
    main()
