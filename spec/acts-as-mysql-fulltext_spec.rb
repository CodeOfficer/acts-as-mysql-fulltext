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
		[[ActsAsMysqlFulltext::Indexable, SomethingWithFulltext], [ActsAsMysqlFulltext::Index, FulltextIndex]].each do |(matching_module, matching_klass)|
			(klass == matching_klass).tap do |should_include|
				it "should #{'not' unless should_include} include #{matching_module}" do
					klass.include?(matching_module).should eql(should_include)
				end
				it "should #{'not' unless should_include} extend #{matching_module}::ClassMethods" do
					klass.is_a?(matching_module::ClassMethods).should eql(should_include)
				end
				it "should #{'not' unless should_include} include #{matching_module}::InstanceMethods" do
					klass.include?(matching_module::InstanceMethods).should eql(should_include)
				end
			end
		end
	end
end