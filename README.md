[![CircleCI](https://circleci.com/gh/wfischer42/sweater-weather-wf/tree/master.svg?style=svg)](https://circleci.com/gh/wfischer42/sweater-weather-wf/tree/master) [![Maintainability](https://api.codeclimate.com/v1/badges/9d4050ddfe04beae6b5a/maintainability)](https://codeclimate.com/github/wfischer42/sweater-weather-wf/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/9d4050ddfe04beae6b5a/test_coverage)](https://codeclimate.com/github/wfischer42/sweater-weather-wf/test_coverage) [![Waffle.io - Columns and their card count](https://badge.waffle.io/wfischer42/sweater-weather-wf.svg?columns=all)](https://waffle.io/wfischer42/sweater-weather-wf)


# README
[Sweater Weather](https://sweaters-api.herokuapp.com) is a Rails API practice project. It allows users to create accounts, then retrieve weather data for various locations and save their favorite locations. It will eventually be consumed by a front-end weather application.

### Local Setup
It uses `Ruby 2.4.1` on `Rails 5.2.2`. Fork and clone it, run `bundle`, then spin up the server with `rails s`

### Primary Endpoint
Request forecast data for a location:
```json
https://sweaters-api.herokuapp.com/api/v1/forecast?location_query=denver
```

### Built With
Ruby 2.4.1
Rails 5.2.2
Rspec
Redis
