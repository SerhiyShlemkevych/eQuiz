
CREATE DATABASE eQuiz;
GO
 
USE eQuiz;
 GO
CREATE TABLE [dbo].[tblFacebookUser]
(
    [Id] [BIGINT] NOT NULL IDENTITY(1, 1),
    [UserId] [INT] NOT NULL,
    [UserName] [VARCHAR](50) NOT NULL,
    [FirstName] [NVARCHAR](50) NULL,
    [LastName] [NVARCHAR](50) NULL,
    [Email] [VARCHAR](50) NOT NULL,
    [ProfileLink] [VARCHAR](100) NULL,
    [ObtainedDate] [DATETIME] NOT NULL,
    CONSTRAINT [PK_tblFacebookUser] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_tblFacebookUser_Email] UNIQUE ([Email]),
    CONSTRAINT [UK_tblFacebookUser_UserName] UNIQUE ([UserName])
);
 
CREATE TABLE [dbo].[tblQuestionAnswer]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuestionId] [INT] NOT NULL,
    [AnswerText] [NVARCHAR](MAX) NOT NULL,
    [AnswerOrder] [TINYINT] NULL,
    [IsRight] [BIT] NULL,
    CONSTRAINT [PK_tblQuestionAnswers] PRIMARY KEY ([Id]) 
);
 
CREATE TABLE [dbo].[tblQuestion]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuestionTypeId] [TINYINT] NOT NULL,
    [TopicId] [SMALLINT] NOT NULL,
    [QuestionText] [NVARCHAR](max) NOT NULL,
    [QuestionComplexity] [TINYINT] NOT NULL,
    [IsActive] [BIT] NOT NULL,
    CONSTRAINT [PK_tblQuestion] PRIMARY KEY ([Id]) 
);
 
CREATE TABLE [dbo].[tblQuestionTag]
(
    [QuestionId] [INT] NOT NULL,
    [TagId] [SMALLINT] NOT NULL,
    CONSTRAINT [PK_tblQuestionTag] PRIMARY KEY ([QuestionId], [TagId]) 
);
 
CREATE TABLE [dbo].[tblQuestionType]
(
    [Id] [TINYINT] NOT NULL IDENTITY(1, 1),
    [TypeName] [VARCHAR](20) NOT NULL,
    [IsAutomatic] [BIT] NOT NULL,
    CONSTRAINT [PK_tblQuestionType] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblQuestionType_Name] UNIQUE ([TypeName]) 
);
 
CREATE TABLE [dbo].[tblQuizBlock]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizId] [INT] NOT NULL,
    [TopicId] [SMALLINT] NOT NULL,
    [BlockOrder] [TINYINT] NULL,
    [IsRandom] [BIT] NOT NULL,
    [QuestionMinComplexity] [TINYINT] NULL,
    [QuestionMaxComplexity] [TINYINT] NULL,
    [QuestionCount] [TINYINT] NULL,
    CONSTRAINT [PK_tblQuizBlock] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblQuizBlock_Quiz] UNIQUE ([QuizId]),
    CONSTRAINT [UK_tblQuizBlock_Topic] UNIQUE ([TopicId])
);
 
CREATE TABLE [dbo].[tblQuiz]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizTypeId] [TINYINT] NOT NULL,
    [Name] [NVARCHAR](50) NOT NULL,
    [Description] [NVARCHAR](MAX) NULL,
    [StartDate] [SMALLDATETIME] NULL,
    [EndDate] [SMALLDATETIME] NULL,
    [TimeLimitMinutes] [SMALLINT] NULL,
    [InternetAccess] [BIT] NOT NULL,
    [GroupId] [SMALLINT] NOT NULL,
    CONSTRAINT [PK_tblQuiz] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_tblQuiz_Name] UNIQUE ([Name])
 ); 
 
CREATE TABLE [dbo].[tblQuizPass]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizId] [INT] NOT NULL,
    [UserId] [INT] NOT NULL,
    [StartTime] [SMALLDATETIME] NOT NULL,
    [FinishTime] [SMALLDATETIME] NULL,
    CONSTRAINT [PK_tblQuizPass] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_tblQuizPass_QuizId] UNIQUE ([QuizId]), 
    CONSTRAINT [UK_tblQuizPass_UserId] UNIQUE ([UserId]), 
    CONSTRAINT [UK_tblQuizPass_StartTime] UNIQUE ([StartTime])
);
 
