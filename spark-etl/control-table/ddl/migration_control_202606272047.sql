INSERT INTO target_analytics.migration_control (migration_id,migration_name,target_table,load_type,watermark_column,last_successful_load,write_mode,enabled) VALUES
	 (1,'Customer Profile Migration','customer_profile','FULL','c.updated_date','2026-06-24 11:46:20','append',0),
	 (200,'Bank','bank','FULL',NULL,NULL,'append',1),
	 (300,'Departments','departments','FULL',NULL,NULL,'append',1),
	 (400,'Media Types','media_type','FULL',NULL,NULL,'append',1);
