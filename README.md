# Ruby using Watir & Rspec
This project utilizes Watir & Rspec to create automated tests.

## Assumptions
This project assumes Ruby version 2.5.0 and utilizes the current versions of rspec (3.7.0) and watir (6.10.3).
Chromedriver (http://brewformulas.org/Chromedriver) is required and assumed to be in your current path.

## Installation
```
bundle install --binstubs
```

## Running the tests
Tests were created in two fashions:
1. With Page Objects
2. Without Page Objects

To run all tests
```
bin/rspec .
```

To run a specific test (I.e. test without page object)
```apple js
bin/rspec spec/home_page_spec.rb
```

