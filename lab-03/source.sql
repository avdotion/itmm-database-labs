/*
  STATUS:
      REVIEWED
  COMMENTS:
      DONE
*/

SHOW DATABASES;
SHOW TABLES;

/*
    1
    Сколько каждая услуга была оказана?
*/

DROP VIEW services_done;

CREATE VIEW services_done
    AS
SELECT services.name, COUNT(*) as amount
  FROM services, orders
 WHERE orders.service_id = services.service_id
 GROUP BY services.name;

SELECT * FROM services_done;

/*
    2
    Перечень услуг за каждый месяц  и общая сумма заказов
*/

DROP VIEW profit_by_month;

CREATE VIEW profit_by_month
    AS
SELECT MONTH(orders.order_datetime) AS month,
       GROUP_CONCAT(DISTINCT services.name) AS each_services,
       SUM(services.cost) AS profit
  FROM orders, services
 WHERE orders.service_id = services.service_id
 GROUP BY 1;

SELECT * FROM profit_by_month;

/*
    3
    Вывести информацию по каждому заказу: клиент, адрес, вид работ, стоимость заказа, дата, назначенные работники (через запятую).
*/

DROP VIEW checkbook;

CREATE VIEW checkbook
    AS
SELECT clients.name as client_name,
       clients.address as delivery_address,
       services.name as service_name,
       services.cost as price,
       GROUP_CONCAT(DISTINCT staff.name) AS hands
  FROM clients, services, staff, orders, orders_staff
 WHERE clients.client_id = orders.client_id
   AND services.service_id = orders.service_id
   AND staff.employee_id = orders_staff.employee_id
   AND orders.order_id = orders_staff.order_id
 GROUP BY orders.order_id;

SELECT * FROM checkbook;

/*
    4
    В таблице `клиент` ввести поле `Сумма заказов`, при оформлении нового заказа, увеличивать общую сумму заказов у клиента на соответствующую сумму.
*/

ALTER TABLE clients
  ADD total_spent INT DEFAULT 0 AFTER phone;

DROP TRIGGER invoice_for_payment;

CREATE TRIGGER invoice_for_payment
 AFTER INSERT
    ON orders
   FOR EACH ROW
 BEGIN
       DECLARE money_spent       INT(10);
       DECLARE current_client_id INT(10);

       SELECT services.cost INTO money_spent
         FROM services, clients
        WHERE NEW.service_id = services.service_id
          AND NEW.client_id = clients.client_id;

       SELECT clients.client_id INTO current_client_id
         FROM clients
        WHERE NEW.client_id = clients.client_id;

       UPDATE clients
          SET total_spent = total_spent + money_spent
        WHERE current_client_id = client_id;
   END;

INSERT INTO orders (client_id, service_id)
VALUES (1, 1),
       (1, 2);

SELECT * FROM orders;

INSERT INTO orders_staff (order_id, employee_id)
VALUES (41, 4),
       (32, 6);

SELECT * FROM clients;

/*
    5
*/

DROP PROCEDURE were_sold_services;

CREATE PROCEDURE were_sold_services(
    IN _service_id INT,
    IN desired_profit     INT,
   OUT were_sold          CHAR(3))
 BEGIN
       DECLARE profit INT;

        SELECT SUM(services.cost) AS profit
          INTO profit
          FROM orders, services
         WHERE orders.service_id = services.service_id
           AND orders.service_id = _service_id;

           IF (profit >= desired_profit)
         THEN
          SET were_sold = 'YES';
         ELSE
          SET were_sold = 'NO';
          END IF;
   END;

CALL were_sold_services(1, 13000, @output);
select @output;

/*
    6
*/

DROP FUNCTION is_the_best_client;

CREATE FUNCTION is_the_best_client(selected_client_id INT)
       RETURNS INT(1)
 BEGIN
     DECLARE best_client_id INT;
     DECLARE answer         INT(1);

     DECLARE it             INT;
     DECLARE it_end         INT;

     DECLARE current_max_spent INT;
     DECLARE max_spent         INT;

     SELECT MAX(client_id) INTO it_end FROM clients;

     SET max_spent = 0;
     SET it = 1;

     WHILE it <= it_end
        DO
           SELECT SUM(services.cost) AS total_spent
             INTO current_max_spent
             FROM clients, services, orders
            WHERE clients.client_id = orders.client_id
              AND services.service_id = orders.service_id
              AND clients.client_id = it
            GROUP BY clients.client_id;

               IF current_max_spent >= max_spent
             THEN SET max_spent = current_max_spent;
              END IF;
              SET it = it + 1;

       END WHILE;

     SELECT client_id
       INTO best_client_id
       FROM (SELECT clients.client_id AS client_id,
                    SUM(services.cost) AS total_spent
               FROM clients, services, orders
              WHERE clients.client_id = orders.client_id
                AND services.service_id = orders.service_id
              GROUP BY clients.client_id) AS sample
      WHERE total_spent = max_spent;

         IF best_client_id = selected_client_id
       THEN SET answer = 1;
       ELSE SET answer = 0;
        END IF;

     RETURN answer;
   END;

SELECT is_the_best_client(3);
