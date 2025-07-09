
--- Inserting POST TAG
CREATE OR REPLACE FUNCTION add_post_tag(p_post_id INT, p_tag_id INT)
RETURNS VOID AS
$$
BEGIN
  INSERT INTO PostTags(post_id, tag_id)
  VALUES (p_post_id, p_tag_id);
END;
$$ LANGUAGE plpgsql;


--- Inserting POST MEDIA
CREATE OR REPLACE FUNCTION add_post_media(p_post_id INT, p_media_type VARCHAR, p_media_url VARCHAR)
RETURNS VOID AS
$$
BEGIN
  INSERT INTO PostMedia(post_id, media_type, url)
  VALUES (p_post_id, p_media_type, p_media_url);
END;
$$ LANGUAGE plpgsql;

--- get all tags for the subreddit
CREATE OR REPLACE FUNCTION get_subreddit_tags(p_subreddit_id INT)
RETURNS TABLE (
  tag_id INT,
  tag_text VARCHAR,
  tag_css_class VARCHAR,
  created_at TIMESTAMP
)
LANGUAGE SQL AS
$$
SELECT tag_id, tag_text, tag_css_class, created_at
FROM Tags
WHERE subreddit_id = p_subreddit_id
ORDER BY created_at;
$$;

--- Get RULES
CREATE OR REPLACE FUNCTION get_subreddit_rules(p_subreddit_id INT)
RETURNS TABLE (
  rules TEXT
)
LANGUAGE SQL AS
$$
SELECT rules
FROM subreddits
WHERE subreddit_id = p_subreddit_id ;
$$;

--- SEE MEDIA RESTRICTION
CREATE OR REPLACE FUNCTION get_subreddit_media_permissions(p_subreddit_id INT)
RETURNS TABLE (
  allow_image BOOLEAN,
  allow_video BOOLEAN,
  allow_url BOOLEAN
)
LANGUAGE SQL AS
$$
SELECT
  allow_image,
  allow_video,
  allow_url
FROM Subreddits
WHERE subreddit_id = p_subreddit_id;
$$;

