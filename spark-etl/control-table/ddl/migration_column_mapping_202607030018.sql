INSERT INTO target_analytics.migration_column_mapping (migration_id,source_expression,target_column,transformation_expression,sequence_no) VALUES
	 (1,'c.customer_id','cust_id',NULL,1),
	 (1,'c.email','email','UPPER(c.email)',2),
	 (2,'a.account_no','account_no',NULL,3),
	 (2,'ad.city','city',NULL,4),
	 (2,'','migration_ts','current_timestamp()',5),
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
	 (400,'m.name','name',NULL,1),
	 (100,'UserFullName','name',NULL,1),
	 (100,'CleanEmail','email',NULL,2),
	 (100,'''''','password','''''',3),
	 (100,'UserName','username',NULL,4);
INSERT INTO target_analytics.migration_column_mapping (migration_id,source_expression,target_column,transformation_expression,sequence_no) VALUES
	 (100,'UserCode','legacy_ids','concat(''{"db":"'',from_db,''","id":"'',UserCode,''"}'')',5),
	 (100,'CreatedDate','created_at',NULL,6),
	 (100,'LastUpdateDate','updated_at',NULL,7),
	 (110,'u.username','username','',1),
	 (110,'u.usercode','legacy_ids','concat(''{"db":"mStudioPortal","id":"'',u.usercode,''"}'')',2),
	 (110,'''''','email','uuid()',3),
	 (110,'''''','password','''''',4),
	 (120,'u.username','username','',1),
	 (120,'u.usercode','legacy_ids','concat(''{"db":"mStudioPortal","id":"'',u.usercode,''"}'')',2),
	 (120,'''''','email','uuid()',3),
	 (120,'''''','password','''''',4);
