INSERT INTO target_analytics.migration_joins (migration_id,left_alias,right_alias,join_type,join_condition) VALUES
	 (2,'c','a','LEFT','c.customer_id = a.customer_id'),
	 (2,'c','ad','LEFT','c.customer_id = ad.customer_id');
