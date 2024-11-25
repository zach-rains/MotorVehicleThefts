# Car Theft Analysis in New Zealand

This project analyzes 6 months of car theft data in New Zealand using MySQL and Excel. It's part of my portfolio demonstrating my skills in data analysis for entry-level/junior roles.

# Project Overview

This project aims to understand car theft trends in New Zealand over a six-month period. I explore questions like:

* Which regions have the highest theft rates?
* What are the most commonly stolen car makes and models?
* Are there any temporal trends in theft occurrences (e.g., day of the week, time of day)? 

# Data Source

The dataset used in this analysis is sourced from New Zealand Police. It includes information on 4,707 thefts occurring over a 6-month period.

# Tools Used

* **MySQL:** Used for data cleaning, transformation, and aggregation.
* **Excel:** Used for data visualization, creating charts and dashboards to present findings.

# Project Structure

* **data:** Contains the raw data files and any cleaned/transformed versions.
* **scripts:** Contains the SQL scripts used for data manipulation and querying.
* **analysis:** Contains Excel workbooks with data analysis, visualizations, and the final report.
* **README.md:** This file, providing an overview of the project.

# Analysis and Findings

## Objective 1: analyze the stolen_vehicles dataset and find out WHEN vehicles are most likely to be stolen.

### Sorted by year
```sql
SELECT 
	YEAR(date_stolen) as Year,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Year
```
Stolen Vehicles By Year:
| Year   | # of Vehicles Stolen   |
|:-------|:-----------------------|
| 2021   | 1668                   |
| 2022   | 2885                   |

### Sorted by month
```sql
SELECT 
	MONTH(date_stolen) as Month,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Month
ORDER BY Month;
```
Stolen Vehicles By Month:
| Month   | # of Vehicles Stolen   |
|:--------|:-----------------------|
| 1       | 740                    |
| 2       | 763                    |
| 3       | 1053                   |
| 4       | 329                    |
| 10      | 464                    |
| 11      | 560                    |
| 12      | 644                    |


### Sorted by day of week
```sql
SELECT 
	DAYOFWEEK(date_stolen) as Day,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Day
ORDER BY Day;
```
Stolen Vehicles By Day Of Week:
| Day       | # of Vehicles Stolen   |
|:----------|:-----------------------|
| Sunday    | 595                    |
| Monday    | 767                    |
| Tuesday   | 711                    |
| Wednesday | 629                    |
| Thursday  | 619                    |
| Friday    | 655                    |
| Saturday  | 577                    |


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

## Objective 2: analyze the stolen_vehicles dataset and find out WHICH vehicles are most likely to be stolen.

### Which vehicle types are MOST likely to be stolen
```sql
SELECT
	vehicle_type,
    COUNT(vehicle_id)
FROM stolen_vehicles
GROUP BY vehicle_type;
```
Which Vehicles - Top 10 Types:
| vehicle_type | COUNT(vehicle_id) |
| --- | --- |
| Stationwagon | 945 |
| Saloon | 851 |
| Hatchback | 644 |
| Trailer | 582 |
| Utility | 466 |
| Roadbike | 297 |
| Moped | 187 |
| Light Van | 154 |
| Boat Trailer | 105 |
| Trailer - Heavy | 90 |

### For each vehicle type, find the average age of the cars that are stolen
```sql
SELECT
	vehicle_type,
    ROUND(AVG(model_year),0)
FROM stolen_vehicles
GROUP BY vehicle_type;
```
| vehicle_type | ROUND(AVG(model_year),0) |
| --- | --- |
| Trailer | 2010 |
| Boat Trailer | 2008 |
| Roadbike | 2012 |
| Moped | 2014 |
| Trailer - Heavy | 2010 |
| Caravan | 1994 |
| Hatchback | 2005 |
| Saloon | 2003 |
| Stationwagon | 2002 |
| Tractor | 2015 |
| Trail Bike | 2001 |
| Light Van | 2002 |
| All Terrain Vehicle | 2011 |
| Utility | 2004 |
| Other Truck | 1998 |
| Sports Car | 2000 |
| Flat Deck Truck | 1994 |
| Light Bus | 2007 |
| Mobile Home - Light | 1987 |
| Convertible | 1999 |
| Heavy Van | 1999 |
| Special Purpose Vehicle | 1957 |
| Articulated Truck | 2007 |
| Cab and Chassis Only | 2011 |
| Mobile Machine | 2017 |
| nan | 2012 |

