--- get SUBREDDIT DETAIL
CREATE OR REPLACE FUNCTION get_subreddit_details(p_subreddit_id INT)
RETURNS TABLE (
  subreddit_id INT,
  name VARCHAR,
  description TEXT,
  visibility TEXT,
  created_by_username VARCHAR,
  member_count INT,
  rules TEXT,
  created_at TIMESTAMP
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.subreddit_id,
    s.name,
    s.description,
    s.visibility::TEXT,
    u.username,
    s.member_count,
    s.rules,
    s.created_at
  FROM Subreddits s
  JOIN Users u ON s.created_by = u.user_id
  WHERE s.subreddit_id = p_subreddit_id;
END;
$$ LANGUAGE plpgsql;
