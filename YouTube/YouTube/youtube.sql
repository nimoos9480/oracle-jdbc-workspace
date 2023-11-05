truncate table video cascade;
truncate table channel cascade;

select * from member;

DROP TABLE VIDEO_LIKE;
DROP TABLE COMMENT_LIKE;
DROP TABLE VIDEO_COMMENT;
DROP TABLE SUBSCRIBE;
DROP TABLE VIDEO;
DROP TABLE CHANNEL;
DROP TABLE CATEGORY;
DROP TABLE MEMBER;
DROP SEQUENCE SEQ_CATEGORY;
DROP SEQUENCE SEQ_CHANNEL;
DROP SEQUENCE SEQ_COMMENT_LIKE;
DROP SEQUENCE SEQ_SUBSCRIBE;
DROP SEQUENCE SEQ_VIDEO;
DROP SEQUENCE SEQ_VIDEO_COMMENT;
DROP SEQUENCE SEQ_VIDEO_LIKE;

CREATE TABLE VIDEO(
    VIDEO_CODE NUMBER,
    VIDEO_TITLE VARCHAR2(100) NOT NULL,
    VIDEO_DESC VARCHAR2(200),
    VIDEO_DATE DATE DEFAULT SYSDATE,
    VIDEO_VIEWS NUMBER DEFAULT 0,
    VIDEO_URL VARCHAR2(300) NOT NULL,
    VIDEO_PHOTO VARCHAR2(300) NOT NULL,
    CATEGORY_CODE NUMBER,
    CHANNEL_CODE NUMBER,
    ID VARCHAR2(200)
);
CREATE TABLE CHANNEL(
    CHANNEL_CODE NUMBER,
    CHANNEL_NAME VARCHAR2(100) NOT NULL,
    CHANNEL_DESC VARCHAR2(200),
    CHANNEL_DATE DATE DEFAULT SYSDATE,
    CHANNEL_PHOTO VARCHAR2(300),
    ID VARCHAR2(200)
);
CREATE TABLE MEMBER(
    ID VARCHAR2(200),
    PASSWORD VARCHAR2(200) NOT NULL,
    NAME VARCHAR2(200) NOT NULL,
    AUTHORITY VARCHAR2(200) DEFAULT 'ROLE_USER'
);
CREATE TABLE VIDEO_LIKE(
    V_LIKE_CODE NUMBER,
    V_LIKE_DATE DATE DEFAULT SYSDATE,
    VIDEO_CODE NUMBER,
    ID VARCHAR2(200)
);
CREATE TABLE VIDEO_COMMENT(
    COMMENT_CODE NUMBER,
    COMMENT_DESC VARCHAR2(300) NOT NULL,
    COMMENT_DATE DATE DEFAULT SYSDATE,
    COMMENT_PARENT NUMBER,
    VIDEO_CODE NUMBER,
    ID VARCHAR2(200)
);
CREATE TABLE SUBSCRIBE(
    SUBS_CODE NUMBER,
    SUBS_DATE DATE DEFAULT SYSDATE,
    ID VARCHAR2(200),
    CHANNEL_CODE NUMBER
);
CREATE TABLE COMMENT_LIKE(
    COMM_LIKE_CODE NUMBER,
    COMM_LIKE_DATE DATE DEFAULT SYSDATE,
    COMMENT_CODE NUMBER,
    ID VARCHAR2(200)
);
CREATE TABLE CATEGORY(
    CATEGORY_CODE NUMBER,
    CATEGORY_NAME VARCHAR2(50)
);
ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_CODE_PK PRIMARY KEY(CATEGORY_CODE);
ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_CODE_PK PRIMARY KEY(CHANNEL_CODE);
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_CODE_PK PRIMARY KEY(COMM_LIKE_CODE);
ALTER TABLE MEMBER ADD CONSTRAINT ID_PK PRIMARY KEY(ID);
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBS_CODE_PK PRIMARY KEY(SUBS_CODE);
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CODE_PK PRIMARY KEY(VIDEO_CODE);
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_CODE_PK PRIMARY KEY(COMMENT_CODE);
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT V_LIKE_CODE_PK PRIMARY KEY(V_LIKE_CODE);
ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_COMMENT_CODE_FK FOREIGN KEY(COMMENT_CODE) REFERENCES VIDEO_COMMENT;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_CHANNEL_CODE_FK FOREIGN KEY(CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CATEGORY_CODE_FK FOREIGN KEY(CATEGORY_CODE) REFERENCES CATEGORY;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CHANNEL_CODE_FK FOREIGN KEY(CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_VIDEO_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_VIDEO_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
CREATE SEQUENCE SEQ_CATEGORY;
CREATE SEQUENCE SEQ_CHANNEL;
CREATE SEQUENCE SEQ_COMMENT_LIKE;
CREATE SEQUENCE SEQ_SUBSCRIBE;
CREATE SEQUENCE SEQ_VIDEO;
CREATE SEQUENCE SEQ_VIDEO_COMMENT;
CREATE SEQUENCE SEQ_VIDEO_LIKE;
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '쇼핑');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '음악');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '영화');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '게임');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '스포츠');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '학습');

