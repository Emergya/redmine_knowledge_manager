class Knowledge < ActiveRecord::Base
  unloadable

  has_many :user_knowledge, :dependent => :destroy

  validates :name, presence: true, uniqueness: true

  def self.main_options
    Knowledge.where("main > 0").order('name').collect{|k| [k.name, k.id]}
  end

  def self.name_options(user = nil)
    not_allowed = [0]

  	if user.present?
  		knowledges = User.find(user).knowledges
      not_allowed = knowledges.collect{|k| k.id} if knowledges.present?
  	end

  	Knowledge.where("id NOT IN (?)",not_allowed).order('name').collect{|k| [k.name, k.id, k.main.present? ? {class: 'main_knowledge'} : {}]}
  end

  def self.level_options
  	[[l(:'km.label_low'), 0],[l(:'km.label_intermediate'), 1],[l(:'km.label_high'), 2]]
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