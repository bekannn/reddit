
CREATE OR REPLACE FUNCTION update_member_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE Subreddits
    SET member_count = member_count + 1
    WHERE subreddit_id = NEW.subreddit_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE Subreddits
    SET member_count = GREATEST(member_count - 1, 0)
    WHERE subreddit_id = OLD.subreddit_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_member_count
AFTER INSERT OR DELETE ON Memberships
FOR EACH ROW
EXECUTE FUNCTION update_member_count();