COMMIT;
SELECT * FROM CATEGORY;

-- 테스트와 관련된 쿼리문들!
-- 회원가입(register)
INSERT INTO MEMBER(ID, MEMBER_PASSWORD, MEMBER_NICKNAME) VALUES('user1', '1234', 'user');
COMMIT;
SELECT * FROM MEMBER;
-- 로그인(login)
SELECT * FROM MEMBER WHERE ID='user1' AND MEMBER_PASSWORD='1234';
-- 채널 추가(addChannel)
INSERT INTO CHANNEL(CHANNEL_CODE, CHANNEL_NAME, CHANNEL_PHOTO, ID) VALUES(SEQ_CHANNEL.NEXTVAL, 'Blue rain', 'PHOTO01', 'user1');
COMMIT;
SELECT * FROM CHANNEL;
-- 채널 수정(updateChannel)
UPDATE CHANNEL SET CHANNEL_NAME='주황색 ORANGE MUSIC' WHERE CHANNEL_CODE=1;
-- 채널 삭제(deleteChannel)
DELETE FROM CHANNEL WHERE CHANNEL_CODE=1;
-- 내 채널 보기(myChannel)
SELECT CHANNEL_CODE, CHANNEL_NAME, MEMBER_NICKNAME
FROM CHANNEL JOIN MEMBER USING(ID)
WHERE ID='user1';
COMMIT;
SELECT * FROM CHANNEL;
-- 비디오 추가
INSERT INTO VIDEO(VIDEO_CODE, VIDEO_TITLE, VIDEO_URL, VIDEO_PHOTO, CATEGORY_CODE, CHANNEL_CODE, ID)
VALUES(SEQ_VIDEO.NEXTVAL, '250만원 받던 직장 그만두고 귀어해서 하루 500만원 버는 39살', 'URL01', 'PHOTO01', 1, 1, 'user1');
COMMIT;
SELECT * FROM VIDEO;
-- 카테고리 보기(categoryList)
SELECT * FROM CATEGORY;
-- 2023-07-08 ~ 여기부터 진행! ---------------------------------------------------------------------------------------------------------------------------
-- 비디오 전체 목록보기(videoAllList) : 비디오 코드(VIDEO_CODE), 비디오 썸네일(VIDEO_PHOTO), 비디오 제목(VIDEO_TITLE), 채널 프로필 사진(CHANNEL_PHOTO), 채널 제목(CHANNEL_NAME), 조회수(VIDEO_VIEWS), 비디오 업데이트 날짜(VIDEO_DATE)
SELECT VIDEO_CODE, VIDEO_PHOTO, VIDEO_TITLE, CHANNEL_PHOTO, CHANNEL_NAME, VIDEO_VIEWS, VIDEO_DATE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE);
-- 채널별 목록보기(channelVideoList) - 내 채널에 있는 비디오 목록 보기
SELECT VIDEO_CODE, VIDEO_PHOTO, VIDEO_TITLE, CHANNEL_PHOTO, CHANNEL_NAME, VIDEO_VIEWS, VIDEO_DATE, CHANNEL_CODE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE) WHERE CHANNEL_CODE=1;
-- 비디오 수정(updateVideo)
UPDATE VIDEO SET VIDEO_TITLE='강남에서 만화카페로 매출 8천 찍고 2호점까지 차린 60대 부부' WHERE VIDEO_CODE=1;
COMMIT;
SELECT * FROM VIDEO;
-- 비디오 삭제(deleteVideo)
DELETE FROM VIDEO WHERE VIDEO_CODE=1;
COMMIT;
-- 비디오 1개 보기(viewVideo) : VIDEO_CODE / VIDEO_TITLE / VIDEO_DATE / VIDEO_VIEWS / VIDEO_URL / CHANNEL_NAME / CHANNEL_PHOTO / CHANNEL_CODE
SELECT VIDEO_CODE, VIDEO_TITLE, VIDEO_DATE, VIDEO_VIEWS, VIDEO_URL, CHANNEL_NAME, CHANNEL_PHOTO, CHANNEL_CODE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE) WHERE VIDEO_CODE=3;
-- 댓글 추가 (addComment)
SELECT * FROM VIDEO;
INSERT INTO VIDEO_COMMENT(COMMENT_CODE, COMMENT_DESC, VIDEO_CODE, ID) VALUES(SEQ_VIDEO_COMMENT.NEXTVAL, '좋아요~~', 3, 'user1');
COMMIT;
SELECT * FROM VIDEO_COMMENT;
-- 비디오 1개 보기에 따른 댓글들 보기 (videoCommentList)
SELECT COMMENT_CODE, MEMBER_NICKNAME, COMMENT_DESC FROM VIDEO_COMMENT JOIN MEMBER USING(ID) WHERE VIDEO_CODE=3;

