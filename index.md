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
      <a class="contact-link" href="{{ link.url }}">{{ link.label }}</a>
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
    <a class="button text" href="{{ "/publications/" | relative_url }}">View More</a>
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
