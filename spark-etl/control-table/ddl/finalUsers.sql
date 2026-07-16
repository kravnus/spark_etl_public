IF OBJECT_ID('mVStudio.dbo.finalUsers', 'U') IS NOT NULL
    DROP TABLE mVStudio.dbo.finalUsers;

WITH Users AS
(
    SELECT
        CAST('mStudioBilling' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS AS FromDB,
        UserCode,
        UserName COLLATE SQL_Latin1_General_CP1_CI_AS AS UserName,
        Password COLLATE SQL_Latin1_General_CP1_CI_AS AS Password,
        EmployeeCode,
        ChannelID,
        Portal,
        EHCM,
        Admin,
        UserType,
        Sec_Ques COLLATE SQL_Latin1_General_CP1_CI_AS AS Sec_Ques,
        Sec_Ans COLLATE SQL_Latin1_General_CP1_CI_AS AS Sec_Ans,
        Activation_Code COLLATE SQL_Latin1_General_CP1_CI_AS AS Activation_Code,
        Mem_Activity,
        Blocked,
        DateCreated COLLATE SQL_Latin1_General_CP1_CI_AS AS DateCreated,
        IsTrialAcc,
        FirstLogon,
        Description COLLATE SQL_Latin1_General_CP1_CI_AS AS Description,
        ADLogin COLLATE SQL_Latin1_General_CP1_CI_AS AS ADLogin,
        UGroupCode,
        Deactivated,
        Deleted,
        CreatedDate,
        CreatedUser,
        LastUpdateDate,
        LastUpdateUser,
        DeleteDate,
        DeleteUser,
        UserFullName COLLATE SQL_Latin1_General_CP1_CI_AS AS UserFullName,
        SalesCenterID,
        CAST(NULL AS VARCHAR(255)) COLLATE SQL_Latin1_General_CP1_CI_AS AS PortalEmail,
        CAST(NULL AS VARCHAR(100)) COLLATE SQL_Latin1_General_CP1_CI_AS AS ContactNo
    FROM mStudioBilling.dbo.MI_Common_Users
    WHERE Deleted = 0
      AND Deactivated = 0

    UNION ALL

    SELECT
        CAST('mVStudio' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS,
        UserCode,
        UserName COLLATE SQL_Latin1_General_CP1_CI_AS,
        Password COLLATE SQL_Latin1_General_CP1_CI_AS,
        EmployeeCode,
        ChannelID,
        Portal,
        EHCM,
        Admin,
        UserType,
        Sec_Ques COLLATE SQL_Latin1_General_CP1_CI_AS,
        Sec_Ans COLLATE SQL_Latin1_General_CP1_CI_AS,
        Activation_Code COLLATE SQL_Latin1_General_CP1_CI_AS,
        Mem_Activity,
        Blocked,
        DateCreated COLLATE SQL_Latin1_General_CP1_CI_AS,
        IsTrialAcc,
        FirstLogon,
        Description COLLATE SQL_Latin1_General_CP1_CI_AS,
        ADLogin COLLATE SQL_Latin1_General_CP1_CI_AS,
        UGroupCode,
        Deactivated,
        Deleted,
        CreatedDate,
        CreatedUser,
        LastUpdateDate,
        LastUpdateUser,
        DeleteDate,
        DeleteUser,
        CAST(NULL AS VARCHAR(255)) COLLATE SQL_Latin1_General_CP1_CI_AS AS UserFullName,
        SalesCenterID,
        CAST(NULL AS VARCHAR(255)) COLLATE SQL_Latin1_General_CP1_CI_AS AS PortalEmail,
        CAST(NULL AS VARCHAR(100)) COLLATE SQL_Latin1_General_CP1_CI_AS AS ContactNo
    FROM mVStudio.dbo.MI_Common_Users
    WHERE Deleted = 0
      AND Deactivated = 0

    UNION ALL

    SELECT
        CAST('mStudioPortal' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS,
        UserCode,
        UserName COLLATE SQL_Latin1_General_CP1_CI_AS,
        Password COLLATE SQL_Latin1_General_CP1_CI_AS,
        CAST(NULL AS INT),
        CAST(NULL AS INT),
        CAST(NULL AS BIT),
        CAST(NULL AS BIT),
        CAST(NULL AS BIT),
        UserType,
        Sec_Ques COLLATE SQL_Latin1_General_CP1_CI_AS,
        Sec_Ans COLLATE SQL_Latin1_General_CP1_CI_AS,
        Activation_Code COLLATE SQL_Latin1_General_CP1_CI_AS,
        CAST(NULL AS BIT),
        Blocked,
        DateCreated COLLATE SQL_Latin1_General_CP1_CI_AS,
        IsTrialAcc,
        FirstLogon,
        Description COLLATE SQL_Latin1_General_CP1_CI_AS,
        CAST(NULL AS VARCHAR(100)) COLLATE SQL_Latin1_General_CP1_CI_AS,
        UGroupCode,
        Deactivated,
        Deleted,
        CreatedDate,
        CreatedUser,
        LastUpdateDate,
        LastUpdateUser,
        DeleteDate,
        DeleteUser,
        FullName COLLATE SQL_Latin1_General_CP1_CI_AS,
        SalesCenterID,
        Email COLLATE SQL_Latin1_General_CP1_CI_AS,
        ContactNo COLLATE SQL_Latin1_General_CP1_CI_AS
    FROM mStudioPortal.dbo.MI_Common_Users
    WHERE Deleted = 0
      AND Deactivated = 0
),
RankedUsers AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY UserName
               ORDER BY
                   CreatedDate DESC,
                   CASE FromDB
                       WHEN 'mVStudio' THEN 1
                       WHEN 'mStudioBilling' THEN 2
                       WHEN 'mStudioPortal' THEN 3
                       ELSE 4
                   END
           ) AS RN
    FROM Users
),
FinalUsers AS
(
    SELECT
        FromDB,
        UserCode,
        UserName,
        Password,
        EmployeeCode,
        ChannelID,
        Portal,
        EHCM,
        Admin,
        UserType,
        Sec_Ques,
        Sec_Ans,
        Activation_Code,
        Mem_Activity,
        Blocked,
        DateCreated,
        IsTrialAcc,
        FirstLogon,
        Description,
        ADLogin,
        UGroupCode,
        Deactivated,
        Deleted,
        CreatedDate,
        CreatedUser,
        LastUpdateDate,
        LastUpdateUser,
        DeleteDate,
        DeleteUser,
        UserFullName,
        SalesCenterID,
        ContactNo,
        COALESCE(
            CASE
                WHEN UserName LIKE '%@%.%' THEN UserName
            END,
            CASE
                WHEN CHARINDEX('@', ISNULL(Description,'')) = 0 THEN NULL
                ELSE LTRIM(RTRIM(SUBSTRING(
                    Description,
                    CHARINDEX('@', Description) - (CHARINDEX(' ', REVERSE(LEFT(Description, CHARINDEX('@', Description) - 1)) + ' ') - 1),
                    (CHARINDEX(' ', REVERSE(LEFT(Description, CHARINDEX('@', Description) - 1)) + ' ') - 1) +
                    CASE
                        WHEN CHARINDEX(',', SUBSTRING(Description, CHARINDEX('@', Description), 100)) > 0
                             AND (
                                 CHARINDEX(' ', SUBSTRING(Description, CHARINDEX('@', Description), 100)) = 0
                                 OR CHARINDEX(',', SUBSTRING(Description, CHARINDEX('@', Description), 100))
                                    < CHARINDEX(' ', SUBSTRING(Description, CHARINDEX('@', Description), 100))
                             )
                        THEN CHARINDEX(',', SUBSTRING(Description, CHARINDEX('@', Description), 100)) - 1
                        ELSE CHARINDEX(' ', SUBSTRING(Description, CHARINDEX('@', Description), 100) + ' ') - 1
                    END
                )))
            END,
            CASE
                WHEN PortalEmail IS NOT NULL
                     AND PortalEmail <> ''
                THEN PortalEmail
            END
        ) AS CleanEmail
    FROM RankedUsers
    WHERE RN = 1
)

SELECT
    FromDB AS from_db,
    UserCode,
    UserName,
    Password,
    EmployeeCode,
    ChannelID,
    Portal,
    EHCM,
    Admin,
    UserType,
    Sec_Ques,
    Sec_Ans,
    Activation_Code,
    Mem_Activity,
    Blocked,
    DateCreated,
    IsTrialAcc,
    FirstLogon,
    Description,
    ADLogin,
    UGroupCode,
    Deactivated,
    Deleted,
    CreatedDate,
    CreatedUser,
    LastUpdateDate,
    LastUpdateUser,
    DeleteDate,
    DeleteUser,
    UserFullName,
    SalesCenterID,
    ContactNo,
    CleanEmail
INTO mVStudio.dbo.finalUsers
FROM FinalUsers
ORDER BY CreatedDate ASC, UserCode ASC;

CREATE CLUSTERED INDEX IX_finalUsers_CreatedDate
    ON mVStudio.dbo.finalUsers (CreatedDate ASC, UserCode ASC);
