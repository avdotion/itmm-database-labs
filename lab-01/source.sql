/*
  STATUS:
      REVIEWED
  COMMENTS:
      DONE
*/

DROP DATABASE laboratory_work;

CREATE DATABASE laboratory_work;
USE laboratory_work;

CREATE TABLE clients (
    PRIMARY KEY (client_id),
    client_id INT      NOT NULL AUTO_INCREMENT,
    name      CHAR(50) NOT NULL,
    address   CHAR(50) NOT NULL,
    phone     CHAR(20) NOT NULL
);

CREATE TABLE orders (
    PRIMARY KEY (order_id),
    order_id       INT       NOT NULL AUTO_INCREMENT,
    client_id      INT       NOT NULL,
    employee_id    INT       NOT NULL,
    order_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cost           INT       UNSIGNED NOT NULL
);

CREATE TABLE staff (
    PRIMARY KEY (employee_id),
    employee_id INT      NOT NULL AUTO_INCREMENT,
    name        CHAR(50) NOT NULL,
    seniority   INT      NOT NULL,
    phone       CHAR(20) NOT NULL,
    address     CHAR(50) NOT NULL
);

ALTER TABLE orders
    ADD CONSTRAINT fk_client
    FOREIGN KEY    (client_id)
    REFERENCES     clients (client_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

    ADD CONSTRAINT fk_employee
    FOREIGN KEY    (employee_id)
    REFERENCES     staff (employee_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

SHOW TABLES;

DESC clients;
DESC staff;
DESC orders;

INSERT INTO clients (name, address, phone)
VALUES ('Megan Winter', '21 Lamphey Road, THE BRATCH', '078 7348 3397'),
       ('Madeleine North', '54 Russell Rd, SHIPMEADOW', '077 1604 4734'),
       ('Corey Adams', '24 South Western Terrace, MILTON KEYNES', '079 1539 4687'),
       ('Kian Barker', '35 Winchester Rd, MERRIOTT', '077 7782 4486'),
       ('Aidan Bibi', '82 Ramsgate Rd, KIRKBAMPTON', '079 6415 5446'),
       ('Jayden Higgins', '52 Emerson Road, KIRKBAMPTON', '077 6074 7762'),
       ('Alicia Singh', '7 Hampton Court Rd, SOUTHWOLD', '079 1268 9935'),
       ('Mia Gill', '49 Guildry Street, GALTRIGILL', '078 8345 7128'),
       ('Harrison Burgess', '88 Prospect Hill, DRAETHEN', '079 8704 2723'),
       ('Ryan Newton', '65 Overton Circle, LITTON', '078 2267 0544');

INSERT INTO staff (name, seniority, phone, address)
VALUES ('Chloe Nixon', 4, '070 1677 0228', '84 Nenthead Road, HIGHBURY'),
       ('Chloe Atkins', 1, '077 5746 5477', '57 Graham Road, CHERITON FITZPAINE'),
       ('Jasmine Fitzgera', 1, '070 7732 5223', '82 Argyll Road, LLANBEDR-DYFFRYN-CLWYD'),
       ('Melissa Gardner', 0, '077 5981 5902', '15 Vicar Lane, SANDON'),
       ('Liam Warren', 4, '078 3488 2090', '30 Wrexham Road, FENHOUSES'),
       ('Ava Field', 2, '078 6698 6894', '22 Manor Way, GREAT PALGRAVE'),
       ('Chelsea Hayward', 4, '077 3369 6445', '53 Russell Rd, SHIPLEY'),
       ('Mason Chapman', 3, '070 2060 7604', '12 St Andrews Lane, DACRE'),
       ('Kai Matthews', 1, '070 2987 3379', '1 Fordham Rd, HALNAKER'),
       ('Morgan Walton', 2, '077 3679 0132', '9 Bishopgate Street, SEFTON');

INSERT INTO orders (client_id, employee_id, cost)
VALUES (9, 2, 1750),
       (2, 10, 1030),
       (6, 4, 640),
       (6, 9, 2090),
       (2, 9, 3720),
       (9, 3, 450),
       (1, 6, 2150),
       (6, 9, 4840),
       (8, 6, 1870),
       (8, 9, 1870),
       (4, 1, 1360),
       (2, 6, 2800),
       (9, 9, 1600),
       (6, 9, 370),
       (5, 5, 2980),
       (3, 8, 3790),
       (5, 5, 2120),
       (4, 5, 4400),
       (7, 5, 3200),
       (7, 6, 4840);

INSERT INTO orders (client_id, employee_id, cost)
VALUES (11, 5, 1250);

SELECT * FROM clients;
SELECT * FROM orders;
SELECT * FROM staff;

CREATE TABLE services (
    PRIMARY KEY (service_id),
    service_id  INT       NOT NULL AUTO_INCREMENT,
    name        CHAR(50)  NOT NULL,
    description CHAR(100),
    cost        INT       UNSIGNED NOT NULL
);

INSERT INTO services (name, cost)
VALUES ('Cleaning', 510),
       ('Windows washing', 1200),
       ('Dry cleaning', 780);

CREATE TABLE orders_staff (
    order_id    INT NOT NULL,
    employee_id INT NOT NULL
);

ALTER TABLE orders
    ADD service_id INT DEFAULT 1 AFTER employee_id;

INSERT INTO orders_staff (order_id, employee_id)
    SELECT order_id, employee_id FROM orders;

ALTER TABLE orders
    DROP FOREIGN KEY fk_employee,
    DROP COLUMN employee_id,
    DROP COLUMN cost;

ALTER TABLE orders_staff
    ADD CONSTRAINT fk_order
    FOREIGN KEY    (order_id)
    REFERENCES     orders (order_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

    ADD CONSTRAINT fk_employee
    FOREIGN KEY    (employee_id)
    REFERENCES     staff (employee_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE orders
    ADD CONSTRAINT fk_service
    FOREIGN KEY    (service_id)
    REFERENCES     services (service_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

SHOW TABLES;

DESC orders;
DESC orders_staff;
DESC services;

SELECT * FROM orders;
SELECT * FROM orders_staff;

INSERT INTO orders (client_id, service_id)
VALUES (6, 2),
       (7, 2),
       (3, 2),
       (5, 1),
       (6, 3),
       (2, 3),
       (9, 2),
       (1, 2),
       (8, 3),
       (1, 2),
       (4, 3),
       (5, 3),
       (3, 3),
       (9, 3),
       (7, 1),
       (7, 1),
       (1, 3),
       (3, 2),
       (2, 3),
       (1, 1);

SELECT * FROM orders;
SELECT * FROM orders_staff;
SELECT * FROM staff;

INSERT INTO orders_staff (order_id, employee_id)
VALUES (31, 4),
       (37, 6),
       (32, 6),
       (26, 10),
       (26, 5),
       (24, 9),
       (23, 1),
       (22, 7),
       (39, 2),
       (30, 4),
       (24, 9),
       (35, 6),
       (39, 10),
       (24, 7),
       (31, 2),
       (25, 10),
       (33, 6),
       (30, 1),
       (26, 8),
       (30, 10),
       (27, 6),
       (22, 8),
       (30, 6),
       (30, 2),
       (39, 6),
       (26, 8),
       (25, 7),
       (40, 8),
       (24, 5),
       (35, 7),
       (25, 9),
       (37, 8),
       (31, 10),
       (29, 5),
       (34, 2),
       (30, 7),
       (27, 7),
       (23, 2),
       (26, 4),
       (28, 3),
       (38, 6),
       (24, 7),
       (31, 9),
       (25, 7),
       (22, 7),
       (25, 5),
       (29, 4),
       (25, 9),
       (23, 3),
       (38, 4),
       (31, 6),
       (40, 1),
       (36, 8),
       (37, 7),
       (35, 6),
       (36, 4),
       (25, 6),
       (34, 9),
       (24, 5);

SELECT * FROM orders;
SELECT * FROM orders_staff;
SELECT * FROM services;

SHOW TABLES;
DESC clients;
DESC staff;
