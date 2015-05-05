class UserKnowledge < ActiveRecord::Base
  unloadable

  belongs_to :user
  belongs_to :knowledge

  validates :user_id, :presence => true
  validates :knowledge_id, :presence => true, uniqueness: { scope: :user_id}
  validates :level, :presence => true

  def name
  	self.knowledge.name
  end

  def level_name
    case (self.level)
    when 0
      l(:'km.label_low')
    when 1
      l(:'km.label_intermediate')      
    when 2
      l(:'km.label_high')
    end
  end

  def get_error_message
    error_msg = ""
    
    # get errors list
    self.errors.full_messages.each do |msg|
      if error_msg != ""
        error_msg << "<br>"
      end
      error_msg << msg
    end

    error_msg
  end
end