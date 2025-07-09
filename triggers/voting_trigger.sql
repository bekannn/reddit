
--- POST VOTE_COUNTS Trigger
CREATE OR REPLACE FUNCTION update_post_vote_counts()
RETURNS TRIGGER AS
$$
BEGIN
  -- Handle INSERT
  IF TG_OP = 'INSERT' THEN
    IF NEW.vote_value = 1 THEN
      UPDATE Posts SET upvote_count = upvote_count + 1 WHERE post_id = NEW.post_id;
    ELSE
      UPDATE Posts SET downvote_count = downvote_count + 1 WHERE post_id = NEW.post_id;
    END IF;

  -- Handle DELETE
  ELSIF TG_OP = 'DELETE' THEN
    IF OLD.vote_value = 1 THEN
      UPDATE Posts SET upvote_count = upvote_count - 1 WHERE post_id = OLD.post_id;
    ELSE
      UPDATE Posts SET downvote_count = downvote_count - 1 WHERE post_id = OLD.post_id;
    END IF;

  -- Handle UPDATE (change vote direction)
  ELSIF TG_OP = 'UPDATE' THEN
    IF OLD.vote_value = NEW.vote_value THEN
      RETURN NULL;
    END IF;

    IF OLD.vote_value = 1 THEN
      UPDATE Posts SET upvote_count = upvote_count - 1 WHERE post_id = OLD.post_id;
    ELSE
      UPDATE Posts SET downvote_count = downvote_count - 1 WHERE post_id = OLD.post_id;
    END IF;

    IF NEW.vote_value = 1 THEN
      UPDATE Posts SET upvote_count = upvote_count + 1 WHERE post_id = NEW.post_id;
    ELSE
      UPDATE Posts SET downvote_count = downvote_count + 1 WHERE post_id = NEW.post_id;
    END IF;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_post_vote_update
AFTER INSERT OR DELETE OR UPDATE ON PostVotes
FOR EACH ROW
EXECUTE FUNCTION update_post_vote_counts();




--- COMMENT VOTE_COUNTS Trigger
CREATE OR REPLACE FUNCTION update_comment_vote_counts()
RETURNS TRIGGER AS
$$
BEGIN
  -- Handle INSERT
  IF TG_OP = 'INSERT' THEN
    IF NEW.vote_value = 1 THEN
      UPDATE Comments SET upvote_count = upvote_count + 1 WHERE comment_id = NEW.comment_id;
    ELSE
      UPDATE Comments SET downvote_count = downvote_count + 1 WHERE comment_id = NEW.comment_id;
    END IF;

  -- Handle DELETE
  ELSIF TG_OP = 'DELETE' THEN
    IF OLD.vote_value = 1 THEN
      UPDATE Comments SET upvote_count = upvote_count - 1 WHERE comment_id = OLD.comment_id;
    ELSE
      UPDATE Comments SET downvote_count = downvote_count - 1 WHERE comment_id = OLD.comment_id;
    END IF;

  -- Handle UPDATE (change vote direction)
  ELSIF TG_OP = 'UPDATE' THEN
    IF OLD.vote_value = NEW.vote_value THEN
      RETURN NULL;
    END IF;

    IF OLD.vote_value = 1 THEN
      UPDATE Comments SET upvote_count = upvote_count - 1 WHERE comment_id = OLD.comment_id;
    ELSE
      UPDATE Comments SET downvote_count = downvote_count - 1 WHERE comment_id = OLD.comment_id;
    END IF;

    IF NEW.vote_value = 1 THEN
      UPDATE Comments SET upvote_count = upvote_count + 1 WHERE comment_id = NEW.comment_id;
    ELSE
      UPDATE Comments SET downvote_count = downvote_count + 1 WHERE comment_id = NEW.comment_id;
    END IF;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_comment_vote_update
AFTER INSERT OR DELETE OR UPDATE ON CommentVotes
FOR EACH ROW
EXECUTE FUNCTION update_comment_vote_counts();