CREATE TABLE [dbo].[tblQuizPassQuestion]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizPassId] [INT] NOT NULL,
    [QuestionId] [INT] NOT NULL,
    [QuizBlockId] [INT] NOT NULL,
    [QuestionOrder] [SMALLINT] NOT NULL,
    CONSTRAINT [PK_tblQuizPassQuestion] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblQuizPassQuestion_QPId] UNIQUE ([QuizPassId]),
    CONSTRAINT [UK_tblQuizPassQuestion_QuestionId] UNIQUE ([QuestionId])
); 
 
CREATE TABLE [dbo].[tblQuizPassScore]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [PassScore] [SMALLINT] NOT NULL,
    [EvaluatedBy] [INT] NOT NULL,
    [EvaluatedAt] [SMALLDATETIME] NOT NULL,
    CONSTRAINT [PK_tblQuizPassScore] PRIMARY KEY ([Id]) 
);
 
CREATE TABLE [dbo].[tblQuizQuestion]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizBlockId] [INT] NOT NULL,
    [QuizVariantId] [INT] NULL,
    [QuestionScore] [TINYINT] NOT NULL,
    [QuestionOrder] [SMALLINT] NULL,
    CONSTRAINT [PK_tblQuizQuestion] PRIMARY KEY ([Id], [QuizBlockId]) 
);
 
CREATE TABLE [dbo].[tblQuizType]
(
    [Id] [TINYINT] NOT NULL IDENTITY(1, 1),
    [TypeName] [VARCHAR](50) NOT NULL,
    CONSTRAINT [PK_tblQuizTypes] PRIMARY KEY ([Id]) 
);
 
CREATE TABLE [dbo].[tblQuizVariant]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [QuizId] [INT] NOT NULL,
    [VariantNumber] [TINYINT] NOT NULL,
    CONSTRAINT [PK_tblQuizVariant] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_tblQuizVariant_QuizId] UNIQUE ([QuizId]),
    CONSTRAINT [UK_tblQuizVariant_Variant] UNIQUE ([VariantNumber])
);
 
CREATE TABLE [dbo].[tblTag]
(
    [Id] [SMALLINT] NOT NULL IDENTITY(1, 1),
    [Name] [NVARCHAR](20) NOT NULL,
    CONSTRAINT [PK_tblTag] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_tblTag_Name] UNIQUE ([Name])
);
 
CREATE TABLE [dbo].[tblTopic]
(
    [Id] [SMALLINT] NOT NULL IDENTITY(1, 1),
    [Name] [NVARCHAR](30) NOT NULL,
    [Description] [NVARCHAR](250) NULL,
    CONSTRAINT [PK_tblTopic] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblTopic_Name] UNIQUE ([Name]) 
);
 
CREATE TABLE [dbo].[tblUserAnswer]
(
    [QuizPassQuestionId] [INT] NOT NULL,
    [AnswerId] [INT] NOT NULL,
    [AnswerTime] [DATETIME] NOT NULL,
    CONSTRAINT [PK_tblUserAnswer] PRIMARY KEY ([QuizPassQuestionId], [AnswerId]) 
);
 
CREATE TABLE [dbo].[tblUserAnswerScore]
(
    [QuizPassQuestionId] [INT] NOT NULL,
    [Score] [TINYINT] NOT NULL,
    [EvaluatedBy] [INT] NOT NULL,
    [EvaluatedAt] [SMALLDATETIME] NOT NULL,
    CONSTRAINT [PK_tblUserAnswerScore] PRIMARY KEY ([QuizPassQuestionId]) 
);
 
CREATE TABLE [dbo].[tblUserGroup]
(
    [Id] [SMALLINT] NOT NULL IDENTITY(1, 1),
    [Name] [NVARCHAR](50) NOT NULL,
    CONSTRAINT [PK_tblUserGroup] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblUserGroups_Name] UNIQUE ([Name]) 
);
 
CREATE TABLE [dbo].[tblUser]
(
    [Id] [INT] NOT NULL IDENTITY(1, 1),
    [FirstName] [NVARCHAR](50) NOT NULL,
    [LastName] [NVARCHAR](50) NOT NULL,
    [FatheName] [NVARCHAR](50) NULL,
    [Email] [VARCHAR](50) NOT NULL,
    [Phone] [VARCHAR](20) NOT NULL,
    [IsEmailConfirmed] [BIT] NOT NULL,
    [PasswordHash] [VARCHAR](MAX) NULL,
    [SecurityStamp] [VARCHAR](MAX) NULL,
    CONSTRAINT [PK_tblUser] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_tblUser_Email] UNIQUE ([Email])
); 
 
