#!/bin/sh

# Fetch the current weather information from Open Weather Map service and
# print it on the console.

if [ -f $HOME/.private_exports.sh ]; then
    . $HOME/.private_exports.sh
fi

readonly WEATHER_BASE_URL="http://api.openweathermap.org/data/2.5/weather"
readonly WEATHER_PARAMS_URL="?zip="$LOCATION_ZIP"&units=imperial&APPID="$KAPI_OPEN_WEATHER""

set -e

weather=$(curl --silent $WEATHER_BASE_URL$WEATHER_PARAMS_URL)

city=$(echo "$weather" | jq .name | tr -d '"')
desc="$(echo "$weather" | jq .weather[0].main | sed 's/\"//g')"
temperature="$(echo "$weather" | jq .main.temp)°F"
wind_speed="$(echo "$weather" | jq .wind.speed | awk '{print int($1+0.5)}') MPH"

printf "%s" "$city: $desc, $temperature, $wind_speed"
