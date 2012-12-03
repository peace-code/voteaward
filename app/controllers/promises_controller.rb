class PromisesController < ApplicationController
  def index
    @promises = Promise.all
    @awards = Award.all
  end

  def new
    @promise = current_user.build_promise
  end

  def create
    @promise = current_user.build_promise(params[:promise])
    if @promise.save
      redirect_to promises_path, notice: I18n.t('promise.created')
    else
      render action: 'new'
    end
  end
end