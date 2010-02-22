class SomethingWithFulltext < ActiveRecord::Base

	acts_as_mysql_fulltext

end

class SomethingWithoutFulltext < ActiveRecord::Base
	
	
	
end