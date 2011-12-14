/*********************************************************************
  InstallSqlState.SQL                                                
                                                                    
  Installs the tables, and stored procedures necessary for           
  supporting ASP.NET session state on SQL Azure.                                  

  Copyright Microsoft, Inc.
  All Rights Reserved.

 *********************************************************************/

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ASPStateTempSessions]') AND type in (N'U'))
DROP TABLE [dbo].[ASPStateTempSessions]
GO   

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ASPStateTempApplications]') AND type in (N'U'))
DROP TABLE [dbo].[ASPStateTempApplications]
GO   

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetMajorVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetMajorVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'CreateTempTables') AND (type = 'P')))
    DROP PROCEDURE [dbo].CreateTempTables
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetHashCode') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetHashCode
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetAppID') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetAppID
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempReleaseStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempReleaseStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertUninitializedItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertUninitializedItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShortNullLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShortNullLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLongNullShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLongNullShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempRemoveStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempRemoveStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempResetTimeout') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempResetTimeout
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'DeleteExpiredSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'ASPStateTempSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO


/*****************************************************************************/

CREATE PROCEDURE dbo.GetMajorVersion
    @@ver int OUTPUT
AS
BEGIN
	DECLARE @version        nchar(100)
	DECLARE @dot            int
	DECLARE @hyphen         int
	DECLARE @SqlToExec      nchar(4000)

	SELECT @@ver = 7
	SELECT @version = @@Version
	SELECT @hyphen  = CHARINDEX(N' - ', @version)
	IF (NOT(@hyphen IS NULL) AND @hyphen > 0)
	BEGIN
		SELECT @hyphen = @hyphen + 3
		SELECT @dot    = CHARINDEX(N'.', @version, @hyphen)
		IF (NOT(@dot IS NULL) AND @dot > @hyphen)
		BEGIN
			SELECT @version = SUBSTRING(@version, @hyphen, @dot - @hyphen)
			SELECT @@ver     = CONVERT(int, @version)
		END
	END
END
GO   

/*****************************************************************************/


CREATE PROCEDURE dbo.CreateTempTables
AS

    CREATE TABLE dbo.ASPStateTempSessions (
        SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
        Created             datetime        NOT NULL DEFAULT GETUTCDATE(),
        Expires             datetime        NOT NULL,
        LockDate            datetime        NOT NULL,
        LockDateLocal       datetime        NOT NULL,
        LockCookie          int             NOT NULL,
        Timeout             int             NOT NULL,
        Locked              bit             NOT NULL,
        SessionItemShort    VARBINARY(7000) NULL,
        SessionItemLong     image           NULL,
        Flags               int             NOT NULL DEFAULT 0,
    ) 

    CREATE NONCLUSTERED INDEX Index_Expires ON dbo.ASPStateTempSessions(Expires)

    CREATE TABLE dbo.ASPStateTempApplications (
        AppId               int             NOT NULL PRIMARY KEY,
        AppName             char(280)       NOT NULL,
    ) 

    CREATE NONCLUSTERED INDEX Index_AppName ON dbo.ASPStateTempApplications(AppName)

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetVersion
    @ver      char(10) OUTPUT
AS
    SELECT @ver = "2"
    RETURN 0
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.GetHashCode
    @input varchar(280),
    @hash int OUTPUT
