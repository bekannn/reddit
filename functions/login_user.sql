CREATE OR REPLACE FUNCTION login_user(_username TEXT, _password TEXT)
RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT users.user_id FROM users WHERE username = _username AND password_hash = _password)
;
END;
$$;
