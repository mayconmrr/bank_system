class Statement < ApplicationRecord
  belongs_to :account
  
  def self.get_report(date={})
      Statement.where("created_at >= ? and created_at <= ?", date['begin'], date['end'])
  end
  
end
