# Redmine Logs View

## Summary

* This plugin lets you view and download Redmine logs (`logs/*`) from Redmine Administration page.
* This plugin is forked from <https://github.com/haru/redmine_logs>. Thanks!
    * A function to delete logs is intentionally omitted for log management security.

[中文](README_zh.md)

## Install

```
cd <path_to_redmine>/plugins
git clone https://github.com/agileware-jp/redmine_logs.git

cd ..
bundle install
bundle exec rake redmine:plugins RAILS_ENV=production
```

and restart Redmine.

## Original Author

[Haruyuki Iida](https://github.com/haru/)

## Maintainer

* [Agileware Inc](https://agileware.jp)
