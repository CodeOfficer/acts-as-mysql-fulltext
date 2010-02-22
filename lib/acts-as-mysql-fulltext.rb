module ActiveRecord
	module Acts #:nodoc:
		module MysqlFulltext #:nodoc:
			def self.included(base)
				base.extend(ClassMethods)
			end

			module ClassMethods
				def acts_as_mysql_fulltext()
					before_destroy :destroy_fulltext_index
					after_save :create_or_update_fulltext_index
					has_one :fulltext_index, :as => :indexable

					include ActiveRecord::Acts::MysqlFulltext::InstanceMethods
					extend	ActiveRecord::Acts::MysqlFulltext::SingletonMethods
				end

				def fulltext_index_columns
					self.columns.select {|c| c.type == :string}.map(&:name).map(&:to_sym)
				end
			end

			module SingletonMethods
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

			module InstanceMethods
				def build_fulltext_index
					self.class.fulltext_index_columns.inject([]) do |result, column|
						result.push read_attribute(column)
					end.join(' ')
				end

				def create_or_update_fulltext_index
					# create or update
				end

				def destroy_fulltext_index
					# destroy
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