drop table users;
drop table feeds;
drop table tags;
drop table tags_in_feed;
DROP TABLE FEED_DRAWINGS;
drop table bookmark_folder;
drop table drawing_rooms;
drop table followings;
drop table join_list;
drop table page_layer;

create table USERS (  
    USER_ID varchar2(50) primary key,  
    NICKNAME varchar2(50) not null,  
    SIGN_IN_DATE date default sysdate,  
    PROFILE_PHOTO varchar2(1000) not null,  
    EMAIL varchar2(500) NOT NULL,  
    FAMILY_NAME varchar2(100),    
    GIVEN_NAME varchar2(100),
    PIXELS number default 0,
    ACCUMULATEDPIXELS number default 0,
    INTRODUCTION varchar2(4000)
);
alter table USERS add constraint users_nickname_uq unique (NICKNAME);
alter table USERS add constraint users_profile_photo_uq unique (PROFILE_PHOTO);
alter table USERS add constraint users_email_uq unique (EMAIL);

-- ?? ???
CREATE TABLE FEEDS(
	FEED_ID VARCHAR2(200) PRIMARY KEY 
	,USER_ID1 VARCHAR2(50) NOT NULL
	,USER_ID2 VARCHAR2(50)
	,USER_ID3 VARCHAR2(50)
	,USER_ID4 VARCHAR2(50)
	,CONTEXT VARCHAR2(4000) NOT NULL
	,INPUTDATE DATE DEFAULT SYSDATE
);
ALTER TABLE FEEDS ADD CONSTRAINT FEEDS_USER_ID1_FK FOREIGN KEY(USER_ID1) REFERENCES USERS(USER_ID) ON DELETE CASCADE;
ALTER TABLE FEEDS ADD CONSTRAINT FEEDS_USER_ID2_FK FOREIGN KEY(USER_ID2) REFERENCES USERS(USER_ID);
ALTER TABLE FEEDS ADD CONSTRAINT FEEDS_USER_ID3_FK FOREIGN KEY(USER_ID3) REFERENCES USERS(USER_ID);
ALTER TABLE FEEDS ADD CONSTRAINT FEEDS_USER_ID4_FK FOREIGN KEY(USER_ID4) REFERENCES USERS(USER_ID);

CREATE TABLE FEED_DRAWINGS(
	DRAWING_ID NUMBER PRIMARY KEY
	,FEED_ID VARCHAR2(200) NOT NULL
	,PAGE_FILE VARCHAR2(200) NOT NULL
);
ALTER TABLE FEED_DRAWINGS ADD CONSTRAINT FEED_DRAWINGS_FEED_ID FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID);
CREATE SEQUENCE DRAWING_ID_SEQ;

CREATE TABLE TAGS(
    TAG_NAME VARCHAR2(100) PRIMARY KEY
);

-- ??? ?? ???
CREATE TABLE TAGS_IN_FEED(
    TIF_ID NUMBER PRIMARY KEY
    ,FEED_ID VARCHAR2(200) NOT NULL
    ,TAG_NAME VARCHAR2(100) NOT NULL
);
ALTER TABLE TAGS_IN_FEED ADD CONSTRAINT TAGS_IN_FEED_FEED_ID_FK FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID) ON DELETE CASCADE;
ALTER TABLE TAGS_IN_FEED ADD CONSTRAINT TAGS_IN_FEED_TAG_NAME_FK FOREIGN KEY(TAG_NAME) REFERENCES TAGS(TAG_NAME);
CREATE SEQUENCE TIF_ID_SEQ;

CREATE TABLE DRAWING_ROOMS(
    ROOM_ID VARCHAR2(200) PRIMARY KEY
    ,ADMIN VARCHAR2(50) NOT NULL
    ,TITLE VARCHAR2(200) NOT NULL
    ,PASSWORD VARCHAR2(20)
    ,USER_NO NUMBER NOT NULL
);
ALTER TABLE DRAWING_ROOMS ADD CONSTRAINT DRAWING_ROOMS_ADMIN_FK FOREIGN KEY(ADMIN) REFERENCES USERS(USER_ID);

