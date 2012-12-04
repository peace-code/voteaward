class GiveupsController < ApplicationController
  def index
    @giveups = Giveup.all
    @giveup = current_user.build_giveup if user_signed_in?
  end

  def create
    @giveup = current_user.build_giveup(params[:giveup])
    if @giveup.save
      redirect_to giveups_url, notice: I18n.t('giveup.created')
    else
      redirect_to giveups_url, notice: 'error'
    end
  end

  def destroy
  end
end