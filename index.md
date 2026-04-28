---
layout: default
title: "Home"
---
{% assign info = site.data.information %}

<section class="hero">
  <div class="hero-text">
    <p class="eyebrow">{{ info.hero.eyebrow }}</p>
    <h1>{{ info.hero.name }}</h1>
    <p class="subtitle">{{ info.hero.subtitle }}</p>
    {% for paragraph in info.hero.intro %}
    <p>{{ paragraph }}</p>
    {% endfor %}
    <div class="hero-links">
      {% for link in info.contact_links %}
      {% assign contact_kind = link.icon | default: link.label | downcase %}
      {% assign contact_icon = "" %}
      {% case contact_kind %}
        {% when "email" %}
          {% assign contact_icon = "/assets/icons/mail.svg" | relative_url %}
        {% when "mail" %}
          {% assign contact_icon = "/assets/icons/mail.svg" | relative_url %}
        {% when "e-mail" %}
          {% assign contact_icon = "/assets/icons/mail.svg" | relative_url %}
        {% when "github" %}
          {% assign contact_icon = "/assets/icons/github.svg" | relative_url %}
        {% when "linkedin" %}
          {% assign contact_icon = "/assets/icons/linkedin.svg" | relative_url %}
      {% endcase %}
      <a class="contact-link"
         href="{{ link.url }}"
         {% unless link.url contains "mailto:" %}target="_blank" rel="noopener noreferrer"{% endunless %}
         {% if contact_icon != "" %}style="--contact-icon: url('{{ contact_icon }}');"{% endif %}>
        {% if contact_icon != "" %}
        <span class="contact-link-icon" aria-hidden="true"></span>
        {% endif %}
        <span class="contact-link-label">{{ link.label }}</span>
      </a>
      {% endfor %}
    </div>
  </div>
  <div class="hero-visual">
    {% assign hero_photo = info.hero.photo %}
    {% if hero_photo and hero_photo.src %}
    <div class="profile-photo has-image">
      <img src="{{ hero_photo.src }}" alt="{{ hero_photo.alt | default: info.hero.name }}">
    </div>
    {% else %}
    <div class="profile-photo" aria-label="Profile photo placeholder">{{ info.hero.profile_placeholder }}</div>
    {% endif %}
  </div>
</section>

<section class="home-section" id="featured-publications">
  <div class="section-heading">
    <div>
      <p class="eyebrow">Publications</p>
    </div>
    <a class="button text" href="{{ "/publications" | relative_url }}">View More</a>
  </div>
  <div class="publication-grid">
    {% for pub in site.data.publications limit: 2 %}
    {% include publication-card.html pub=pub %}
    {% endfor %}
  </div>
</section>



<section class="home-section" id="education">
  <p class="eyebrow">{{ info.education.eyebrow }}</p>
  {% if info.education.heading %}
  <h2>{{ info.education.heading }}</h2>
  {% endif %}
  <div class="education-list">
    {% for entry in info.education.entries %}
    <article class="education-card">
      <div class="education-row">
        <span class="education-degree">{{ entry.degree }}</span>
        <span class="education-school">{{ entry.school }}</span>
        {% if entry.period %}
        <span class="education-period">{{ entry.period }}</span>
        {% endif %}
      </div>
    </article>
    {% endfor %}
  </div>
</section>

{% if info.experiences %}
<section class="home-section" id="experience">
  <p class="eyebrow">{{ info.experiences.eyebrow }}</p>
  <div class="education-list">
    {% for entry in info.experiences.entries %}
    <article class="education-card">
      <div class="education-row">
        <span class="education-degree">{{ entry.role }}</span>
        <span class="education-school">{{ entry.organization }}</span>
        {% if entry.period %}
        <span class="education-period">{{ entry.period }}</span>
        {% endif %}
      </div>
    </article>
    {% endfor %}
  </div>
</section>
{% endif %}

