-- 1. SUPER TYPE Users table
DROP TABLE IF EXISTS Users CASCADE;
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()

);

-- 2. RegularUsers Table
CREATE TYPE user_status AS ENUM ('active', 'banned', 'suspended');
DROP TABLE IF EXISTS RegularUsers CASCADE;
CREATE TABLE RegularUsers (
  user_id INT PRIMARY KEY REFERENCES Users(user_id) ON DELETE CASCADE,
  post_karma INT DEFAULT 0,
  comment_karma INT DEFAULT 0,
  profile_description TEXT,
  profile_image_url VARCHAR,
  status user_status DEFAULT 'active'
);

-- 3. Admin Table
DROP TABLE IF EXISTS Admins CASCADE;
CREATE TABLE Admins (
  user_id INT PRIMARY KEY REFERENCES Users(user_id) ON DELETE CASCADE,
  last_login TIMESTAMP,
  permission_level INT
);


-- 4. Posts Table
CREATE TYPE post_type AS ENUM ('text', 'image', 'video', 'link');
DROP TABLE IF EXISTS Posts CASCADE;
CREATE TABLE Posts (
  post_id SERIAL PRIMARY KEY,
  subreddit_id INT REFERENCES Subreddits(subreddit_id) ON DELETE CASCADE,
  user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  post_type post_type,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  is_deleted BOOLEAN DEFAULT FALSE,
  upvote_count INT DEFAULT 0,
  downvote_count INT DEFAULT 0,
  comment_count INT DEFAULT 0
);

-- 5. Subreddit Table
CREATE TYPE subreddit_visibility AS ENUM ('public', 'restricted', 'private');
DROP TABLE IF EXISTS Subreddits CASCADE;
CREATE TABLE Subreddits (
  subreddit_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT NOT NULL,
  created_by INT REFERENCES Users(user_id) ON DELETE CASCADE,
  visibility subreddit_visibility,
  allow_url BOOLEAN DEFAULT TRUE,
  allow_image BOOLEAN DEFAULT TRUE,
  allow_video BOOLEAN DEFAULT TRUE,
  require_flair BOOLEAN DEFAULT FALSE,
  require_karma BOOLEAN DEFAULT FALSE,
  karma_threshold INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  member_count INT DEFAULT 0,
  rules TEXT
);

-- 6. Comments Table
DROP TABLE IF EXISTS Comments CASCADE;
CREATE TABLE Comments (
  comment_id SERIAL PRIMARY KEY,
  post_id INT REFERENCES Posts(post_id) ON DELETE CASCADE,
  user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
  parent_comment_id INT REFERENCES Comments(comment_id),
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  is_deleted BOOLEAN DEFAULT FALSE,
  upvote_count INT DEFAULT 0,
  downvote_count INT DEFAULT 0
);


-- 7. PostVotes
DROP TABLE IF EXISTS PostVotes CASCADE;
CREATE TABLE PostVotes (
  user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
  post_id INT REFERENCES Posts(post_id) ON DELETE CASCADE,
  vote_value INT CHECK (vote_value IN (-1, 1)),
  PRIMARY KEY (user_id, post_id)
);

-- 8. CommentVotes
DROP TABLE IF EXISTS CommentVotes CASCADE;
CREATE TABLE CommentVotes (
  user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
  comment_id INT REFERENCES Comments(comment_id) ON DELETE CASCADE,
  vote_value INT CHECK (vote_value IN (-1, 1)),
  PRIMARY KEY (user_id, comment_id)
);


-- 9. Membership
DROP TABLE IF EXISTS Memberships CASCADE;
CREATE TABLE Memberships (
    subreddit_id INT REFERENCES Subreddits(subreddit_id) ON DELETE CASCADE,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    joined_at DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (subreddit_id, user_id)
);

-- 10. PostMedia
DROP TABLE IF EXISTS PostMedia CASCADE;
CREATE TABLE PostMedia (
    media_id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Posts(post_id) ON DELETE CASCADE,
    media_type VARCHAR NOT NULL,
    url VARCHAR NOT NULL
);

-- 11. Tags (for post in each subreddit)
DROP TABLE IF EXISTS Tags CASCADE;
CREATE TYPE tag_type_enum AS ENUM ('post', 'user');
CREATE TABLE Tags (
    tag_id SERIAL PRIMARY KEY,
    subreddit_id INT REFERENCES Subreddits(subreddit_id) ON DELETE CASCADE,
    tag_text VARCHAR NOT NULL,
    tag_css_class VARCHAR,
    tag_type tag_type_enum,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES Users(user_id)
);

