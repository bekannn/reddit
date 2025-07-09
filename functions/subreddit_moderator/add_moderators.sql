CREATE OR REPLACE FUNCTION add_moderator(
  p_subreddit_id INT,
  p_owner_id INT,
  p_new_mod_id INT
)
RETURNS VOID AS $$
BEGIN
  -- Check ownership
  IF NOT EXISTS (
    SELECT 1 FROM Subreddits
    WHERE subreddit_id = p_subreddit_id AND created_by = p_owner_id
  ) THEN
    RAISE EXCEPTION 'Only the subreddit owner can add moderators';
  END IF;

  -- Insert moderator if not already
  INSERT INTO Moderators (subreddit_id, user_id)
  VALUES (p_subreddit_id, p_new_mod_id)
  ON CONFLICT DO NOTHING;

  -- Ensure moderator is a member too
  INSERT INTO Memberships (subreddit_id, user_id)
  VALUES (p_subreddit_id, p_new_mod_id)
  ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;
