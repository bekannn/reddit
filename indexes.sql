CREATE INDEX idx_posts_user_id ON Posts(user_id);
CREATE INDEX idx_posts_subreddit_id ON Posts(subreddit_id);
CREATE INDEX idx_comments_post_id ON Comments(post_id);
CREATE INDEX idx_comments_user_id ON Comments(user_id);
CREATE INDEX idx_comments_parent_id ON Comments(parent_comment_id);
CREATE INDEX idx_postvotes_post_id ON PostVotes(post_id);
