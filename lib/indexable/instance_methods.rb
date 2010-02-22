module ActsAsMysqlFulltext
	module Indexable
		module InstanceMethods
			def fulltext_index_tokens
				self.class.fulltext_index_columns.map do |column|
					read_attribute(column)
				end.join(' ').strip
			end
			def create_or_update_fulltext_index
				fulltext_index && fulltext_index.update_attribute(:tokens, fulltext_index_tokens) || 
				                  build_fulltext_index(:tokens => fulltext_index_tokens)
			end
		end
	end
end