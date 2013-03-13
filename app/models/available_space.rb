class AvailableSpace < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.total_aval_space

   	OrderSetting.last.maximum_space
  end	
end
