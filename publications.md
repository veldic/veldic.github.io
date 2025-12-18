---
layout: default
title: "Publications"
permalink: /publications
---

<section class="page-hero">
  <h1>Publications</h1>
  <p>
    <!-- add anything you want -->
  </p>
</section>

<section class="publication-list">
  {% for pub in site.data.publications %}
  {% include publication-card.html pub=pub detailed=true %}
  {% endfor %}
</section>
