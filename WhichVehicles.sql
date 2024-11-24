# Vehicle types that are most often and least often stolen
SELECT
	vehicle_type,
    COUNT(vehicle_id)
FROM stolen_vehicles
GROUP BY vehicle_type;

# For each vehicle type, find the average age of the cars that are stolen
SELECT
	vehicle_type,
    ROUND(AVG(model_year),0)
FROM stolen_vehicles
GROUP BY vehicle_type;

# For each vehicle type, find the percent of vehicles stolen that are luxury versus standard
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

# Create a table where the rows represent the top 10 vehicle types, 
# the columns represent the top 7 vehicle colors (plus 1 column for all other colors) 
# and the values are the number of vehicles stolen.

# Top 10 Types
SELECT
	vehicle_type,
    COUNT(vehicle_id)
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(vehicle_id) DESC
LIMIT 10;

# Top 7 Colors
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
