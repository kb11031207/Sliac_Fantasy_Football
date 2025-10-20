-- Add BoxScoreUrl column to existing Fixtures table
-- Run this ONCE if your Fixtures table already exists without this column

-- Check if column already exists
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Fixtures' 
    AND COLUMN_NAME = 'BoxScoreUrl'
)
BEGIN
    ALTER TABLE Fixtures
    ADD BoxScoreUrl NVARCHAR(512) NULL;
    
    PRINT 'BoxScoreUrl column added successfully';
END
ELSE
BEGIN
    PRINT 'BoxScoreUrl column already exists';
END
GO





