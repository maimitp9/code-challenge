# Code Challenge

Design a web application that allows employees to submit feedback toward each other's performance review.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Introduction

### Admin view
* Add/remove/update/view employees
* Add/update/view performance reviews
* Assign employees to participate in another employee's performance review

### Employee view
* List of performance reviews requiring feedback
* Submit feedback

### Prerequisites

* Ruby version

  - Ruby-2.7.2

* Rails vesrion

  - Rails-6.0.3.3

* Frontend
  - Vue.js - 2.6.12

* Testing framework
  - RSpec

### Installing

A step by step series of examples that tell you how to get a development env running.

- Clone this repository

```
https://github.com/maimitp9/code-challenge.git
```

- Move to the `code-challenge` directory from your terminal

```
cd code-challenge
```

- Install bundle to install the application dependencies

```
bundle install
```

- Install yarn dependencies

```
yarn install
```


## Database Configuration

*PostgreSQL* used as database for this application.
> Make sure PostgreSQL is installed in your machine and you have setup the  `database.yml` file correctly

- Database creation

```
bundle exec rails db:create
```

- Tables migration

```
bundle exec rails db:migrate
```

- check the *db/schema.rb* after migration completed successfully
- Run *db/seed.rb* file to create `admin user` for application login

```
bundle exec rails db:seed
```

## Running Tests

Test cases written using *RSpec*

### Test includes

- Model specs
- Request specs - Due to the time limit not written

### How to run tests

Run this command

```
bundle exec rspec
```

All the tests should be *GREEN* to pass all test cases

## Running Application

- Starting application

> Make sure you are in the application folder and already installed application dependencies

```
foreman start
```

- Check the application on browser, open the any browser of your choice and hit the following in the browser url *http://localhost:3000/*

> Make sure server listen on port 3000

```
localhost:3000
```

- Use the `admin user` credentials that we have created in above step.
> Check an attached video in this zip file for better understanding of application flow.

- *This application can not meet the full specification requirement there are some functionalities are still pending*

## Author

* **Maimit Patel** - [GitHub profile](https://github.com/maimitp9)
