module ActsAsMysqlFulltext
	module Index
		module InstanceMethods
			def find_all_matching(tokens, options)
				results = self.find(:all,
					:conditions => ["MATCH(tokens) AGAINST (? IN BOOLEAN MODE)", self.to_s, tokens.strip],
					:include => [:indexable])
				results.map(&:indexable)
			end
		end
	end
end