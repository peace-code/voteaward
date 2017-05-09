투표 대잔치
========

### 설치

* ruby 2
* rails 4.2
* mongoid 4.0.2
* mongoid-observers 0.2.0


### 실행

* 환경변수
  * MONGODB
    - 예) mongodb://USER_NAME:PASSWORD@mongodburl.com:PORT/DATA
  * omniauth login
    * TWITTER_KEY
    * TWITTER_SECRET
    * FACEBOOK_KEY
    * FACEBOOK_SECRET
  * image file upload
    * AWS_KEY
    * AWS_SECRET
    * AWS_BUCKET


### 배포

* Capistrano
  * SERVER
  * REPO
  * BRANCH
  * DEPLOYER
