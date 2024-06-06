-- insert data --
INSERT INTO locations (x, y, z) VALUES
                                    (0.1, 0.2, 0.3),
                                    (1.1, 1.2, 1.3),
                                    (2.1, 2.2, 2.3);
INSERT INTO researches (specialization, health) VALUES
                                                    ('Astrophysics', 'healthy'),
                                                    ('Robotics', 'ill'),
                                                    ('Quantum Computing', 'healthy');
INSERT INTO robots (model, appointment, condition) VALUES
                                                       ('033', 'Exploration', 'Fine'),
                                                       ('077', 'Maintenance', 'Medium'),
                                                       ('999', 'Research', 'Broken');
INSERT INTO items (name, condition, readiness) VALUES
                                                   ('Sensor Module', 'Factory New', 'Operational'),
                                                   ('Battery Pack', 'Field Tested', 'Maintenance'),
                                                   ('Control Unit', 'Damaged', 'Developing');
INSERT INTO domes (location_id, research) VALUES
                                              (1, 'Operational'),
                                              (2, 'Maintenance');
INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name,
                   location_id) VALUES
                                    (NOW(), NOW(), NOW() + INTERVAL '1 day', 'Running', 'Data Collection',
                                     1),
                                    (NOW(), NOW(), NOW() + INTERVAL '2 days', 'Finished', 'Maintenance Work',
                                     2);
INSERT INTO _task_to_researchers (researcher_id, task_id) VALUES
                                                              (1, 1),
                                                              (2, 2);
INSERT INTO _task_to_robots (robot_id, task_id) VALUES
                                                    (1, 1),
                                                    (2, 2);
INSERT INTO _task_to_items (item_id, task_id) VALUES
                                                  (1, 1),
                                                  (2, 2);
INSERT INTO missions (name, goal, result) VALUES
                                              ('Mars Exploration', 'Explore the Martian Surface', 'Successful'),
                                              ('Lunar Base Setup', 'Establish a base on the Moon', 'In Progress');
INSERT INTO _task_to_mission (task_id, mission_id) VALUES
                                                       (1, 1),
                                                       (2, 2);