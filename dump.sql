--
-- File generated with SQLiteStudio v3.2.1 on Mon Mar 25 21:24:49 2019
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: applications
CREATE TABLE applications (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL UNIQUE);
INSERT INTO applications (id, name) VALUES (1, 'Accelerated Contouring Body Mask');
INSERT INTO applications (id, name) VALUES (2, 'Collagen Ampoule');
INSERT INTO applications (id, name) VALUES (3, 'Elastin Ampuole');
INSERT INTO applications (id, name) VALUES (4, 'Hyaluronic Ampoule');
INSERT INTO applications (id, name) VALUES (5, 'Aminocell Ampoule');
INSERT INTO applications (id, name) VALUES (6, 'Aminodren Ampoule');

-- Table: body_treatment_rooms
CREATE TABLE body_treatment_rooms (id INTEGER PRIMARY KEY AUTOINCREMENT, room_id INTEGER REFERENCES rooms (id) ON UPDATE CASCADE NOT NULL, body_treatment_id INTEGER REFERENCES body_treatments (id) ON UPDATE CASCADE NOT NULL);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (1, 1, 1);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (2, 2, 1);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (3, 6, 1);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (4, 1, 2);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (5, 2, 2);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (6, 6, 2);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (7, 1, 3);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (8, 2, 3);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (9, 6, 3);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (10, 1, 4);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (11, 2, 4);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (12, 6, 4);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (13, 1, 5);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (14, 2, 5);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (15, 6, 5);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (16, 1, 6);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (17, 2, 6);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (18, 6, 6);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (19, 1, 7);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (20, 2, 7);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (21, 6, 7);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (22, 1, 8);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (23, 2, 8);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (24, 6, 8);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (25, 1, 9);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (26, 2, 9);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (27, 6, 9);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (28, 3, 10);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (29, 4, 10);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (30, 5, 10);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (31, 3, 11);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (32, 4, 11);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (33, 5, 11);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (34, 3, 12);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (35, 4, 12);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (36, 5, 12);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (37, 1, 13);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (38, 2, 13);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (39, 3, 13);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (40, 4, 13);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (41, 5, 13);
INSERT INTO body_treatment_rooms (id, room_id, body_treatment_id) VALUES (42, 6, 13);

-- Table: body_treatments
CREATE TABLE body_treatments (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING UNIQUE NOT NULL);
INSERT INTO body_treatments (id, name) VALUES (1, 'Infrared Treatment');
INSERT INTO body_treatments (id, name) VALUES (2, 'Collagen Turbo');
INSERT INTO body_treatments (id, name) VALUES (3, 'Mega Plus Turbo');
INSERT INTO body_treatments (id, name) VALUES (4, 'Mediprotrim Turbo');
INSERT INTO body_treatments (id, name) VALUES (5, 'Diamond Turbo');
INSERT INTO body_treatments (id, name) VALUES (6, 'Vinotherapy Turbo');
INSERT INTO body_treatments (id, name) VALUES (7, 'Vinotherapy Diamond Turbo');
INSERT INTO body_treatments (id, name) VALUES (8, 'Seaweed Diamond Turbo');
INSERT INTO body_treatments (id, name) VALUES (9, 'Seaweed Vinotherapy Diamond Turbo');
INSERT INTO body_treatments (id, name) VALUES (10, 'Firmasulpt Treatment');
INSERT INTO body_treatments (id, name) VALUES (11, 'Firmasculpt w/Medi Bands');
INSERT INTO body_treatments (id, name) VALUES (12, 'Firmasculpt Diamond w/Medi Bands');
INSERT INTO body_treatments (id, name) VALUES (13, 'LED Full Body Treatment');

-- Table: client_measurements
CREATE TABLE client_measurements (id INTEGER PRIMARY KEY AUTOINCREMENT, client_id INTEGER REFERENCES clients (id) ON UPDATE CASCADE NOT NULL, created_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP), weight DECIMAL, waist DECIMAL);
INSERT INTO client_measurements (id, client_id, created_at, weight, waist) VALUES (18, 1, '2019-03-26 02:56:12.426 +00:00', 1, 1);
INSERT INTO client_measurements (id, client_id, created_at, weight, waist) VALUES (19, 2, '2019-03-26 03:04:39.217 +00:00', 11, 11);

