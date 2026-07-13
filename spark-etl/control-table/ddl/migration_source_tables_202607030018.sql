INSERT INTO target_analytics.migration_source_tables (migration_id,table_alias,source_schema,source_table,join_order,`filter`) VALUES
	 (1,'c','source_warehouse','raw_customer',1,NULL),
	 (2,'a','dbo','account',2,NULL),
	 (2,'ad','dbo','address',3,NULL),
	 (200,'b','mVStudio','dbo.MI_mBill_Banks',1,'Deleted = false'),
	 (300,'d','mStudioCommon','dbo.PODepartments',1,NULL),
	 (400,'m','mStudioCommon','dbo.MediaTypes',1,'deleted = false'),
	 (100,'billing','mStudioBilling','dbo.MI_Common_Users',1,'Deleted = false AND Deactivated = false'),
	 (100,'vstudio','mVStudio','dbo.MI_Common_Users',2,'Deleted = false AND Deactivated = false'),
	 (100,'portal','mStudioPortal','dbo.MI_Common_Users',3,'Deleted = false AND Deactivated = false');
