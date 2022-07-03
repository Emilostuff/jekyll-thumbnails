# jekyll-thumbnails
A Jekyll plugin to replace images with a lower resolution thumbnail for optimized performance.


# Installation
In gemfile:

```
gem 'jekyll-thumbnails', git: 'https://github.com/Emilostuff/jekyll-thumbnails', group: :jekyll_plugins
```

# Usage
To generate and insert image with desired WIDTH:

```
{% thumbnail path/to/image.jpg WIDTH %}
```

# Example
In Liquid template:
```
<img src="{% thumbnail path/to/image.jpg 500 %}">
```