--> 좋아요 포함하려고 해서 변경!
SELECT C.COMM_LIKE_CODE, V.COMMENT_CODE, V.COMMENT_DESC, M.MEMBER_NICKNAME FROM COMMENT_LIKE C
JOIN VIDEO_COMMENT V ON (C.COMMENT_CODE = V.COMMENT_CODE)
JOIN MEMBER M ON (V.ID = V.ID) WHERE V.VIDEO_CODE=3;

-- 댓글 수정 (updateComment)
UPDATE VIDEO_COMMENT SET COMMENT_DESC='싫진 않아요' WHERE COMMENT_CODE=1;
COMMIT;
SELECT * FROM VIDEO_COMMENT;

-- 댓글 삭제 (deleteComment)
DELETE FROM VIDEO_COMMENT WHERE COMMENT_CODE=1;
COMMIT;
SELECT * FROM VIDEO_COMMENT;

-- 댓글 좋아요 추가 (addCommentLike)
INSERT INTO COMMENT_LIKE(COMM_LIKE_CODE, COMMENT_CODE, ID) VALUES(SEQ_COMMENT_LIKE.NEXTVAL, 3, 'user1');
COMMIT;
SELECT * FROM COMMENT_LIKE JOIN VIDEO_COMMENT USING(COMMENT_CODE);

-- 댓글 좋아요 취소 (deleteCommentLike)
DELETE FROM COMMENT_LIKE WHERE COMM_LIKE_CODE=1;
COMMIT;
SELECT * FROM COMMENT_LIKE;
-- 좋아요 추가 (addLike)
INSERT INTO VIDEO_LIKE(V_LIKE_CODE, VIDEO_CODE, ID) VALUES(SEQ_VIDEO_LIKE.NEXTVAL, 3, 'user1');
COMMIT;
SELECT * FROM VIDEO_LIKE;
-- 좋아요 취소 (deleteLike)
DELETE FROM VIDEO_LIKE WHERE VIDEO_CODE=3 AND ID='user1';
COMMIT;
SELECT * FROM VIDEO_LIKE;
-- 구독 추가(addSubscribe)
INSERT INTO SUBSCRIBE(SUBS_CODE, CHANNEL_CODE, ID) VALUES(SEQ_SUBSCRIBE.NEXTVAL, 1, 'user1');
COMMIT;
SELECT * FROM SUBSCRIBE;
-- 내가 구독한 채널 목록 보기(mySubscribeList)
SELECT C.CHANNEL_CODE, C.CHANNEL_NAME, C.CHANNEL_PHOTO
FROM SUBSCRIBE S
JOIN CHANNEL C ON(S.CHANNEL_CODE = C.CHANNEL_CODE)
WHERE S.ID='user1';
-- 구독 취소(deleteSubscribe)
DELETE FROM SUBSCRIBE WHERE CHANNEL_CODE=1 AND ID='user1';
COMMIT;
SELECT * FROM SUBSCRIBE;
SELECT CHANNEL_CODE, CHANNEL_NAME, MEMBER_NICKNAME
FROM CHANNEL JOIN MEMBER USING(ID)
WHERE ID='user1';