CREATE TABLE [dbo].[tblUserToUserGroup]
(
    [UserId] [INT] NOT NULL,
    [GroupId] [SMALLINT] NOT NULL,
    CONSTRAINT [PK_UserToUserGroup] PRIMARY KEY ([UserId], [GroupId]) 
);
 
CREATE TABLE [dbo].[tblUserTextAnswer]
(
    [QuizPassQuestionId] [INT] NOT NULL,
    [AnswerTime] [DATETIME] NOT NULL,
    [AnswerText] [NVARCHAR](MAX) NOT NULL,
    CONSTRAINT [PK_UserTextAnswer] PRIMARY KEY ([QuizPassQuestionId]) 
);
 
GO
ALTER TABLE [dbo].[tblFacebookUser]  WITH CHECK ADD CONSTRAINT [FK_tblFacebookUser_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblFacebookUser] CHECK CONSTRAINT [FK_tblFacebookUser_tblUser]
GO
ALTER TABLE [dbo].[tblQuestionAnswer]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestionAnswer_tblQuestion] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[tblQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblQuestionAnswer] CHECK CONSTRAINT [FK_tblQuestionAnswer_tblQuestion]
GO
ALTER TABLE [dbo].[tblQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestion_tblQuestionType] FOREIGN KEY([QuestionTypeId])
REFERENCES [dbo].[tblQuestionType] ([Id])
GO
ALTER TABLE [dbo].[tblQuestion] CHECK CONSTRAINT [FK_tblQuestion_tblQuestionType]
GO
ALTER TABLE [dbo].[tblQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestion_tblTopic] FOREIGN KEY([TopicId])
REFERENCES [dbo].[tblTopic] ([Id])
GO
ALTER TABLE [dbo].[tblQuestion] CHECK CONSTRAINT [FK_tblQuestion_tblTopic]
GO
ALTER TABLE [dbo].[tblQuestionTag]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestionTag_tblQuestion] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[tblQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblQuestionTag] CHECK CONSTRAINT [FK_tblQuestionTag_tblQuestion]
GO
ALTER TABLE [dbo].[tblQuestionTag]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestionTag_tblTag] FOREIGN KEY([TagId])
REFERENCES [dbo].[tblTag] ([Id])
GO
ALTER TABLE [dbo].[tblQuestionTag] CHECK CONSTRAINT [FK_tblQuestionTag_tblTag]
GO
ALTER TABLE [dbo].[tblQuizBlock]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizBlock_tblQuiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[tblQuiz] ([Id])
GO
ALTER TABLE [dbo].[tblQuizBlock] CHECK CONSTRAINT [FK_tblQuizBlock_tblQuiz]
GO
ALTER TABLE [dbo].[tblQuizBlock]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizBlock_Topic] FOREIGN KEY([TopicId])
REFERENCES [dbo].[tblTopic] ([Id])
GO
ALTER TABLE [dbo].[tblQuizBlock] CHECK CONSTRAINT [FK_tblQuizBlock_Topic]
GO
ALTER TABLE [dbo].[tblQuiz]  WITH CHECK ADD  CONSTRAINT [FK_tblQuiz_tblQuizType] FOREIGN KEY([QuizTypeId])
REFERENCES [dbo].[tblQuizType] ([Id])
GO
ALTER TABLE [dbo].[tblQuiz]  WITH CHECK ADD  CONSTRAINT [FK_tblQuiz_tblGroup] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblQuiz] CHECK CONSTRAINT [FK_tblQuiz_tblQuizType]
GO
ALTER TABLE [dbo].[tblQuizPass]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPass_tblQuiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[tblQuiz] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPass] CHECK CONSTRAINT [FK_tblQuizPass_tblQuiz]
GO
ALTER TABLE [dbo].[tblQuizPass]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPass_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPass] CHECK CONSTRAINT [FK_tblQuizPass_tblUser]
GO
ALTER TABLE [dbo].[tblQuizPassQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPassQuestion_tblQuestion] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[tblQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPassQuestion] CHECK CONSTRAINT [FK_tblQuizPassQuestion_tblQuestion]
GO
ALTER TABLE [dbo].[tblQuizPassQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPassQuestion_QuizBlock] FOREIGN KEY([QuizBlockId])
REFERENCES [dbo].[tblQuizBlock] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPassQuestion] CHECK CONSTRAINT [FK_tblQuizPassQuestion_QuizBlock]
GO
ALTER TABLE [dbo].[tblQuizPassQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPassQuestion_tblQuizPass] FOREIGN KEY([QuizPassId])
REFERENCES [dbo].[tblQuizPass] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPassQuestion] CHECK CONSTRAINT [FK_tblQuizPassQuestion_tblQuizPass]
GO
ALTER TABLE [dbo].[tblQuizPassScore]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPassScore_tblQuizPass] FOREIGN KEY([Id])
REFERENCES [dbo].[tblQuizPass] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPassScore] CHECK CONSTRAINT [FK_tblQuizPassScore_tblQuizPass]
GO
ALTER TABLE [dbo].[tblQuizPassScore]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizPassScore_tblUser] FOREIGN KEY([EvaluatedBy])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblQuizPassScore] CHECK CONSTRAINT [FK_tblQuizPassScore_tblUser]
GO
ALTER TABLE [dbo].[tblQuizQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizQuestion_tblQuestion] FOREIGN KEY([Id])
REFERENCES [dbo].[tblQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblQuizQuestion] CHECK CONSTRAINT [FK_tblQuizQuestion_tblQuestion]
GO
ALTER TABLE [dbo].[tblQuizQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizQuestion_tblQuizBlock] FOREIGN KEY([QuizBlockId])
REFERENCES [dbo].[tblQuizBlock] ([Id])
GO
ALTER TABLE [dbo].[tblQuizQuestion] CHECK CONSTRAINT [FK_tblQuizQuestion_tblQuizBlock]
GO
ALTER TABLE [dbo].[tblQuizQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizQuestion_tblQuizVariant] FOREIGN KEY([QuizVariantId])
REFERENCES [dbo].[tblQuizVariant] ([Id])
GO
ALTER TABLE [dbo].[tblQuizQuestion] CHECK CONSTRAINT [FK_tblQuizQuestion_tblQuizVariant];
 
