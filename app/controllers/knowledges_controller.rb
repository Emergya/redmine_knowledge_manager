﻿class KnowledgesController < ApplicationController
  unloadable

  def show
    @knowledges = Knowledge.name_options
  end

  def new
    @knowledge = Knowledge.new knowledge_params

    if @knowledge.save
      flash[:notice] = l(:notice_successful_create)
    else
      flash[:error] = @knowledge.get_error_message
    end

    redirect_to :action => 'show'
  end

  def edit
    data = params[:knowledge]
    knowledge = Knowledge.find(data[:id])

    if knowledge.update_attributes knowledge_params
      flash[:notice] = l(:notice_successful_update)
    else
      error_msg = ""
      hup.errors.full_messages.each do |msg|
        if error_msg != ""
          error_msg << "<br>"
        end
        error_msg << msg
      end

      flash[:error] = error_msg
    end

    redirect_to request.referrer
  end

  def destroy
    data = params[:knowledge]
    knowledge = Knowledge.find(data[:id])

    if knowledge.destroy
      flash[:notice] = l(:notice_successful_delete)
    else
      error_msg = ""
      knowledge.errors.full_messages.each do |msg|
        if error_msg != ""
          error_msg << "<br>"
        end
        error_msg << msg
      end

      flash[:error] = error_msg
    end

    redirect_to request.referrer
  end

  def get_data
    knowledge = Knowledge.find(params[:id])

    if request.xhr?
      render :json => knowledge
    end
  end

  private
  def knowledge_params
    params.require(:knowledge).permit(:name, :main)
  end
end