AS
    /* 
       This sproc is based on this C# hash function:

        int GetHashCode(string s)
        {
            int     hash = 5381;
            int     len = s.Length;

            for (int i = 0; i < len; i++) {
                int     c = Convert.ToInt32(s[i]);
                hash = ((hash << 5) + hash) ^ c;
            }

            return hash;
        }

        However, SQL 7 doesn't provide a 32-bit integer
        type that allows rollover of bits, we have to
        divide our 32bit integer into the upper and lower
        16 bits to do our calculation.
    */
       
    DECLARE @hi_16bit   int
    DECLARE @lo_16bit   int
    DECLARE @hi_t       int
    DECLARE @lo_t       int
    DECLARE @len        int
    DECLARE @i          int
    DECLARE @c          int
    DECLARE @carry      int

    SET @hi_16bit = 0
    SET @lo_16bit = 5381
    
    SET @len = DATALENGTH(@input)
    SET @i = 1
    
    WHILE (@i <= @len)
    BEGIN
        SET @c = ASCII(SUBSTRING(@input, @i, 1))

        /* Formula:                        
           hash = ((hash << 5) + hash) ^ c */

        /* hash << 5 */
        SET @hi_t = @hi_16bit * 32 /* high 16bits << 5 */
        SET @hi_t = @hi_t & 0xFFFF /* zero out overflow */
        
        SET @lo_t = @lo_16bit * 32 /* low 16bits << 5 */
        
        SET @carry = @lo_16bit & 0x1F0000 /* move low 16bits carryover to hi 16bits */
        SET @carry = @carry / 0x10000 /* >> 16 */
        SET @hi_t = @hi_t + @carry
        SET @hi_t = @hi_t & 0xFFFF /* zero out overflow */

        /* + hash */
        SET @lo_16bit = @lo_16bit + @lo_t
        SET @hi_16bit = @hi_16bit + @hi_t + (@lo_16bit / 0x10000)
        /* delay clearing the overflow */

        /* ^c */
        SET @lo_16bit = @lo_16bit ^ @c

        /* Now clear the overflow bits */	
        SET @hi_16bit = @hi_16bit & 0xFFFF
        SET @lo_16bit = @lo_16bit & 0xFFFF

        SET @i = @i + 1
    END

    /* Do a sign extension of the hi-16bit if needed */
    IF (@hi_16bit & 0x8000 <> 0)
        SET @hi_16bit = 0xFFFF0000 | @hi_16bit

    /* Merge hi and lo 16bit back together */
    SET @hi_16bit = @hi_16bit * 0x10000 /* << 16 */
    SET @hash = @hi_16bit | @lo_16bit

    RETURN 0
GO

/*****************************************************************************/

DECLARE @cmd nchar(4000)

SET @cmd = N'
    CREATE PROCEDURE dbo.TempGetAppID
    @appName    varchar(280),
    @appId      int OUTPUT
    AS
    SET @appName = LOWER(@appName)
    SET @appId = NULL

    SELECT @appId = AppId
    FROM dbo.ASPStateTempApplications
    WHERE AppName = @appName

    IF @appId IS NULL BEGIN
        BEGIN TRAN        

        SELECT @appId = AppId
        FROM dbo.ASPStateTempApplications WITH (TABLOCKX)
        WHERE AppName = @appName
        
        IF @appId IS NULL
        BEGIN
            EXEC GetHashCode @appName, @appId OUTPUT
            
            INSERT dbo.ASPStateTempApplications
            VALUES
            (@appId, @appName)
            
            IF @@ERROR = 2627 
            BEGIN
                DECLARE @dupApp varchar(280)
            
                SELECT @dupApp = RTRIM(AppName)
                FROM dbo.ASPStateTempApplications 
                WHERE AppId = @appId
                
                RAISERROR(''SQL session state fatal error: hash-code collision between applications ''''%s'''' and ''''%s''''. Please rename the 1st application to resolve the problem.'', 
                            18, 1, @appName, @dupApp)
            END
        END

        COMMIT
    END

    RETURN 0'
EXEC(@cmd)    
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetStateItem
    @id         nvarchar(88),
    @itemShort  varbinary(7000) OUTPUT,
    @locked     bit OUTPUT,
    @lockDate   datetime OUTPUT,
    @lockCookie int OUTPUT
AS
    DECLARE @now AS datetime
    SET @now = GETUTCDATE()

    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, @now), 
        @locked = Locked,
        @lockDate = LockDateLocal,
        @lockCookie = LockCookie,
        @itemShort = CASE @locked
            WHEN 0 THEN SessionItemShort
            ELSE NULL
            END
    WHERE SessionId = @id
    RETURN 0
    
GO

/*****************************************************************************/

        CREATE PROCEDURE dbo.TempGetStateItem2
            @id         nvarchar(88),
            @itemShort  varbinary(7000) OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END
            WHERE SessionId = @id


            RETURN 0
            
GO
            
/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetStateItem3
    @id         nvarchar(88),
    @itemShort  varbinary(7000) OUTPUT,
    @locked     bit OUTPUT,
    @lockAge    int OUTPUT,
    @lockCookie int OUTPUT,
    @actionFlags int OUTPUT
