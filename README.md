# 🌫️ India Air Quality Analysis

> A complete end-to-end Data Science project analysing real-time air pollution data across 29 Indian states, 262 cities, and 7 pollutants — with EDA, visualisations, and a Linear Regression prediction model.

---

## 📊 Project Overview

This project analyses India's real-time air quality monitoring data to:
- Understand national pollution patterns across 7 pollutants
- Identify the most and least polluted states and cities
- Study pollutant spread and correlations
- Build and validate a Linear Regression model to predict PM2.5 levels

---

## 📁 Repository Structure

```
india-air-quality-analysis/
├── project.csv                    ← Raw dataset (3,443 records)
├── Air_Quality_Project.py         ← Main Python script (all 5 phases)
├── Air_Quality_Presentation.pptx  ← 11-slide PowerPoint presentation
├── Air_Quality_Report.docx        ← Detailed project Word document
└── README.md                      ← This file
```

---

## 📋 Dataset Description

| Column | Type | Description |
|--------|------|-------------|
| `country / state / city` | String | Geographic hierarchy |
| `station` | String | Monitoring station name |
| `last_update` | Datetime | Reading timestamp (DD-MM-YYYY HH:MM:SS) |
| `latitude / longitude` | Float | GPS coordinates |
| `pollutant_id` | String | CO, NH3, NO2, OZONE, PM10, PM2.5, SO2 |
| `pollutant_min/max/avg` | Integer | Measured concentration values |

**After cleaning:** 3,197 records · 29 States · 262 Cities · 7 Pollutants

---

## 🔬 Project Phases

### Phase 1 — Data Loading & Cleaning
- Loaded CSV with `pandas`
- Parsed `last_update` with `dayfirst=True`
- Dropped 246 rows with missing pollutant values
- Converted numeric columns with `errors='coerce'`

### Phase 2 — Exploratory Data Analysis (5 Objectives)

| # | Objective | Key Finding |
|---|-----------|-------------|
| 1 | National avg per pollutant | PM10 (96.5) and PM2.5 (78.7) dominate — 5× WHO limits |
| 2 | Most/least polluted states | Delhi #1 (73.9); Tripura cleanest (8.6) |
| 3 | Pollutant spread analysis | PM2.5 range = 127 units — extreme station-level variation |
| 4 | City pollution hotspots | Singrauli (MP) worst at 111.7 µg/m³ |
| 5 | PM2.5 vs PM10 correlation | Pearson r = 0.60 — moderate positive correlation |

### Phase 3 — Visualisations
- Bar charts (vertical & horizontal) for objectives 1, 2, 4
- Grouped bar charts for objectives 3, 5
- State × Pollutant heatmap using seaborn

### Phase 4 — Linear Regression Model
```
PM2.5_avg = 0.957 × PM2.5_min + 47.82
```
| Metric | Value |
|--------|-------|
| MAE | 31.41 µg/m³ |
| RMSE | 43.84 µg/m³ |
| R² | 16.8% |
| CV R² (5-fold) | 0.14 |

### Phase 5 — Model Validation (Per-Pollutant)

| Pollutant | R² | Fit Quality |
|-----------|-----|-------------|
| SO2 | 0.69 | ✅ Good |
| CO | 0.67 | ✅ Good |
| OZONE | 0.67 | ✅ Good |
| NO2 | 0.66 | ✅ Good |
| NH3 | 0.55 | 🟡 Acceptable |
| PM10 | 0.47 | 🟡 Acceptable |
| PM2.5 | 0.17 | 🔴 Weak (needs multi-variable model) |

---

## 🧰 Tech Stack

| Tool | Purpose |
|------|---------|
| Python 3.x | Core language |
| pandas | Data loading, cleaning, analysis |
| numpy | Numerical operations |
| matplotlib | Chart generation |
| seaborn | Heatmap visualisation |
| scikit-learn | Linear Regression, CV, metrics |

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/india-air-quality-analysis.git
   cd india-air-quality-analysis
   ```

2. **Install dependencies**
   ```bash
   pip install pandas numpy matplotlib seaborn scikit-learn
   ```

3. **Run the project**
   ```bash
   python Air_Quality_Project.py
   ```

---

## 📌 Key Conclusions

1. **PM10 and PM2.5 are India's most dangerous pollutants** — both exceed WHO guidelines by 5–6×
2. **Delhi, Haryana, and UP are most at risk** — urgent policy needed in the Indo-Gangetic Plain
3. **Singrauli, Rupnagar, Nandesari** are extreme industrial hotspots
4. **PM2.5 & PM10 moderately correlated (r=0.60)** — shared sources but need separate treatment
5. **Linear Regression works well for gaseous pollutants** — PM2.5 needs advanced modelling

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

*India Air Quality Analysis — Data Science Project*
