/* Version 1.0.1 */

/*
** Create missing tables
*/
if not exists (select 1 from sysobjects where id = object_id(N'yaf_Active') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Active(
		SessionID		nvarchar (24) NOT NULL ,
		BoardID			int NOT NULL ,
		UserID			int NOT NULL ,
		IP				nvarchar (15) NOT NULL ,
		Login			datetime NOT NULL ,
		LastActive		datetime NOT NULL ,
		Location		nvarchar (50) NOT NULL ,
		ForumID			int NULL ,
		TopicID			int NULL ,
		Browser			nvarchar (50) NULL ,
		Platform		nvarchar (50) NULL 
	)
go

if not exists (select 1 from sysobjects where id = object_id(N'yaf_BannedIP') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_BannedIP(
		ID				int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Mask			nvarchar (15) NOT NULL ,
		Since			datetime NOT NULL 
	)
go

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Category') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Category(
		CategoryID		int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL ,
		SortOrder		smallint NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_CheckEmail') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_CheckEmail(
		CheckEmailID	int IDENTITY (1, 1) NOT NULL ,
		UserID			int NOT NULL ,
		Email			nvarchar (50) NOT NULL ,
		Created			datetime NOT NULL ,
		Hash			nvarchar (32) NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Choice') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Choice(
		ChoiceID		int IDENTITY (1, 1) NOT NULL ,
		PollID			int NOT NULL ,
		Choice			nvarchar (50) NOT NULL ,
		Votes			int NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_PollVote') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	CREATE TABLE [dbo].[yaf_PollVote] (
		[PollVoteID] [int] IDENTITY (1, 1) NOT NULL ,
		[PollID] [int] NOT NULL ,
		[UserID] [int] NULL ,
		[RemoteIP] [nvarchar] (10) NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Forum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Forum(
		ForumID			int IDENTITY (1, 1) NOT NULL ,
		CategoryID		int NOT NULL ,
		ParentID		int NULL ,
		Name			nvarchar (50) NOT NULL ,
		Description		nvarchar (255) NOT NULL ,
		SortOrder		smallint NOT NULL ,
		LastPosted		datetime NULL ,
		LastTopicID		int NULL ,
		LastMessageID	int NULL ,
		LastUserID		int NULL ,
		LastUserName	nvarchar (50) NULL ,
		NumTopics		int NOT NULL,
		NumPosts		int NOT NULL,
		RemoteURL		nvarchar(100) null,
		Flags			int not null constraint DF_yaf_Forum_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_ForumAccess') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_ForumAccess(
		GroupID			int NOT NULL ,
		ForumID			int NOT NULL ,
		AccessMaskID	int NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Group') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Group(
		GroupID			int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL ,
		Flags			int not null constraint DF_yaf_Group_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Mail') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Mail(
		MailID			int IDENTITY (1, 1) NOT NULL ,
		FromUser		nvarchar (50) NOT NULL ,
		ToUser			nvarchar (50) NOT NULL ,
		Created			datetime NOT NULL ,
		Subject			nvarchar (100) NOT NULL ,
		Body			ntext NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Message') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Message(
		MessageID		int IDENTITY (1, 1) NOT NULL ,
		TopicID			int NOT NULL ,
		ReplyTo			int NULL ,
		Position		int NOT NULL ,
		Indent			int NOT NULL ,
		UserID			int NOT NULL ,
		UserName		nvarchar (50) NULL ,
		Posted			datetime NOT NULL ,
		Message			ntext NOT NULL ,
		IP				nvarchar (15) NOT NULL ,
		Edited			datetime NULL ,
		Flags			int NOT NULL constraint DF_yaf_Message_Flags default (23)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_PMessage') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_PMessage(
		PMessageID		int IDENTITY (1, 1) NOT NULL ,
		FromUserID		int NOT NULL ,
		Created			datetime NOT NULL ,
		Subject			nvarchar (100) NOT NULL ,
		Body			ntext NOT NULL,
		Flags			int NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Poll') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Poll(
		PollID			int IDENTITY (1, 1) NOT NULL ,
		Question		nvarchar (50) NOT NULL,
		Closes datetime NULL 		
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Smiley') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Smiley(
		SmileyID		int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Code			nvarchar (10) NOT NULL ,
		Icon			nvarchar (50) NOT NULL ,
		Emoticon		nvarchar (50) NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Topic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Topic(
		TopicID			int IDENTITY (1, 1) NOT NULL ,
		ForumID			int NOT NULL ,
		UserID			int NOT NULL ,
		UserName		nvarchar (50) NULL ,
		Posted			datetime NOT NULL ,
		Topic			nvarchar (100) NOT NULL ,
		Views			int NOT NULL ,
		Priority		smallint NOT NULL ,
		PollID			int NULL ,
		TopicMovedID	int NULL ,
		LastPosted		datetime NULL ,
		LastMessageID	int NULL ,
		LastUserID		int NULL ,
		LastUserName	nvarchar (50) NULL,
		NumPosts		int NOT NULL,
		Flags			int not null constraint DF_yaf_Topic_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_User') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_User(
		UserID			int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL,
		Name			nvarchar (50) NOT NULL ,
		Password		nvarchar (32) NOT NULL ,
		Email			nvarchar (50) NULL ,
		Joined			datetime NOT NULL ,
		LastVisit		datetime NOT NULL ,
		IP				nvarchar (15) NULL ,
		NumPosts		int NOT NULL ,
		Location		nvarchar (50) NULL ,
		HomePage		nvarchar (50) NULL ,
		TimeZone		int NOT NULL ,
		Avatar			nvarchar (255) NULL ,
		Signature		ntext NULL ,
		AvatarImage		image NULL,
		RankID			int NOT NULL,
		Suspended		datetime NULL,
		LanguageFile	nvarchar(50) NULL,
		ThemeFile		nvarchar(50) NULL,
		MSN				nvarchar (50) NULL ,
		YIM				nvarchar (30) NULL ,
		AIM				nvarchar (30) NULL ,
		ICQ				int NULL ,
		RealName		nvarchar (50) NULL ,
		Occupation		nvarchar (50) NULL ,
		Interests		nvarchar (100) NULL ,
		Gender			tinyint NOT NULL ,
		Weblog			nvarchar (100) NULL,
		Flags			int not null constraint DF_yaf_User_Flags default (0),
		ProviderUserKey	uniqueidentifier
)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_WatchForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_WatchForum(
		WatchForumID	int IDENTITY (1, 1) NOT NULL ,
		ForumID			int NOT NULL ,
		UserID			int NOT NULL ,
		Created			datetime NOT NULL ,
		LastMail		datetime null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_WatchTopic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_WatchTopic(
		WatchTopicID	int IDENTITY (1, 1) NOT NULL ,
		TopicID			int NOT NULL ,
		UserID			int NOT NULL ,
		Created			datetime NOT NULL ,
		LastMail		datetime null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Attachment') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Attachment(
		AttachmentID	int identity not null,
		MessageID		int not null,
		FileName		nvarchar(250) not null,
		Bytes			int not null,
		FileID			int null,
		ContentType		nvarchar(50) null,
		Downloads		int not null,
		FileData		image null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserGroup') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_UserGroup(
		UserID			int NOT NULL,
		GroupID			int NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Rank') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Rank(
		RankID			int IDENTITY (1, 1) NOT NULL,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL,
		MinPosts		int NULL,
		RankImage		nvarchar (50) NULL,
		Flags			int not null constraint DF_yaf_Rank_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_AccessMask') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_AccessMask(
		AccessMaskID	int IDENTITY NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar(50) NOT NULL ,
		Flags			int not null constraint DF_yaf_AccessMask_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_UserForum(
		UserID			int NOT NULL ,
		ForumID			int NOT NULL ,
		AccessMaskID	int NOT NULL ,
		Invited			datetime NOT NULL ,
		Accepted		bit NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Board') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_Board(
		BoardID			int NOT NULL IDENTITY(1,1),
		Name			nvarchar(50) NOT NULL,
		AllowThreaded	bit NOT NULL,
	)
end
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpServer') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpServer(
		NntpServerID	int identity not null,
		BoardID			int NOT NULL ,
		Name			nvarchar(50) not null,
		Address			nvarchar(100) not null,
		Port			int null,
		UserName		nvarchar(50) null,
		UserPass		nvarchar(50) null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpForum(
		NntpForumID		int identity not null,
		NntpServerID	int not null,
		GroupName		nvarchar(100) not null,
		ForumID			int not null,
		LastMessageNo	int not null,
		LastUpdate		datetime not null,
		Active			bit not null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpTopic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpTopic(
		NntpTopicID		int identity not null,
		NntpForumID		int not null,
		Thread			char(32) not null,
		TopicID			int not null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserPMessage') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_UserPMessage(
		UserPMessageID	int identity not null,
		UserID			int not null,
		PMessageID		int not null,
		IsRead			bit not null
	)
end
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'yaf_Replace_Words') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Replace_Words(
		id				int IDENTITY (1, 1) NOT NULL ,
		badword			nvarchar (255) NULL ,
		goodword		nvarchar (255) NULL ,
		constraint PK_Replace_Words primary key(id)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Registry') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_Registry(
		RegistryID		int IDENTITY(1, 1) NOT NULL,
		Name			nvarchar(50) NOT NULL,
		Value			nvarchar(400),
		BoardID			int,
		CONSTRAINT PK_Registry PRIMARY KEY (RegistryID)
	)
end
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_EventLog') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_EventLog(
		EventLogID	int identity(1,1) not null,
		EventTime	datetime not null constraint DF_yaf_EventLog_EventTime default getdate(),
		UserID		int,
		Source		nvarchar(50) not null,
		Description	ntext not null,
		constraint PK_yaf_EventLog primary key(EventLogID)
	)
end
GO

/*
** Added columns
*/

if exists(select 1 from dbo.syscolumns where id = object_id(N'yaf_User') and name=N'Signature' and xtype<>99)
	alter table yaf_User alter column Signature ntext null
go

if not exists(select * from syscolumns where id=object_id('yaf_Forum') and name='RemoteURL')
	alter table yaf_Forum add RemoteURL nvarchar(100) null
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_NntpForum') and name='Active')
begin
	alter table yaf_NntpForum add Active bit null
	exec('update yaf_NntpForum set Active=1 where Active is null')
	alter table yaf_NntpForum alter column Active bit not null
end
GO

if exists (select * from dbo.syscolumns where id = object_id(N'yaf_Replace_Words') and name='badword' and prec < 255)
 	alter table yaf_Replace_Words alter column badword nvarchar(255) NULL
GO

if exists (select * from dbo.syscolumns where id = object_id(N'yaf_Replace_Words') and name='goodword' and prec < 255)
	alter table yaf_Replace_Words alter column goodword nvarchar(255) NULL
GO	

if not exists(select 1 from syscolumns where id=object_id('yaf_Registry') and name='BoardID')
	alter table yaf_Registry add BoardID int
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_PMessage') and name='Flags')
begin
	alter table dbo.yaf_PMessage add Flags int not null constraint DF_yaf_Message_Flags default (23)
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Topic') and name='Flags')
begin
	alter table dbo.yaf_Topic add Flags int not null constraint DF_yaf_Topic_Flags default (0)
	update yaf_Message set Flags = Flags & 7
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Message') and name='Approved')
begin
	exec('update yaf_Message set Flags = Flags | 16 where Approved<>0')
	alter table dbo.yaf_Message drop column Approved
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Flags')
begin
	alter table dbo.yaf_Forum add Flags int not null constraint DF_yaf_Forum_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Locked')
begin
	exec('update yaf_Forum set Flags = Flags | 1 where Locked<>0')
	alter table dbo.yaf_Forum drop column Locked
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Hidden')
begin
	exec('update yaf_Forum set Flags = Flags | 2 where Hidden<>0')
	alter table dbo.yaf_Forum drop column Hidden
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='IsTest')
begin
	exec('update yaf_Forum set Flags = Flags | 4 where IsTest<>0')
	alter table dbo.yaf_Forum drop column IsTest
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Moderated')
begin
	exec('update yaf_Forum set Flags = Flags | 8 where Moderated<>0')
	alter table dbo.yaf_Forum drop column Moderated
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='Flags')
begin
	alter table dbo.yaf_Group add Flags int not null constraint DF_yaf_Group_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsAdmin')
begin
	exec('update yaf_Group set Flags = Flags | 1 where IsAdmin<>0')
	alter table dbo.yaf_Group drop column IsAdmin
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsGuest')
begin
	exec('update yaf_Group set Flags = Flags | 2 where IsGuest<>0')
	alter table dbo.yaf_Group drop column IsGuest
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsStart')
begin
	exec('update yaf_Group set Flags = Flags | 4 where IsStart<>0')
	alter table dbo.yaf_Group drop column IsStart
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsModerator')
begin
	exec('update yaf_Group set Flags = Flags | 8 where IsModerator<>0')
	alter table dbo.yaf_Group drop column IsModerator
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='Flags')
begin
	alter table dbo.yaf_AccessMask add Flags int not null constraint DF_yaf_AccessMask_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ReadAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 1 where ReadAccess<>0')
	alter table dbo.yaf_AccessMask drop column ReadAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PostAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 2 where PostAccess<>0')
	alter table dbo.yaf_AccessMask drop column PostAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ReplyAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 4 where ReplyAccess<>0')
	alter table dbo.yaf_AccessMask drop column ReplyAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PriorityAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 8 where PriorityAccess<>0')
	alter table dbo.yaf_AccessMask drop column PriorityAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PollAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 16 where PollAccess<>0')
	alter table dbo.yaf_AccessMask drop column PollAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='VoteAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 32 where VoteAccess<>0')
	alter table dbo.yaf_AccessMask drop column VoteAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ModeratorAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 64 where ModeratorAccess<>0')
	alter table dbo.yaf_AccessMask drop column ModeratorAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='EditAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 128 where EditAccess<>0')
	alter table dbo.yaf_AccessMask drop column EditAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='DeleteAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 256 where DeleteAccess<>0')
	alter table dbo.yaf_AccessMask drop column DeleteAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='UploadAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 512 where UploadAccess<>0')
	alter table dbo.yaf_AccessMask drop column UploadAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Topic') and name='IsLocked')
