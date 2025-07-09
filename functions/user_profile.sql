CREATE OR REPLACE FUNCTION get_user_profile(p_user_id INT)
RETURNS TABLE (
  user_id INT,
  username VARCHAR,
  email VARCHAR,
  created_at TIMESTAMP,
  post_karma INT,
  comment_karma INT,
  total_karma INT,
  profile_description TEXT,
  profile_image_url VARCHAR,
  status user_status
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    u.user_id,
    u.username,
    u.email,
    u.created_at,
    ru.post_karma,
    ru.comment_karma,
    (ru.post_karma + ru.comment_karma) AS total_karma,
    ru.profile_description,
    ru.profile_image_url,
    ru.status
  FROM Users u
  JOIN RegularUsers ru ON u.user_id = ru.user_id
  WHERE u.user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;
