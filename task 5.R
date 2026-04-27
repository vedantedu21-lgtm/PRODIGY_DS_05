library(tidyverse)
library(lubridate)
library(scales)
library(RColorBrewer)
library(viridis)

df <- read.csv("C:/Users/Vedant/Desktop/Prodigy Tasks/Task 5/archive/US_Accidents_March23.csv", stringsAsFactors = FALSE)

df <- df %>% sample_n(1000)

df$Start_Time <- ymd_hms(df$Start_Time)
df$Hour       <- hour(df$Start_Time)
df$Month      <- month(df$Start_Time, label = TRUE, abbr = TRUE)
df$Weekday    <- wday(df$Start_Time, label = TRUE, abbr = TRUE)
df$Year       <- year(df$Start_Time)

df$Severity <- factor(df$Severity, levels = 1:4, labels = c("Low","Moderate","High","Critical"))

dim(df)
str(df %>% select(Severity, Hour, Month, Weekday, Weather_Condition, State, Sunrise_Sunset))
colSums(is.na(df %>% select(Severity, Hour, Month, Weekday, Weather_Condition, State)))

x11()
sev_count <- df %>% count(Severity)
ggplot(sev_count, aes(x = Severity, y = n, fill = Severity)) +
  geom_bar(stat = "identity", width = 0.5, color = "white") +
  geom_text(aes(label = comma(n)), vjust = -0.5, size = 4.5, fontface = "bold") +
  scale_fill_manual(values = c("Low" = "#2ecc71", "Moderate" = "#f1c40f",
                               "High" = "#e67e22", "Critical" = "#e74c3c")) +
  labs(title = "Accident Count by Severity", x = "Severity", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
hour_df <- df %>% count(Hour)
ggplot(hour_df, aes(x = Hour, y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  scale_fill_viridis_c(option = "C") +
  scale_x_continuous(breaks = 0:23) +
  labs(title = "Accidents by Hour of Day", x = "Hour (0-23)", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
weekday_df <- df %>% count(Weekday)
ggplot(weekday_df, aes(x = Weekday, y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  scale_fill_viridis_c(option = "B") +
  labs(title = "Accidents by Day of Week", x = "Day", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
month_df <- df %>% count(Month)
ggplot(month_df, aes(x = Month, y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  scale_fill_viridis_c(option = "D") +
  labs(title = "Accidents by Month", x = "Month", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
weather_df <- df %>%
  filter(!is.na(Weather_Condition), Weather_Condition != "") %>%
  count(Weather_Condition, sort = TRUE) %>%
  top_n(10)
ggplot(weather_df, aes(x = reorder(Weather_Condition, n), y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  coord_flip() +
  scale_fill_viridis_c(option = "C") +
  labs(title = "Top 10 Weather Conditions During Accidents",
       x = "Weather Condition", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
state_df <- df %>% count(State, sort = TRUE) %>% top_n(15)
ggplot(state_df, aes(x = reorder(State, n), y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  coord_flip() +
  scale_fill_viridis_c(option = "B") +
  labs(title = "Top 15 States by Accident Count", x = "State", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
daynight_df <- df %>%
  filter(!is.na(Sunrise_Sunset)) %>%
  count(Sunrise_Sunset, Severity)
ggplot(daynight_df, aes(x = Sunrise_Sunset, y = n, fill = Severity)) +
  geom_bar(stat = "identity", position = "dodge", color = "white") +
  scale_fill_manual(values = c("Low" = "#2ecc71", "Moderate" = "#f1c40f",
                               "High" = "#e67e22", "Critical" = "#e74c3c")) +
  labs(title = "Accident Severity: Day vs Night", x = NULL, y = "Count", fill = "Severity") +
  theme_minimal()

x11()
hour_sev <- df %>% count(Hour, Severity)
ggplot(hour_sev, aes(x = Hour, y = n, fill = Severity)) +
  geom_area(position = "stack", alpha = 0.85) +
  scale_fill_manual(values = c("Low" = "#2ecc71", "Moderate" = "#f1c40f",
                               "High" = "#e67e22", "Critical" = "#e74c3c")) +
  scale_x_continuous(breaks = 0:23) +
  labs(title = "Accident Severity by Hour of Day", x = "Hour", y = "Count", fill = "Severity") +
  theme_minimal()

cat("\n==============================\n")
cat("ACCIDENT SUMMARY\n")
cat("==============================\n")
cat("Total Records Analyzed :", nrow(df), "\n\n")
cat("By Severity:\n")
print(df %>% count(Severity) %>% mutate(Percentage = round(n / sum(n) * 100, 1)))
cat("\nPeak Accident Hour:", hour_df$Hour[which.max(hour_df$n)], ":00\n")
cat("Most Affected State:", state_df$State[1], "\n")
cat("Most Common Weather:", weather_df$Weather_Condition[1], "\n")