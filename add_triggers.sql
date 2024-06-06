-- Функции и триггеры
CREATE OR REPLACE FUNCTION update_task_coordinates() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE tasks
    SET x = NEW.x,
        y = NEW.y,
        z = NEW.z
    WHERE location_id = NEW.location_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_task_coordinates
    AFTER UPDATE OF x, y, z
    ON locations
    FOR EACH ROW
EXECUTE FUNCTION update_task_coordinates();

CREATE OR REPLACE FUNCTION update_task_mission_name() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE tasks
    SET mission_name = NEW.name
    WHERE EXISTS (SELECT 1
                  FROM _task_to_mission
                  WHERE _task_to_mission.task_id = tasks.task_id
                    AND _task_to_mission.mission_id = NEW.mission_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_task_mission_name
    AFTER UPDATE OF name
    ON missions
    FOR EACH ROW
EXECUTE FUNCTION update_task_mission_name();

CREATE OR REPLACE FUNCTION update_task_researcher_specialization() RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO _task_to_researchers (researcher_id, task_id, specialization)
        VALUES (NEW.researcher_id, NEW.task_id,
                (SELECT specialization FROM researches WHERE researcher_id = NEW.researcher_id));
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE _task_to_researchers
        SET specialization = (SELECT specialization FROM researches WHERE researcher_id = NEW.researcher_id)
        WHERE researcher_id = NEW.researcher_id
          AND task_id = NEW.task_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_task_researcher_specialization
    AFTER INSERT OR UPDATE
    ON _task_to_researchers
    FOR EACH ROW
EXECUTE FUNCTION update_task_researcher_specialization();

CREATE TABLE IF NOT EXISTS processed_tasks
(
    task_id INT PRIMARY KEY
);


CREATE OR REPLACE FUNCTION assign_task_to_researchers() RETURNS TRIGGER AS $$
DECLARE
    least_loaded_researcher INT;
BEGIN
    SELECT r.researcher_id
    INTO least_loaded_researcher
    FROM researches r
             LEFT JOIN (
        SELECT researcher_id, COUNT(task_id) AS task_count
        FROM _task_to_researchers
        GROUP BY researcher_id
    ) AS task_counts
                    ON r.researcher_id = task_counts.researcher_id
    WHERE r.specialization = NEW.specialization
    ORDER BY task_counts.task_count ASC NULLS FIRST
    LIMIT 1;

    IF least_loaded_researcher IS NOT NULL THEN
        INSERT INTO _task_to_researchers (researcher_id, task_id, specialization)
        VALUES (least_loaded_researcher, NEW.task_id, NEW.specialization);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_assign_task_to_researchers
    AFTER INSERT ON tasks
    FOR EACH ROW
EXECUTE FUNCTION assign_task_to_researchers();
