# Mini Hacker News Clone


##### 前置需求

請確保 Ruby 版本為 2.7.4。
- Ruby 2.7.4
- Rails 6.1.4
- PostgreSQL
- crontab

##### 1. 將專案複製至本機

```
git clone https://github.com/JesseHung/mini-hacker-news-clone.git
```


##### 2. 安裝套件

```
bundle install
```


##### 3. 資料庫建置

執行以下指令以建立資料庫。
```ruby
rails db:create
rails db:migrate
```


##### 4. 準備填充資料

請依序在 Terminal 執行以下指令以新建填充資料。
以下共會建立 100 名使用者，100 則貼文以及共 1000 個貼文基本點數分散於所有貼文。
```
rake generate_test_users
rake generate_posts
```


##### 5. 設定 Crontab 

利用 whenever gem 設定 crontab 以達成每分鐘更新一次權重分數功能。請在 Terminal 執行以下指令：
```
whenever --update-crontab --set environment='development'
```


##### 6. 執行 Rails Server

```ruby
rails s
```

打開瀏覽器並且進入網頁 http://localhost:3000 即可使用 Mini Hacker News Clone.
