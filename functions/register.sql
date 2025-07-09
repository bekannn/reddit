CREATE OR REPLACE FUNCTION register_regular_user(
    p_username VARCHAR(50),
    p_email VARCHAR(100),
    p_password_hash VARCHAR(255)
)
RETURNS TABLE (
    user_id INT,
    username VARCHAR,
    email VARCHAR
)
LANGUAGE plpgsql AS
$$
DECLARE
    new_user_id INT;
BEGIN
    -- Insert into Users
    INSERT INTO Users (username, email, password_hash, created_at)
    VALUES (p_username, p_email, p_password_hash, NOW())
    RETURNING Users.user_id INTO new_user_id;  -- ✅ disambiguated

    -- Insert into RegularUsers
    INSERT INTO RegularUsers (user_id, status)
    VALUES (new_user_id, 'active');

    -- Return user info
    RETURN QUERY
    SELECT u.user_id, u.username, u.email
    FROM Users u
    WHERE u.user_id = new_user_id;
END;
$$;

DROP FUNCTION register_regular_user(p_username VARCHAR(50), p_email VARCHAR(100), p_password_hash VARCHAR(255));