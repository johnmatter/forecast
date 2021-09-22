# forecast

_**Please note that this repository will soon be obsolete.
The DarkSky API will be [shut down by late 2022](https://blog.darksky.net).**_

This script generates a png displaying the coming week's forecast.
I've chosen to use Fahrenheit for temperature and millimeters per hour for
precipitation rate, an admittedly unorthodox combination of units.
I made this choice because with these units, values can reasonably be assumed
to span roughly the same orders of magnitude, which happen to have the same
scale as precipitation probability (i.e. between 0 and 100).
This allows us to use the same y-axis ticks for all values.

[Powered by Dark Sky](https://darksky.net/poweredby/ "Dark Sky")

![Example output](forecast_example.png)

### Prerequisites
1. A Dark Sky API key. ~~You can register [here](https://darksky.net/dev).~~ You can no longer register for the API.
2. python3 and modules `requests` and `json`
3. R libraries `ggplot2`, `anytime`, and `jsonlite`

### Usage

1. Clone this repo

   `git clone https://github.com/johnmatter/forecast`

   `cd forecast`

2. Create a file called devinfo.json containing your Dark Sky API key, latitude and longitude

   `echo '{"latitude": 72.5, "longitude": -21.4, "apiKey": "abcdefg"}' > devinfo.json`

3. Run the main script.

   `./run.sh`

### TODO:
1. Move everything into a single R or python script
2. Include measured data from past 24 hours in forecast
3. Add timezone to devinfo.json and remove explicit east coast from plot.R
4. Find a new API!
