-- user_table
CREATE TABLE user_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE, -- 이메일 중복 방지
    nick VARCHAR(20),
    pw VARCHAR(255),
    status TINYINT
);

-- badge_table
CREATE TABLE badge_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_idx BIGINT,
    type VARCHAR(20),
    grade TINYINT,
    date DATETIME
--     ,FOREIGN KEY (user_idx) REFERENCES user_table(idx) -- 외래 키 제약 조건
);

-- plan_table
CREATE TABLE plan_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_idx BIGINT,
    area_code TINYINT,
    title VARCHAR(30),
    start_date DATE,
    end_date DATE,
    status TINYINT
--     ,FOREIGN KEY (user_idx) REFERENCES user_table(idx)
);

-- date_table
CREATE TABLE date_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_idx BIGINT,
    date DATE,
    memo VARCHAR(500)
--     ,FOREIGN KEY (plan_idx) REFERENCES plan_table(idx)
);

-- place_table
CREATE TABLE place_table (
    date_idx BIGINT,
    visit_order TINYINT,
    content_id VARCHAR(20),
    content_type_id TINYINT,
    title VARCHAR(50),
    thumnail VARCHAR(100),
    map_x DOUBLE,
    map_y DOUBLE,
    time TIME,
    primary key (date_idx, visit_order)
);

-- place_like_table
CREATE TABLE place_like_table (
    content_id VARCHAR(20),
    user_idx BIGINT,
    area_code TINYINT,
    content_type_id VARCHAR(20),
    title VARCHAR(50),
    thumnail VARCHAR(100),
    selected_datetime DATETIME,
    unselected_datetime DATETIME,
--     FOREIGN KEY (user_idx) REFERENCES user_table(idx),
    PRIMARY KEY (content_id, user_idx)
);

-- place_recommend_table
CREATE TABLE place_recommend_table (
    contentid VARCHAR(20) PRIMARY KEY,
    area_code TINYINT,
    status TINYINT
);

-- journal_table
CREATE TABLE journal_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_idx BIGINT,
    title VARCHAR(50),
    subtitle VARCHAR(500),
    hit BIGINT,
    reg_date datetime,
    status TINYINT
--     ,FOREIGN KEY (plan_idx) REFERENCES plan_table(idx)
);

-- journal_like_table
create table journal_like_table (
	idx bigint primary key auto_increment,
	journal_idx bigint,
	user_idx bigint,
	status tinyint
-- 	,foreign key (journal_idx) references journal_table(idx),
-- 	foreign key (user_idx) references user_table(idx)
);

-- review_table
CREATE TABLE review_table (
    idx BIGINT auto_increment,
    content_id VARCHAR(20),
    user_idx BIGINT,
    place_idx BIGINT,
    rate TINYINT,
    review VARCHAR(500),
    reg_date DATETIME,
    status TINYINT,
    primary key (idx, content_id)
-- 	,foreign key (user_idx) references user_table(idx),
-- 	foreign key (place_idx) references place_table(idx)
);

-- image_table
CREATE TABLE image_table (
    idx BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_idx BIGINT,
    place_idx BIGINT,
    type varchar(10),
    upload_date DATETIME,
    file_path VARCHAR(255)
--     ,foreign key (plan_idx) references journal_table(plan_idx),
--     foreign key (place_idx) references review_table(place_idx)
);

-- journal_best_table
create table journal_best_table (
	idx bigint primary key auto_increment,
	journal_idx bigint,
	tier tinyint,
	act_date datetime,
	deact_date datetime,
	status tinyint
-- 	,foreign key (journal_idx) references journal_table(idx)
);

-- notice_table
create table notice_table (
	idx bigint primary key auto_increment,
	title varchar(100),
	content text,
	reg_date datetime,
	update_date datetime,
	hit mediumint,
	status tinyint
);

-- support_table
create table support_table (
	idx bigint primary key auto_increment,
	user_idx bigint,
	title varchar(100),
	content varchar(5000),
	reg_date datetime,
	type varchar(20),
	status tinyint
);

-- event_image_table
create table event_image_table (
	idx bigint primary key auto_increment,
	upload_date datetime,
	file_path varchar(255)
);

-- faq_table
create table faq_table (
	idx bigint primary key auto_increment,
	title varchar(250),
	content text,
	reg_date datetime,
	status tinyint
);