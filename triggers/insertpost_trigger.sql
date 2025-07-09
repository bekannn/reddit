
CREATE OR REPLACE FUNCTION insert_post_media_if_needed()
RETURNS TRIGGER AS
$$
BEGIN
  IF NEW.post_type IN ('image', 'video', 'link') THEN
    -- Insert a default or placeholder media_url
    INSERT INTO PostMedia (post_id, media_type, url)
    VALUES (NEW.post_id, NEW.post_type, 'https://example.com/placeholder.jpg');
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--- haven't
CREATE TRIGGER trg_add_post_media
AFTER INSERT ON Posts
FOR EACH ROW
EXECUTE FUNCTION insert_post_media_if_needed();