begin
	grant update on yaf_Topic to public
	exec('update yaf_Topic set Flags = Flags | 1 where IsLocked<>0')
	revoke update on yaf_Topic from public
	alter table dbo.yaf_Topic drop column IsLocked
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_User') and name='Flags')
begin
	alter table dbo.yaf_User add Flags int not null constraint DF_yaf_User_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_User') and name='IsHostAdmin')
begin
	grant update on yaf_User to public
	exec('update yaf_User set Flags = Flags | 1 where IsHostAdmin<>0')
	revoke update on yaf_User from public
	alter table dbo.yaf_User drop column IsHostAdmin
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_User') and name='Approved')
begin
	grant update on yaf_User to public
	exec('update yaf_User set Flags = Flags | 2 where Approved<>0')
	revoke update on yaf_User from public
	alter table dbo.yaf_User drop column Approved
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='Flags')
begin
	alter table dbo.yaf_Rank add Flags int not null constraint DF_yaf_Rank_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='IsStart')
begin
	grant update on yaf_Rank to public
	exec('update yaf_Rank set Flags = Flags | 1 where IsStart<>0')
	revoke update on yaf_Rank from public
	alter table dbo.yaf_Rank drop column IsStart
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='IsLadder')
begin
	grant update on yaf_Rank to public
	exec('update yaf_Rank set Flags = Flags | 2 where IsLadder<>0')
	revoke update on yaf_Rank from public
	alter table dbo.yaf_Rank drop column IsLadder
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Poll') and name='Closes')
begin
	alter table dbo.yaf_Poll add Closes datetime null
end
GO

if not exists(select 1 from dbo.syscolumns where id = object_id(N'yaf_EventLog') and name=N'Type')
begin
	alter table dbo.yaf_EventLog add Type int not null constraint DF_yaf_EventLog_Type default (0)
	exec('update yaf_EventLog set Type = 0')
end
GO

if exists(select 1 from dbo.syscolumns where id = object_id(N'yaf_EventLog') and name=N'UserID' and isnullable=0)
	alter table yaf_EventLog alter column UserID int null
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_User') and name='ProviderUserKey')
begin
	alter table dbo.yaf_User add ProviderUserKey uniqueidentifier
end
GO

if exists(select 1 from dbo.yaf_Group where (Flags & 2)=2)
begin
	update dbo.yaf_User set Flags = Flags | 4 where UserID in(select distinct UserID from dbo.yaf_UserGroup a join dbo.yaf_Group b on b.GroupID=a.GroupID and (b.Flags & 2)=2)
end
go
