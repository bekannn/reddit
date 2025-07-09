
--- Search POST
CREATE OR REPLACE FUNCTION search_posts(keyword TEXT)
RETURNS TABLE (
  post_id INT,
  title VARCHAR,
  content TEXT,
  subreddit_name VARCHAR,
  username VARCHAR,
  created_at TIMESTAMP
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.post_id,
    p.title,
    p.content,
    s.name AS subreddit_name,
    u.username,
    p.created_at
  FROM Posts p
  JOIN Subreddits s ON p.subreddit_id = s.subreddit_id
  JOIN Users u ON p.user_id = u.user_id
  WHERE LOWER(p.title) LIKE LOWER('%' || keyword || '%')
     OR LOWER(p.content) LIKE LOWER('%' || keyword || '%')
  ORDER BY p.created_at DESC, (p.upvote_count - p.downvote_count) DESC;
END;
$$ LANGUAGE plpgsql;

--- Search SUBREDDIT
CREATE OR REPLACE FUNCTION search_subreddits(keyword TEXT)
RETURNS TABLE (
  subreddit_id INT,
  name VARCHAR,
  description TEXT,
  member_count INT,
  topics TEXT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.subreddit_id,
    s.name,
    s.description,
    s.member_count,
    COALESCE(STRING_AGG(st.name, ', '), '') AS topics
  FROM Subreddits s
  LEFT JOIN SubredditTopicLinks stl ON s.subreddit_id = stl.subreddit_id
  LEFT JOIN SubredditTopics st ON stl.topic_id = st.topic_id
  WHERE LOWER(s.name) LIKE LOWER('%' || keyword || '%')
     OR LOWER(s.description) LIKE LOWER('%' || keyword || '%')
     OR LOWER(st.name) LIKE LOWER('%' || keyword || '%')
  GROUP BY s.subreddit_id, s.name, s.description, s.member_count
  ORDER BY s.member_count DESC;
END;
$$ LANGUAGE plpgsql;

