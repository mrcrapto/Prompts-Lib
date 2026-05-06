# Prompt Library

A clean, public library where anyone can browse and contribute AI prompts. Grid layout, one-click copy, recommended models per prompt, light & dark themes.

Hosted free on **Supabase** (database + image storage) and **GitHub Pages** (the site itself).

## Features

- **Public read + submit** — visitors can browse all prompts and contribute their own
- **Owner-only edit & delete** — protected by a password you set once in the database
- **Thumbnails** — paste an image URL or upload from device (auto-compressed before upload)
- **Recommended models** — tag each prompt with ChatGPT, Claude, Gemini, DeepSeek, Qwen, or Grok
- **Search & filter** — search by title or content, filter by recommended model
- **Light & dark themes** with system preference detection
- **One-click copy** to clipboard
- **Optional submitter name** — credits the contributor on each card
- **Fully responsive** — works on phones, tablets, desktops
- **Keyboard shortcuts** — `Cmd/Ctrl+K` for search, `Cmd/Ctrl+N` to submit, `Esc` closes modals

## Setup (≈ 10 minutes)

### 1. Create a free Supabase project

1. Go to [supabase.com](https://supabase.com) and sign up
2. Click **New Project**, pick any name and region (the closer to your users, the faster)
3. Wait ~2 minutes for it to provision

### 2. Run the database setup

1. In your Supabase dashboard, open **SQL Editor** → **New query**
2. Open `setup.sql` from this repo, copy the contents
3. **Important:** find the two lines that say `'CHANGE_THIS_TO_A_LONG_RANDOM_STRING'` and replace both with the same long random password (this is your owner password — use 20+ random characters)
4. Paste into the SQL Editor and click **Run**

### 3. Get your project credentials

In Supabase, go to **Project Settings → API**. Copy these two values:

- **Project URL** — looks like `https://xxxx.supabase.co`
- **anon public key** — long string starting with `eyJ…` (this is **safe to publish** — RLS controls what it can do)

### 4. Edit `index.html`

Open `index.html` in any text editor. Near the top of the `<script>` section, you'll see:

```js
const SUPABASE_CONFIG = {
  url:     'YOUR_SUPABASE_URL_HERE',
  anonKey: 'YOUR_SUPABASE_ANON_KEY_HERE'
};
```

Paste your URL and anon key. Save the file.

### 5. Deploy to GitHub Pages

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
git push -u origin main
```

Then in your repo: **Settings → Pages → Source** → select `main` branch / `/ (root)` → **Save**. After ~1 minute your library is live at `https://YOUR-USERNAME.github.io/YOUR-REPO/`.

### 6. Become the owner

Once configured and deployed:

1. Open the site
2. Click the **gear icon** in the header
3. Enter the password you set in step 2
4. You'll see a green "Owner" badge appear, and edit/delete buttons unlock on cards

The password is stored on **your device only** in localStorage — it's never sent to GitHub or anywhere except your own Supabase project. You'll need to re-enter it on each new device you want owner access from.

## Security & moderation notes

- **Anyone can submit prompts** — that's the point of a public library, but it means you should monitor for spam or inappropriate content
- **Only you can delete or edit** — the owner password is the gate
- **Image uploads are public-readable** in your Supabase Storage bucket, but only writable through the site
- **The anon key is safe to publish** — it's the public key designed for client-side use; what it can actually do is determined by your RLS policies (which we configured to be read + insert only)
- If a bad prompt gets through, sign in as owner and click the edit pencil on the card to delete it
- For more aggressive moderation, you can disable public inserts in Supabase and re-enable them after review — see the policies in `setup.sql`

## Free tier limits

Supabase free tier gives you:
- 500 MB database storage (room for tens of thousands of prompts)
- 1 GB file storage (~10,000 thumbnails at 100 KB each)
- 5 GB bandwidth/month
- Pauses after 1 week of inactivity (resumes instantly on first request)

For most personal/community libraries this is more than enough.

## Tech

- Vanilla HTML, CSS, JavaScript — no framework, no build step
- [Supabase JS client](https://supabase.com/docs/reference/javascript) v2 via CDN
- Fonts: [Fraunces](https://fonts.google.com/specimen/Fraunces) + [Geist](https://fonts.google.com/specimen/Geist)
- Image compression done client-side via Canvas before upload

## File structure

```
.
├── index.html       ← the entire app
├── setup.sql        ← run this once in Supabase SQL Editor
├── README.md        ← you are here
├── LICENSE          ← MIT
└── .gitignore
```

## License

MIT — see [LICENSE](./LICENSE).
