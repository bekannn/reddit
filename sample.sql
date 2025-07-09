

-- USERS
INSERT INTO Users (username, email, password_hash, created_at) VALUES
('user1', 'user1@example.com', 'hashed_pw_1', '2023-06-25 01:13:00'),('user2', 'user2@example.com', 'hashed_pw_2', '2024-07-12 14:40:50'),('user3', 'user3@example.com', 'hashed_pw_3', '2023-02-07 14:10:26'),('user4', 'user4@example.com', 'hashed_pw_4', '2024-08-21 01:51:00'),('user5', 'user5@example.com', 'hashed_pw_5', '2024-09-06 13:33:15'),('user6', 'user6@example.com', 'hashed_pw_6', '2023-07-30 16:52:29'),('user7', 'user7@example.com', 'hashed_pw_7', '2023-12-18 14:18:00'),('user8', 'user8@example.com', 'hashed_pw_8', '2024-05-26 12:11:17'),('user9', 'user9@example.com', 'hashed_pw_9', '2024-04-17 02:00:31'),('user10', 'user10@example.com', 'hashed_pw_10', '2023-02-19 16:49:42'),('user11', 'user11@example.com', 'hashed_pw_11', '2023-02-01 07:41:05'),('user12', 'user12@example.com', 'hashed_pw_12', '2023-06-08 07:21:57'),('user13', 'user13@example.com', 'hashed_pw_13', '2024-11-09 00:23:16'),('user14', 'user14@example.com', 'hashed_pw_14', '2024-04-26 14:24:48'),('user15', 'user15@example.com', 'hashed_pw_15', '2023-05-19 14:24:30'),('user16', 'user16@example.com', 'hashed_pw_16', '2023-02-07 00:19:52'),('user17', 'user17@example.com', 'hashed_pw_17', '2024-10-19 12:44:54'),('user18', 'user18@example.com', 'hashed_pw_18', '2023-11-15 17:33:44'),('user19', 'user19@example.com', 'hashed_pw_19', '2023-10-18 00:27:56'),('user20', 'user20@example.com', 'hashed_pw_20', '2023-06-26 08:10:01'),('user21', 'user21@example.com', 'hashed_pw_21', '2024-11-23 22:29:45'),('user22', 'user22@example.com', 'hashed_pw_22', '2024-01-21 06:09:59'),('user23', 'user23@example.com', 'hashed_pw_23', '2023-08-16 14:58:13'),('user24', 'user24@example.com', 'hashed_pw_24', '2024-04-28 14:45:05'),('user25', 'user25@example.com', 'hashed_pw_25', '2024-12-18 12:49:34'),('user26', 'user26@example.com', 'hashed_pw_26', '2024-12-20 14:58:21'),('user27', 'user27@example.com', 'hashed_pw_27', '2024-09-23 02:03:42'),('user28', 'user28@example.com', 'hashed_pw_28', '2023-07-10 09:32:51'),('user29', 'user29@example.com', 'hashed_pw_29', '2023-01-25 21:23:41'),('user30', 'user30@example.com', 'hashed_pw_30', '2023-09-14 03:28:33'),('user31', 'user31@example.com', 'hashed_pw_31', '2024-09-16 17:01:20'),('user32', 'user32@example.com', 'hashed_pw_32', '2024-03-15 23:17:58'),('user33', 'user33@example.com', 'hashed_pw_33', '2023-05-20 02:41:38'),('user34', 'user34@example.com', 'hashed_pw_34', '2024-01-21 13:07:29'),('user35', 'user35@example.com', 'hashed_pw_35', '2024-07-28 21:56:53'),('user36', 'user36@example.com', 'hashed_pw_36', '2023-09-17 11:59:07'),('user37', 'user37@example.com', 'hashed_pw_37', '2023-06-22 16:44:48'),('user38', 'user38@example.com', 'hashed_pw_38', '2024-01-07 06:57:22'),('user39', 'user39@example.com', 'hashed_pw_39', '2024-02-09 14:38:57'),('user40', 'user40@example.com', 'hashed_pw_40', '2024-07-09 05:14:56'),('user41', 'user41@example.com', 'hashed_pw_41', '2023-03-24 02:02:15'),('user42', 'user42@example.com', 'hashed_pw_42', '2024-10-05 18:49:02'),('user43', 'user43@example.com', 'hashed_pw_43', '2023-01-07 11:48:15'),('user44', 'user44@example.com', 'hashed_pw_44', '2023-02-19 20:51:46'),('user45', 'user45@example.com', 'hashed_pw_45', '2023-07-31 05:56:22'),('user46', 'user46@example.com', 'hashed_pw_46', '2024-01-25 22:15:48'),('user47', 'user47@example.com', 'hashed_pw_47', '2024-12-24 06:15:05'),('user48', 'user48@example.com', 'hashed_pw_48', '2023-04-15 14:41:41'),('user49', 'user49@example.com', 'hashed_pw_49', '2024-02-27 03:40:24'),('user50', 'user50@example.com', 'hashed_pw_50', '2024-04-19 10:19:32');

