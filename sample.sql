

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
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('vestibulum ante ipsum primis in faucibus orci luctus et ultrices', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', 27, 'video', '2025-04-26 07:16:20', 2);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('nec sem duis aliquam convallis nunc proin at turpis a', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', 29, 'link', '2025-03-23 09:35:08', 10);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 23, 'text', '2025-06-28 10:38:40', 13);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 2, 'image', '2025-01-22 10:36:16', 5);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 21, 'text', '2025-03-03 20:49:04', 12);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 9, 'link', '2025-03-18 08:49:58', 13);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 31, 'image', '2025-06-13 10:11:31', 3);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 19, 'image', '2025-06-29 08:29:13', 16);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('ante nulla justo aliquam quis turpis eget elit sodales scelerisque', 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 25, 'image', '2025-07-01 16:43:16', 5);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 45, 'link', '2025-06-06 03:22:06', 2);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 48, 'video', '2025-06-10 13:59:22', 17);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', 'Aenean auctor gravida sem.', 4, 'video', '2025-06-04 16:18:20', 12);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 10, 'text', '2025-01-17 22:45:02', 12);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('a libero nam dui proin leo odio porttitor id consequat in', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 34, 'image', '2025-05-08 02:31:05', 1);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('est congue elementum in hac habitasse platea dictumst morbi vestibulum', 'Nullam molestie nibh in lectus.', 17, 'link', '2025-02-14 07:23:34', 7);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 6, 'text', '2025-01-13 03:43:15', 16);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 34, 'link', '2025-06-25 09:59:05', 17);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.', 34, 'text', '2025-01-22 04:11:24', 14);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('ultrices libero non mattis pulvinar nulla pede ullamcorper augue a', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 26, 'link', '2025-05-31 19:00:13', 1);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 22, 'link', '2025-03-09 00:14:05', 3);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue', 'Pellentesque eget nunc.', 27, 'link', '2025-04-14 05:54:02', 16);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', 32, 'text', '2025-02-17 03:32:31', 7);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', 34, 'text', '2025-02-08 20:56:55', 6);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 6, 'link', '2025-01-24 03:06:11', 4);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', 19, 'link', '2025-04-09 16:10:03', 16);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', 'Vivamus tortor. Duis mattis egestas metus.', 19, 'video', '2025-04-20 12:22:40', 9);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 2, 'link', '2025-06-04 15:37:28', 8);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', 33, 'video', '2025-04-24 19:10:00', 15);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.', 43, 'link', '2025-06-12 03:58:43', 10);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 12, 'video', '2025-02-19 06:18:59', 12);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum', 'Morbi a ipsum.', 45, 'image', '2025-05-12 11:40:23', 15);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin', 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 6, 'text', '2025-01-18 07:11:11', 1);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', 'Aenean sit amet justo. Morbi ut odio.', 29, 'text', '2025-03-22 13:25:16', 15);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 5, 'link', '2025-05-20 22:14:45', 1);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.', 6, 'image', '2025-01-22 08:03:37', 6);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in', 'Mauris sit amet eros.', 9, 'text', '2025-01-18 15:51:39', 17);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('magna at nunc commodo placerat praesent blandit nam nulla integer', 'In sagittis dui vel nisl.', 38, 'text', '2025-03-27 12:06:07', 17);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 44, 'link', '2025-07-02 06:51:11', 7);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('turpis enim blandit mi in porttitor pede justo eu massa donec', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 37, 'text', '2025-04-11 12:31:19', 10);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan', 'Quisque ut erat.', 5, 'image', '2025-02-01 06:34:19', 6);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('non sodales sed tincidunt eu felis fusce posuere felis sed lacus', 'Ut tellus. Nulla ut erat id mauris vulputate elementum.', 46, 'video', '2025-02-20 17:14:27', 6);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.', 20, 'image', '2025-02-08 21:18:59', 11);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('sit amet sem fusce consequat nulla nisl nunc nisl duis', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 11, 'text', '2025-01-10 11:05:46', 16);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 38, 'text', '2025-04-28 22:18:31', 7);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque', 'Quisque ut erat. Curabitur gravida nisi at nibh.', 29, 'text', '2025-04-01 23:53:42', 12);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('sed tristique in tempus sit amet sem fusce consequat nulla', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 22, 'link', '2025-04-01 10:52:35', 14);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 41, 'image', '2025-03-11 08:59:59', 2);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('volutpat erat quisque erat eros viverra eget congue eget semper', 'Sed ante.', 16, 'image', '2025-05-10 06:15:20', 15);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor', 'Suspendisse potenti.', 10, 'video', '2025-05-01 09:28:59', 5);
insert into Posts (title, content, user_id, post_type, created_at, subreddit_id) values ('neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio', 'Nulla mollis molestie lorem. Quisque ut erat.', 11, 'text', '2025-01-31 05:47:51', 14);