{% if site.data.photos.size > 0 %}
<section class="home-section home-photo-preview" id="featured-photos">
  <div class="section-heading">
    <div>
      <p class="eyebrow">Photos</p>
    </div>
    <a class="button text" href="{{ "/photos" | relative_url }}">View All</a>
  </div>
  <div class="photo-slideshow" data-home-slideshow>
    <div class="photo-slideshow-viewport">
      <div class="photo-slideshow-track">
        {% for photo in site.data.photos limit: 8 %}
        {% assign photo_thumbnail = photo.thumbnail %}
        {% unless photo_thumbnail %}
          {% assign photo_thumbnail = photo.image | replace: '/assets/images/photos/', '/assets/images/photos/thumbnails/' %}
        {% endunless %}
        <a class="photo-slide"
           href="{{ "/photos" | relative_url }}"
           data-slide-index="{{ forloop.index0 }}"
           aria-label="View photos: {{ photo.title | escape }} from {{ photo.date | escape }}">
          <img src="{{ photo_thumbnail | relative_url }}"
               alt="{{ photo.title | escape }}, {{ photo.date | escape }}"
               {% if forloop.first %}loading="eager" fetchpriority="high"{% else %}loading="lazy"{% endif %}
               decoding="async"
               onerror="this.onerror=null;this.src='{{ photo.image | relative_url }}';">
          <span class="home-photo-caption" aria-hidden="true">
            <span class="home-photo-title">{{ photo.title }}</span>
            <span class="home-photo-date">{{ photo.date }}</span>
          </span>
        </a>
        {% endfor %}
      </div>
    </div>
    <div class="photo-slideshow-controls">
      <button type="button" class="photo-slideshow-button" data-slide-prev aria-label="Previous photo">
        <span aria-hidden="true">&lt;</span>
      </button>
      <div class="photo-slideshow-dots" aria-label="Photo slideshow">
        {% for photo in site.data.photos limit: 8 %}
        <button type="button"
                class="photo-slideshow-dot{% if forloop.first %} is-active{% endif %}"
                data-slide-dot="{{ forloop.index0 }}"
                aria-label="Show photo {{ forloop.index }}"></button>
        {% endfor %}
      </div>
      <button type="button" class="photo-slideshow-button" data-slide-next aria-label="Next photo">
        <span aria-hidden="true">&gt;</span>
      </button>
    </div>
  </div>
</section>
{% endif %}

<script>
  (function() {
    var slideshow = document.querySelector('[data-home-slideshow]');
    if (!slideshow) return;

    var track = slideshow.querySelector('.photo-slideshow-track');
    var slides = Array.prototype.slice.call(slideshow.querySelectorAll('.photo-slide'));
    var dots = Array.prototype.slice.call(slideshow.querySelectorAll('[data-slide-dot]'));
    var prevButton = slideshow.querySelector('[data-slide-prev]');
    var nextButton = slideshow.querySelector('[data-slide-next]');
    var activeIndex = 0;
    var timer = 0;
    var interval = 5500;
    var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    function getVisibleCount() {
      var visibleCount = parseInt(window.getComputedStyle(slideshow).getPropertyValue('--photo-visible-count'), 10);
      return Math.min(slides.length, Math.max(1, visibleCount || 1));
    }

    function getMaxIndex() {
      return Math.max(0, slides.length - getVisibleCount());
    }

    function updateControls(maxIndex) {
      dots.forEach(function(dot, dotIndex) {
        var isAvailable = dotIndex <= maxIndex;
        dot.hidden = !isAvailable;
        dot.disabled = !isAvailable;
        dot.classList.toggle('is-active', dotIndex === activeIndex);
      });

      var isStatic = maxIndex === 0;
      slideshow.classList.toggle('is-static', isStatic);
      if (prevButton) prevButton.disabled = isStatic;
      if (nextButton) nextButton.disabled = isStatic;
    }

    function setActive(index) {
      if (!slides.length) return;
      var visibleCount = getVisibleCount();
      var maxIndex = getMaxIndex();
      activeIndex = (index + maxIndex + 1) % (maxIndex + 1);

      track.style.transform = 'translate3d(-' + slides[activeIndex].offsetLeft + 'px, 0, 0)';

      slides.forEach(function(slide, slideIndex) {
        var isVisible = slideIndex >= activeIndex && slideIndex < activeIndex + visibleCount;
        slide.classList.toggle('is-active', isVisible);
        slide.setAttribute('aria-hidden', isVisible ? 'false' : 'true');
        slide.tabIndex = isVisible ? 0 : -1;
      });

      updateControls(maxIndex);
    }

    function stop() {
      if (!timer) return;
      window.clearInterval(timer);
      timer = 0;
    }

    function start() {
      if (reduceMotion || getMaxIndex() === 0) return;
      stop();
      timer = window.setInterval(function() {
        setActive(activeIndex + 1);
      }, interval);
    }

    if (getMaxIndex() === 0) {
      setActive(0);
      slideshow.classList.add('is-static');
      return;
    }

    prevButton.addEventListener('click', function() {
      setActive(activeIndex - 1);
      start();
    });

    nextButton.addEventListener('click', function() {
      setActive(activeIndex + 1);
      start();
    });

    dots.forEach(function(dot) {
      dot.addEventListener('click', function() {
        setActive(Number(dot.dataset.slideDot));
        start();
      });
    });

    slideshow.addEventListener('mouseenter', stop);
    slideshow.addEventListener('mouseleave', start);
    slideshow.addEventListener('focusin', stop);
    slideshow.addEventListener('focusout', function(evt) {
      if (slideshow.contains(evt.relatedTarget)) return;
      start();
    });
    window.addEventListener('resize', function() {
      setActive(Math.min(activeIndex, getMaxIndex()));
      start();
    });

    setActive(0);
    start();
  })();
</script>
