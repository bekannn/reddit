
-- HOME page
CREATE OR REPLACE FUNCTION get_home_feed(p_user_id INT)
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    created_at TIMESTAMP,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    username VARCHAR,
    subreddit_name VARCHAR,
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
    p.upvote_count,
    p.downvote_count,
    p.comment_count,
    u.username,
    s.name AS subreddit_name,
    pm.media_type,
    pm.url AS media_url
FROM posts p
JOIN users u ON p.user_id = u.user_id
JOIN subreddits s ON p.subreddit_id = s.subreddit_id
JOIN memberships m ON m.subreddit_id = s.subreddit_id AND m.user_id = p_user_id
LEFT JOIN postmedia pm ON pm.post_id = p.post_id
WHERE p.is_deleted = FALSE
ORDER BY p.created_at DESC, (p.upvote_count - p.downvote_count) DESC
LIMIT 10;
$$;

DROP FUNCTION get_popular_feed();
--- POPULAR page
CREATE OR REPLACE FUNCTION get_popular_feed()
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    post_type post_type,
    created_at TIMESTAMP,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    username VARCHAR,
    subreddit_name VARCHAR,
    media_type VARCHAR,
    media_url VARCHAR,
    score INT
)
LANGUAGE SQL AS
$$
SELECT
    p.post_id,
    p.title,
    p.content,
    p.post_type,
    p.created_at,
    p.upvote_count,
    p.downvote_count,
    p.comment_count,
    u.username,
    s.name AS subreddit_name,
    pm.media_type,
    pm.url AS media_url,
    (p.upvote_count - p.downvote_count) AS score
FROM posts p
JOIN users u ON p.user_id = u.user_id
JOIN subreddits s ON p.subreddit_id = s.subreddit_id
LEFT JOIN postmedia pm ON pm.post_id = p.post_id
WHERE p.is_deleted = FALSE AND s.visibility != 'private'
ORDER BY score DESC, p.comment_count DESC
LIMIT 30;
$$;


--- WATCH feed
CREATE OR REPLACE FUNCTION get_watch_feed()
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    post_type post_type,
    created_at TIMESTAMP,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    subreddit_name VARCHAR,
    media_url TEXT
)
LANGUAGE SQL AS
$$
SELECT
    p.post_id,
    p.title,
    p.content,
    p.post_type,
    p.created_at,
    p.upvote_count,
    p.downvote_count,
    p.comment_count,
    s.name AS subreddit_name,
    m.url AS media_url
FROM posts p
JOIN postmedia m ON p.post_id = m.post_id
JOIN subreddits s ON p.subreddit_id = s.subreddit_id
WHERE m.media_type = 'video'
  AND p.is_deleted = FALSE
  AND s.visibility != 'private'
ORDER BY (p.upvote_count - p.downvote_count) DESC, p.comment_count DESC
LIMIT 30;
$$;

--- NEWS page
CREATE OR REPLACE FUNCTION get_news_feed()
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    post_type post_type,
    created_at TIMESTAMP,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    username VARCHAR,
    subreddit_name VARCHAR,
    media_type VARCHAR,
    media_url VARCHAR
)
LANGUAGE SQL AS
$$
SELECT
    p.post_id,
    p.title,
    p.content,
    p.post_type,
    p.created_at,
    p.upvote_count,
    p.downvote_count,
    p.comment_count,
    u.username,
    s.name AS subreddit_name,
    pm.media_type,
    pm.url AS media_url
FROM posts p
JOIN users u ON p.user_id = u.user_id
JOIN subreddits s ON p.subreddit_id = s.subreddit_id
LEFT JOIN postmedia pm ON pm.post_id = p.post_id
WHERE p.is_deleted = FALSE
  AND s.visibility != 'private'
  AND s.name IN ('news', 'worldnews', 'politics', 'economics')
ORDER BY (p.upvote_count - p.downvote_count) DESC, p.comment_count DESC
LIMIT 20;
$$;

--- LATEST page
CREATE OR REPLACE FUNCTION get_latest_posts(p_user_id INT)
RETURNS TABLE (
    post_id INT,
    title VARCHAR,
    content TEXT,
    post_type post_type,
    created_at TIMESTAMP,
    upvote_count INT,
    downvote_count INT,
    comment_count INT,
    username VARCHAR,
    subreddit_name VARCHAR,
    media_type VARCHAR,
    media_url VARCHAR
)
LANGUAGE SQL AS
$$
SELECT
    p.post_id,
    p.title,
    p.content,
    p.post_type,
    p.created_at,
    p.upvote_count,
    p.downvote_count,
    p.comment_count,
    u.username,
    s.name AS subreddit_name,
    pm.media_type,
    pm.url AS media_url
FROM posts p
JOIN subreddits s ON p.subreddit_id = s.subreddit_id
JOIN users u ON p.user_id = u.user_id
JOIN memberships m ON m.subreddit_id = s.subreddit_id
LEFT JOIN postmedia pm ON pm.post_id = p.post_id
WHERE m.user_id = p_user_id
  AND p.is_deleted = FALSE
ORDER BY p.created_at DESC
LIMIT 20;
$$;
