---
layout: page
title: 咕咚
tagline:
---
{% include JB/setup %}

<ul class="posts" id="posts">
  {% for post in site.posts %}
  
    {% if post.title != "关于" and post.title != "编程之路" and  post.title != "我的项目"  %}
    
    
    <li>
     <h3 class="post-title">
        <a href="{{ BASE_PATH }}{{ post.url }}">
          {{ post.title }}
        </a>
      </h3>
      <div class="datatime">
         <span>{{ post.date | date: "%m/%d/%Y" }}</span>
      </div>
      <div class="post-content">
             {{ post.excerpt }}
      </div>

    </li>
    {% endif %}
  {% endfor %}
</ul>
<ul class="pager" id="pager">

  {% if paginator.previous_page %}
  <li class="previous">
    {% if paginator.previous_page == 1 %}
    <a href="{{ BASE_PATH }}/">&larr;</a>
    {% else %}
    <a href="{{ BASE_PATH }}/{{ site.paginate_path | replace: ':num', paginator.previous_page }}">&larr;</a>
    {% endif %}
  </li>
  {% else %}
  <li class="previous disabled">
    <a>&larr;</a>
  </li>
  {% endif %}



  {% if paginator.next_page %}
  <li class="next">
    <a href="{{ BASE_PATH }}/{{ site.paginate_path|replace: ':num',paginator.next_page }}">&rarr;</a>
  </li>
  {% else %}
  <li class="next disabled">
    <a>&rarr;</a>
  </li>
  {% endif %}
  
</ul>

