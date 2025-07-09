CREATE OR REPLACE FUNCTION get_post_details(p_post_id INT)
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    created_at TIMESTAMP,
    author_username VARCHAR,
    subreddit_name VARCHAR,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    media_type VARCHAR,
    media_url VARCHAR
)
LANGUAGE SQL AS
$$
SELECT
  p.post_id,
  p.title,
  p.content,
  p.created_at,
  u.username AS author_username,
  s.name AS subreddit_name,
  p.upvote_count,
  p.downvote_count,
  p.comment_count,
  CASE WHEN p.post_type != 'text' THEN pm.media_type ELSE NULL END,
  CASE WHEN p.post_type != 'text' THEN pm.url ELSE NULL END
FROM Posts p
JOIN Users u ON p.user_id = u.user_id
JOIN Subreddits s ON p.subreddit_id = s.subreddit_id
LEFT JOIN PostMedia pm ON p.post_id = pm.post_id
WHERE p.post_id = p_post_id;
$$;