### For each vehicle type, find the percent of vehicles stolen that are luxury versus standard
```sql
SELECT 
    vehicle_type,
    ROUND(SUM(CASE WHEN make_type = 'Luxury' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS luxury_percent
FROM 
    stolen_vehicles
LEFT JOIN 
    make_details
ON 
    stolen_vehicles.make_id = make_details.make_id
GROUP BY 
    vehicle_type;
```
| vehicle_type | luxury_percent |
| --- | --- |
| Trailer | 0.0 |
| Boat Trailer | 0.0 |
| Roadbike | 1.3 |
| Moped | 0.0 |
| Trailer - Heavy | 0.0 |
| Caravan | 0.0 |
| Hatchback | 3.3 |
| Saloon | 12.9 |
| Stationwagon | 3.7 |
| Tractor | 0.0 |
| Trail Bike | 0.0 |
| Light Van | 1.3 |
| All Terrain Vehicle | 0.0 |
| Utility | 0.2 |
| Other Truck | 0.0 |
| Sports Car | 22.5 |
| Flat Deck Truck | 0.0 |
| Light Bus | 0.0 |
| Mobile Home - Light | 0.0 |
| Convertible | 50.0 |
| Heavy Van | 14.3 |
| Special Purpose Vehicle | 0.0 |
| Articulated Truck | 0.0 |
| Cab and Chassis Only | 0.0 |
| Mobile Machine | 0.0 |
| nan | 3.8 |

### Create a table where the rows represent the top 10 vehicle types, the columns represent the top 7 vehicle colors (plus 1 column for all other colors) and the values are the number of vehicles stolen.

### Top 10 Types
```sql
SELECT
	vehicle_type,
    COUNT(vehicle_id)
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(vehicle_id) DESC
LIMIT 10;
```

### Top 7 Colors + Top 10 Types
```sql
WITH TopColors AS (
    SELECT color
    FROM stolen_vehicles
    GROUP BY color
    ORDER BY COUNT(vehicle_id) DESC
    LIMIT 7
)
SELECT
    CASE
        WHEN color IN (SELECT color FROM TopColors) THEN color
        ELSE 'Other'
    END AS color_group,
    COUNT(vehicle_id) AS vehicle_count
FROM stolen_vehicles
GROUP BY color_group
ORDER BY vehicle_count DESC;

WITH TopColors AS (
    SELECT color
    FROM stolen_vehicles
    GROUP BY color
    ORDER BY COUNT(vehicle_id) DESC
    LIMIT 7
),
TopTypes AS (
    SELECT vehicle_type
    FROM stolen_vehicles
    GROUP BY vehicle_type
    ORDER BY COUNT(vehicle_id) DESC
    LIMIT 10
)
SELECT
    vt.vehicle_type,
    SUM(CASE WHEN c.color_group = 'Red' THEN 1 ELSE 0 END) AS Red,
    SUM(CASE WHEN c.color_group = 'Blue' THEN 1 ELSE 0 END) AS Blue,
    SUM(CASE WHEN c.color_group = 'Green' THEN 1 ELSE 0 END) AS Green,
    SUM(CASE WHEN c.color_group = 'Black' THEN 1 ELSE 0 END) AS Black,
    SUM(CASE WHEN c.color_group = 'White' THEN 1 ELSE 0 END) AS White,
    SUM(CASE WHEN c.color_group = 'Yellow' THEN 1 ELSE 0 END) AS Yellow,
    SUM(CASE WHEN c.color_group = 'Purple' THEN 1 ELSE 0 END) AS Purple,
    SUM(CASE WHEN c.color_group = 'Other' THEN 1 ELSE 0 END) AS Other
FROM 
    stolen_vehicles sv
INNER JOIN 
    TopTypes vt ON sv.vehicle_type = vt.vehicle_type
LEFT JOIN (
    SELECT 
        vehicle_id,
        CASE
            WHEN color IN (SELECT color FROM TopColors) THEN color
            ELSE 'Other'
        END AS color_group
    FROM stolen_vehicles
) c ON sv.vehicle_id = c.vehicle_id
GROUP BY 
    vt.vehicle_type
ORDER BY 
    vt.vehicle_type;
```
| vehicle_type | Red | Blue | Green | Black | White | Yellow | Purple | Other |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Boat Trailer | 0 | 0 | 0 | 3 | 5 | 0 | 0 | 1 |
| Hatchback | 58 | 104 | 24 | 76 | 114 | 0 | 0 | 50 |
| Light Van | 7 | 5 | 6 | 0 | 104 | 0 | 0 | 6 |
| Moped | 34 | 18 | 1 | 85 | 25 | 0 | 0 | 13 |
| Roadbike | 51 | 38 | 12 | 105 | 42 | 0 | 0 | 21 |
| Saloon | 75 | 125 | 52 | 99 | 160 | 0 | 0 | 43 |
| Stationwagon | 84 | 142 | 59 | 141 | 159 | 0 | 0 | 53 |
| Trailer | 9 | 17 | 22 | 29 | 21 | 0 | 0 | 12 |
| Trailer - Heavy | 0 | 3 | 2 | 1 | 9 | 0 | 0 | 10 |
| Utility | 45 | 46 | 38 | 36 | 183 | 0 | 0 | 15 |

## Objective 3: analyze the stolen_vehicles dataset and find out WHERE vehicles are most likely to be stolen.