ALTER TABLE [dbo].[tblQuizVariant]  WITH CHECK ADD  CONSTRAINT [FK_tblQuizVariant_tblQuiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[tblQuiz] ([Id]);
GO
ALTER TABLE [dbo].[tblQuizVariant] CHECK CONSTRAINT [FK_tblQuizVariant_tblQuiz]
GO
ALTER TABLE [dbo].[tblUserAnswer]  WITH CHECK ADD  CONSTRAINT [FK_tblUserAnswer_tblQuestionAnswer] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[tblQuestionAnswer] ([Id])
GO
ALTER TABLE [dbo].[tblUserAnswer] CHECK CONSTRAINT [FK_tblUserAnswer_tblQuestionAnswer]
GO
ALTER TABLE [dbo].[tblUserAnswer]  WITH CHECK ADD  CONSTRAINT [FK_tblUserAnswer_tblQuizPassQuestion] FOREIGN KEY([QuizPassQuestionId])
REFERENCES [dbo].[tblQuizPassQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblUserAnswer] CHECK CONSTRAINT [FK_tblUserAnswer_tblQuizPassQuestion]
GO
ALTER TABLE [dbo].[tblUserAnswerScore]  WITH CHECK ADD  CONSTRAINT [FK_tblUserAnswerScore_tblQuizPassQuestion] FOREIGN KEY([QuizPassQuestionId])
REFERENCES [dbo].[tblQuizPassQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblUserAnswerScore] CHECK CONSTRAINT [FK_tblUserAnswerScore_tblQuizPassQuestion]
GO
ALTER TABLE [dbo].[tblUserAnswerScore]  WITH CHECK ADD  CONSTRAINT [FK_tblUserAnswerScore_tblUser] FOREIGN KEY([EvaluatedBy])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblUserAnswerScore] CHECK CONSTRAINT [FK_tblUserAnswerScore_tblUser]
GO
ALTER TABLE [dbo].[tblUserToUserGroup]  WITH CHECK ADD  CONSTRAINT [FK_tblUserToUserGroup_tblUserGroup] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblUserToUserGroup] CHECK CONSTRAINT [FK_tblUserToUserGroup_tblUserGroup]
GO
ALTER TABLE [dbo].[tblUserToUserGroup]  WITH CHECK ADD  CONSTRAINT [FK_tblUserToUserGroup_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblUserToUserGroup] CHECK CONSTRAINT [FK_tblUserToUserGroup_tblUser]
GO
ALTER TABLE [dbo].[tblUserTextAnswer]  WITH CHECK ADD  CONSTRAINT [FK_tblUserTextAnswer_tblQuizPassQuestion] FOREIGN KEY([QuizPassQuestionId])
REFERENCES [dbo].[tblQuizPassQuestion] ([Id])
GO
ALTER TABLE [dbo].[tblUserTextAnswer] CHECK CONSTRAINT [FK_tblUserTextAnswer_tblQuizPassQuestion]
GO