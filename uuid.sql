CREATE TABLE user
(
    user_id SERIAL PRIMARY KEY,
    uuid VARCHAR(16) UNIQUE,
    username VARCHAR(50)
);

-- (uuid) -> username
-- (user_id) -> username