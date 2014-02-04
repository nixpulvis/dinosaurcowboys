# Party Shark [![Build Status](https://travis-ci.org/party-shark/website.png?branch=master)](https://travis-ci.org/party-shark/website)

This is the website for Party Shark, we are a World of Warcraft raiding guild on Stormreaver Horde.

## Setup

This application is build under the assumption the following dependencies are installed. `Postgres 9.3.2`, `Ruby 2.1`, `Rails 4.0`.

To run locally:
```
git clone https://github.com/party-shark/website.git
cd website
bundle install
rake db:create && rake db:migrate && rake db:seed
foreman start
```
