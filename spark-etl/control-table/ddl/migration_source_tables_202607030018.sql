INSERT INTO target_analytics.migration_source_tables (migration_id,table_alias,source_schema,source_table,join_order,`filter`) VALUES
	 (1,'c','source_warehouse','raw_customer',1,NULL),
	 (2,'a','dbo','account',2,NULL),
	 (2,'ad','dbo','address',3,NULL),
	 (100,'fu','mVStudio','dbo.finalUsers',1,NULL),
	 (200,'b','mVStudio','dbo.MI_mBill_Banks',1,'Deleted = false');
