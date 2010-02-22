require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveRecord do
	it 'should extend our module' do
		ActiveRecord::Base.is_a?(ActsAsMysqlFulltext).should be_true
	end
end

[SomethingWithFulltext, SomethingWithoutFulltext].each do |klass|
	describe klass do
		it 'should extend our module' do
			klass.is_a?(ActsAsMysqlFulltext).should be_true
		end
		it 'should respond to acts_as_mysql_fulltext' do
			klass.respond_to?(:acts_as_mysql_fulltext).should be_true
		end
		it "should#{(klass == SomethingWithoutFulltext) && ' not' || ''} include ActsAsMysqlFulltext::Indexable" do
			klass.include?(ActsAsMysqlFulltext::Indexable).should eql(klass != SomethingWithoutFulltext)
		end
		it "should#{(klass == SomethingWithoutFulltext) && ' not' || ''} extend ActsAsMysqlFulltext::Indexable::ClassMethods" do
			klass.is_a?(ActsAsMysqlFulltext::Indexable::ClassMethods).should eql(klass != SomethingWithoutFulltext)
		end
		it "should#{(klass == SomethingWithoutFulltext) && ' not' || ''} include ActsAsMysqlFulltext::Indexable::InstanceMethods" do
			klass.include?(ActsAsMysqlFulltext::Indexable::InstanceMethods).should eql(klass != SomethingWithoutFulltext)
		end
		
		it "should not include ActsAsMysqlFulltext::Index" do
			klass.include?(ActsAsMysqlFulltext::Index).should be_false
		end
		it "should not extend ActsAsMysqlFulltext::Index::ClassMethods" do
			klass.is_a?(ActsAsMysqlFulltext::Index::ClassMethods).should be_false
		end
		it "should not include ActsAsMysqlFulltext::Index::InstanceMethods" do
			klass.include?(ActsAsMysqlFulltext::Index::InstanceMethods).should be_false
		end
	end
end

describe FulltextIndex do
	
	it 'should extend our module' do
		FulltextIndex.is_a?(ActsAsMysqlFulltext).should be_true
	end
	it 'should respond to acts_as_mysql_fulltext' do
		FulltextIndex.respond_to?(:acts_as_mysql_fulltext).should be_true
	end
	it "should not include ActsAsMysqlFulltext::Indexable" do
		FulltextIndex.include?(ActsAsMysqlFulltext::Indexable).should be_false
	end
	it "should not extend ActsAsMysqlFulltext::Indexable::ClassMethods" do
		FulltextIndex.is_a?(ActsAsMysqlFulltext::Indexable::ClassMethods).should be_false
	end
	it "should not include ActsAsMysqlFulltext::Indexable::InstanceMethods" do
		FulltextIndex.include?(ActsAsMysqlFulltext::Indexable::InstanceMethods).should be_false
	end
	
	it "should include ActsAsMysqlFulltext::Index" do
		FulltextIndex.include?(ActsAsMysqlFulltext::Index).should be_true
	end
	it "should extend ActsAsMysqlFulltext::Index::ClassMethods" do
		FulltextIndex.is_a?(ActsAsMysqlFulltext::Index::ClassMethods).should be_true
	end
	it "should include ActsAsMysqlFulltext::Index::InstanceMethods" do
		FulltextIndex.include?(ActsAsMysqlFulltext::Index::InstanceMethods).should be_true
	end
	
end