-- view post reports
CREATE OR REPLACE FUNCTION view_post_reports(p_user_id INT)
RETURNS TABLE (
  report_id INT,
  reporter_id INT,
  reason_text VARCHAR,
  is_self BOOLEAN,
  created_at TIMESTAMP,
  status report_status_enum,
  post_id INT
) AS $$
DECLARE
  is_admin BOOLEAN;
BEGIN
  SELECT EXISTS (SELECT 1 FROM Admins WHERE user_id = p_user_id) INTO is_admin;

  IF NOT is_admin THEN
    RAISE EXCEPTION 'Access denied: user % is not an admin', p_user_id;
  END IF;

  RETURN QUERY
  SELECT
    r.report_id,
    r.reporter_id,
    rr.reason_text,
    r.is_self,
    r.created_at,
    r.status,
    pr.post_id
  FROM Reports r
  JOIN ReportReasons rr ON r.reason_id = rr.reason_id
  JOIN PostReports pr ON r.report_id = pr.report_id
  ORDER BY r.created_at DESC;
END;
$$ LANGUAGE plpgsql;


-- view Comment Reports
CREATE OR REPLACE FUNCTION view_comment_reports(p_user_id INT)
RETURNS TABLE (
  report_id INT,
  reporter_id INT,
  reason_text VARCHAR,
  is_self BOOLEAN,
  created_at TIMESTAMP,
  status report_status_enum,
  comment_id INT
) AS $$
DECLARE
  is_admin BOOLEAN;
BEGIN
  SELECT EXISTS (SELECT 1 FROM Admins WHERE user_id = p_user_id) INTO is_admin;

  IF NOT is_admin THEN
    RAISE EXCEPTION 'Access denied: user % is not an admin', p_user_id;
  END IF;

  RETURN QUERY
  SELECT
    r.report_id,
    r.reporter_id,
    rr.reason_text,
    r.is_self,
    r.created_at,
    r.status,
    cr.comment_id
  FROM Reports r
  JOIN ReportReasons rr ON r.reason_id = rr.reason_id
  JOIN CommentReports cr ON r.report_id = cr.report_id
  ORDER BY r.created_at DESC;
END;
$$ LANGUAGE plpgsql;
