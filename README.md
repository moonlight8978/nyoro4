# Nyoro4

#### About App
* Twitter Clone App (Main features)
* For learning purpose

#### Technology
* Rails 5.x Fullstack

#### Environment
###### OS:
```shell
> systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
OS Name:                   Microsoft Windows 10 Pro
OS Version:                10.0.16299 N/A Build 16299
```

###### Ruby:
```shell
$ ruby --version
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-linux]
```

###### Rails:
```shell
$ rails --version
Rails 5.1.5
```

###### Database:
* Username: postgres
* Password: 1221
* Client:

```shell
$ psql --version
psql (PostgreSQL) 9.5.10
```

* Server:

```shell
postgres=# select version();
                          version
------------------------------------------------------------
 PostgreSQL 10.0, compiled by Visual C++ build 1800, 64-bit
(1 row)
```

#### Dependencies
* Redis: `$ sudo apt-get install redis-server`
* Elasticsearch: `$ sudo apt-get install elasticsearch`
* ImageMagick: `$ sudo apt-get install imagemagick`
* libidn: `$ sudo apt-get install libidn11-dev idn`
* Yarn

#### Run
* `$ bundle install`
* `$ yarn install`
* `$ rake db:drop db:create db:schema:load db:seed`
* `$ rails s`

#### TODO
* ~~Settings pages~~
* ~~Following~~
* ~~User profile~~
* ~~Tweet, Retweet/Favorite Tweet~~
* ~~Reply, Retweet/Favorite Reply~~
* ~~Hashtag~~
* ~~Mention~~
* ~~Search~~
* ~~Fix delete tweet/reply~~
* Profile page
* Tweet composer (改)
* Newfeed
* Support Docker
