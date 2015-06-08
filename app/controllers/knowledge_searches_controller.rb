class KnowledgeSearchesController < ApplicationController
  unloadable

  before_filter :authorize_global, :only => [:show]
  
  def show
    @knowledges_options = Knowledge.name_options
  	@users_options = User.all.sort_by{|u| u.login.downcase}.collect{|u| [u.login, u.id]}

    @knowledges_selected = params[:knowledges]
    @users_selected = params[:users]
    final_users_selected = params[:users] || User.all.collect{|u| u.id.to_s}

  	if params[:knowledges].present?
  		#@users = User.includes(:user_knowledges).where("user_knowledges.knowledge_id IN (?)", @knowledges_selected)
  		@users = User.joins(:user_knowledges).where("user_knowledges.knowledge_id IN (?) AND users.id IN (?)", @knowledges_selected, final_users_selected).select("users.*, count(*) AS count").group('users.id').sort_by{|e| -e.count}
  	end
  end
end