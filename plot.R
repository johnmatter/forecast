library(ggplot2)
library(anytime)
library(jsonlite)

# Load
d<-fromJSON("hourly.json")
d$time <- anytime(d$time)

# Convert precipitation units:
# 1) Probability to percent
# 2) Intensity to mm/hour
d$precipProbability <- 100*d$precipProbability
d$precipIntensity <- 25.4*d$precipIntensity

# Format for displaying dates
dates <- data.frame(Date = round(as.POSIXct(unique(anydate(d$time))), "days"))
dates <- mutate(dates,
                Label = paste(format(Date, "%a %m/%d")),
                Midday = as.POSIXct(Date) + 12*60*60
               )

# Location for breaks
breaksPerDay <- c(0, 6, 12, 18)*60*60
hourBreaks <- c()
for (date in dates$Date) {
    for (hour in breaksPerDay) {
        hourBreaks <- c(hourBreaks, date+hour)
    }
}
hourBreaks <- as.POSIXct(anytime(hourBreaks))

dateLims = c(as.POSIXct(min(dates$Date)), as.POSIXct(max(dates$Date))+24*60*60)

# Aesthetics for plotting
colorMap <- c(
              'temp' = 'gray0',
              'feels' = 'forestgreen',
              'precipProb' = 'skyblue1',
              'precipInt' = 'skyblue4'
             )
label_breaks <- c('temp', 'feels', 'precipProb', 'precipInt')
label_labels <- c('Temperature [°F]', 'Feels like [°F]', 'Precipitation probability [%]', 'Precipitation [mm/hr]')

# Plot
p <- ggplot(d) +
        # Where are do days end?
        geom_vline(data = dates, aes(xintercept = as.numeric(Date)), alpha=0.3) +

        # Quantities to plot
        geom_line(aes(x=time,y=temperature, colour="temp"), alpha=0.7) +
        geom_area(aes(x=time,y=temperature, fill="temp"), alpha=0.0) +

        geom_line(aes(x=time,y=apparentTemperature, colour="feels"), alpha=0.7) +
        geom_area(aes(x=time,y=apparentTemperature, fill="feels"), alpha=0.0) +

        geom_line(aes(x=time,y=precipProbability, colour="precipProb"), alpha=0.7) +
        geom_area(aes(x=time,y=precipProbability, fill="precipProb"), alpha=0.3) +

        geom_line(aes(x=time,y=precipIntensity, colour="precipInt"), alpha=0.7) +
        geom_area(aes(x=time,y=precipIntensity, fill="precipInt"), alpha=0.3) +

        # Fill/color
        scale_color_manual(name="Value", values=colorMap, breaks=label_breaks, labels=label_labels) +
        scale_fill_manual(name="Value", values=colorMap, breaks=label_breaks, labels=label_labels) +

        # What time is it now?
        geom_vline(aes(xintercept=Sys.time()), color="red", alpha=0.6) +

        # Text labels for days
        geom_text(data = dates,  aes(x = Midday, label=Label, y=0, vjust=-0.5), check_overlap = TRUE, size = 3.5) +

        # Axes
        scale_y_continuous(breaks=seq(0,100,10)) +
        scale_x_datetime(
            labels = date_format("%H:%M", tz="America/New_York"),
            limits = dateLims,
            breaks = hourBreaks
        ) +

        xlab("") +
        ylab("") +

        # Theme
        theme_bw() +
        theme(axis.text.x = element_text(
                    angle = 45, vjust = 1.0, hjust = 1.0))

# Save
ggsave(plot=p, filename="forecast.png", width=9, height=3)
