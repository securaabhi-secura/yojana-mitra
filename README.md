# Yojana Mitra — Govt Scheme Awareness Chatbot

Static frontend (GitHub Pages) + Supabase (Postgres) backend. No server/PHP needed.

## What it does
- **Ask a question** mode: free-text chat, keyword-matches your query against a schemes table.
- **Check eligibility** mode: structured form (age, gender, income, occupation) → returns schemes you likely qualify for.
- All matching happens client-side in JS against data fetched from Supabase.

## Files
- `index.html` — the entire app (UI + logic), single self-contained file
- `supabase-schema.sql` — creates the `schemes` table, enables Row Level Security with public read-only access, and seeds 10 real government schemes
- `config.example.js` — template for your Supabase credentials
- `config.js` — your actual credentials (gitignored, you create this)

## 1. Set up Supabase
1. Go to [supabase.com](https://supabase.com) → create a free project.
2. Once it's ready: **SQL Editor** → New query → paste the contents of `supabase-schema.sql` → Run.
   This creates the `schemes` table, seeds it with 10 schemes, and sets a public read-only policy.
3. **Project Settings → API** → copy your **Project URL** and **anon public** key.

## 2. Configure the app
1. Copy `config.example.js` → `config.js`
2. Fill in your `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
   (The anon key is safe to expose client-side — Row Level Security only allows reads, no writes.)

## 3. Deploy on GitHub Pages
1. Create a new GitHub repo (e.g. `yojana-mitra`) and push all these files, **including your real `config.js`** this time — GitHub Pages is static hosting, so `config.js` must be in the repo for the live site to read it. (Since the anon key is public-safe, this is fine.)
2. Repo → **Settings → Pages** → Source: `Deploy from a branch` → Branch: `main` / `root` → Save.
3. GitHub gives you a URL like `https://<your-username>.github.io/yojana-mitra/` — that's your live demo link.

## Extending it (good "future scope" talking points for your pitch)
- Add more schemes — just insert more rows into the `schemes` table via Supabase's Table Editor
- Swap keyword matching for a proper NLP/LLM-based intent match (could call an LLM API from the client, or add a Supabase Edge Function)
- Add Hindi language support in the UI
- Add a "nearest CSC/govt office" locator using Google Maps API
- Enforce `eligibility_state` filtering (column exists in the schema but isn't used in matching logic yet — easy next addition)
