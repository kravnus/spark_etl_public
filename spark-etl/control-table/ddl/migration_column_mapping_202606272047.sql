INSERT INTO target_analytics.migration_column_mapping (migration_id,source_expression,target_column,transformation_expression,sequence_no) VALUES
	 (1,'c.customer_id','cust_id',NULL,1),
	 (1,'c.email','email','UPPER(c.email)',2),
	 (2,'a.account_no','account_no',NULL,3),
	 (2,'ad.city','city',NULL,4),
	 (2,NULL,'migration_ts','current_timestamp()',5),
	 (1,'c.first_name','first_name',NULL,3),
	 (1,'c.last_name','last_name',NULL,4),
	 (200,'b.bankName','bank_name',NULL,1),
	 (200,'b.bankCode','bank_code',NULL,2),
	 (200,'''''','account_no',NULL,3);
INSERT INTO target_analytics.migration_column_mapping (migration_id,source_expression,target_column,transformation_expression,sequence_no) VALUES
	 (200,'''''','beneficiary_name',NULL,4),
	 (200,'''''','bank_address',NULL,5),
	 (200,'0','bank_branch',NULL,6),
	 (200,'0','user_id',NULL,7),
	 (300,'d.department','name',NULL,1),
	 (400,'m.name','name',NULL,1);