SELECT tgname, tgrelid::regclass, tgtype, tgfoid::regprocedure
FROM pg_trigger
WHERE tgrelid = 'Posts'::regclass AND NOT tgisinternal;


-- COMMENTS
-- 1. Insert top-level comments (no parent_comment_id)
DELETE FROM Comments;
INSERT INTO Comments (post_id, user_id, parent_comment_id, content, created_at, updated_at, is_deleted)

SELECT
  p.post_id,
  u.user_id,
  NULL,
  'Top-level comment on post ' || p.post_id,
  CURRENT_TIMESTAMP - (FLOOR(random() * 100) || ' days')::INTERVAL,
  NULL,
  FALSE
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
WHERE p.post_type = 'image'
  AND NOT EXISTS (
    SELECT 1 FROM PostMedia pm
    WHERE pm.post_id = p.post_id AND pm.media_type = 'image'
  );
INSERT INTO PostMedia (post_id, media_type, url)
SELECT p.post_id, 'video', 'https://example.com/media/post_video.mp4'
FROM Posts p
WHERE p.post_type = 'video'
  AND NOT EXISTS (
    SELECT 1 FROM PostMedia pm
    WHERE pm.post_id = p.post_id AND pm.media_type = 'video'
  );
INSERT INTO PostMedia (post_id, media_type, url)
SELECT p.post_id, 'link', 'https://example.com/linkkkkkkk'
FROM Posts p
WHERE p.post_type = 'link'
  AND NOT EXISTS (
    SELECT 1 FROM PostMedia pm
    WHERE pm.post_id = p.post_id AND pm.media_type = 'link'
  );


-- TAGS
---DELETE FROM tags;
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (17, 'molestie', 'Turquoise', 'user', 15);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (16, 'amet', 'Green', 'post', 40);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (9, 'sapien', 'Green', 'user', 13);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (11, 'viverra', 'Turquoise', 'user', 42);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (13, 'donec', 'Purple', 'post', 40);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (1, 'nunc', 'Yellow', 'post', 7);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (3, 'odio', 'Violet', 'post', 6);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (9, 'etiam', 'Orange', 'post', 8);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (7, 'nunc', 'Yellow', 'post', 24);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (9, 'neque', 'Pink', 'user', 13);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (4, 'mauris', 'Goldenrod', 'user', 13);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (14, 'dapibus', 'Teal', 'user', 34);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (1, 'ipsum', 'Teal', 'user', 42);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (15, 'urna', 'Purple', 'user', 7);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (2, 'faucibus', 'Yellow', 'user', 3);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (10, 'phasellus', 'Turquoise', 'user', 36);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (1, 'at', 'Pink', 'post', 42);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (9, 'rutrum', 'Maroon', 'post', 8);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (16, 'luctus', 'Turquoise', 'user', 2);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (3, 'vestibulum', 'Teal', 'post', 2);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (8, 'dolor', 'Aquamarine', 'user', 2);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (3, 'orci', 'Mauv', 'user', 6);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (1, 'enim', 'Blue', 'post', 3);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (12, 'in', 'Yellow', 'user', 42);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (12, 'dictumst', 'Aquamarine', 'user', 3);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (16, 'consequat', 'Yellow', 'user', 39);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (9, 'accumsan', 'Turquoise', 'post', 3);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (6, 'orci', 'Red', 'user', 40);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (8, 'est', 'Green', 'user', 13);
insert into tags (subreddit_id, tag_text, tag_css_class, tag_type, created_by) values (13, 'lectus', 'Mauv', 'user', 13);


