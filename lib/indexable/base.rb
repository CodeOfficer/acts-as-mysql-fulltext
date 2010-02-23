module ActsAsMysqlFulltext
	module Indexable
		def self.included(base)
			autoload :ClassMethods,    'indexable/class_methods'
			autoload :InstanceMethods, 'indexable/instance_methods'
			base.class_eval do
				include InstanceMethods
				extend  ClassMethods
				after_save :create_or_update_the_fulltext_index
				has_one :fulltext_index, :as => :indexable, :dependent => :destroy
			end
		end
	end
end