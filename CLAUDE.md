# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Jekyll blog (咕咚同学's blog) hosted at https://blog.gudong.site. The blog uses the [tmaize-blog](https://github.com/TMaize/tmaize-blog) theme - a lightweight, fast-loading Jekyll theme with minimal dependencies.

## Development Commands

### Local Development
```bash
# Install dependencies (first time only)
bundle install

# Start local dev server (default port 8080)
./blog.sh run
# Or specify port
./blog.sh run 4000

# Build to dist directory
./blog.sh build

# Deploy (uses custom ~/bin/blog-deploy-linux script)
./blog.sh deploy
```

### Direct Jekyll Commands
```bash
bundle exec jekyll serve --watch --host=127.0.0.1 --port=8080
bundle exec jekyll build --destination=dist
```

## Architecture

### Content Structure
- **Posts**: `_posts/` - Blog posts named `YYYY-MM-DD-title.md`
- **Assets**: `assets/` - Images and static resources (no date-based subdirectories)
- **Pages**: Root level `.md` files (`about.md`, `index.html`) use `layout: page` or `layout: mypost`
- **Layouts**: `_layouts/` - `mypost.html` (articles), `page.html` (generic pages)
- **Includes**: `_includes/` - Reusable components (header, footer, scripts, analytics)

### Article Frontmatter
```yaml
---
layout: mypost
author: 咕咚同学 或 咕咚
tags: daily 或 think 等
categories: blog
title: "文章标题"
---
```

### Key Configuration
- `_config.yml` - Main Jekyll config (site info, menu, extensions)
- Permalink format: `/:year/:month/:day/:title.html`
- Domain: `https://blog.gudong.site`
- Comments: Utterances (repo: maoruibin/maoruibin.github.com)

### Theme Features
- Dark mode support
- RSS feed at `/static/xml/rss.xml`
- Search functionality
- Tag/category filtering
- Custom menu in `_config.yml`

### Deployment
The blog uses GitHub Pages with custom domain. The `.travis.yml` indicates CI/CD setup, but primary deployment is via the `blog-deploy-linux` script which syncs the `dist/` directory.

## Content Patterns

### Daily Notes (咚记)
- Filename: `YYYY-MM-DD-daily.md`
- Tag: `daily`
- Category: `blog`
- These are short daily updates/reflections

### Technical/Feature Articles
- Use descriptive titles
- Tags: `think`, tech-specific tags
- Include external image links (often WeChat CDN or `doc.gudong.site`)

### Image Handling
- Images stored in `assets/` (flat structure, not date-based)
- External images often use WeChat mmbiz CDN or `doc.gudong.site`
- Local images referenced as `/assets/filename.ext`

## Important Notes

- The `dist/` directory contains generated static files - DO NOT edit directly
- New posts should follow the `YYYY-MM-DD-title.md` naming convention
- The blog author is "咕咚同学" (Gudong), an indie developer who writes about:
  - Indie app development (inBox notes, 仓咚咚 asset manager)
  - Basketball
  - Daily reflections (咚记)
  - Technical thoughts
