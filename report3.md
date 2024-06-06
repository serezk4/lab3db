# Лабораторная работа 3 `42934`

## Выполнил Дорохин Сергей `412934`

## 1. Опишите функциональные зависимости для отношений полученной схемы (минимальное множество);

- `researcher_id → specialization, health`
- `robot_id → model, appointment, condition`
- `location_id → x, y, z`
- `item_id → name, condition, readiness`
- `dome_id → location_id, research`
- `task_id → creation_time, begin_time, end_time, task_status, name, location_id`
- `(task_id, researcher_id) → (task_id, researcher_id)`
- `(task_id, robot_id) → (task_id, robot_id)`
- `(task_id, item_id) → (task_id, item_id)`
- `mission_id → name, goal, result`
- `(task_id, mission_id) → (task_id, mission_id)`

## 2. Приведите отношения в 3NF (как минимум). Постройте схему на основеNF (как минимум).

### 2.1. Условия 1NF:
- Устраните повторяющиеся группы в отдельных таблицах.
- Создайте отдельную таблицу для каждого набора связанных данных.
- Идентифицируйте каждый набор связанных данных с помощью первичного ключа.

### 2.2 Условия 2NF:
- Создайте отдельные таблицы для наборов значений, относящихся к нескольким записям.
- Свяжите эти таблицы с помощью внешнего ключа.

### 2.3 Условия 3NF
- Исключите поля, которые не зависят от ключа.

### 2.4 Мои таблицы:

- Таблица `researches` уже в **3NF** (атрибуты зависят от `researcher_id`)
- Таблица `robots` уже в **3NF** (атрибуты зависят от `robot_id`)
- Таблица `locations` уже в **3NF** (атрибуты зависят от `location_id`)
- Таблица `items` уже в **3NF** (атрибуты зависят от `item_id`)
- Таблица `domes` уже в **3NF** (атрибуты зависят от `dome_id`)
- Таблица `tasks` уже в **3NF** (атрибуты зависят от `task_id`)
- Таблица `missions` уже в **3NF** (атрибуты зависят от `mission_id`)
- Таблица `_task_to_researchers` уже в **в** (атрибуты зависят от `(researcher_id, task_id)`)
- Таблица `_task_to_robots` уже в **3NF** (атрибуты зависят от `(robot_id, task_id)`)
- Таблица `_task_to_items` уже в **3NF** (атрибуты зависят от `(item_id, task_id)`)
- Таблица `_task_to_mission` уже в **3NF** (атрибуты зависят от `(task_id, mission_id)`)

Схема приведена к третьей нормальной форме. Все таблицы соответствуют требованиям 3NF, так как все атрибуты зависят от
ключа и нет транзитивных зависимостей.

## 3. Опишите изменения в функциональных зависимостях, произошедшие после преобразования в 3NF (как минимум). Постройте схему на основеNF;

Изменения в функциональных зависимостях отсутсвуют. Все зависимости в приведенной схеме соответствуют требованиям 3NF,
что минимизирует дублирование данных и обеспечивает целостность данных.

## 4. Преобразуйте отношения в BCNF. Докажите, что полученные отношения представлены в BCNF. Если ваша схема находится уже в BCNF, докажите это;

### 4.1 Шаги для преобразоания в BCNF

 4.1.1. **Определение зависимостей**:
  - Сначала я найду все функциональные зависимости для каждой таблицы в схеме базы данных.

4.1.2. **Проверка на соответствие BCNF**:
  - Для каждой зависимости \( X → Y \) я проверю, является ли \( X \) суперключом:
    - Если \( X \) суперключ, таблица уже в BCNF.
    - Если \( X \) не суперключ, я разделю таблицу.

4.1.3. **Разделение таблицы**:
  - Для каждой зависимости \( X → Y \), где \( X \) не суперключ:
    - Я создам новую таблицу с атрибутами \( X ∪ Y \).
    - Оставлю исходную таблицу с атрибутами \( R - Y ∪ X \).

4.1.4. **Повторение процесса**:
  - Я повторю шаги 2 и 3 для всех новых таблиц, пока все таблицы не будут в BCNF.

В итоге все таблицы будут приведены к BCNF.

### 4.2 Мои таблицы

Я, согласно алгоритму `4.1`, могу сделать вывод, что все таблицы в моей базе уже приведены к BCNF

