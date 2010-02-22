class CreateFulltextIndices < ActiveRecord::Migration
  def self.up
    execute "CREATE TABLE `fulltext_indices` (
    `id` int(11) NOT NULL auto_increment,
    `indexable_type` varchar(60) NOT NULL,
    `indexable_id` int(11) NOT NULL,
    `tokens` text NOT NULL,
    PRIMARY KEY  (`id`),
    KEY `indexable_type` (`indexable_type`,`indexable_id`),
    FULLTEXT KEY `tokens` (`tokens`)
    ) ENGINE=MyISAM;"
  end

  def self.down
    drop_table :fulltext_indices
  end
end
