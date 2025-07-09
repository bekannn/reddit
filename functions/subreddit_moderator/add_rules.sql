
CREATE OR REPLACE FUNCTION update_subreddit_rules(
  p_subreddit_id INT,
  p_user_id INT,
  p_rules TEXT
)
RETURNS VOID AS $$
BEGIN
  -- Check if user is the owner
  IF EXISTS (
    SELECT 1 FROM Subreddits
    WHERE subreddit_id = p_subreddit_id AND created_by = p_user_id
  ) THEN
    UPDATE Subreddits
    SET rules = p_rules
    WHERE subreddit_id = p_subreddit_id;
  ELSE
    RAISE EXCEPTION 'Only the subreddit owner can update rules';
  END IF;
END;
$$ LANGUAGE plpgsql;
