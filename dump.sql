--
-- File generated with SQLiteStudio v3.2.1 on Mon Mar 25 13:34:59 2019
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

-- Table: clients
CREATE TABLE clients (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name STRING NOT NULL, last_name STRING NOT NULL, created_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP));
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (1, 'Frank', 'Richards', '2019-03-18 06:18:27.755 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (2, 'Joe', 'Fresh', '2019-03-18 21:18:59.584 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (3, 'Peter', 'Johnson', '2019-03-18 21:54:51.271 +00:00');
INSERT INTO clients (id, first_name, last_name, created_at) VALUES (4, 'Lisa', 'Washington', '2019-03-18 22:18:30.391 +00:00');

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
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (177, '2019-03-21 21:35:29.665 +00:00', 2, 4, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (178, '2019-03-21 21:35:32.383 +00:00', 2, 3, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (179, '2019-03-21 21:35:34.400 +00:00', 2, 2, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (180, '2019-03-21 21:35:36.058 +00:00', 2, 1, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (181, '2019-03-21 21:35:42.823 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (182, '2019-03-21 21:35:45.508 +00:00', 2, 4, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (183, '2019-03-21 21:35:48.349 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (184, '2019-03-21 21:35:56.106 +00:00', 3, 4, '11', NULL, NULL, NULL, NULL, '3', '3');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (185, '2019-03-21 21:35:59.535 +00:00', 2, 3, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (186, '2019-03-21 21:36:00.733 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (187, '2019-03-21 21:36:02.696 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (188, '2019-03-21 21:36:05.265 +00:00', 2, 2, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (189, '2019-03-21 21:36:06.801 +00:00', 2, 1, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (190, '2019-03-21 21:36:08.701 +00:00', 3, 3, '11', NULL, NULL, NULL, NULL, '3', '3');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (191, '2019-03-21 21:36:10.909 +00:00', 3, 2, '11', NULL, NULL, NULL, NULL, '3', '3');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (192, '2019-03-21 21:36:18.303 +00:00', 3, 1, '11', NULL, NULL, NULL, NULL, '3', '3');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (193, '2019-03-21 21:40:57', 7, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (194, '2019-03-21 21:40:57', 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (195, '2019-03-21 21:40:57', 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (196, '2019-03-21 21:40:57', 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (197, '2019-03-21 21:40:57', 11, 1, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (198, '2019-03-21 21:42:57.302 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (199, '2019-03-21 21:42:59.624 +00:00', 2, 4, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (200, '2019-03-21 21:43:04.549 +00:00', 2, 3, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (201, '2019-03-21 21:43:05.421 +00:00', 2, 2, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (202, '2019-03-21 21:43:07.009 +00:00', 2, 1, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (203, '2019-03-21 22:11:14.923 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (204, '2019-03-21 22:11:22.156 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (205, '2019-03-21 22:11:24.749 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '1', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (206, '2019-03-23 18:36:55.191 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '3');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (207, '2019-03-23 18:37:25.047 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (208, '2019-03-23 18:37:43.935 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (209, '2019-03-23 18:37:47.781 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (210, '2019-03-23 18:38:23.294 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (211, '2019-03-23 18:38:32.929 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (212, '2019-03-23 18:38:41.687 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (213, '2019-03-23 18:38:43.130 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (214, '2019-03-23 18:38:49.719 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (215, '2019-03-23 18:39:00.704 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (216, '2019-03-23 18:41:40.226 +00:00', 2, 4, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (217, '2019-03-23 18:48:54.366 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (218, '2019-03-23 18:48:55.790 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (219, '2019-03-25 01:14:10.098 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (220, '2019-03-25 01:14:14.250 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (221, '2019-03-25 01:14:16.696 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (222, '2019-03-25 01:14:18.745 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (223, '2019-03-25 03:53:53.721 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (224, '2019-03-25 03:53:55.544 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (225, '2019-03-25 03:53:57.675 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (226, '2019-03-25 03:53:59.908 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (227, '2019-03-25 03:54:01.862 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (228, '2019-03-25 03:57:53.265 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (229, '2019-03-25 03:57:57.549 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (230, '2019-03-25 03:59:49.927 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (231, '2019-03-25 04:08:12.459 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (232, '2019-03-25 04:08:14.991 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (233, '2019-03-25 04:08:19.680 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (234, '2019-03-25 04:08:20.923 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (235, '2019-03-25 04:11:06.136 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (236, '2019-03-25 04:11:08.598 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (237, '2019-03-25 04:11:10.073 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (238, '2019-03-25 04:12:10.482 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (239, '2019-03-25 04:12:11.538 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (240, '2019-03-25 04:12:12.587 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (241, '2019-03-25 04:12:13.725 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (242, '2019-03-25 04:17:07.258 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (243, '2019-03-25 04:17:09.058 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (244, '2019-03-25 04:17:10.262 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (245, '2019-03-25 04:17:11.402 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (246, '2019-03-25 04:17:12.923 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (247, '2019-03-25 04:17:55.942 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (248, '2019-03-25 04:17:57.022 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (249, '2019-03-25 04:17:58.800 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (250, '2019-03-25 04:18:00.106 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (251, '2019-03-25 04:18:01.176 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (252, '2019-03-25 04:18:01.949 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (253, '2019-03-25 04:30:16.691 +00:00', 2, 6, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (254, '2019-03-25 04:30:19.264 +00:00', 2, 3, '1', NULL, NULL, NULL, NULL, '2', '2');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (255, '2019-03-25 04:40:36.573 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (256, '2019-03-25 04:41:11.917 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (257, '2019-03-25 04:41:14.330 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (258, '2019-03-25 04:41:15.949 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (259, '2019-03-25 04:43:01.951 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (260, '2019-03-25 04:43:03.133 +00:00', 1, 4, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (261, '2019-03-25 04:43:04.963 +00:00', 1, 6, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (262, '2019-03-25 04:43:06.760 +00:00', 1, 3, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (263, '2019-03-25 04:43:08.440 +00:00', 1, 2, '3', NULL, NULL, NULL, NULL, '3', '5');
INSERT INTO room_logs (id, created_at, room_id, room_state_id, body_treatment_id, second_body_treatment_id, application_id, face_treatment_id, upgrade_id, client_id, employee_id) VALUES (264, '2019-03-25 04:43:09.771 +00:00', 1, 1, '3', NULL, NULL, NULL, NULL, '3', '5');

-- Table: room_states
CREATE TABLE room_states (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING UNIQUE NOT NULL, next_state_id INTEGER REFERENCES room_states (id) ON UPDATE CASCADE);
INSERT INTO room_states (id, name, next_state_id) VALUES (1, 'available', 4);
INSERT INTO room_states (id, name, next_state_id) VALUES (2, 'needs_cleaning', 1);
INSERT INTO room_states (id, name, next_state_id) VALUES (3, 'client_in_treatment', 2);
INSERT INTO room_states (id, name, next_state_id) VALUES (4, 'client_waiting', 6);
INSERT INTO room_states (id, name, next_state_id) VALUES (5, 'reserved', 1);
INSERT INTO room_states (id, name, next_state_id) VALUES (6, 'treatment_being_applied', 3);

-- Table: rooms
CREATE TABLE rooms (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL, location_id INTEGER REFERENCES locations (id) ON UPDATE CASCADE);
INSERT INTO rooms (id, name, location_id) VALUES (1, 1, 1);
INSERT INTO rooms (id, name, location_id) VALUES (2, 2, 1);
INSERT INTO rooms (id, name, location_id) VALUES (3, 3, 1);
INSERT INTO rooms (id, name, location_id) VALUES (4, 4, 1);
INSERT INTO rooms (id, name, location_id) VALUES (5, 5, 1);
INSERT INTO rooms (id, name, location_id) VALUES (6, 6, 1);
INSERT INTO rooms (id, name, location_id) VALUES (7, 1, 2);
INSERT INTO rooms (id, name, location_id) VALUES (8, 2, 2);
INSERT INTO rooms (id, name, location_id) VALUES (9, 3, 2);
INSERT INTO rooms (id, name, location_id) VALUES (10, 4, 2);
INSERT INTO rooms (id, name, location_id) VALUES (11, 5, 2);

-- Table: upgrades
CREATE TABLE upgrades (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL UNIQUE);
INSERT INTO upgrades (id, name) VALUES (1, 'Vino Diamond');
INSERT INTO upgrades (id, name) VALUES (2, 'Pumpkin');
INSERT INTO upgrades (id, name) VALUES (3, 'Mega Plus');
INSERT INTO upgrades (id, name) VALUES (4, 'Mediprotrim');
INSERT INTO upgrades (id, name) VALUES (5, 'Vinotherapy');
INSERT INTO upgrades (id, name) VALUES (6, 'Seaweed Diamond');
INSERT INTO upgrades (id, name) VALUES (7, 'Ultimate Skin Renewal');

-- Table: weight_measurements
CREATE TABLE weight_measurements (id INTEGER PRIMARY KEY AUTOINCREMENT, client_id INTEGER REFERENCES clients (id) ON UPDATE CASCADE NOT NULL, created_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP), weight DECIMAL NOT NULL);
INSERT INTO weight_measurements (id, client_id, created_at, weight) VALUES (1, 1, '2019-03-21 06:09:23', 200);
INSERT INTO weight_measurements (id, client_id, created_at, weight) VALUES (2, 1, '2019-03-21 06:26:51.628 +00:00', 143);
INSERT INTO weight_measurements (id, client_id, created_at, weight) VALUES (3, 1, '2019-03-21 06:27:29.282 +00:00', 143);
INSERT INTO weight_measurements (id, client_id, created_at, weight) VALUES (4, 1, '2019-03-21 06:29:55.281 +00:00', 34);
INSERT INTO weight_measurements (id, client_id, created_at, weight) VALUES (5, 1, '2019-03-21 06:30:00.645 +00:00', 66);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
