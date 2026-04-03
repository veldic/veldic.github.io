---
layout: default
title: "Photos"
permalink: /photos
---
{% assign photos = site.data.photos %}

<section class="page-hero">
  <h1>Photos</h1>
  <p>
    As an amateur photographer, I’d like to show some of my photos here. Feel free to browse around and enjoy.
  </p>
</section>

<section class="photo-grid">
  {% for photo in photos %}
  {% assign photo_thumbnail = photo.thumbnail %}
  {% unless photo_thumbnail %}
    {% assign photo_thumbnail = photo.image | replace: '/assets/images/photos/', '/assets/images/photos/thumbnails/' %}
  {% endunless %}
  <figure class="photo-card">
    <button type="button" class="photo-media"
            data-image="{{ photo.image }}"
            data-thumbnail="{{ photo_thumbnail }}"
            data-title="{{ photo.title }}"
            data-date="{{ photo.date }}"
            aria-label="{{ photo.title }}">
      <img src="{{ photo_thumbnail }}"
           alt=""
           aria-hidden="true"
           loading="lazy"
           decoding="async"
           onerror="this.onerror=null;this.src='{{ photo.image }}';">
      <div class="photo-overlay">
        <h2>{{ photo.title }}</h2>
        <p>{{ photo.date }}</p>
      </div>
    </button>
  </figure>
  {% endfor %}
</section>

<div class="photo-lightbox" id="photo-lightbox" aria-hidden="true">
  <div class="lightbox-backdrop" id="lightbox-backdrop"></div>
  <div class="lightbox-content" role="dialog" aria-modal="true" aria-labelledby="lightbox-title" aria-describedby="lightbox-date">
    <button class="lightbox-close" type="button" aria-label="Close photo viewer">&times;</button>
    <div class="lightbox-media" id="lightbox-media">
      <img src="" alt="" class="lightbox-preview" id="lightbox-preview" aria-hidden="true">
      <img src="" alt="" class="lightbox-image" id="lightbox-image">
    </div>
    <div class="lightbox-info">
      <p class="lightbox-title" id="lightbox-title"></p>
      <p class="lightbox-date" id="lightbox-date"></p>
    </div>
  </div>
</div>

<script>
  (function() {
    var lightbox = document.getElementById('photo-lightbox');
    if (!lightbox) return;
    var mediaEl = document.getElementById('lightbox-media');
    var previewEl = document.getElementById('lightbox-preview');
    var imageEl = document.getElementById('lightbox-image');
    var titleEl = document.getElementById('lightbox-title');
    var dateEl = document.getElementById('lightbox-date');
    var closeBtn = lightbox.querySelector('.lightbox-close');
    var backdrop = document.getElementById('lightbox-backdrop');
    var loadToken = 0;
    function openLightbox(target) {
      var src = target.dataset.image;
      var thumbnail = target.dataset.thumbnail || src;
      var title = target.dataset.title;
      var date = target.dataset.date;
      var currentLoadToken = ++loadToken;
      mediaEl.classList.remove('is-loaded');
      previewEl.src = thumbnail;
      previewEl.onerror = function() {
        if (currentLoadToken !== loadToken) return;
        this.onerror = null;
        this.src = src;
      };
      imageEl.removeAttribute('src');
      imageEl.alt = title;
      imageEl.onload = function() {
        if (currentLoadToken !== loadToken) return;
        mediaEl.classList.add('is-loaded');
      };
      imageEl.onerror = function() {
        if (currentLoadToken !== loadToken) return;
        mediaEl.classList.add('is-loaded');
      };
      imageEl.src = src;
      titleEl.textContent = title;
      dateEl.textContent = date;
      lightbox.classList.add('is-open');
      lightbox.setAttribute('aria-hidden', 'false');
    }
    function closeLightbox() {
      loadToken += 1;
      lightbox.classList.remove('is-open');
      lightbox.setAttribute('aria-hidden', 'true');
      mediaEl.classList.remove('is-loaded');
      previewEl.src = '';
      previewEl.onerror = null;
      imageEl.removeAttribute('src');
      imageEl.onload = null;
      imageEl.onerror = null;
      titleEl.textContent = '';
      dateEl.textContent = '';
    }
    document.querySelectorAll('.photo-media').forEach(function(btn) {
      btn.addEventListener('click', function() {
        openLightbox(btn);
      });
    });
    closeBtn.addEventListener('click', closeLightbox);
    backdrop.addEventListener('click', closeLightbox);
    document.addEventListener('keydown', function(evt) {
      if (evt.key === 'Escape' && lightbox.classList.contains('is-open')) {
        closeLightbox();
      }
    });
  })();
</script>
