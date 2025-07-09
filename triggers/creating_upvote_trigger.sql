--- (POST) automatically increment upvote for user's own post
CREATE OR REPLACE FUNCTION auto_upvote_post()
RETURNS TRIGGER AS
$$
BEGIN
  INSERT INTO PostVotes(user_id, post_id, vote_value)
  VALUES (NEW.user_id, NEW.post_id, 1);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_auto_upvote_post
AFTER INSERT ON Posts
FOR EACH ROW
EXECUTE FUNCTION auto_upvote_post();


--- (COMMENT) automatically increment upvote for user's own comment
CREATE OR REPLACE FUNCTION auto_upvote_comment()
RETURNS TRIGGER AS
$$
BEGIN
  INSERT INTO CommentVotes(user_id, comment_id, vote_value)
  VALUES (NEW.user_id, NEW.comment_id, 1);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_auto_upvote_comment
AFTER INSERT ON Comments
FOR EACH ROW
EXECUTE FUNCTION auto_upvote_comment();


SELECT tgname, tgrelid::regclass, tgtype, tgfoid::regprocedure
FROM pg_trigger
WHERE NOT tgisinternal;

