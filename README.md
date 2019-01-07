[![CircleCI](https://circleci.com/gh/wfischer42/sweater-weather-wf/tree/master.svg?style=svg)](https://circleci.com/gh/wfischer42/sweater-weather-wf/tree/master) [![Maintainability](https://api.codeclimate.com/v1/badges/9d4050ddfe04beae6b5a/maintainability)](https://codeclimate.com/github/wfischer42/sweater-weather-wf/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/9d4050ddfe04beae6b5a/test_coverage)](https://codeclimate.com/github/wfischer42/sweater-weather-wf/test_coverage) [![Waffle.io - Columns and their card count](https://badge.waffle.io/wfischer42/sweater-weather-wf.svg?columns=all)](https://waffle.io/wfischer42/sweater-weather-wf)


# README
Sweater Weather is a Rails API practice project. It allows users to create accounts, then retrieve weather data for various locations and save their favorite locations. It will eventually be consumed by a front-end weather application.

### Setup
Sweater Weather is not yet deployed, so you'll have to run it locally if you want to try it out. It uses `Ruby 2.4.1` on `Rails 5.2.2`. Fork and clone it, run `bundle`, then spin up the server with `rails s`

### Endpoints
Request forecast data for a city and state:
```json
GET localhost:3000/api/v1/forecast?city=denver&state=co
```
Request images related to the upcoming week's daily forecast:

```json
GET localhost:3000/api/v1/gifs?city=denver&state=co
```

User account creation is on it's way
