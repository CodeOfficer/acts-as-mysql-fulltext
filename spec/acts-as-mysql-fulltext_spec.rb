require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveRecord do
	it 'should extend our module' do
		ActiveRecord::Base.is_a?(ActsAsMysqlFulltext).should be_true
	end
end

[SomethingWithFulltext, SomethingWithoutFulltext, FulltextIndex].each do |klass|
	describe klass do
		it 'should extend our module' do
			klass.is_a?(ActsAsMysqlFulltext).should be_true
		end
		it 'should respond to acts_as_mysql_fulltext' do
			klass.respond_to?(:acts_as_mysql_fulltext).should be_true
		end
		it "should#{(klass != SomethingWithFulltext) && ' not' || ''} include ActsAsMysqlFulltext::Indexable" do
			klass.include?(ActsAsMysqlFulltext::Indexable).should eql(klass == SomethingWithFulltext)
		end
		it "should#{(klass != SomethingWithFulltext) && ' not' || ''} extend ActsAsMysqlFulltext::Indexable::ClassMethods" do
			klass.is_a?(ActsAsMysqlFulltext::Indexable::ClassMethods).should eql(klass == SomethingWithFulltext)
		end
		it "should#{(klass != SomethingWithFulltext) && ' not' || ''} include ActsAsMysqlFulltext::Indexable::InstanceMethods" do
			klass.include?(ActsAsMysqlFulltext::Indexable::InstanceMethods).should eql(klass == SomethingWithFulltext)
		end
		it "should#{(klass != FulltextIndex) && ' not' || ''} include ActsAsMysqlFulltext::Index" do
			klass.include?(ActsAsMysqlFulltext::Index).should eql(klass == FulltextIndex)
		end
		it "should#{(klass != FulltextIndex) && ' not' || ''} extend ActsAsMysqlFulltext::Index::ClassMethods" do
			klass.is_a?(ActsAsMysqlFulltext::Index::ClassMethods).should eql(klass == FulltextIndex)
		end
		it "should#{(klass != FulltextIndex) && ' not' || ''} include ActsAsMysqlFulltext::Index::InstanceMethods" do
			klass.include?(ActsAsMysqlFulltext::Index::InstanceMethods).should eql(klass == FulltextIndex)
		end
	end
end