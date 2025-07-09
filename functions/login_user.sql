CREATE OR REPLACE FUNCTION login_user(_username TEXT, _password TEXT)
RETURNS INTEGER AS $$
DECLARE
    uid INTEGER;
BEGIN
    SELECT u.user_id
    INTO uid
    FROM Users u
    JOIN RegularUsers r ON u.user_id = r.user_id
    WHERE u.username = _username
      AND u.password_hash = _password;

    IF uid IS NULL THEN
        RAISE EXCEPTION 'Invalid credentials';
    END IF;

    IF EXISTS (
        SELECT 1 FROM RegularUsers r
        JOIN Users u ON u.user_id = r.user_id
        WHERE u.username = _username AND r.status = 'banned'::user_status
    ) THEN
        RAISE EXCEPTION 'User % is banned', _username;
    END IF;

    RETURN uid;
END;
$$ LANGUAGE plpgsql;


