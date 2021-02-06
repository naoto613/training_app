# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
  2.6.6p146

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  ・mac で mysql2 が bundle install できないとき
  bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"
