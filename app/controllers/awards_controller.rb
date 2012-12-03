class AwardsController < ApplicationController
  def new
    @award = current_user.awards.build
  end

  def create
    @award = current_user.awards.build(params[:award])
    if @award.save
      redirect_to promises_path, notice: I18n.t('award.created')
    else
      render action: 'new'
    end
  end
end