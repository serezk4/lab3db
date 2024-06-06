-- create enums ---
CREATE TYPE readiness_status AS ENUM ('Operational', 'Maintenance',
    'Developing');
CREATE TYPE task_status AS ENUM ('Registration', 'Running', 'Finished',
    'Failed');
CREATE TYPE item_condition AS ENUM ('Factory New', 'Field Tested', 'Damaged',
    'Broken');
CREATE TYPE research_status AS ENUM ('Reached', 'Unreached');
CREATE TYPE technical_condition AS ENUM ('Fine', 'Medium', 'Broken');
CREATE TYPE model_type AS ENUM ('033', '077', '999');
CREATE TYPE health_status AS ENUM ('healthy', 'ill');

-- create tables --
CREATE TABLE researches
(
    researcher_id  SERIAL PRIMARY KEY,
    specialization varchar(200),
    health         health_status
);

CREATE TABLE robots
(
    robot_id    SERIAL PRIMARY KEY,
    model       model_type,
    appointment varchar(200),
    condition   technical_condition
);

--
-- CREATE TABLE locations
-- (
--     location_id SERIAL PRIMARY KEY,
--     x           float,
--     y           float,
--     z           float
-- );

CREATE TABLE locations
(
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(255) UNIQUE,
    x           float,
    y           float,
    z           float
);

CREATE TABLE locations_names (
    location_name_id SERIAL PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL,
    location_id SERIAL REFERENCES locations(location_id)
);

CREATE TABLE items
(
    item_id   SERIAL PRIMARY KEY,
    name      varchar(200),
    condition item_condition,
    readiness readiness_status
);
CREATE TABLE domes
(
    dome_id     SERIAL PRIMARY KEY,
    location_id INT REFERENCES locations (location_id) ON DELETE CASCADE,
    research    readiness_status
);
-- CREATE TABLE tasks
-- (
--     task_id       SERIAL PRIMARY KEY,
--     creation_time timestamptz,
--     begin_time    timestamptz,
--     end_time      timestamptz,
--     task_status   task_status,
--     name          varchar(200),
--     location_id   INT REFERENCES locations (location_id)
-- );

-- replaced with normalization
CREATE TABLE tasks
(
    task_id        SERIAL PRIMARY KEY,
    creation_time  timestamptz,
    begin_time     timestamptz,
    end_time       timestamptz,
    task_status    task_status,
    name           varchar(200),
    location_id    INT REFERENCES locations (location_id),
    x              float,
    y              float,
    z              float,
    mission_name   varchar(200),
    specialization varchar(200) -- Новое поле специализации
);

-- CREATE TABLE _task_to_researchers
-- (
--     researcher_id INT REFERENCES researches(researcher_id) ON DELETE CASCADE,
--     task_id INT REFERENCES tasks(task_id) ON DELETE CASCADE
-- );

-- replaced with normalization
CREATE TABLE _task_to_researchers
(
    researcher_id  INT REFERENCES researches (researcher_id) ON DELETE CASCADE,
    task_id        INT REFERENCES tasks (task_id) ON DELETE CASCADE
);

CREATE TABLE _task_to_robots
(
    robot_id INT REFERENCES robots (robot_id) ON DELETE CASCADE,
    task_id  INT REFERENCES tasks (task_id) ON DELETE CASCADE
);
CREATE TABLE _task_to_items
(
    item_id INT REFERENCES items (item_id) ON DELETE CASCADE,
    task_id INT REFERENCES tasks (task_id) ON DELETE CASCADE
);

CREATE TABLE missions
(
    mission_id SERIAL PRIMARY KEY,
    name       varchar(200),
    goal       varchar(200),
    result     varchar(200)
);
CREATE TABLE _task_to_mission
(
    task_id    INT REFERENCES tasks (task_id) ON DELETE CASCADE,
    mission_id INT REFERENCES missions (mission_id) ON DELETE CASCADE
);