## 5. Какие денормализации будут полезны для вашей схемы? Приведите подробное описание.

### 5.1 Денормализация `tasks` и `locations`

Добавление координат местоположения (x, y, z) непосредственно в таблицу tasks для уменьшения количества соединений.

> Измененный код:

```sql
CREATE TABLE tasks
(
  task_id       SERIAL PRIMARY KEY,
  creation_time timestamptz,
  begin_time    timestamptz,
  end_time      timestamptz,
  task_status   task_status,
  name          varchar(200),
  location_id   INT REFERENCES locations (location_id),
  x             float,
  y             float,
  z             float
);
```

**Преимущества:**

- Уменьшение количества соединений при выполнении запросов, связанных с местоположением задач.
- Ускорение выполнения запросов

**Недостатки:** избыточность данных. При изменении координат местоположения нужно обновлять все связанные записи
в  `tasks`.

### 5.2 Денормализация `tasks` и `missions`

Добавление названия миссии непосредственно в таблицу tasks для уменьшения количества соединений.

> Измененный код:

```sql
CREATE TABLE tasks
(
  task_id       SERIAL PRIMARY KEY,
  creation_time timestamptz,
  begin_time    timestamptz,
  end_time      timestamptz,
  task_status   task_status,
  name          varchar(200),
  location_id   INT REFERENCES locations (location_id),
  mission_name  varchar(200)
);
```

**Преимущества:**

- Уменьшение количества соединений при выполнении запросов, связанных с миссиями задач.
- Ускорение выполнения запросов

**Недостатки:**

- Избыточность данных. При изменении названия миссии нужно обновлять все связанные записи в `tasks`.

## 5.3 Денормализация `researches` и `tasks`

> Измененный код:

```sql
CREATE TABLE _task_to_researchers
(
  researcher_id  INT REFERENCES researches (researcher_id) ON DELETE CASCADE,
  task_id        INT REFERENCES tasks (task_id) ON DELETE CASCADE,
  specialization varchar(200)
);
```

**Преимущества:**

- Уменьшение количества соединений при выполнении запросов, связанных с исследователями и их задачами.
- Ускорение выполнения запросов.

**Недостатки:**

- Избыточность данных. При изменении специализации исследователя нужно обновлять все связанные записи
  в `_task_to_researchers`.

### 5.4 Итоговый код для приминения денормализации:

```postgresql
CREATE TABLE tasks
(
  task_id       SERIAL PRIMARY KEY,
  creation_time timestamptz,
  begin_time    timestamptz,
  end_time      timestamptz,
  task_status   task_status,
  name          varchar(200),
  location_id   INT REFERENCES locations (location_id),
  x             float,
  y             float,
  z             float,
  mission_name  varchar(200)
);

CREATE TABLE _task_to_researchers
(
  researcher_id  INT REFERENCES researches (researcher_id) ON DELETE CASCADE,
  task_id        INT REFERENCES tasks (task_id) ON DELETE CASCADE,
  specialization varchar(200)
);
```

## 6. Триггер и связанная с ним функция на PL/pgSQL

