# PRODIGY_DS_05 - Traffic Accident Data Analysis

## Task 05 - Prodigy InfoTech Data Science Internship

Analyze traffic accident data to identify patterns related to road conditions, weather, and time of day. Visualize accident hotspots and contributing factors.

---

## Dataset

- **Source:** [Kaggle - US Accidents](https://www.kaggle.com/datasets/sobhanmoosavi/us-accidents)
- **File Used:** `US_Accidents_March23.csv`
- **Size:** 7.7 million records (script samples 100,000 for performance)

---

## Tools & Libraries Used

- RStudio
- tidyverse
- lubridate
- scales
- viridis
- RColorBrewer

---

## What the Script Does

- Loads and samples the dataset
- Parses datetime and extracts Hour, Month, Weekday, Year
- Analyzes accident severity distribution
- Identifies peak accident hours and days
- Analyzes weather conditions during accidents
- Identifies top states by accident count
- Compares day vs night accident severity
- Stacked area chart of severity by hour

---

## Plots Generated

| Plot | Description |
|------|-------------|
| Bar Chart | Accident count by severity |
| Bar Chart | Accidents by hour of day |
| Bar Chart | Accidents by day of week |
| Bar Chart | Accidents by month |
| Bar Chart | Top 10 weather conditions |
| Bar Chart | Top 15 states by accident count |
| Grouped Bar | Day vs Night severity comparison |
| Area Chart | Severity distribution by hour |

---

## How to Run

1. Clone this repository
```bash
git clone https://github.com/YOUR_USERNAME/PRODIGY_DS_05.git
```
2. Download `US_Accidents_March23.csv` from the Kaggle link above
3. Place the file in the same folder as the script
4. Open `Task05_AccidentAnalysis.R` in RStudio
5. Run with `Ctrl + A` then `Ctrl + Enter`

> **Note:** The dataset is large (~3GB). The script automatically samples 100,000 records for faster processing.

---

## Author

Vedant Chaudhari
Data Science Intern — Prodigy InfoTech
