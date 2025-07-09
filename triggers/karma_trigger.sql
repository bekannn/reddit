
--- POST KARMA
CREATE OR REPLACE FUNCTION update_post_karma()
RETURNS TRIGGER AS
$$
DECLARE
  author_id INT;
BEGIN
  -- Get post author
  SELECT user_id INTO author_id FROM Posts WHERE post_id = NEW.post_id;

  IF TG_OP = 'INSERT' THEN
    UPDATE RegularUsers
    SET post_karma = post_karma + NEW.vote_value
    WHERE user_id = author_id;

  ELSIF TG_OP = 'DELETE' THEN
    UPDATE RegularUsers
    SET post_karma = post_karma - OLD.vote_value
    WHERE user_id = author_id;

  ELSIF TG_OP = 'UPDATE' THEN
    UPDATE RegularUsers
    SET post_karma = post_karma + (NEW.vote_value - OLD.vote_value)
    WHERE user_id = author_id;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_post_karma
AFTER INSERT OR DELETE OR UPDATE ON PostVotes
FOR EACH ROW
EXECUTE FUNCTION update_post_karma();


--- COMMENT KARMA
CREATE OR REPLACE FUNCTION update_comment_karma()
RETURNS TRIGGER AS
$$
DECLARE
  author_id INT;
BEGIN
  SELECT user_id INTO author_id FROM Comments WHERE comment_id = NEW.comment_id;

  IF TG_OP = 'INSERT' THEN
    UPDATE RegularUsers
    SET comment_karma = comment_karma + NEW.vote_value
    WHERE user_id = author_id;

  ELSIF TG_OP = 'DELETE' THEN
    UPDATE RegularUsers
    SET comment_karma = comment_karma - OLD.vote_value
    WHERE user_id = author_id;

  ELSIF TG_OP = 'UPDATE' THEN
    UPDATE RegularUsers
    SET comment_karma = comment_karma + (NEW.vote_value - OLD.vote_value)
    WHERE user_id = author_id;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_comment_karma
AFTER INSERT OR DELETE OR UPDATE ON CommentVotes
FOR EACH ROW
EXECUTE FUNCTION update_comment_karma();