use [pepa]
GO
GRANT SELECT ON [dbo].[piggy] TO [operador]
GO


select SYSTEM_USER LOGIN_ID, USER_NAME() USER_DB;
GO