AS
    DECLARE @textptr AS varbinary(16)
    DECLARE @length AS int
    DECLARE @now AS datetime
    SET @now = GETUTCDATE()

    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, @now), 
        @locked = Locked,
        @lockAge = DATEDIFF(second, LockDate, @now),
        @lockCookie = LockCookie,
        @itemShort = CASE @locked
            WHEN 0 THEN SessionItemShort
            ELSE NULL
            END,
        /* If the Uninitialized flag (0x1) if it is set,
           remove it and return InitializeItem (0x1) in actionFlags */
        Flags = CASE
            WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
            ELSE Flags
            END,
        @actionFlags = CASE
            WHEN (Flags & 1) <> 0 THEN 1
            ELSE 0
            END
    WHERE SessionId = @id

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetStateItemExclusive
    @id         nvarchar(88),
    @itemShort  varbinary(7000) OUTPUT,
    @locked     bit OUTPUT,
    @lockDate   datetime OUTPUT,
    @lockCookie int OUTPUT
AS
    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime

    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()
    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, @now), 
        LockDate = CASE Locked
            WHEN 0 THEN @now
            ELSE LockDate
            END,
        @lockDate = LockDateLocal = CASE Locked
            WHEN 0 THEN @nowLocal
            ELSE LockDateLocal
            END,
        @lockCookie = LockCookie = CASE Locked
            WHEN 0 THEN LockCookie + 1
            ELSE LockCookie
            END,
        @itemShort = CASE Locked
            WHEN 0 THEN SessionItemShort
            ELSE NULL
            END,
        @locked = Locked,
        Locked = 1
    WHERE SessionId = @id

    RETURN 0
    
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetStateItemExclusive2
    @id         nvarchar(88),
    @itemShort  varbinary(7000) OUTPUT,
    @locked     bit OUTPUT,
    @lockAge    int OUTPUT,
    @lockCookie int OUTPUT
AS
    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime

    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()
    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, @now), 
        LockDate = CASE Locked
            WHEN 0 THEN @now
            ELSE LockDate
            END,
        LockDateLocal = CASE Locked
            WHEN 0 THEN @nowLocal
            ELSE LockDateLocal
            END,
        @lockAge = CASE Locked
            WHEN 0 THEN 0
            ELSE DATEDIFF(second, LockDate, @now)
            END,
        @lockCookie = LockCookie = CASE Locked
            WHEN 0 THEN LockCookie + 1
            ELSE LockCookie
            END,
        @itemShort = CASE Locked
            WHEN 0 THEN SessionItemShort
            ELSE NULL
            END,
        @locked = Locked,
        Locked = 1
    WHERE SessionId = @id

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempGetStateItemExclusive3
    @id         nvarchar(88),
    @itemShort  varbinary(7000) OUTPUT,
    @locked     bit OUTPUT,
    @lockAge    int OUTPUT,
    @lockCookie int OUTPUT,
    @actionFlags int OUTPUT
AS
    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime

    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()
    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, @now), 
        LockDate = CASE Locked
            WHEN 0 THEN @now
            ELSE LockDate
            END,
        LockDateLocal = CASE Locked
            WHEN 0 THEN @nowLocal
            ELSE LockDateLocal
            END,
        @lockAge = CASE Locked
            WHEN 0 THEN 0
            ELSE DATEDIFF(second, LockDate, @now)
            END,
        @lockCookie = LockCookie = CASE Locked
            WHEN 0 THEN LockCookie + 1
            ELSE LockCookie
            END,
        @itemShort = CASE Locked
            WHEN 0 THEN SessionItemShort
            ELSE NULL
            END,
        @locked = Locked,
        Locked = 1,

        /* If the Uninitialized flag (0x1) if it is set,
           remove it and return InitializeItem (0x1) in actionFlags */
        Flags = CASE
            WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
            ELSE Flags
            END,
        @actionFlags = CASE
            WHEN (Flags & 1) <> 0 THEN 1
            ELSE 0
            END
    WHERE SessionId = @id

    RETURN 0
            
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
    @id         nvarchar(88),
    @lockCookie int
AS
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, GETUTCDATE()), 
        Locked = 0
    WHERE SessionId = @id AND LockCookie = @lockCookie

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempInsertUninitializedItem
    @id         nvarchar(88),
    @itemShort  varbinary(7000),
    @timeout    int
