/*
  STATUS:
      UNREVIEWED
  COMMENTS:
      NOT-STATED
*/

/* 1.1 */
SELECT name, description, cost
  FROM services
 ORDER BY cost DESC;

/* 1.2 */
SELECT service_id, name, description, cost
  FROM services
 ORDER BY description IS NULL;

/* 1.3 */
SELECT DISTINCT address
  FROM clients;

/* 1.4 */
SELECT client_id, name, address, phone
  FROM clients
 WHERE address LIKE '%KIRKBAMPTON%';

/* 1.5 */

SELECT client_id, name, address, phone
  FROM clients
 WHERE address LIKE '%KIRKBAMPTON%'
   AND phone LIKE '079%';

SELECT client_id, name, address, phone
  FROM clients
 WHERE address LIKE '%KIRKBAMPTON%'
    OR address LIKE '%DRAETHEN%';

/* 1.6 */

SELECT concat('Hi, I\'am ', name, ' from ', address, '. Call me later: ', phone, '!')
  FROM clients;

/* 1.7 */

SELECT name, (1 / cost * 10)
  FROM services;

/* 1.8 */

SELECT name, (1 / cost * 1000) AS happines
  FROM services
 ORDER BY happines DESC;

/* 2.1 */

SELECT clients.name, orders.order_datetime
  FROM clients, orders, services
 WHERE orders.client_id = clients.client_id;

/* 2.2 */

SELECT clients.name, orders.order_datetime, services.name
  FROM clients, orders, services
 WHERE orders.client_id = clients.client_id
   AND orders.service_id = orders.service_id;

/* 2.3 */

SELECT name
  FROM clients
       LEFT JOIN orders USING (client_id)
       WHERE order_id IS NULL;

/* 2.4 */

SELECT clients.name, address, phone
  FROM clients LIMIT 5

 UNION

SELECT services.name, description, cost
  FROM services LIMIT 10;

/* 3.1 */

SELECT COUNT(client_id), order_datetime
  FROM orders
 GROUP BY order_datetime;

/* 3.2 */

SELECT client_id, service_id, COUNT(*)
  FROM orders
 GROUP BY client_id, service_id;

/* 3.3 */

SELECT name, service_id, MAX(order_datetime)
  FROM orders, clients
 WHERE orders.client_id = clients.client_id
 GROUP BY name, orders.service_id;

/* 3.4 */

SELECT name, service_id, MAX(order_datetime)
  FROM orders
  JOIN clients USING (client_id)
 WHERE orders.order_datetime >= '2019-04-18 09:20:30'
 GROUP BY name, orders.service_id;

/* 3.5 */

SELECT name, service_id, MAX(order_datetime)
  FROM orders
  JOIN clients USING (client_id)
 GROUP BY name, orders.service_id
       HAVING MAX(order_datetime) >= '2019-04-18 09:20:30';

/* 3.6 */

SELECT GROUP_CONCAT(services.name, ' - ', orders_staff.order_id), order_datetime
  FROM clients, services, orders_staff, orders, staff
 WHERE clients.client_id = orders.client_id
   AND orders_staff.order_id = orders.order_id
 GROUP BY order_datetime;

/* 4.1 */

SELECT name
  FROM clients
 WHERE client_id IN
       (SELECT client_id
          FROM orders
         WHERE orders.service_id = 2);

/* 4.2 */

SELECT name
  FROM clients
 WHERE client_id = ANY
       (SELECT client_id
          FROM orders
         WHERE orders.service_id = 1);

/* 4.3 */

SELECT name
  FROM clients
 WHERE client_id <> ALL
       (SELECT client_id
          FROM orders);

/* 4.4 */

SELECT name
  FROM clients
 WHERE NOT EXISTS
       (SELECT 1
          FROM orders
         WHERE orders.client_id = clients.client_id);

/* 5 */

/*
    Для каждого работника вывести общее количество
    выполненных заказов и их суммарную стоимость в каждом
    месяце за последние полгода. Если заказ выполнялся несколькими работниками,
    то стоимость заказа делится между ними поровну.
*/

SELECT * FROM staff;

SELECT staff.employee_id,
       staff.name,
       SUM(services.cost) / staff_on_each_order.amt AS revenue,
       MONTH(orders.order_datetime) AS month
  FROM staff,
       services,
       orders_staff,
       orders,
       (SELECT COUNT(*) AS amt, orders.order_id
          FROM staff, orders_staff, orders
         WHERE staff.employee_id = orders_staff.employee_id
           AND orders.order_id = orders_staff.order_id
         GROUP BY orders.order_id) AS staff_on_each_order
 WHERE staff.employee_id = orders_staff.employee_id
   AND orders.order_id   = orders_staff.order_id
   AND orders.service_id = services.service_id
   AND orders.order_id = staff_on_each_order.order_id
   AND TO_DAYS(NOW()) - TO_DAYS(orders.order_datetime) < 30 * 6
 GROUP BY staff.employee_id;