-- POSTTAGS
DELETE FROM Posttags;
INSERT INTO PostTags (post_id, tag_id)
SELECT p.post_id, t.tag_id
FROM Posts p, Tags t
WHERE random() < 0.3
LIMIT 5;


-- REPORTREASONS
INSERT INTO ReportReasons (reason_text) VALUES
('Spam'), ('Abuse'), ('Off-topic');

-- REPORTS
insert into Reports (reporter_id, reason_id, is_self, created_at) values (2, 2, false, '2025-04-14 04:12:07');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (25, 1, false, '2025-02-26 17:58:51');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (1, 3, true, '2025-03-16 09:43:13');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (42, 1, false, '2025-05-31 04:35:59');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (1, 2, true, '2025-02-01 15:05:24');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (25, 3, true, '2025-02-24 13:54:20');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (47, 2, true, '2024-12-21 20:08:22');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (27, 1, false, '2025-06-20 04:56:00');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (16, 1, false, '2025-03-06 15:19:47');
insert into Reports (reporter_id, reason_id, is_self, created_at) values (14, 1, true, '2025-03-06 02:42:48');

-- POSTREPORTS
insert into PostReports (report_id, post_id) values (5, 47);
insert into PostReports (report_id, post_id) values (7, 45);
insert into PostReports (report_id, post_id) values (6, 3);

