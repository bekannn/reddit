
--- POST VOTING
CREATE OR REPLACE FUNCTION vote_post(
    p_user_id INT,
    p_post_id INT,
    p_vote_value INT  -- 1 for upvote, -1 for downvote
) RETURNS VOID
LANGUAGE plpgsql AS
$$
DECLARE
    old_vote INT;
BEGIN
    IF p_vote_value NOT IN (-1, 1) THEN
        RAISE EXCEPTION 'vote_value must be -1, or 1';
    END IF;

    -- Find previous vote if exists
    SELECT vote_value INTO old_vote
    FROM PostVotes
    WHERE user_id = p_user_id AND post_id = p_post_id;

    IF old_vote IS NULL THEN
        -- Insert new vote
        INSERT INTO PostVotes(user_id, post_id, vote_value) VALUES (p_user_id, p_post_id, p_vote_value);

    ELSE
        -- Previous vote exists
        IF p_vote_value = old_vote THEN
            -- delete vote
            DELETE FROM PostVotes WHERE user_id = p_user_id AND post_id = p_post_id;
            RETURN;
        ELSE
            -- Change vote from old_vote to p_vote_value
            UPDATE PostVotes SET vote_value = p_vote_value WHERE user_id = p_user_id AND post_id = p_post_id;

        END IF;
    END IF;
END;
$$;


--- COMMENT VOTING
CREATE OR REPLACE FUNCTION vote_comment(
    c_user_id INT,
    c_comment_id INT,
    c_vote_value INT  -- 1 for upvote, -1 for downvote
) RETURNS VOID
LANGUAGE plpgsql AS
$$
DECLARE
    old_vote INT;
BEGIN
    IF c_vote_value NOT IN (-1, 1) THEN
        RAISE EXCEPTION 'vote_value must be -1, or 1';
    END IF;

    -- Find previous vote if exists
    SELECT vote_value INTO old_vote
    FROM CommentVotes
    WHERE user_id = c_user_id AND comment_id = c_comment_id;

    IF old_vote IS NULL THEN
        -- Insert new vote
        INSERT INTO CommentVotes(user_id, comment_id, vote_value) VALUES (c_user_id, c_comment_id, c_vote_value);

    ELSE
        -- Previous vote exists
        IF c_vote_value = old_vote THEN
            -- delete vote
            DELETE FROM CommentVotes WHERE user_id = c_user_id AND comment_id = c_comment_id;
            RETURN;
        ELSE
            -- Change vote from old_vote to p_vote_value
            UPDATE CommentVotes SET vote_value = c_vote_value WHERE user_id = c_user_id AND comment_id = c_comment_id;

        END IF;
    END IF;
END;
$$;