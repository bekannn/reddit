-- view all Repost Reasons
CREATE OR REPLACE FUNCTION get_report_reasons()
RETURNS TABLE (
  reason_id INT,
  reason_text VARCHAR
) AS $$
BEGIN
  RETURN QUERY
  SELECT rr.reason_id, rr.reason_text
  FROM ReportReasons rr
  ORDER BY rr.reason_id;
END;
$$ LANGUAGE plpgsql;

-- Report Post or Comment
CREATE OR REPLACE FUNCTION report_content(
  p_reporter_id INT,
  p_reason_id INT,
  p_is_self BOOLEAN,
  p_post_id INT DEFAULT NULL,
  p_comment_id INT DEFAULT NULL
) RETURNS VOID AS $$
DECLARE
  new_report_id INT;
BEGIN
  IF p_post_id IS NULL AND p_comment_id IS NULL THEN
    RAISE EXCEPTION 'Must report either a post or a comment.';
  END IF;

  IF p_post_id IS NOT NULL AND p_comment_id IS NOT NULL THEN
    RAISE EXCEPTION 'Cannot report both post and comment at once.';
  END IF;

  -- Insert into Reports supertype
  INSERT INTO Reports(reporter_id, reason_id, is_self)
  VALUES (p_reporter_id, p_reason_id, p_is_self)
  RETURNING report_id INTO new_report_id;

  -- Insert into subtype
  IF p_post_id IS NOT NULL THEN
    INSERT INTO PostReports(report_id, post_id) VALUES (new_report_id, p_post_id);
  ELSE
    INSERT INTO CommentReports(report_id, comment_id) VALUES (new_report_id, p_comment_id);
  END IF;
END;
$$ LANGUAGE plpgsql;

