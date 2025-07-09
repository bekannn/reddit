CREATE OR REPLACE FUNCTION create_post(
  p_user_id INT,
  p_subreddit_id INT,
  p_title VARCHAR,
  p_content TEXT,
  p_post_type post_type,
  p_tag_id INT DEFAULT NULL,
  p_media_type VARCHAR DEFAULT NULL,
  p_media_url VARCHAR DEFAULT NULL
) RETURNS INT AS
$$
DECLARE
  new_post_id INT;
  flair_required BOOLEAN;
BEGIN
  -- Check if subreddit exists and get flair rule
  SELECT require_flair
  INTO flair_required
  FROM Subreddits
  WHERE subreddit_id = p_subreddit_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Subreddit % does not exist', p_subreddit_id;
  END IF;

  -- Check if tag is required
  IF flair_required AND p_tag_id IS NULL THEN
    RAISE EXCEPTION 'This subreddit requires a post tag (flair)';
  END IF;

  -- Insert into Posts table
  INSERT INTO Posts (
    subreddit_id, user_id, title, content, post_type, created_at
  ) VALUES (
    p_subreddit_id, p_user_id, p_title, p_content, p_post_type, NOW()
  )
  RETURNING post_id INTO new_post_id;

  -- Call helper functions
  IF p_tag_id IS NOT NULL THEN
    PERFORM add_post_tag(new_post_id, p_tag_id);
  END IF;

  IF p_media_url IS NOT NULL AND p_media_type IS NOT NULL THEN
    PERFORM add_post_media(new_post_id, p_media_type, p_media_url);
  END IF;

  RETURN new_post_id;
END;
$$ LANGUAGE plpgsql;
