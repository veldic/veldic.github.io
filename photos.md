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
  <figure class="photo-card">
    <button type="button" class="photo-media" style="background-image: url('{{ photo.image | default: "" }}');"
            data-image="{{ photo.image }}"
            data-title="{{ photo.title }}"
            data-date="{{ photo.date }}"
            aria-label="{{ photo.title }}">
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
  <div class="lightbox-content" role="dialog" aria-modal="true">
    <button class="lightbox-close" type="button" aria-label="Close photo viewer">&times;</button>
    <img src="" alt="" id="lightbox-image">
    <p class="lightbox-caption" id="lightbox-caption"></p>
  </div>
</div>

<script>
  (function() {
    var lightbox = document.getElementById('photo-lightbox');
    if (!lightbox) return;
    var imageEl = document.getElementById('lightbox-image');
    var captionEl = document.getElementById('lightbox-caption');
    var closeBtn = lightbox.querySelector('.lightbox-close');
    var backdrop = document.getElementById('lightbox-backdrop');
    function openLightbox(target) {
      var src = target.dataset.image;
      var title = target.dataset.title;
      var date = target.dataset.date;
      imageEl.src = src;
      imageEl.alt = title;
      captionEl.textContent = title + ' — ' + date;
      lightbox.classList.add('is-open');
      lightbox.setAttribute('aria-hidden', 'false');
    }
    function closeLightbox() {
      lightbox.classList.remove('is-open');
      lightbox.setAttribute('aria-hidden', 'true');
      imageEl.src = '';
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
