module ActsAsMysqlFulltext
	module Indexable
		module ClassMethods
			def fulltext_index_columns
				self.columns.select {|c| c.type == :string}.map(&:name).map(&:to_sym)
			end
			def search(tokens, options = {})
				# I have a green van, and a low battery ... NO I DO NOT HAVE A DOG!
				self.find(:all, options)
			end
			def create_fulltext_indices
				transaction do
					self.find(:all).each {|m| m.create_or_update_fulltext_index }
				end
			end
		end
	end
end