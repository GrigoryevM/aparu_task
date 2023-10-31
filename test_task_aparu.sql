CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    geo_location VARCHAR(100),
    order_date DATE
);


CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    geo_location VARCHAR(100)
);


INSERT INTO orders (order_id, geo_location, order_date) VALUES
(1, 'ул. Абая, Усть-Каменогорск', '2023-10-25'),
(2, 'ул. Гоголя, Усть-Каменогорск', '2023-10-25'),
(3, 'пр. Независимости, Усть-Каменогорск', '2023-10-26'),
(4, 'ул. Лермонтова, Усть-Каменогорск', '2023-10-26'),
(5, 'ул. Пушкина, Усть-Каменогорск', '2023-10-27');


INSERT INTO drivers (driver_id, geo_location) VALUES
(1, 'ул. Абая, Усть-Каменогорск'),
(2, 'ул. Гоголя, Усть-Каменогорск'),
(3, 'ул. Лермонтова, Усть-Каменогорск'),
(4, 'пр. Независимости, Усть-Каменогорск'),
(5, 'ул. Мира, Усть-Каменогорск');


-- Анализ соотношения заказов и водителей с учетом временной шкалы
SELECT 
    o.geo_location, 
    o.order_date, 
    COUNT(o.order_id) AS total_orders, 
    COUNT(d.driver_id) AS total_drivers,
    CASE 
        WHEN COUNT(o.order_id) > COUNT(d.driver_id) THEN 'High Markup'
        WHEN COUNT(o.order_id) < COUNT(d.driver_id) THEN 'Low Markup'
        ELSE 'Standard Markup'
    END AS markup_category
FROM orders o
LEFT JOIN drivers d ON o.geo_location = d.geo_location
GROUP BY o.geo_location, o.order_date;
