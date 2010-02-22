require 'rubygems'
require 'active_record'

module ActsAsMysqlFulltext

	def acts_as_mysql_fulltext
		include ActsAsMysqlFulltext::Indexable
	end
	
	module Indexable
		def self.included(base)
			base.class_eval do
				include InstanceMethods
				extend  ClassMethods
				after_save :create_or_update_fulltext_index
				has_one :fulltext_index, :as => :indexable, :dependent => :destroy
			end
		end
		
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

class FulltextIndex < ActiveRecord::Base
	belongs_to :indexable, :polymorphic => true

	def self.find_all_matching(tokens, options)
		results = self.find(:all,
			:conditions => ["MATCH(tokens) AGAINST (? IN BOOLEAN MODE)", self.to_s, tokens.strip],
			:include => [:indexable])
		results.map(&:indexable)
	end
end

ActiveRecord::Base.extend ActsAsMysqlFulltext