CREATE TABLE JOIN_LIST(
    JOINlIST_ID NUMBER PRIMARY KEY
    ,USER_ID VARCHAR2(50)
    ,ROOM_ID VARCHAR2(200)
    ,USER_TYPE VARCHAR2(20)
);
ALTER TABLE JOIN_LIST ADD CONSTRAINT JOIN_LIST_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);
ALTER TABLE JOIN_LIST ADD CONSTRAINT JOIN_LIST_ROOM_ID_FK FOREIGN KEY(ROOM_ID) REFERENCES DRAWING_ROOMS(ROOM_ID);
CREATE SEQUENCE JOINLIST_SEQ;

CREATE TABLE PAGE_LAYER(
    ROOM_ID VARCHAR2(200) NOT NULL
    ,PAGE_NO NUMBER(4)
    ,LAYER_NO NUMBER(4)
    ,STRINGIFY CLOB
    ,CONSTRAINT PL_ID PRIMARY KEY(ROOM_ID, PAGE_NO, LAYER_NO)
);
ALTER TABLE PAGE_LAYER ADD CONSTRAINT PAGE_LAYER_ROOM_ID_FK fOREIGN KEY(ROOM_ID) REFERENCES DRAWING_ROOMS(ROOM_ID);

CREATE TABLE BOOKMARK_FOLDER(
    FOLDER_ID NUMBER PRIMARY KEY
    ,USER_ID VARCHAR2(50)
    ,FOLDER_NAME VARCHAR2(50) UNIQUE
);
ALTER TABLE BOOKMARK_FOLDER ADD CONSTRAINT BOOKMARK_FOLDER_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);
CREATE SEQUENCE FOLDER_ID_SEQ;

CREATE TABLE FOLLOWINGS(
    F_ID NUMBER PRIMARY KEY
    ,USER_ID VARCHAR2(50) NOT NULL
    ,FOLLOWING_ID VARCHAR2(50) NOT NULL
);
ALTER TABLE FOLLOWINGS ADD CONSTRAINT FOLLOWINGS_USR_ID_FK FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID);
ALTER TABLE FOLLOWINGS ADD CONSTRAINT FOLLOWINGS_FOLLOWING_ID_FK FOREIGN KEY (FOLLOWING_ID) REFERENCES USERS(USER_ID);
CREATE SEQUENCE F_ID_SEQ;

CREATE TABLE TRANSACTION_PIXEL (
	TRANSACTION_ID NUMBER PRIMARY KEY
	,SENDER	VARCHAR2(50) NOT NULL
	,RECEIVER VARCHAR2(50) NOT NULL
	,PIXELS_AMOUNT NUMBER NOT NULL
	,TRANSACTION_DATE DATE DEFAULT SYSDATE
);
ALTER TABLE TRANSACTION_PIXEL ADD CONSTRAINT TRANSACTION_PIXEL_SENDER_FK FOREIGN KEY (SENDER) REFERENCES USERS(USER_ID);
ALTER TABLE TRANSACTION_PIXEL ADD CONSTRAINT TRANSACTION_PIXEL_RECEIVER_FK FOREIGN KEY (RECEIVER) REFERENCES USERS(USER_ID);
CREATE SEQUENCE TRANSPX_SEQ;

CREATE TABLE FEED_COMMENT(
    COMMENT_ID NUMBER PRIMARY KEY
    ,USER_ID VARCHAR2(50) NOT NULL
    ,FEED_ID VARCHAR2(200) NOT NULL
    ,FEED_COMMENT VARCHAR2(4000) NOT NULL
    ,INPUTDATE DATE DEFAULT SYSDATE
);
ALTER TABLE FEED_COMMENT ADD CONSTRAINT FEED_COMMENT_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);
ALTER TABLE FEED_COMMENT ADD CONSTRAINT FEED_COMMENT_FEED_ID_FK FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID);
CREATE SEQUENCE COMMENT_SEQ;

