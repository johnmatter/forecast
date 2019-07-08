#!/usr/local/bin/python3
from json import load, dump

inputFilename = "response.json"
hourlyFilename = "hourly.json"

#-------------------------

# Read
with open(inputFilename, 'r') as f:
    data = load(f)

# Write hourly data
with open(hourlyFilename, 'w') as f:
    dump(data["hourly"]["data"], f)