-- COMMENTREPORTS
insert into CommentReports (report_id, comment_id) values (1, 19);
insert into CommentReports (report_id, comment_id) values (2, 9);
insert into CommentReports (report_id, comment_id) values (3, 18);
insert into CommentReports (report_id, comment_id) values (4, 20);
insert into CommentReports (report_id, comment_id) values (8, 7);
insert into CommentReports (report_id, comment_id) values (9, 1);
insert into CommentReports (report_id, comment_id) values (10, 14);

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
insert into SubredditTopics (name, description, created_by, created_at) values ('heuristic', 'dolor sit amet', 50, '2025-01-24 19:53:10');
insert into SubredditTopics (name, description, created_by, created_at) values ('Re-contextualized', 'nam', 49, '2024-08-12 07:19:19');
insert into SubredditTopics (name, description, created_by, created_at) values ('hierarchy', 'ut nunc vestibulum', 50, '2024-04-29 02:38:38');
insert into SubredditTopics (name, description, created_by, created_at) values ('methodology', 'vivamus', 49, '2025-02-28 13:45:21');
insert into SubredditTopics (name, description, created_by, created_at) values ('Mandatory', 'at', 50, '2024-12-16 05:57:20');
insert into SubredditTopics (name, description, created_by, created_at) values ('disintermediate', 'quisque ut erat', 50, '2025-01-08 23:07:06');
insert into SubredditTopics (name, description, created_by, created_at) values ('object-oriented', 'phasellus', 49, '2024-12-29 01:06:42');
insert into SubredditTopics (name, description, created_by, created_at) values ('utilisation', 'elementum nullam varius', 50, '2024-06-19 12:50:35');
insert into SubredditTopics (name, description, created_by, created_at) values ('encryption', 'ac consequat metus', 49, '2024-05-04 01:28:52');
insert into SubredditTopics (name, description, created_by, created_at) values ('global', 'vestibulum sit amet', 49, '2024-05-17 02:31:25');
insert into SubredditTopics (name, description, created_by, created_at) values ('scalable', 'ultrices', 50, '2025-03-01 17:40:50');
insert into SubredditTopics (name, description, created_by, created_at) values ('Multi-lateral', 'arcu', 49, '2024-12-29 11:59:17');
insert into SubredditTopics (name, description, created_by, created_at) values ('project', 'et tempus semper', 50, '2025-03-16 03:10:38');
insert into SubredditTopics (name, description, created_by, created_at) values ('flexibility', 'integer', 49, '2025-03-05 23:49:12');
insert into SubredditTopics (name, description, created_by, created_at) values ('firmware', 'porttitor', 50, '2024-08-12 13:05:46');
insert into SubredditTopics (name, description, created_by, created_at) values ('encoding', 'adipiscing elit', 50, '2024-05-16 13:02:31');
insert into SubredditTopics (name, description, created_by, created_at) values ('contingency', 'non lectus', 50, '2025-01-09 22:13:23');
insert into SubredditTopics (name, description, created_by, created_at) values ('parallelism', 'diam id ornare', 49, '2025-06-21 18:01:46');
insert into SubredditTopics (name, description, created_by, created_at) values ('Front-line', 'lectus', 49, '2024-03-09 20:03:00');
insert into SubredditTopics (name, description, created_by, created_at) values ('matrix', 'vel', 49, '2024-09-17 18:28:22');
insert into SubredditTopics (name, description, created_by, created_at) values ('Balanced', 'eget', 49, '2024-09-08 17:35:08');
insert into SubredditTopics (name, description, created_by, created_at) values ('bottom-line', 'ullamcorper', 50, '2024-08-12 08:38:18');
insert into SubredditTopics (name, description, created_by, created_at) values ('Triple-buffered', 'in felis', 50, '2025-01-16 23:49:29');
insert into SubredditTopics (name, description, created_by, created_at) values ('Horizontal', 'est', 49, '2024-09-12 06:03:34');
insert into SubredditTopics (name, description, created_by, created_at) values ('initiative', 'mollis molestie', 50, '2024-08-06 22:51:41');
insert into SubredditTopics (name, description, created_by, created_at) values ('User-friendly', 'dictumst aliquam augue', 50, '2024-12-12 08:20:53');
insert into SubredditTopics (name, description, created_by, created_at) values ('systemic', 'massa volutpat', 50, '2024-04-07 07:39:40');
insert into SubredditTopics (name, description, created_by, created_at) values ('User-centric', 'blandit', 50, '2024-07-19 20:49:21');
insert into SubredditTopics (name, description, created_by, created_at) values ('hybrid', 'ut massa', 49, '2024-11-09 03:45:14');
insert into SubredditTopics (name, description, created_by, created_at) values ('Switchable', 'egestas metus', 50, '2025-02-28 17:48:14');
insert into SubredditTopics (name, description, created_by, created_at) values ('intranet', 'ut at dolor', 49, '2024-05-20 08:32:54');
insert into SubredditTopics (name, description, created_by, created_at) values ('pop', 'natoque penatibus et', 50, '2025-07-03 02:39:40');
insert into SubredditTopics (name, description, created_by, created_at) values ('local', 'nulla ultrices', 50, '2024-12-21 07:39:38');
insert into SubredditTopics (name, description, created_by, created_at) values ('info-mediaries', 'diam neque', 49, '2025-06-12 15:44:55');
insert into SubredditTopics (name, description, created_by, created_at) values ('DATABASE', 'ut', 50, '2024-10-27 04:52:41');
insert into SubredditTopics (name, description, created_by, created_at) values ('internet solution', 'justo', 49, '2024-11-24 23:52:08');
insert into SubredditTopics (name, description, created_by, created_at) values ('Robust', 'magnis', 50, '2024-08-05 04:10:54');
insert into SubredditTopics (name, description, created_by, created_at) values ('Exclusive', 'porta volutpat quam', 49, '2025-04-10 12:48:56');
insert into SubredditTopics (name, description, created_by, created_at) values ('Cutesy', 'vitae', 49, '2025-01-16 15:59:54');
insert into SubredditTopics (name, description, created_by, created_at) values ('demureeee', 'nibh ligula nec', 49, '2024-06-22 05:04:40');





-- SUBREDDITTOPICLINKS

