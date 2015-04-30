class Knowledge < ActiveRecord::Base
  unloadable

  has_many :user_knowledge

  def self.name_options(user = nil)
    not_allowed = [0]

  	if user.present?
  		knowledges = User.find(user).knowledges
      not_allowed = knowledges.collect{|k| k.id} if knowledges.present?
  	end

  	Knowledge.where("id NOT IN (?)",not_allowed).collect{|k| [k.name, k.id, k.main.present? ? {style: 'color:red'} : {style: 'color:black'}]}
  end

  def self.level_options
  	(1..3).to_a
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