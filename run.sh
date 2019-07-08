#!/bin/bash
# This script generates a png of the week's forecast.
#
# Powered by Dark Sky
# https://darksky.net/poweredby/

# Make a call to the Dark Sky API.
# If successful, save the result as response.json
./getJson.py

# We currently only want the hourly data.
# We'll save that as hourly.json
./parseJson.py

# Plot (some of) the data and save it as forecast.png
Rscript plot.R