AS    

    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime
    
    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()

    INSERT dbo.ASPStateTempSessions 
        (SessionId, 
         SessionItemShort, 
         Timeout, 
         Expires, 
         Locked, 
         LockDate,
         LockDateLocal,
         LockCookie,
         Flags) 
    VALUES 
        (@id, 
         @itemShort, 
         @timeout, 
         DATEADD(n, @timeout, @now), 
         0, 
         @now,
         @nowLocal,
         1,
         1)

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempInsertStateItemShort
    @id         nvarchar(88),
    @itemShort  varbinary(7000),
    @timeout    int
AS    

    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime
    
    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()

    INSERT dbo.ASPStateTempSessions 
        (SessionId, 
         SessionItemShort, 
         Timeout, 
         Expires, 
         Locked, 
         LockDate,
         LockDateLocal,
         LockCookie) 
    VALUES 
        (@id, 
         @itemShort, 
         @timeout, 
         DATEADD(n, @timeout, @now), 
         0, 
         @now,
         @nowLocal,
         1)

    RETURN 0

GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempInsertStateItemLong
    @id         nvarchar(88),
    @itemLong   image,
    @timeout    int
AS    
    DECLARE @now AS datetime
    DECLARE @nowLocal AS datetime
    
    SET @now = GETUTCDATE()
    SET @nowLocal = GETDATE()

    INSERT dbo.ASPStateTempSessions 
        (SessionId, 
         SessionItemLong, 
         Timeout, 
         Expires, 
         Locked, 
         LockDate,
         LockDateLocal,
         LockCookie) 
    VALUES 
        (@id, 
         @itemLong, 
         @timeout, 
         DATEADD(n, @timeout, @now), 
         0, 
         @now,
         @nowLocal,
         1)

    RETURN 0
    
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempUpdateStateItemShort
    @id         nvarchar(88),
    @itemShort  varbinary(7000),
    @timeout    int,
    @lockCookie int
AS    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
        SessionItemShort = @itemShort, 
        Timeout = @timeout,
        Locked = 0
    WHERE SessionId = @id AND LockCookie = @lockCookie

    RETURN 0
    
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
    @id         nvarchar(88),
    @itemShort  varbinary(7000),
    @timeout    int,
    @lockCookie int
AS    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
        SessionItemShort = @itemShort, 
        SessionItemLong = NULL, 
        Timeout = @timeout,
        Locked = 0
    WHERE SessionId = @id AND LockCookie = @lockCookie

    RETURN 0
    
GO
            
/*****************************************************************************/

CREATE PROCEDURE dbo.TempUpdateStateItemLong
    @id         nvarchar(88),
    @itemLong   image,
    @timeout    int,
    @lockCookie int
AS    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
        SessionItemLong = @itemLong,
        Timeout = @timeout,
        Locked = 0
    WHERE SessionId = @id AND LockCookie = @lockCookie

    RETURN 0
    
GO

/*****************************************************************************/

CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
    @id         nvarchar(88),
    @itemLong   image,
    @timeout    int,
    @lockCookie int
AS    
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
        SessionItemLong = @itemLong, 
        SessionItemShort = NULL,
        Timeout = @timeout,
        Locked = 0
    WHERE SessionId = @id AND LockCookie = @lockCookie

    RETURN 0
         
GO
   
/*****************************************************************************/

CREATE PROCEDURE dbo.TempRemoveStateItem
    @id     nvarchar(88),
    @lockCookie int
AS
    DELETE dbo.ASPStateTempSessions
    WHERE SessionId = @id AND LockCookie = @lockCookie
    RETURN 0
   
GO
            
/*****************************************************************************/

CREATE PROCEDURE dbo.TempResetTimeout
    @id     nvarchar(88)
AS
    UPDATE dbo.ASPStateTempSessions
    SET Expires = DATEADD(n, Timeout, GETUTCDATE())
    WHERE SessionId = @id
    RETURN 0
    
GO
            
/*****************************************************************************/

CREATE PROCEDURE dbo.DeleteExpiredSessions
AS
    DECLARE @now datetime
    SET @now = GETUTCDATE()

    DELETE dbo.ASPStateTempSessions
    WHERE Expires < @now

    RETURN 0
    
GO  
            
/*****************************************************************************/

EXECUTE dbo.CreateTempTables
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT ''
PRINT '------------------------------------------'
PRINT 'Completed execution of InstallSqlState.SQL'
PRINT '------------------------------------------'

