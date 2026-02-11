---
title: "Using Claude Cowork to Process Scanned PDF Receipts for Expense Claims"
date: 2026-02-11
draft: false
tags: ["claude", "AI", "automation", "productivity"]
author: "Rameez Khan"
showToc: true
TocOpen: false
hidemeta: false
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
series: []
---

I recently returned from a business trip with a folder full of scanned receipts. The task ahead was familiar and tedious: match each receipt to my bank statement and fill out the company expense form. It's the kind of work that demands attention but not creativity - perfect for automation.

That's when I thought: what if I tried Claude's new cowork feature for this?

## What is Cowork?

Cowork is Claude's autonomous work mode. Rather than a back-and-forth conversation, you give Claude a task with clear instructions and let it work through the steps - reading files, creating folders, writing documents, and reasoning through problems.

The key is that you're still directing the work. You provide the instructions, the verification criteria, and the expected output format. Claude executes.

An expense claim suited this well. I had 12 receipts, a bank statement to reconcile against, and a specific spreadsheet format to produce. Let's see how it went.

## The Workflow

### Step 1: Pointing Claude at the Files

I started by giving Claude access to a directory containing my 12 scanned PDF receipts and my bank statement. From there, it read through each receipt and extracted the key details:

- Date of transaction
- Description (restaurant name, meal type, etc.)
- Amount

### Step 2: Organising the Chaos

My scanned files had meaningless names like `scan_001.pdf` and `receipt_final_v2.pdf`. I asked Claude to rename them using the format `YYYYMMDD_placename.pdf` - being specific about the naming convention mattered here.

I also instructed it to move the originals to an archive folder, keeping the working directory clean. Useful when finance has questions later.

### Step 3: Matching to Bank Statement

Here's where cowork really earned its keep. Using the bank statement from the same directory (which already shows all transactions in local currency), Claude cross-referenced each receipt against the actual transactions.

Some matches required judgement. A receipt from "Café Milano" might appear on the statement as "CAFE MILANO SRL" or sometimes just a merchant code. Claude flagged uncertain matches for my review rather than guessing.

### Step 4: Building the Spreadsheet

With all the data reconciled, Claude created an Excel spreadsheet matching our company's expense form format:

| Ref | Date | Description / Business Reason | Cost |
|-----|------|-------------------------------|------|
| 1 | 2026-01-15 | Client lunch - Project kickoff meeting | 45.00 |
| 2 | 2026-01-15 | Dinner - Working session with team | 62.50 |
| ... | ... | ... | ... |

Each line included a business reason, not just "lunch" or "dinner". This is the part I usually rush through and later regret when finance asks for clarification.

### Step 5: Transport Charges

Expense claims aren't just meals. I asked Claude to pull out public transport charges from the bank statement - metro tickets, bus fares - and group them by day.

It also caught airport transfers that I'd initially overlooked. These were buried in the statement as generic "TRANSPORT" entries, but Claude matched them to my travel dates and added them to the claim.

### Step 6: Review and Completeness Check

Before declaring victory, I gave Claude specific verification steps to run through:

- Check that every receipt has a matching bank transaction
- Look for any statement entries from the trip period not yet claimed
- Verify the totals reconcile

This is where good prompting pays off. By explicitly asking for these checks, Claude caught two items I'd missed: an eSIM purchase and an Uber expense. Both legitimate expenses that would have been lost in the noise.

## The Result

The final output: a 21-line expense claim totalling the full amount spent during the trip. Every receipt matched to its bank statement entry, and proper business reasons throughout.

The whole thing took about six prompts and a few minutes. What would normally be an hour or two of tedious cross-referencing - opening PDFs, scanning the bank statement, copying amounts into a spreadsheet.

I copied the spreadsheet into our company's expense system, attached the renamed PDFs, and submitted. Done.

## Conclusion

**What worked well:**
- Reading and parsing scanned PDF receipts
- Following specific instructions for organisation and naming
- Cross-referencing between receipts and bank statements
- Building structured output in the required format

**The prompts matter:**
Cowork isn't magic - it's only as good as the instructions you give it. I had to be specific about:
- The exact naming format I wanted (`YYYYMMDD_placename.pdf`)
- The verification steps to run before finishing
- The spreadsheet columns and format
- Which expenses were business vs. personal

Vague instructions would have produced vague results. The more precise I was about what I wanted, the better the output.

**When cowork shines:**
Multi-step tasks involving documents and data transformation. The kind of work where you'd normally have multiple browser tabs, a spreadsheet, and a cup of coffee. Claude can hold all that context and work through it systematically - but you need to tell it what "done" looks like.

**Cowork vs regular Claude Code:**
With Claude Code, I'd be iterating in conversation. Cowork felt more like delegating a task to a colleague - here's the brief, here's what good looks like, let me know when you're finished.

For my next trip, I'll be scanning receipts as I go - knowing that the tedious reconciliation at the end is no longer tedious at all.

Till next time.
