--- LOG IN function
SELECT login_user('m','hash123');
---- id 51
--- REGISTER function
-- SELECT register_regular_user('m', 'mmm@gmail.com', 'hash123');

--- HOME page
SELECT * FROM get_home_feed(5);

--- POPULAR page
SELECT * FROM get_popular_feed();

--- WATCH page
SELECT * FROM get_watch_feed();

--- LATEST page
SELECT * FROM get_latest_posts(5);

--- SEARCH
SELECT * FROM search_posts('non');

SELECT * FROM search_subreddits('project');

--- VIEW A POST
SELECT * FROM get_post_details(1);

--- COMMENT THREAD
SELECT * FROM get_post_comments(1);

--- COMMENTING
SELECT insert_comment(1,1,'commmmmment', 17);


------- POSTING
SELECT * FROM get_subreddit_details(10);

SELECT * FROM get_subreddit_tags(10);

SELECT get_subreddit_rules(10);

--- POSTING (return post_id)
SELECT create_post(5, 2, 'my post', 'i like my post', 'text');
SELECT * FROM get_post_details(51);

--- for subreddit owners
SELECT update_subreddit_rules(10, 13, 'No spam. Be respectful.');

--- POST VOTING
SELECT vote_post(5, 51, -1);
--- COMMENT VOTING
SELECT vote_comment(5, 20, -1);

SELECT * FROM get_comment(20);

-- SELECT add_moderator(10, 13, 22);


SELECT * FROM get_report_reasons();
SELECT report_content(5, 3, true, 51, null);

SELECT * FROM view_post_reports(50);
SELECT * FROM view_comment_reports(49);


SELECT restrict_user(50,23,'Repeated rule violations');

SELECT * FROM view_restricted_users(49);

-- SELECT remove_restriction(50, 2);

SELECT create_announcement(5,'hello', 'yeah');


---
SELECT tgname, tgrelid::regclass, tgtype, tgfoid::regprocedure
FROM pg_trigger
WHERE NOT tgisinternal;

SELECT * FROM Posts WHERE post_type != 'text';

