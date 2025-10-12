-- Add authentication and lockout fields to users table

-- Check if columns don't exist before adding them
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND name = 'FailedLoginAttempts')
BEGIN
    ALTER TABLE [dbo].[users]
    ADD [FailedLoginAttempts] INT NOT NULL DEFAULT 0;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND name = 'LockoutEnd')
BEGIN
    ALTER TABLE [dbo].[users]
    ADD [LockoutEnd] DATETIME NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND name = 'RefreshToken')
BEGIN
    ALTER TABLE [dbo].[users]
    ADD [RefreshToken] NVARCHAR(256) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND name = 'RefreshTokenExpiryTime')
BEGIN
    ALTER TABLE [dbo].[users]
    ADD [RefreshTokenExpiryTime] DATETIME NULL;
END

GO

PRINT 'Authentication fields added successfully to users table';