### Number of vehicles stolen in each region
```sql
SELECT
	locations.region,
    COUNT(vehicle_id) AS Vehicle_Count
FROM locations
LEFT JOIN stolen_vehicles
	ON locations.location_id = stolen_vehicles.location_id
GROUP BY locations.region
ORDER BY COUNT(vehicle_id) DESC;
```
| region | Vehicle_Count |
| --- | --- |
| Auckland | 1638 |
| Canterbury | 660 |
| Bay of Plenty | 446 |
| Wellington | 420 |
| Waikato | 371 |
| Northland | 234 |
| Gisborne | 176 |
| Manawatū-Whanganui | 139 |
| Otago | 139 |
| Taranaki | 112 |
| Hawke's Bay | 100 |
| Nelson | 92 |
| Southland | 26 |
| Tasman | 0 |
| Marlborough | 0 |
| West Coast | 0 |

### Combine the previous output with the population and density statistics for each region
```sql
SELECT
    locations.region,
    MAX(locations.population) AS population,
    MAX(locations.density) AS density,
    COUNT(stolen_vehicles.vehicle_id) AS Vehicle_Count
FROM locations
LEFT JOIN stolen_vehicles
    ON locations.location_id = stolen_vehicles.location_id
GROUP BY locations.region
ORDER BY Vehicle_Count DESC;
```
| region | population | density | Vehicle_Count |
| --- | --- | --- | --- |
| Auckland | 1695200 | 343.09 | 1638 |
| Canterbury | 655000 | 14.72 | 660 |
| Bay of Plenty | 347700 | 28.8 | 446 |
| Wellington | 543500 | 67.52 | 420 |
| Waikato | 513800 | 21.5 | 371 |
| Northland | 201500 | 16.11 | 234 |
| Gisborne | 52100 | 6.21 | 176 |
| Manawatū-Whanganui | 258200 | 11.62 | 139 |
| Otago | 246000 | 7.89 | 139 |
| Taranaki | 127300 | 17.55 | 112 |
| Hawke's Bay | 182700 | 12.92 | 100 |
| Nelson | 54500 | 129.15 | 92 |
| Southland | 102400 | 3.28 | 26 |
| Tasman | 58700 | 6.1 | 0 |
| Marlborough | 51900 | 4.94 | 0 |
| West Coast | 32700 | 1.41 | 0 |

### Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?
```sql
(SELECT
    locations.region,
    MAX(locations.density) AS Density,
	MAX(stolen_vehicles.vehicle_type) AS Type
FROM locations
LEFT JOIN stolen_vehicles
    ON locations.location_id = stolen_vehicles.location_id
GROUP BY locations.region
ORDER BY density DESC
LIMIT 3
)
UNION ALL
(
SELECT
    locations.region,
    MAX(locations.density) AS Density,
	MAX(stolen_vehicles.vehicle_type) AS Type
FROM locations
LEFT JOIN stolen_vehicles
    ON locations.location_id = stolen_vehicles.location_id
WHERE stolen_vehicles.vehicle_type IS NOT NULL
GROUP BY locations.region
ORDER BY density ASC
LIMIT 3);
```
| region     | Density   | Type    |
|:-----------|:----------|:--------|
| Auckland   | 343.09    | Utility |
| Nelson     | 129.15    | Utility |
| Wellington | 67.52     | Utility |
| Southland  | 3.28      | Utility |
| Gisborne   | 6.21      | Utility |

### Create a scatter plot of population versus density, and change the size of the points based on the number of vehicles stolen in each region
```sql
SELECT
    locations.region,
    MAX(locations.population) AS population,
    MAX(locations.density) AS density,
    COUNT(stolen_vehicles.vehicle_id) AS Vehicle_Count
FROM locations
LEFT JOIN stolen_vehicles
    ON locations.location_id = stolen_vehicles.location_id
GROUP BY locations.region
ORDER BY Vehicle_Count DESC;
```
![image](https://github.com/user-attachments/assets/ea1c7643-5eb4-4a41-9d08-f0fb54ba87be)

### Create a map of the regions and color the regions based on the number of stolen vehicles
```sql
SELECT
    locations.region,
    COUNT(stolen_vehicles.vehicle_id) AS Vehicle_Count
FROM locations
LEFT JOIN stolen_vehicles
    ON locations.location_id = stolen_vehicles.location_id
GROUP BY locations.region
ORDER BY Vehicle_Count DESC;
```
![Picture1](https://github.com/user-attachments/assets/678802a0-70ed-4ae7-a98f-ba87ce830507)

## Key Skills Demonstrated

* **Data Cleaning and Transformation:** Handling missing values, data type conversion, etc. using SQL.
* **Data Analysis:**  Using SQL to perform aggregate analysis, identify trends, and answer key questions.
* **Data Visualization:** Creating clear and informative charts and dashboards in Excel to communicate findings.
* **Problem Solving:**  Applying analytical thinking to extract meaningful insights from the data.


This project demonstrates my ability to use SQL and Excel to perform end-to-end data analysis. I'm eager to apply these skills and learn more in a junior data analyst role.
