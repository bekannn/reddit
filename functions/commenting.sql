CREATE OR REPLACE FUNCTION insert_comment(
  p_user_id INT,
  p_post_id INT,
  p_content TEXT,
  p_parent_comment_id INT DEFAULT NULL
) RETURNS INT
LANGUAGE plpgsql AS
$$
DECLARE
  new_comment_id INT;
BEGIN
  INSERT INTO Comments (user_id, post_id, parent_comment_id, content, created_at)
  VALUES (p_user_id, p_post_id, p_parent_comment_id, p_content, NOW())
  RETURNING comment_id INTO new_comment_id;

  RETURN new_comment_id;
END;
$$;
