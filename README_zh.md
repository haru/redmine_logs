# 红矿（Redmine)记录观察器插件

## 大要

* 在管理UI上这个插件能观察红矿的记录。
* 这个插件分叉从[这里](https://github.com/haru/redmine_logs)。谢谢你。

## 机能

为了安全记录管理，这个插件不能删除记录。经由SSH请删除记录，如果您删除记录。

|机能|可以|
|----|----|
|观察记录|是|
|下载记录|是|
|删除记录|不是|

## 安装

```
cd <path_to_redmine>/plugins
git clone https://github.com/agileware-jp/redmine_logs_view.git

cd ..
bundle install
bundle exec rake redmine:plugins RAILS_ENV=production
```

重启动红矿服务

## 维护者

[Agileware Inc](https://agileware.jp)
