# Car Theft Analysis in New Zealand

This project analyzes 6 months of car theft data in New Zealand using MySQL and Excel. It's part of my portfolio demonstrating my skills in data analysis for entry-level/junior roles.

## Project Overview

This project aims to understand car theft trends in New Zealand over a six-month period. I explore questions like:

* Which regions have the highest theft rates?
* What are the most commonly stolen car makes and models?
* Are there any temporal trends in theft occurrences (e.g., day of the week, time of day)? 

## Data Source

The dataset used in this analysis is sourced from New Zealand Police. It includes information on 4,707 thefts occurring over a 6-month period.

## Tools Used

* **MySQL:** Used for data cleaning, transformation, and aggregation.
* **Excel:** Used for data visualization, creating charts and dashboards to present findings.

## Project Structure

* **data:** Contains the raw data files (if you choose to include them, consider using a smaller sample due to size limitations) and any cleaned/transformed versions.
* **scripts:** Contains the SQL scripts used for data manipulation and querying.
* **analysis:** Contains Excel workbooks with data analysis, visualizations, and the final report.
* **README.md:** This file, providing an overview of the project.

## Analysis and Findings

### To address Objective 1, I used three SQL queries to analyze the stolen_vehicles dataset and find out when vehicles are most likely to be stolen.

### Sorted by year
```sql
SELECT 
	YEAR(date_stolen) as Year,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Year
```
<img width="137" alt="image" src="https://github.com/user-attachments/assets/8a00be29-d794-41cd-88e9-5230e28ebe60">


### Sorted by month
```sql
SELECT 
	MONTH(date_stolen) as Month,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Month
ORDER BY Month;
```
<img width="146" alt="image" src="https://github.com/user-attachments/assets/885a6444-4200-411e-8df1-1e5fdaf50f46">


### Sorted by day of week
```sql
SELECT 
	DAYOFWEEK(date_stolen) as Day,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Day
ORDER BY Day;
```
<img width="186" alt="image" src="https://github.com/user-attachments/assets/6c9a1b8b-92f7-4889-a264-90b00f987e02">


### Replace day of week number with actual day name
```sql
SELECT 
    DATE_FORMAT(date_stolen, '%W') AS Day,  -- '%W' returns the full weekday name
    COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY DAYOFWEEK(date_stolen), Day
ORDER BY DAYOFWEEK(date_stolen);
```
<img width="592" alt="image" src="https://github.com/user-attachments/assets/8f208e94-ca18-4ae2-ab11-32c502f091af">

*Bar chart with final findings for car thefts by day of the week.*

* Identified the top 3 regions with the highest car theft rates.
* Found that [car make and model] were the most frequently stolen vehicles.
* Observed a significant increase in thefts during [specific time period or day of the week].

## How to Run the Analysis

1. **Set up MySQL:** Install MySQL and import the provided data (if included) into a database.
2. **Execute SQL scripts:** Run the SQL scripts in the `scripts` folder to clean, transform, and aggregate the data.
3. **Open Excel workbooks:** Open the Excel files in the `analysis` folder to explore the visualizations and findings.

## Key Skills Demonstrated

* **Data Cleaning and Transformation:** Handling missing values, data type conversion, etc. using SQL.
* **Data Analysis:**  Using SQL to perform aggregate analysis, identify trends, and answer key questions.
* **Data Visualization:** Creating clear and informative charts and dashboards in Excel to communicate findings.
* **Problem Solving:**  Applying analytical thinking to extract meaningful insights from the data.


## Future Work

[Optional: Briefly mention any potential extensions to the analysis, e.g., incorporating additional data sources, using more advanced analytical techniques, etc.]


This project demonstrates my ability to use SQL and Excel to perform end-to-end data analysis. I'm eager to apply these skills and learn more in a junior data analyst role.
