/*
  STATUS:
      REVIEWED
  COMMENTS:
      First three points are done
*/

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

SELECT * FROM orders;
