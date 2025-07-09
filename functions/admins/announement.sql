
CREATE OR REPLACE FUNCTION create_announcement(
  p_admin_id INT,
  p_title VARCHAR,
  p_body TEXT
) RETURNS VOID AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Admins WHERE user_id = p_admin_id) THEN
    RAISE EXCEPTION 'User % is not an admin.', p_admin_id;
  END IF;

  INSERT INTO Announcements (admin_id, title, body)
  VALUES (p_admin_id, p_title, p_body);
END;
$$ LANGUAGE plpgsql;
