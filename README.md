# Veldic Theme

Custom Jekyll theme for a researcher/portfolio site. The repository ships a minimal content set so you can tweak presentation without touching layouts.

## Pages

| Path | Description |
| --- | --- |
| `/` | Landing page with hero, publication highlights, education, and experience. |
| `/publications/` | Full list of publications rendered from `_data/publications.yml`. |
| `/photos/` | Photo diary fed by `_data/photos.yml` featuring hover overlays, lightweight thumbnails, and a lightbox. |

## Data-driven sections

Edit `_data/*` files to update content:

- `information.yml` – hero text, contact links, education, experience.
- `publications.yml` – title, authors, venue, and links for each paper/project.
- `photos.yml` – photo title, date, image path, and optional thumbnail override for the gallery.

## Photo thumbnails

- Grid cards load thumbnails from `assets/images/photos/thumbnails/` while the viewer still opens the original file.
- Run `bash scripts/generate_photo_thumbnails.sh` to regenerate thumbnails locally.
- GitHub Actions automatically refreshes thumbnails on pushes that change photos or the generator workflow.

## Development

1. Install dependencies: `bundle install`
2. Run locally: `bundle exec jekyll serve`
3. Build for production: `bundle exec jekyll build`
