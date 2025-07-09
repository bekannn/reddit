
-- insert A COMMENT
CREATE OR REPLACE FUNCTION insert_comment(
  p_user_id INT,
  p_post_id INT,
  p_content TEXT,
  p_parent_comment_id INT DEFAULT NULL
) RETURNS INT
LANGUAGE SQL AS
$$
  INSERT INTO Comments (user_id, post_id, parent_comment_id, content, created_at)
  VALUES (p_user_id, p_post_id, p_parent_comment_id, p_content, NOW())
  RETURNING comment_id;
$$;

-- get A COMMENT
CREATE OR REPLACE FUNCTION get_comment(p_comment_id INT)
RETURNS TABLE (
  comment_id INT,
  post_id INT,
  user_id INT,
  parent_comment_id INT,
  content TEXT,
  created_at TIMESTAMP,
  upvote_count INT,
  downvote_count INT,
  reply_count INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.comment_id,
    c.post_id,
    c.user_id,
    c.parent_comment_id,
    c.content,
    c.created_at,
    c.upvote_count,
    c.downvote_count,
    (
      SELECT COUNT(*)::INT FROM Comments r
      WHERE r.parent_comment_id = c.comment_id
    ) AS reply_count
  FROM Comments c
  WHERE c.comment_id = p_comment_id AND is_deleted != 'true';
END;
$$ LANGUAGE plpgsql;
