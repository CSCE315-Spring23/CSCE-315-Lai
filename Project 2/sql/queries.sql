/* tables exist */
SELECT * FROM menuitem;
SELECT * FROM inventory;
SELECT * FROM orderitem;
SELECT * FROM solditem;
SELECT * FROM recipeitem;
SELECT * FROM employee;

/* over $1mill */
SELECT SUM(total_cost) FROM orderitem;

/* normal day */
SELECT SUM(total_cost) FROM orderitem WHERE date='2022-09-02';

/* game day */
SELECT SUM(total_cost) FROM orderitem WHERE date='2022-09-03';
-- SELECT SUM(total_cost) FROM orderitem WHERE date='2022-10-22';
-- SELECT SUM(total_cost) FROM orderitem where date='2022-11-19';
-- SELECT SUM(total_cost) FROM orderitem where date='2022-11-26';

/* total number of days */
SELECT (MAX(date)-MIN(date)) AS days_elapsed FROM orderitem;

/* average */
SELECT AVG(total_cost) FROM orderitem WHERE customer_name='Victoria';
SELECT AVG(total_cost) FROM orderitem WHERE date='2022-07-04';

/* joining tables to process data */
SELECT * FROM recipeitem 
    JOIN inventory ON recipeitem.inventoryid = inventory.id 
    JOIN menuitem ON recipeitem.menuid = menuitem.id 
    WHERE menuitem.name = 'Chick-fil-A Chicken Sandwich'; /* given name */

-- SELECT * from recipeitem 
--     JOIN inventory ON recipeitem.inventoryid = inventory.id 
--     JOIN menuitem ON recipeitem.menuid = menuitem.id 
--     WHERE menuitem.name = 'Chick-fil-A Chicken Sandwich'; /* given id */

/* specific employee */
SELECT * FROM orderitem JOIN employee ON orderitem.employee_id = employee.id WHERE employee.name = 'Cluck Rogers' LIMIT 10; 

/* Sorts Employees Alphabetically */
SELECT name, role AS employee_role FROM employee
    ORDER BY name ASC;

/* number sold for menu item */
SELECT menuitem.name, COUNT(solditem.menuid) AS menuid_count
    FROM solditem
    JOIN menuitem ON solditem.menuid = menuitem.id
    WHERE menuitem.name = 'M. Waffle Fries'
    GROUP BY solditem.menuid, menuitem.name
    ORDER BY menuid_count DESC
    LIMIT 1;

/* top 5 menu items */
SELECT menuitem.name, COUNT(solditem.menuid) AS count
    FROM solditem
    JOIN menuitem ON solditem.menuid = menuitem.id
    GROUP BY solditem.menuid, menuitem.name
    ORDER BY count DESC
    LIMIT 5;


/* Select top 10 most sold menu items and count */
SELECT menuid, COUNT(menuid) FROM solditem
    GROUP BY menuid
    ORDER BY count DESC
    LIMIT 10;

