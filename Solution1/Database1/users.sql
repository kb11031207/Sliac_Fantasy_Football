CREATE TABLE [dbo].[users] (
    [id]                     INT            IDENTITY (1, 1) NOT NULL,
    [email]                  NVARCHAR (256) NULL,
    [username]               NCHAR (64)     NULL,
    [school]                 NCHAR (100)    NULL,
    [passHash]               VARBINARY (64) NOT NULL,
    [passSalt]               VARBINARY (16) NOT NULL,
    [FailedLoginAttempts]    INT            DEFAULT ((0)) NOT NULL,
    [LockoutEnd]             DATETIME       NULL,
    [RefreshToken]           NVARCHAR (256) NULL,
    [RefreshTokenExpiryTime] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [UQ_users_email] UNIQUE NONCLUSTERED ([email] ASC),
    CONSTRAINT [UQ_users_username] UNIQUE NONCLUSTERED ([username] ASC)
);

