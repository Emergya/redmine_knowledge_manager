class UserKnowledgesController < ApplicationController
  unloadable

  before_filter :authorize_global, :only => [:show]
  autocomplete :knowledge, :name, :full => true, :extra_data => [:id]
  
  def show
    @user = User.current
    @main_knowledges = Knowledge.main_options
  end

  def new
    data = params[:user_knowledge]

    name = data.delete(:name)

    if !data[:knowledge_id].present?
      knowledge = Knowledge.where("lower(name) = ?", name.downcase) 
      if knowledge.present?
        data[:knowledge_id] = knowledge.first.id
      else
        knowledge = Knowledge.create({:name => name, :main => false})
        data[:knowledge_id] = knowledge.id
      end
    end

    @user_knowledge = UserKnowledge.new user_knowledge_params
    if @user_knowledge.save
      flash[:notice] = l(:notice_successful_create)
    else
      flash[:error] = @user_knowledge.get_error_message
    end

    redirect_to :action => 'show'
  end

  def destroy
    uk = UserKnowledge.find(params[:id])

    if uk.destroy
      flash[:notice] = l(:notice_successful_delete)
    else
      error_msg = ""
      uk.errors.full_messages.each do |msg|
        if error_msg != ""
          error_msg << "<br>"
        end
        error_msg << msg
      end

      flash[:error] = error_msg
    end

    redirect_to request.referrer
  end

  private
  def user_knowledge_params
    params.require(:user_knowledge).permit(:user_id, :knowledge_id, :level, knowledge_attributes: [:name, :main])
  end
end