-- REGULAR USERS

INSERT INTO RegularUsers (user_id, post_karma, comment_karma, profile_description, profile_image_url, status)
SELECT user_id, 0, 0,
       'Profile description for user', 'https://example.com/image.png', 'active'
FROM Users
ORDER BY user_id
LIMIT 48;


-- ADMINS

INSERT INTO Admins (user_id, last_login, permission_level)
SELECT user_id, CURRENT_TIMESTAMP, FLOOR(random() * 3 + 1)
FROM Users
ORDER BY user_id DESC
LIMIT 2;


-- SUBREDDITS
-- Insert Subreddits using regular users as creators
WITH new_subreddits AS (
  INSERT INTO subreddits (
    name, description, created_by, visibility, allow_url,
    allow_image, allow_video, created_at, rules
  )
  VALUES
    ('application', '', 42, 'public', true, true, true, '2024-07-14 05:01:23', null),
    ('Devolved', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 7, 'public', false, false, false, '2025-04-05 04:16:44', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.'),
    ('moratorium', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 2, 'private', true, false, false, '2024-11-10 09:20:07', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.'),
    ('asynchronous', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 15, 'private', true, false, true, '2024-12-07 00:51:29', null),
    ('news', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 13, 'restricted', true, true, true, '2024-12-04 05:26:37', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.'),
    ('multimedia', '', 4, 'public', true, true, false, '2024-12-30 10:09:31', null),
    ('full-range', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 39, 'private', false, false, false, '2025-02-11 08:14:22', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.'),
    ('systematic', '', 40, 'restricted', false, false, false, '2024-11-24 04:25:16', null),
    ('intermediate', '', 3, 'restricted', true, false, true, '2024-08-29 22:24:59', null),
    ('Down-sized', 'Sed vel enim sit amet nunc viverra dapibus.', 13, 'restricted', false, false, false, '2025-04-18 07:51:46', null),
    ('worldnews', '', 36, 'restricted', false, true, false, '2024-08-16 21:31:14', null),
    ('Multi-channelled', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', 8, 'restricted', false, false, false, '2024-07-26 03:30:05', null),
    ('Open-source', 'Duis ac nibh.', 6, 'restricted', false, true, true, '2024-12-05 20:30:18', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'),
    ('it', '', 18, 'public', true, false, false, '2025-07-01 10:22:18', 'In quis justo. Maecenas rhoncus aliquam lacus.'),
    ('implementation', 'Fusce consequat. Nulla nisl. Nunc nisl.', 2, 'private', true, true, false, '2024-09-28 21:49:30', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.'),
    ('Vision-oriented', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 24, 'private', true, true, false, '2025-04-22 09:19:48', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.'),
    ('upward-trending', 'In quis justo. Maecenas rhoncus aliquam lacus.', 34, 'private', false, false, false, '2024-11-08 17:24:21', null)
  RETURNING subreddit_id, created_by
)

INSERT INTO Moderators (subreddit_id, user_id)
SELECT subreddit_id, created_by
FROM new_subreddits;



-- POSTS
INSERT INTO Posts (subreddit_id, user_id, title, content, post_type, created_at, updated_at, is_deleted)
SELECT
  r.subreddit_id,
  u.user_id,
  'Sample Post',
  'Post content here',
  'text',
  CURRENT_TIMESTAMP - (FLOOR(random() * 365) || ' days')::INTERVAL,
  NULL,
  FALSE
FROM generate_series(1, 17),
LATERAL (
  SELECT subreddit_id FROM Subreddits ORDER BY random() LIMIT 1
) r,
LATERAL (
  SELECT user_id FROM Users ORDER BY random() LIMIT 1
) u;





-- COMMENTS
-- 1. Insert top-level comments (no parent_comment_id)
INSERT INTO Comments (post_id, user_id, parent_comment_id, content, created_at, updated_at, is_deleted,
                      upvote_count, downvote_count)
SELECT
  p.post_id,
  u.user_id,
  NULL,
  'Top-level comment on post ' || p.post_id,
  CURRENT_TIMESTAMP - (FLOOR(random() * 100) || ' days')::INTERVAL,
  NULL,
  FALSE,
  FLOOR(random() * 10),  -- upvotes 0–9
  FLOOR(random() * 5)    -- downvotes 0–4
FROM Posts p
JOIN (SELECT * FROM Users LIMIT 48) u ON true
WHERE random() < 0.4
LIMIT 20;


-- 2. Insert reply comments (with parent_comment_id)
INSERT INTO Comments (post_id, user_id, parent_comment_id, content, created_at, updated_at, is_deleted,
                      upvote_count, downvote_count)
SELECT
  c.post_id,
  u.user_id,
  c.comment_id,
  'Reply to comment ' || c.comment_id,
  CURRENT_TIMESTAMP - (FLOOR(random() * 50) || ' days')::INTERVAL,
  NULL,
  FALSE,
  FLOOR(random() * 5),
  FLOOR(random() * 3)
FROM Comments c
JOIN (SELECT * FROM Users LIMIT 48) u ON true
WHERE random() < 0.4
LIMIT 15;


-- POSTVOTES
INSERT INTO PostVotes (user_id, post_id, vote_value)
SELECT u.user_id, p.post_id, CASE WHEN random() > 0.5 THEN 1 ELSE -1 END
FROM Users u, Posts p
WHERE random() < 0.2
LIMIT 20;

-- COMMENTVOTES
INSERT INTO CommentVotes (user_id, comment_id, vote_value)
SELECT u.user_id, c.comment_id, CASE WHEN random() > 0.5 THEN 1 ELSE -1 END
FROM Users u, Comments c
WHERE random() < 0.2
LIMIT 20;


-- POSTMEDIA
INSERT INTO PostMedia (post_id, media_type, url)
SELECT p.post_id, 'image', 'https://example.com/media/post_media.jpg'
FROM Posts p
WHERE random() < 0.5
LIMIT 5;
INSERT INTO PostMedia (post_id, media_type, url)
SELECT p.post_id, 'video', 'https://example.com/media/post_video.mp4'
FROM Posts p
WHERE random() < 0.5
LIMIT 5;

-- TAGS
INSERT INTO Tags (subreddit_id, tag_text, tag_css_class, tag_type, created_at, created_by)
SELECT s.subreddit_id, 'Tag sample', 'css-class', 'post', CURRENT_TIMESTAMP, u.user_id
FROM Subreddits s, Users u
WHERE random() < 0.3
LIMIT 3;

-- POSTTAGS
INSERT INTO PostTags (post_id, tag_id)
SELECT p.post_id, t.tag_id
FROM Posts p, Tags t
WHERE random() < 0.3
LIMIT 5;

-- MODERATORS
INSERT INTO Moderators (subreddit_id, user_id, assigned_at)
SELECT s.subreddit_id, u.user_id, CURRENT_TIMESTAMP
FROM Subreddits s, Users u
WHERE random() < 0.2
LIMIT 3;

-- REPORTREASONS
INSERT INTO ReportReasons (reason_text) VALUES
('Spam'), ('Abuse'), ('Off-topic');

-- REPORTS
INSERT INTO Reports (reporter_id, reason_id, is_self, created_at, status)
SELECT u.user_id, r.reason_id, FALSE, CURRENT_TIMESTAMP, 'pending'
FROM Users u, ReportReasons r
WHERE random() < 0.2
LIMIT 5;

-- POSTREPORTS
INSERT INTO PostReports (report_id, post_id)
SELECT rep.report_id, p.post_id
FROM Reports rep, Posts p
WHERE random() < 0.3
LIMIT 2;

-- COMMENTREPORTS
INSERT INTO CommentReports (report_id, comment_id)
SELECT rep.report_id, c.comment_id
FROM Reports rep, Comments c
WHERE random() < 0.3
LIMIT 3;

-- CHATS
INSERT INTO Chats (chat_name, is_group, is_community, linked_subreddit_id, created_by, created_at)
SELECT 'Chat sample', TRUE, FALSE, s.subreddit_id, u.user_id, CURRENT_TIMESTAMP
FROM Subreddits s, Users u
WHERE random() < 0.3
LIMIT 3;

-- CHATPARTICIPANTS
INSERT INTO ChatParticipants (chat_id, user_id, joined_at, is_admin, is_muted)
SELECT ch.chat_id, u.user_id, CURRENT_TIMESTAMP, FALSE, FALSE
FROM Chats ch, Users u
WHERE random() < 0.3
LIMIT 10;

-- MESSAGES
INSERT INTO Messages (chat_id, sender_id, content, has_media, created_at, is_deleted)
SELECT ch.chat_id, u.user_id, 'Message content', FALSE, CURRENT_TIMESTAMP, FALSE
FROM Chats ch, Users u
WHERE random() < 0.3
LIMIT 8;

-- MESSAGEMEDIA
INSERT INTO MessageMedia (message_id, media_type, url, uploaded_at)
SELECT m.message_id, 'image', 'https://example.com/media/message_media.jpg', CURRENT_TIMESTAMP
FROM Messages m
WHERE random() < 0.3
LIMIT 2;


-- SUBREDDITTOPICS
INSERT INTO SubredditTopics (name, description, created_at, created_by)
SELECT
  'Topic sample ' || i,
  'Description of topic ' || i,
  CURRENT_TIMESTAMP,
  a.user_id
FROM (
  SELECT user_id, ROW_NUMBER() OVER () AS i
  FROM Admins
  WHERE random() < 0.5
  LIMIT 3
) a;



-- SUBREDDITTOPICLINKS
INSERT INTO SubredditTopicLinks (subreddit_id, topic_id)
SELECT s.subreddit_id, t.topic_id
FROM Subreddits s, SubredditTopics t
WHERE random() < 0.3
LIMIT 3;
