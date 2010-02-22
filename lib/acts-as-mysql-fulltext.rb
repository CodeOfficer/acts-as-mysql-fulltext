require 'rubygems'
require 'active_record'

module ActsAsMysqlFulltext
	autoload :Index,     'index/base'
	autoload :Indexable, 'indexable/base'
	def acts_as_mysql_fulltext
		include ActsAsMysqlFulltext::Indexable
	end
end

ActiveRecord::Base.extend ActsAsMysqlFulltext

class FulltextIndex < ActiveRecord::Base
	include ActsAsMysqlFulltext::Index
end