CREATE TABLE LIKE_TABLE(
    LIKE_ID NUMBER PRIMARY KEY
    ,FEED_ID VARCHAR2(200) NOT NULL
    ,USER_ID VARCHAR2(50) NOT NULL
    ,INPUTDATE DATE DEFAULT SYSDATE
);
ALTER TABLE LIKE_TABLE ADD CONSTRAINT LIKE_TABLE_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);
ALTER TABLE LIKE_TABLE ADD CONSTRAINT LIKE_TABLE_FEED_ID_FK FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID);
CREATE SEQUENCE LIKE_SEQ;

CREATE TABLE BOOKMARKED_FEEDS(
    BKFS_ID NUMBER NOT NULL
    ,FOLDER_ID NUMBER NOT NULL
    ,FEED_ID VARCHAR2(200) NOT NULL
    ,BOOKMARK_INDATE DATE DEFAULT SYSDATE
);
ALTER TABLE BOOKMARKED_FEEDS ADD CONSTRAINT BOOKMARKED_FEEDS_FEED_ID_FK FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID);
ALTER TABLE BOOKMARKED_FEEDS ADD CONSTRAINT BOOKMARKED_FEEDS_FOLDER_ID_FK FOREIGN KEY(FOLDER_ID) REFERENCES BOOKMARK_FOLDER(FOLDER_ID);
ALTER TABLE BOOKMARKED_FEEDS ADD CONSTRAINT BOOKMARKED_FEEDS_PK PRIMARY KEY(FOLDER_ID, FEED_ID);
CREATE SEQUENCE BKFS_ID_SEQ;

-- 스플릿 함수
CREATE OR REPLACE FUNCTION FUNC_SPLIT(COLNAME VARCHAR, SEP VARCHAR, NUM NUMBER)
	RETURN VARCHAR
IS
	STR VARCHAR2(512);
BEGIN
	IF NUM > 0 THEN
		IF INSTR(COLNAME, SEP, 1, NUM+1) < 1 THEN
			IF INSTR(COLNAME, SEP, 1, NUM) > 0 THEN
				SELECT SUBSTR(COLNAME, INSTR(COLNAME, SEP, 1, NUM) + LENGTH(SEP), LENGTH(COLNAME)) INTO STR FROM DUAL;
			END IF;
		END IF;
		IF INSTR(COLNAME, SEP, 1, NUM+1) > 0 THEN
		SELECT SUBSTR(COLNAME, INSTR(COLNAME, SEP, 1, NUM) + LENGTH(SEP), (INSTR(COLNAME, SEP, 1, NUM+1) - INSTR(COLNAME, SEP, 1, NUM) - LENGTH(SEP))) INTO STR FROM DUAL;
		END IF;
	END IF;
	IF NUM = 0 THEN
		SELECT SUBSTR(COLNAME, 0, INSTR(COLNAME, SEP, 1, 1) - 1) INTO STR FROM DUAL;
	END IF;
RETURN STR;
END func_split;

-- HISTORY TABLE
CREATE TABLE HISTORIES(
    HISTORY_ID NUMBER NOT NULL
    ,USER_ID VARCHAR2(50) NOT NULL
    ,FEED_ID VARCHAR2(200) NOT NULL
    ,HISTORY_INDATE DATE DEFAULT SYSDATE
);
ALTER TABLE HISTORIES ADD CONSTRAINT HISTORIES_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);
ALTER TABLE HISTORIES ADD CONSTRAINT HISTORIES_FEED_ID_FK FOREIGN KEY(FEED_ID) REFERENCES FEEDS(FEED_ID);
ALTER TABLE HISTORIES ADD CONSTRAINT HISTORIES_PK PRIMARY KEY(USER_ID, FEED_ID);
CREATE SEQUENCE HISTORY_ID_SEQ;
    