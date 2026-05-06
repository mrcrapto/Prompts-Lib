# Prompt Library

A clean, fast, single-page library for organizing your AI prompts. Save them in a grid, copy with one click, tag with the models that work best, and switch between light and dark themes.

No build step, no dependencies, no backend — just one HTML file.

## Features

- **Grid layout** with thumbnail, title, prompt preview, and recommended models per card
- **One-click copy** straight to clipboard
- **Two ways to add a thumbnail** — paste an image URL or upload from your device (drag-and-drop supported, auto-compressed before saving)
- **Image preview** when you open a prompt — full-width hero on the detail view
- **Recommended LLMs** — tag each prompt with ChatGPT, Claude, Gemini, DeepSeek, Qwen, and Grok
- **Search & filter** — search by title or content, filter by recommended model
- **Light & Dark theme** with system preference detection, your choice is remembered
- **Persistent storage** — everything saves to your browser's `localStorage` automatically
- **Export & Import** — back up your library to a JSON file or import on another device
- **Keyboard shortcuts** — `Cmd/Ctrl+K` for search, `Cmd/Ctrl+N` for new prompt, `Esc` to close modals
- **Responsive** — works on phones, tablets, and desktops

## Try it

Open `index.html` in any modern browser. That's it.

## Deploy to GitHub Pages

1. Create a new GitHub repository
2. Push these files to it:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
   git push -u origin main
   ```
3. Go to **Settings → Pages** in your repo
4. Under **Source**, select **Deploy from a branch**, choose `main` and `/ (root)`, then **Save**
5. After a minute, your library will be live at `https://YOUR-USERNAME.github.io/YOUR-REPO/`

## Tech

- Vanilla HTML, CSS, and JavaScript — no frameworks, no build step
- Fonts: [Fraunces](https://fonts.google.com/specimen/Fraunces) and [Geist](https://fonts.google.com/specimen/Geist) via Google Fonts
- Storage: browser `localStorage` (~5–10 MB per origin, plenty for hundreds of prompts)
- Image compression done client-side via Canvas

## Data & privacy

Everything stays in your browser. No server, no analytics, no tracking. If you clear your browser data, your prompts go with it — that's what the **Export** button is for. Export to JSON regularly if your library is important to you.

## License

MIT — see [LICENSE](./LICENSE).