-- 12. PostTags
DROP TABLE IF EXISTS PostTags CASCADE;
CREATE TABLE PostTags (
    post_id INT REFERENCES Posts(post_id) ON DELETE CASCADE,
    tag_id INT REFERENCES Tags(tag_id),
    PRIMARY KEY (post_id, tag_id)
);

-- 13. Moderators
DROP TABLE IF EXISTS Moderators CASCADE;
CREATE TABLE Moderators (
    subreddit_id INT REFERENCES Subreddits(subreddit_id),
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (subreddit_id, user_id)
);

-- 14. Report Reasons Tag
DROP TABLE IF EXISTS ReportReasons CASCADE;
CREATE TABLE ReportReasons (
  reason_id SERIAL PRIMARY KEY,
  reason_text VARCHAR NOT NULL
);

-- Report Status Enum
CREATE TYPE report_status_enum AS ENUM ('pending', 'resolved', 'rejected');

-- 15. Reports Supertype
DROP TABLE IF EXISTS Reports CASCADE;
CREATE TABLE Reports (
  report_id SERIAL PRIMARY KEY,
  reporter_id INT REFERENCES Users(user_id),
  reason_id INT REFERENCES ReportReasons(reason_id),
  is_self BOOLEAN,
  created_at TIMESTAMP DEFAULT NOW(),
  status report_status_enum DEFAULT 'pending'
);

-- 16. Subtype: PostReports
DROP TABLE IF EXISTS PostReports CASCADE;
CREATE TABLE PostReports (
  report_id INT PRIMARY KEY REFERENCES Reports(report_id) ON DELETE CASCADE,
  post_id INT REFERENCES Posts(post_id) NOT NULL
);

-- 17. Subtype: CommentReports
DROP TABLE IF EXISTS CommentReports CASCADE;

CREATE TABLE CommentReports (
  report_id INT PRIMARY KEY REFERENCES Reports(report_id) ON DELETE CASCADE,
  comment_id INT REFERENCES Comments(comment_id) NOT NULL
);


-- 18. Chat
DROP TABLE IF EXISTS Chats CASCADE;
CREATE TABLE Chats (
    chat_id SERIAL PRIMARY KEY,
    chat_name VARCHAR,
    is_group BOOLEAN DEFAULT FALSE,
    is_community BOOLEAN DEFAULT FALSE,
    linked_subreddit_id INT REFERENCES Subreddits(subreddit_id),
    created_by INT REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 19. Chat Participants
DROP TABLE IF EXISTS ChatParticipants CASCADE;
CREATE TABLE ChatParticipants (
    chat_id INT REFERENCES Chats(chat_id) ON DELETE CASCADE,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_admin BOOLEAN DEFAULT FALSE,
    is_muted BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (chat_id, user_id)
);

-- 20. Messages
DROP TABLE IF EXISTS Messages CASCADE;
CREATE TABLE Messages (
    message_id SERIAL PRIMARY KEY,
    chat_id INT NOT NULL REFERENCES Chats(chat_id) ON DELETE CASCADE,
    sender_id INT NOT NULL REFERENCES Users(user_id),
    content TEXT NOT NULL,
    has_media BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);


-- 21. Message Media
DROP TABLE IF EXISTS MessageMedia CASCADE;
CREATE TABLE MessageMedia (
    media_id SERIAL PRIMARY KEY,
    message_id INT REFERENCES Messages(message_id),
    media_type VARCHAR,
    url VARCHAR NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 22. Subreddit Topics
DROP TABLE IF EXISTS SubredditTopics CASCADE;
CREATE TABLE SubredditTopics (
    topic_id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES Admins(user_id)
);

-- 23. Subreddit Topic Link
DROP TABLE IF EXISTS SubredditTopicLinks CASCADE;
CREATE TABLE SubredditTopicLinks (
    subreddit_id INT REFERENCES Subreddits(subreddit_id) ON DELETE CASCADE,
    topic_id INT REFERENCES SubredditTopics(topic_id) ON DELETE CASCADE,
    PRIMARY KEY (subreddit_id, topic_id)
);


