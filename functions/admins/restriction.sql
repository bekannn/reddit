
CREATE OR REPLACE FUNCTION restrict_user(
  p_admin_id INT,
  p_user_id INT,
  p_reason TEXT,
  p_duration_days INT DEFAULT NULL  -- NULL = ban, number = suspension
) RETURNS VOID AS $$
DECLARE
  is_admin BOOLEAN;
BEGIN
  -- Check admin rights
  SELECT EXISTS (
    SELECT 1 FROM Admins WHERE user_id = p_admin_id
  ) INTO is_admin;
  IF NOT is_admin THEN
    RAISE EXCEPTION 'Only admins can restrict users';
  END IF;

  -- Insert restriction
  INSERT INTO Restriction (
    user_id, admin_id, reason, ban_date, duration_days, is_active
  ) VALUES (
    p_user_id, p_admin_id, p_reason, NOW(), p_duration_days, true
  );

  UPDATE RegularUsers
  SET status = CASE
    WHEN p_duration_days IS NULL THEN 'banned'::user_status
    ELSE 'suspended'::user_status
  END
  WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION view_restricted_users(p_admin_user_id INT)
RETURNS TABLE (
  restriction_id INT,
  user_id INT,
  restriction_type user_status,
  reason TEXT,
  ban_date TIMESTAMP,
  duration_days INT,
  is_active BOOLEAN
) AS $$
BEGIN
  -- Check if the caller is an admin
  IF NOT EXISTS (SELECT 1 FROM Admins a WHERE a.user_id = p_admin_user_id) THEN
    RAISE EXCEPTION 'Access denied: not an admin';
  END IF;

  RETURN QUERY
  SELECT
    r.restriction_id,
    r.user_id,
    u.status,
    r.reason,
    r.ban_date,
    r.duration_days,
    r.is_active
  FROM Restriction r
  JOIN RegularUsers u ON r.user_id = u.user_id
  WHERE r.is_active = TRUE;
END;
$$ LANGUAGE plpgsql;



-- REMOVES
CREATE OR REPLACE FUNCTION remove_restriction(p_admin_id INT, p_user_id INT)
RETURNS VOID AS $$
BEGIN
  -- Check admin rights
  IF NOT EXISTS (SELECT 1 FROM Admins WHERE user_id = p_admin_id) THEN
    RAISE EXCEPTION 'Access denied: not an admin';
  END IF;

  -- Deactivate restriction
  UPDATE Restriction
  SET is_active = FALSE
  WHERE user_id = p_user_id AND is_active = TRUE;

  -- Restore user status to 'active'
  UPDATE RegularUsers
  SET status = 'active'::user_status
  WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