insert into SubredditTopicLinks (subreddit_id, topic_id) values (1, 8);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (2, 38);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (3, 31);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (4, 15);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (5, 40);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (6, 27);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (7, 16);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (8, 28);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (9, 37);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (10, 4);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (11, 14);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (12, 12);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (13, 36);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (14, 1);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (15, 13);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (16, 1);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (17, 2);


insert into SubredditTopicLinks (subreddit_id, topic_id) values (13, 27);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (2, 36);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (5, 13);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (6, 26);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (3, 2);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (6, 7);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (7, 7);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (14, 14);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (17, 11);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (13, 12);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (5, 17);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (1, 18);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (3, 33);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (16, 39);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (11, 32);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (14, 17);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (4, 1);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (9, 32);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (2, 37);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (13, 21);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (2, 25);
insert into SubredditTopicLinks (subreddit_id, topic_id) values (13, 34);


--- Membership
insert into Memberships (subreddit_id, user_id, joined_at) values (1, 12, '2025-06-02 12:58:13');
insert into Memberships (subreddit_id, user_id, joined_at) values (4, 19, '2025-06-09 17:37:07');
insert into Memberships (subreddit_id, user_id, joined_at) values (6, 48, '2025-06-10 07:16:16');
insert into Memberships (subreddit_id, user_id, joined_at) values (6, 15, '2025-06-15 00:49:56');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 9, '2025-07-02 20:49:18');
insert into Memberships (subreddit_id, user_id, joined_at) values (17, 45, '2025-06-10 08:38:39');
insert into Memberships (subreddit_id, user_id, joined_at) values (6, 35, '2025-06-03 04:01:51');
insert into Memberships (subreddit_id, user_id, joined_at) values (12, 15, '2025-06-06 17:39:12');
insert into Memberships (subreddit_id, user_id, joined_at) values (4, 8, '2025-06-15 09:27:53');
insert into Memberships (subreddit_id, user_id, joined_at) values (3, 12, '2025-06-23 09:19:05');
insert into Memberships (subreddit_id, user_id, joined_at) values (7, 6, '2025-06-16 02:34:49');
insert into Memberships (subreddit_id, user_id, joined_at) values (13, 6, '2025-05-27 02:56:48');
insert into Memberships (subreddit_id, user_id, joined_at) values (11, 10, '2025-06-13 12:26:18');
insert into Memberships (subreddit_id, user_id, joined_at) values (16, 25, '2025-06-26 09:16:46');
insert into Memberships (subreddit_id, user_id, joined_at) values (7, 31, '2025-06-21 10:00:48');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 19, '2025-07-07 07:14:23');
insert into Memberships (subreddit_id, user_id, joined_at) values (3, 28, '2025-06-17 19:22:25');
insert into Memberships (subreddit_id, user_id, joined_at) values (5, 45, '2025-06-17 17:31:42');
insert into Memberships (subreddit_id, user_id, joined_at) values (8, 37, '2025-06-05 02:30:27');
insert into Memberships (subreddit_id, user_id, joined_at) values (7, 40, '2025-06-30 11:57:28');
insert into Memberships (subreddit_id, user_id, joined_at) values (8, 29, '2025-05-28 14:22:16');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 8, '2025-06-15 09:27:48');
insert into Memberships (subreddit_id, user_id, joined_at) values (6, 31, '2025-06-29 14:22:36');
insert into Memberships (subreddit_id, user_id, joined_at) values (6, 12, '2025-06-16 12:27:44');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 23, '2025-06-22 23:40:14');
insert into Memberships (subreddit_id, user_id, joined_at) values (17, 9, '2025-05-30 06:41:36');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 25, '2025-05-27 03:48:50');
insert into Memberships (subreddit_id, user_id, joined_at) values (11, 24, '2025-06-11 13:59:32');
insert into Memberships (subreddit_id, user_id, joined_at) values (8, 19, '2025-05-27 14:57:00');
insert into Memberships (subreddit_id, user_id, joined_at) values (3, 25, '2025-06-12 04:07:03');
insert into Memberships (subreddit_id, user_id, joined_at) values (2, 31, '2025-07-04 11:36:36');
insert into Memberships (subreddit_id, user_id, joined_at) values (15, 27, '2025-07-05 18:50:37');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 16, '2025-06-19 07:20:47');
insert into Memberships (subreddit_id, user_id, joined_at) values (16, 1, '2025-06-03 09:11:49');
insert into Memberships (subreddit_id, user_id, joined_at) values (16, 45, '2025-05-29 10:01:07');
insert into Memberships (subreddit_id, user_id, joined_at) values (15, 36, '2025-06-26 17:49:27');
insert into Memberships (subreddit_id, user_id, joined_at) values (17, 2, '2025-06-11 17:39:21');
insert into Memberships (subreddit_id, user_id, joined_at) values (7, 1, '2025-06-06 13:33:24');
insert into Memberships (subreddit_id, user_id, joined_at) values (12, 29, '2025-05-27 18:24:34');
insert into Memberships (subreddit_id, user_id, joined_at) values (17, 44, '2025-06-14 08:11:52');
insert into Memberships (subreddit_id, user_id, joined_at) values (17, 15, '2025-06-16 14:47:46');
insert into Memberships (subreddit_id, user_id, joined_at) values (15, 21, '2025-06-03 23:50:15');
insert into Memberships (subreddit_id, user_id, joined_at) values (11, 1, '2025-06-22 08:32:37');
insert into Memberships (subreddit_id, user_id, joined_at) values (2, 40, '2025-06-01 22:02:54');
insert into Memberships (subreddit_id, user_id, joined_at) values (11, 4, '2025-06-08 05:47:31');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 13, '2025-07-03 20:47:28');
insert into Memberships (subreddit_id, user_id, joined_at) values (7, 19, '2025-07-07 14:32:29');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 46, '2025-05-30 08:18:21');
insert into Memberships (subreddit_id, user_id, joined_at) values (10, 5, '2025-06-08 07:18:43');
insert into Memberships (subreddit_id, user_id, joined_at) values (15, 23, '2025-06-10 22:24:19');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 3, '2025-05-28 08:06:12');
insert into Memberships (subreddit_id, user_id, joined_at) values (4, 43, '2025-05-30 00:02:41');
insert into Memberships (subreddit_id, user_id, joined_at) values (4, 41, '2025-06-01 23:58:31');
insert into Memberships (subreddit_id, user_id, joined_at) values (12, 13, '2025-06-26 19:42:21');
insert into Memberships (subreddit_id, user_id, joined_at) values (1, 42, '2025-06-21 10:15:53');
insert into Memberships (subreddit_id, user_id, joined_at) values (12, 38, '2025-07-04 10:09:09');
insert into Memberships (subreddit_id, user_id, joined_at) values (16, 6, '2025-06-24 16:04:09');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 43, '2025-05-27 03:22:17');
insert into Memberships (subreddit_id, user_id, joined_at) values (13, 20, '2025-06-20 10:00:39');
insert into Memberships (subreddit_id, user_id, joined_at) values (10, 41, '2025-06-06 01:15:16');
insert into Memberships (subreddit_id, user_id, joined_at) values (9, 5, '2025-06-25 07:20:43');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 7, '2025-07-02 17:51:12');
insert into Memberships (subreddit_id, user_id, joined_at) values (11, 47, '2025-06-29 00:01:39');
insert into Memberships (subreddit_id, user_id, joined_at) values (14, 39, '2025-06-04 22:26:28');
insert into Memberships (subreddit_id, user_id, joined_at) values (1, 13, '2025-06-05 16:40:36');
insert into Memberships (subreddit_id, user_id, joined_at) values (2, 34, '2025-06-23 09:16:08');
insert into Memberships (subreddit_id, user_id, joined_at) values (3, 31, '2025-06-06 05:36:00');
insert into Memberships (subreddit_id, user_id, joined_at) values (16, 29, '2025-06-12 15:07:42');


