
CREATE OR REPLACE FUNCTION update_comment_count()
RETURNS TRIGGER AS
$$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE Posts
    SET comment_count = comment_count + 1
    WHERE post_id = NEW.post_id;

  ELSIF TG_OP = 'DELETE' THEN
    UPDATE Posts
    SET comment_count = comment_count - 1
    WHERE post_id = OLD.post_id;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_comment_count_update
AFTER INSERT OR DELETE ON Comments
FOR EACH ROW
EXECUTE FUNCTION update_comment_count();
