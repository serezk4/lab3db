-- DELETE FROM _task_to_researchers WHERE researcher_id > 0;
-- DELETE FROM _task_to_researchers WHERE task_id > 0;
-- DELETE FROM researches WHERE researcher_id > 0;
-- DELETE FROM tasks WHERE task_id > 0;
--
-- INSERT INTO researches (specialization, health)
-- VALUES ('Biology', 'healthy');
--
-- INSERT INTO researches (specialization, health)
-- VALUES ('Biology', 'healthy');
--
INSERT INTO researches (specialization, health)
VALUES ('Biology', 'healthy');

select * from researches;

INSERT INTO locations (x,y,z)
VALUES (1,2,3);

select * from locations;

INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 1', 'Biology');

INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 2', 'Biology');

INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 3', 'Biology');

INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 3', 'Biology');
INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 3', 'Biology');
INSERT INTO tasks (creation_time, begin_time, end_time, task_status, name, location_id, x, y, z, mission_name, specialization)
VALUES (NOW(), NOW() + INTERVAL '1 hour', NOW() + INTERVAL '2 hours', 'Registration', 'New Task', 1, 10.0, 20.0, 30.0, 'Mission Alpha 3', 'Biology');

select * from tasks;

SELECT * FROM _task_to_researchers;