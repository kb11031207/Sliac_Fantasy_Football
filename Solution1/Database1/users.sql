CREATE TABLE [dbo].[users]
(
	[id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [email] NVARCHAR(256) NULL, 
    [username] NCHAR(64) NULL, 
    [school] NCHAR(100) NULL,
    [passHash] varbinary(64) NOT NULL,
    [passSalt] varbinary(16) NOT NULL,
    --add a unique constraint on email and username
    CONSTRAINT [UQ_users_email] UNIQUE ([email]),
    CONSTRAINT [UQ_users_username] UNIQUE ([username])
    --index on email and username for faster lookups
)