[//]: # (### 6.1 Триггер и функция для обновления координат задач при изменении местоположения)

[//]: # ()
[//]: # (```postgresql)

[//]: # (CREATE OR REPLACE FUNCTION update_task_coordinates&#40;&#41; RETURNS TRIGGER AS)

[//]: # ($$)

[//]: # (BEGIN)

[//]: # (    UPDATE tasks)

[//]: # (    SET x = NEW.x,)

[//]: # (        y = NEW.y,)

[//]: # (        z = NEW.z)

[//]: # (    WHERE location_id = NEW.location_id;)

[//]: # (    RETURN NEW;)

[//]: # (END;)

[//]: # ($$ LANGUAGE plpgsql;)

[//]: # ()
[//]: # (AFTER)

[//]: # (UPDATE OF x, y, z)

[//]: # (ON locations)

[//]: # (    FOR EACH ROW)

[//]: # (EXECUTE FUNCTION update_task_coordinates&#40;&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 6.2 Триггер и функция для обновления названия миссии в задачах при изменении названия миссии)

[//]: # ()
[//]: # (```postgresql)

[//]: # (CREATE OR REPLACE FUNCTION update_task_mission_name&#40;&#41; RETURNS TRIGGER AS)

[//]: # ($$)

[//]: # (BEGIN)

[//]: # (    UPDATE tasks)

[//]: # (    SET mission_name = NEW.name)

[//]: # (    WHERE EXISTS &#40;SELECT 1)

[//]: # (                  FROM _task_to_mission)

[//]: # (                  WHERE _task_to_mission.task_id = tasks.task_id)

[//]: # (                    AND _task_to_mission.mission_id = NEW.mission_id&#41;;)

[//]: # (    RETURN NEW;)

[//]: # (END;)

[//]: # ($$ LANGUAGE plpgsql;)

[//]: # ()
[//]: # (CREATE TRIGGER trg_update_task_mission_name)

[//]: # (    AFTER UPDATE OF name)

[//]: # (    ON missions)

[//]: # (    FOR EACH ROW)

[//]: # (EXECUTE FUNCTION update_task_mission_name&#40;&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 6.3 Триггер и функция для вставки или обновления специализации исследователей в _task_to_researchers)

[//]: # ()
[//]: # (```postgresql)

[//]: # (CREATE OR REPLACE FUNCTION update_task_researcher_specialization&#40;&#41; RETURNS TRIGGER AS)

[//]: # ($$)

[//]: # (BEGIN)

[//]: # (    IF TG_OP = 'INSERT' THEN)

[//]: # (        INSERT INTO _task_to_researchers &#40;researcher_id, task_id, specialization&#41;)

[//]: # (        VALUES &#40;NEW.researcher_id, NEW.task_id,)

[//]: # (                &#40;SELECT specialization FROM researches WHERE researcher_id = NEW.researcher_id&#41;&#41;;)

[//]: # (    ELSIF TG_OP = 'UPDATE' THEN)

[//]: # (        UPDATE _task_to_researchers)

[//]: # (        SET specialization = &#40;SELECT specialization FROM researches WHERE researcher_id = NEW.researcher_id&#41;)

[//]: # (        WHERE researcher_id = NEW.researcher_id)

[//]: # (          AND task_id = NEW.task_id;)

[//]: # (    END IF;)

[//]: # (    RETURN NEW;)

[//]: # (END;)

[//]: # ($$ LANGUAGE plpgsql;)

[//]: # ()
[//]: # (CREATE TRIGGER trg_update_task_researcher_specialization)

[//]: # (    AFTER INSERT OR UPDATE)

[//]: # (    ON _task_to_researchers)

[//]: # (    FOR EACH ROW)

[//]: # (EXECUTE FUNCTION update_task_researcher_specialization&#40;&#41;;)

[//]: # (```)

### 6.1 триггер и функция для равномерного распределения задач между исследователями

> assign_task_to_researchers() function
```postgresql
CREATE TABLE IF NOT EXISTS processed_tasks
(
  task_id INT PRIMARY KEY
);


CREATE OR REPLACE FUNCTION assign_task_to_researchers() RETURNS TRIGGER AS
$trg_assign_task_to_researchers$
DECLARE
  least_loaded_researcher INT;
BEGIN
  SELECT r.researcher_id
  INTO least_loaded_researcher
  FROM researches r
         LEFT JOIN (SELECT researcher_id, COUNT(task_id) AS task_count
                    FROM _task_to_researchers
                    GROUP BY researcher_id) AS task_counts
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
$trg_assign_task_to_researchers$ LANGUAGE plpgsql;
```

> trg_assign_task_to_researchers trigger

```postgresql
CREATE OR REPLACE TRIGGER trg_assign_task_to_researchers
  AFTER INSERT
  ON tasks
  FOR EACH ROW
EXECUTE FUNCTION assign_task_to_researchers();
```

> code for test:

```postgresql
DELETE FROM _task_to_researchers WHERE researcher_id > 0;
DELETE FROM _task_to_researchers WHERE task_id > 0;
DELETE FROM researches WHERE researcher_id > 0;
DELETE FROM tasks WHERE task_id > 0;

INSERT INTO researches (specialization, health)
VALUES ('Biology', 'healthy');

INSERT INTO researches (specialization, health)
VALUES ('Biology', 'healthy');

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

select * from tasks;

SELECT * FROM _task_to_researchers;
```