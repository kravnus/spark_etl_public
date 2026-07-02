INSERT INTO target_analytics.migration_source_tables (migration_id,table_alias,source_schema,source_table,join_order,`filter`) VALUES
	 (1,'c','source_warehouse','raw_customer',1,NULL),
	 (2,'a','dbo','account',2,NULL),
	 (2,'ad','dbo','address',3,NULL),
	 (200,'b','mStudioCommon','dbo.banks',1,'deleted == False'),
	 (300,'d','mStudioCommon','dbo.PODepartments',1,NULL),
	 (400,'m','mStudioCommon','dbo.MediaTypes',1,'deleted == False'),
	 (100,'u','mStudioBilling','dbo.MI_Common_Users',1,'deleted == False'),
	 (110,'u','mVStudio','dbo.MI_Common_Users',1,'deleted == False'),
	 (120,'u','mStudioPortal','dbo.MI_Common_Users',1,'deleted == False');
