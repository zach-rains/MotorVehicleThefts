# Sorted by year
SELECT 
	YEAR(date_stolen) as Year,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Year;

# Sorted by month
SELECT 
	MONTH(date_stolen) as Month,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Month
ORDER BY Month;

# Sorted by day of week
SELECT 
	DAYOFWEEK(date_stolen) as Day,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Day
ORDER BY Day;

# Replace day of week number with actual day name
SELECT 
    DATE_FORMAT(date_stolen, '%W') AS Day,  -- '%W' returns the full weekday name
    COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY DAYOFWEEK(date_stolen), Day
ORDER BY DAYOFWEEK(date_stolen);


