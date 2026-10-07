# Used car, LA / North Hollywood, $3,500–6,900

**Date:** 2026-10-07 | **Founder profile:** n/a — personal purchase, not a business idea

## Question
Reliable, decent-looking used cars on Facebook Marketplace within reach of
North Hollywood, $3,500–6,900, good condition, not embarrassing to arrive in.

## Gates (feasibility for this founder)
Not applicable: this is a purchase, not a product idea (rule 6 covers ideas).

## What we found
Method: Apify `apify/facebook-marketplace-scraper`, search URLs on slug `la`
(slug `losangeles` silently returns national results — discarded), price
filter 3500–6900, listed in last 14 days, one general vehicles query plus 12
model queries. 407 raw items → filtered to live, unsold, ≤30 mi from North
Hollywood, 2007+, reliable makes, ≤175k mi, no salvage/rebuilt/"needs work"
wording → 88 candidates (`candidates.json`). Main photos of 20 reviewed by eye.
All data is seller-reported; snapshot of 2026-10-07 — listings go fast.

Dropped on purpose: every "título salvaje" (salvage title) listing (Yaris,
Avalon, Corolla SE, Infiniti G37), BMWs/Audis (cheap to buy, expensive to
keep — the opposite of the brief), 5-year-old "runs but needs a tow" cars.

### Shortlist (best reliability × looks × price)
| # | Car | Price | Miles | Where | Why / catch |
|---|---|---|---|---|---|
| 1 | [2014 Honda Accord Hybrid](https://www.facebook.com/marketplace/item/1407298470925590/) | $5,300 | 134k | LA, 11 mi | Best-looking car on the list for the money, white, modern. Catch: priced low for the model — confirm clean title, hybrid battery health. |
| 2 | [2012 Acura TL](https://www.facebook.com/marketplace/item/958704953402745/) | $6,900 | 112k | LA, 15 mi | Looks the most "premium", V6, leather, sunroof, low miles. Catch: ask for timing-belt/water-pump history; at the top of budget. |
| 3 | [2008 Lexus ES 350](https://www.facebook.com/marketplace/item/1782141366162351/) | $5,000 | 145k | LA, 11 mi | Toyota V6 reliability in a luxury shell; white with black wheels. Catch: 2008, check dash/seat wear. A [second ES 350](https://www.facebook.com/marketplace/item/2313613556083924/) ($5,300, 142k, Compton) is the same car in a dated gold. |
| 4 | [2012 Toyota Camry Hybrid XLE](https://www.facebook.com/marketplace/item/1422149833216784/) | $6,900 | 103k | Gardena, 20 mi | Low miles, clean gray, 42 mpg. Catch: top of budget, hybrid battery check. |
| 5 | [2016 Toyota Corolla S](https://www.facebook.com/marketplace/item/2224420721748754/) | $6,800 | 140k | LA, 14 mi | Newest and sportiest-looking Corolla. Catch: sparse listing text, haggle. |
| 6 | [2012 Honda Civic LX](https://www.facebook.com/marketplace/item/2510808002751633/) | $5,800 | 155k | Burbank, 4 mi | Closest; seller claims $2,300 of recent maintenance with receipts — ask to see them. |
| 7 | [2011 Honda Accord EX](https://www.facebook.com/marketplace/item/2309212639852831/) | $5,950 | 137k | LA, 11 mi | Loaded, tidy, pink slip + smog ready. Catch: fine but not exciting. |
| 8 | [2014 Mazda3 Touring](https://www.facebook.com/marketplace/item/3336764269849306/) | $6,500 | 161k | LA, 4 mi | Best-looking compact; sporty. Catch: highest miles of the list. |

Skip: 2013 Civic DX / 2010 Corolla N. Hollywood ($6,650 for a 151k-mile 2010 —
overpriced), 2009 Scion xb (reliable but boxy, against the "not ugly" brief).

## Competitors / what already exists
n/a.

## Assessment
For "reliable and not embarrassing": **#1 Accord Hybrid** and **#3 Lexus
ES 350** for style per dollar, **#2 Acura TL** if you can stretch to $6,900.
Before paying anyone: ask for the VIN, run a Carfax/AutoCheck, check
`CA DMV` smog/registration status, and pay an independent mechanic ~$150
for a pre-purchase inspection. Never pay a deposit before seeing the car and
title in person. Mileage in the scrape is parsed from the listing subtitle
and a few entries are garbled (e.g. "1.3K"); the table above uses the
mileage written in the descriptions.

## Next step
Message sellers of #1–#3 today, book viewings, bring a mechanic or book a PPI.
Re-run the Apify query in a few days to catch new listings
(`candidates.json` has the 88-listing snapshot).

**Verdict:** closed — personal purchase, shortlist delivered; re-run the search only if none of #1–#3 pans out
