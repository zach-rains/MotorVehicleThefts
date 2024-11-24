SELECT 
	MONTH(date_stolen) as Month,
	COUNT(vehicle_id) AS '# of Vehicles Stolen'
FROM stolen_vehicles
GROUP BY Month
ORDER BY Month