require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SomethingWithFulltext do

	it 'should have proper tokens' do
		a = SomethingWithFulltext.new(:something => 'a')
		a.fulltext_index_tokens.should eql('a')
	end

	it 'should create the fulltext index' do
		a = SomethingWithFulltext.create!(:something => 'a')
		a.fulltext_index.attributes.should == {"tokens"=>"a", "indexable_type"=>"SomethingWithFulltext", "indexable_id"=>1, "id"=>1}
	end

	it 'should update the fulltext index' do
		b = SomethingWithFulltext.create!(:something => 'b')
		b.fulltext_index.attributes.should == {"tokens"=>"b", "indexable_type"=>"SomethingWithFulltext", "indexable_id"=>2, "id"=>2}
		b.update_attributes(:something_else => 'b2')
		b.fulltext_index.attributes.should == {"tokens"=>"b b2", "indexable_type"=>"SomethingWithFulltext", "indexable_id"=>2, "id"=>2}
	end

end