module ActiveRecord
	module Acts #:nodoc:
		module MysqlFulltext #:nodoc:
			def self.included(base)
				base.extend(ClassMethods)
			end

			module ClassMethods
				def acts_as_mysql_fulltext()
					before_destroy :remove_index
					after_save :update_index
					has_one :fulltext_index, :as => :indexable

					include ActiveRecord::Acts::MysqlFulltext::InstanceMethods
					extend ActiveRecord::Acts::MysqlFulltext::SingletonMethods
				end

				def indexed_columns
				  self.columns.select {|c| c.type == :string}.map(&:name).map(&:to_sym)
				end
			end

			module SingletonMethods
				def search(tokens, options = {})
          # insert magic here
					self.find(:all, options)
				end

				def insert_indexes
					transaction do
						self.find(:all).each {|m| m.insert_index }
					end
				end
			end

			module InstanceMethods
				def build_fulltext_index
					self.class.indexed_columns.inject([]) do |result, column|
					  result.push read_attribute(column)
				  end.join(' ')
				end

				def update_index
          # update or create
				end

				def remove_index
          # remove
				end
			end
		end
	end
end

class FulltextIndex < ActiveRecord::Base
	belongs_to :indexable, :polymorphic => true

	def self.find_all_matching(tokens, options)
		results = self.find(:all,
      :conditions => ["MATCH(tokens) AGAINST (? IN BOOLEAN MODE)", self.to_s, tokens.strip],
      :include => [:indexable])
		results.map(&:indexable)
	end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::MysqlFulltext)