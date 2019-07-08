#!/usr/local/bin/python3
from requests import get
from json import load, dump

# Read developer and location info
devInfoFilename = "devinfo.json"
with open(devInfoFilename, 'r') as f:
    devinfo = load(f)

latitude = devinfo["latitude"]
longitude = devinfo["longitude"]
apiKey = devinfo["apiKey"]

apiCallFormat='https://api.darksky.net/forecast/%s/%f,%f?extend=hourly&units=us'

outputFilename = "response.json"

#-------------------------

# Format call
apiCall = apiCallFormat % (apiKey, latitude, longitude)

# GET
resp = get(apiCall)
if resp.status_code != 200:
    raise ApiError('GET {}'.format(resp.status_code))

# Write
with open(outputFilename, 'w') as f:
    dump(resp.json(), f)
