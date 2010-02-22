ActiveRecord::Schema.define(:version => 1) do
	drop_table :fulltext_indices rescue nil
	execute "CREATE TABLE `fulltext_indices` (
  `id` int(11) NOT NULL auto_increment,
  `indexable_type` varchar(60) NOT NULL,
  `indexable_id` int(11) NOT NULL,
  `tokens` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `indexable_type` (`indexable_type`,`indexable_id`),
  FULLTEXT KEY `tokens` (`tokens`)
  ) ENGINE=MyISAM;"
	create_table :something_with_fulltext, :force => true do |t|
		
	end
	create_table :something_without_fulltext, :force => true do |t|
		
	end
end