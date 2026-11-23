USE employee;

USE employee;

SELECT
    l.location,
    e.employee_name
FROM Employees e
RIGHT JOIN Location l
ON e.location_id = l.location_id;