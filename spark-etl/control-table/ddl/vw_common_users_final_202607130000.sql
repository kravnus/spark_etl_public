CREATE OR ALTER VIEW dbo.vw_common_users_final AS
WITH Users AS
(
    SELECT CAST('mStudioBilling' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS AS FromDB,
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
           CAST(NULL AS VARCHAR(255)) COLLATE SQL_Latin1_General_CP1_CI_AS AS PortalEmail
    FROM mStudioBilling.dbo.MI_Common_Users
    WHERE Deleted = 0 AND Deactivated = 0

    UNION ALL

    SELECT CAST('mVStudio' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS,
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
           CAST(NULL AS VARCHAR(255)) COLLATE SQL_Latin1_General_CP1_CI_AS AS PortalEmail
    FROM mVStudio.dbo.MI_Common_Users
    WHERE Deleted = 0 AND Deactivated = 0

    UNION ALL

    SELECT CAST('mStudioPortal' AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CI_AS,
           UserCode,
           UserName COLLATE SQL_Latin1_General_CP1_CI_AS,
           Password COLLATE SQL_Latin1_General_CP1_CI_AS,
           CAST(NULL AS INT) AS EmployeeCode,
           CAST(NULL AS INT) AS ChannelID,
           CAST(NULL AS BIT) AS Portal,
           CAST(NULL AS BIT) AS EHCM,
           CAST(NULL AS BIT) AS Admin,
           UserType,
           Sec_Ques COLLATE SQL_Latin1_General_CP1_CI_AS,
           Sec_Ans COLLATE SQL_Latin1_General_CP1_CI_AS,
           Activation_Code COLLATE SQL_Latin1_General_CP1_CI_AS,
           CAST(NULL AS BIT) AS Mem_Activity,
           Blocked,
           DateCreated COLLATE SQL_Latin1_General_CP1_CI_AS AS DateCreated,
           IsTrialAcc,
           FirstLogon,
           Description COLLATE SQL_Latin1_General_CP1_CI_AS AS Description,
           CAST(NULL AS VARCHAR(100)) COLLATE SQL_Latin1_General_CP1_CI_AS AS ADLogin,
           UGroupCode,
           Deactivated,
           Deleted,
           CreatedDate,
           CreatedUser,
           LastUpdateDate,
           LastUpdateUser,
           DeleteDate,
           DeleteUser,
           FullName COLLATE SQL_Latin1_General_CP1_CI_AS AS UserFullName,
           SalesCenterID,
           Email COLLATE SQL_Latin1_General_CP1_CI_AS AS PortalEmail
    FROM mStudioPortal.dbo.MI_Common_Users
    WHERE Deleted = 0 AND Deactivated = 0
),
RankedUsers AS
(
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY UserName
               ORDER BY CreatedDate DESC,
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
    SELECT *
    FROM RankedUsers
    WHERE RN = 1
)
SELECT *
FROM FinalUsers;