-- Table: clients
CREATE TABLE clients (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name STRING NOT NULL, last_name STRING NOT NULL, created_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP));
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (1, 'Frank', 'Richards', '2019-03-18 06:18:27.755 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (2, 'Joe', 'Fresh', '2019-03-18 21:18:59.584 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (3, 'Peter', 'Johnson', '2019-03-18 21:54:51.271 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (4, 'Lisa', 'Washington', '2019-03-18 22:18:30.391 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (6, 'Drew', 'Pereli', '2019-03-25 23:26:25.349 +00:00');

-- Table: employees
CREATE TABLE employees (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name STRING NOT NULL, last_name STRING NOT NULL, location_id INTEGER REFERENCES locations (id) NOT NULL, created_at DATETIME DEFAULT (CURRENT_TIMESTAMP) NOT NULL);
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (2, 'Joe', 'Smith', 1, '2019-03-19 01:23:54.377 +00:00');
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (3, 'John', 'Brown', 1, '2019-03-19 01:25:02.665 +00:00');
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (4, 'Jane', 'Doe', 2, '2019-03-21 21:40:45');
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (5, 'Jim', 'Johnson', 1, '2019-03-21 22:08:02.075 +00:00');
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (6, 'Jessica', 'White', 1, '2019-03-21 22:10:17.718 +00:00');
INSERT INTO employees (id, first_name, last_name, location_id, created_at) VALUES (7, 'Laura', 'Smith', 2, '2019-03-21 22:10:29.314 +00:00');

-- Table: face_treatments
CREATE TABLE face_treatments (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL UNIQUE);
INSERT INTO face_treatments (id, name) VALUES (1, 'Non-surgical Face Lift');
INSERT INTO face_treatments (id, name) VALUES (2, 'Non-surgical Forehead');
INSERT INTO face_treatments (id, name) VALUES (3, 'Non-surgical Combo');
INSERT INTO face_treatments (id, name) VALUES (4, 'Collagen Face Mask');
INSERT INTO face_treatments (id, name) VALUES (5, '24K Gold Face Mask');
INSERT INTO face_treatments (id, name) VALUES (6, 'Face Wrap');

-- Table: locations
CREATE TABLE locations (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL, password STRING (256) NOT NULL);
INSERT INTO locations (id, name, password) VALUES (1, 'location 1', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');
INSERT INTO locations (id, name, password) VALUES (2, 'location 2', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');

-- Table: room_logs
CREATE TABLE room_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, created_at DATETIME DEFAULT (CURRENT_TIMESTAMP) NOT NULL, room_id REFERENCES rooms (id) ON UPDATE CASCADE NOT NULL, room_state_id REFERENCES room_states (id) ON UPDATE CASCADE NOT NULL, body_treatment_id REFERENCES body_treatments (id) ON UPDATE CASCADE, second_body_treatment_id REFERENCES body_treatments (id) ON UPDATE CASCADE, application_id REFERENCES applications (id) ON UPDATE CASCADE, face_treatment_id REFERENCES face_treatments (id) ON UPDATE CASCADE, upgrade_id REFERENCES upgrades (id) ON UPDATE CASCADE, client_id REFERENCES clients (id) ON UPDATE CASCADE, employee_id REFERENCES employees (id) ON UPDATE CASCADE NOT NULL);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (8, '2019-03-19 02:26:37', 6, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (9, '2019-03-19 02:26:37', 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (10, '2019-03-19 02:26:37', 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (11, '2019-03-19 02:26:37', 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (12, '2019-03-19 02:26:37', 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (13, '2019-03-19 02:26:37', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (193, '2019-03-21 21:40:57', 7, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (194, '2019-03-21 21:40:57', 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (195, '2019-03-21 21:40:57', 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (196, '2019-03-21 21:40:57', 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (197, '2019-03-21 21:40:57', 11, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (400, '2019-03-26 04:22:02.359 +00:00', 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (401, '2019-03-26 04:22:05.712 +00:00', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (402, '2019-03-26 04:23:12.910 +00:00', 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (403, '2019-03-26 04:23:14.308 +00:00', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (404, '2019-03-26 04:23:20.432 +00:00', 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (405, '2019-03-26 04:23:22.293 +00:00', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (406, '2019-03-26 04:23:29.484 +00:00', 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (407, '2019-03-26 04:23:30.826 +00:00', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2');

-- Table: room_states
CREATE TABLE room_states (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING UNIQUE NOT NULL, next_state_id INTEGER REFERENCES room_states (id) ON UPDATE CASCADE);
INSERT INTO room_states (id, name, next_state_id) VALUES (1, 'available', 4);
INSERT INTO room_states (id, name, next_state_id) VALUES (2, 'needs_cleaning', 1);
INSERT INTO room_states (id, name, next_state_id) VALUES (3, 'client_in_treatment', 2);
INSERT INTO room_states (id, name, next_state_id) VALUES (4, 'client_waiting', 6);
INSERT INTO room_states (id, name, next_state_id) VALUES (5, 'reserved', 1);
INSERT INTO room_states (id, name, next_state_id) VALUES (6, 'treatment_being_applied', 3);

-- Table: rooms
CREATE TABLE rooms (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL, location_id INTEGER REFERENCES locations (id) ON UPDATE CASCADE, turbo BOOLEAN NOT NULL DEFAULT (false));
INSERT INTO rooms (id, name, location_id, turbo) VALUES (1, 1, 1, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (2, 2, 1, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (3, 3, 1, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (4, 4, 1, 0);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (5, 5, 1, 0);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (6, 6, 1, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (7, 1, 2, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (8, 2, 2, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (9, 3, 2, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (10, 4, 2, 1);
INSERT INTO rooms (id, name, location_id, turbo) VALUES (11, 5, 2, 1);

-- Table: upgrades
CREATE TABLE upgrades (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL UNIQUE);
INSERT INTO upgrades (id, name) VALUES (1, 'Vino Diamond');
INSERT INTO upgrades (id, name) VALUES (2, 'Pumpkin');
INSERT INTO upgrades (id, name) VALUES (3, 'Mega Plus');
INSERT INTO upgrades (id, name) VALUES (4, 'Mediprotrim');
INSERT INTO upgrades (id, name) VALUES (5, 'Vinotherapy');
INSERT INTO upgrades (id, name) VALUES (6, 'Seaweed Diamond');
INSERT INTO upgrades (id, name) VALUES (7, 'Ultimate Skin Renewal');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
