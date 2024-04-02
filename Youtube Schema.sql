DROP DATABASE IF EXISTS youtube;

CREATE DATABASE youtube CHARACTER SET utf8mb4;

USE youtube;

create table users (
	user_id int unsigned auto_increment not null primary key,
    email varchar (50) not null,
    user_password varchar(15)not null,
    user_name varchar(50)not null,
    borth_date date not null,
    gender enum('male', 'female', 'not binary', 'not gender', 'undeclared gender') not null,
    country varchar(50)not null,
    potscode int not null
);

create table tags	(
	tag_id int unsigned auto_increment not null primary key,
    tag_name varchar(25) not null
);

create table video_tags	(
	video_tag_id int unsigned auto_increment not null primary key,
    tag_id int unsigned not null,
    video_id int unsigned not null,
    foreign key (tag_id) references tags(tag_id)
);
    
create table videos	(
	video_id int unsigned auto_increment not null primary key,
    title varchar(50) not null,
    video_description varchar(255) not null,
    size varchar(10) not null,
    archive_name varchar(50) not null,
    thumbnail blob not null  , 
    duration varchar(20) not null,
    creation_date timestamp,
    reproductions_number int not null,
    likes int unsigned,
    dislikes int unsigned,
    video_status enum('public', 'private','hidden'),
    video_tag_id int unsigned not null,
    user_id int unsigned not null,
    foreign key (user_id) references users(user_id),
    foreign key (video_tag_id) references video_tags(video_tag_id)
);

create table reactions_video (
	reaction_video_id int unsigned auto_increment not null,
	reaction_name enum('like', 'dislike') unique not null,
    video_id int unsigned not null,
    user_id int unsigned not null,
    date_reaction timestamp not null,
    primary key (reaction_video_id, video_id),
    foreign key (video_id) references videos(video_id)
    
);


create table channels (
	channel_id int unsigned auto_increment not null primary key,
    channel_name varchar(50)not null,
    channel_descripcion varchar(255) not null,
    creation_date date not null,
    user_id int unsigned not null,
    foreign key (user_id) references users (user_id)
);

create table channel_suscriptions (
	suscrition_channel_id int unsigned auto_increment not null primary key,
    channel_id int unsigned not null,
    user_id int unsigned not null,
    foreign key (channel_id) references channels(channel_id),
    foreign key (user_id) references users(user_id)
);

create table playlists (
	playlist_id int unsigned auto_increment not null primary key,
	playlist_name varchar(50) not null,
    creation_date date not null,
    status_id int unsigned not null,
    user_id int unsigned not null,
    foreign key (user_id) references users(user_id)
);

create table statuses_playlist	(
	status_id int unsigned auto_increment not null primary key,
    status_playlist enum('public', 'private') not null,
    playlist_id int unsigned not null,
    foreign key (status_id) references playlists(playlist_id),
    foreign key (playlist_id) references playlists(playlist_id)
);

create table playlist_videos	(
	playlist_video_id int unsigned auto_increment not null primary key,
	video_id int unsigned not null,
    playlist_id int unsigned not null,
    foreign key (video_id) references videos(video_id),
    foreign key (playlist_id) references playlists(playlist_id)
);

create table comments	(
	comment_id int unsigned auto_increment not null primary key,
    video_id int unsigned not null,
    user_id int unsigned not null,
    comment_text varchar(255),
    comment_data timestamp,
    foreign key (video_id) references videos(video_id),
    foreign key (user_id) references users(user_id)
);

create table reactions_comments	(
	reactions_comments_id int unsigned auto_increment not null primary key,
    comment_id int unsigned not null,
    reaction_type enum('like', 'dislike'),
    user_id int unsigned,
    foreign key (comment_id) references comments(comment_id),
    foreign key (user_id) references users(user_id)
);
