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
      current_user.facebook.put_wall_post(
        I18n.t('promise.share', username: current_user.name, reason: @promise.reason, seq: @promise.seq),
        {name: I18n.t('g.title'), link: promises_url}
      )
      redirect_to promises_path, notice: I18n.t('promise.created')
    else
      render action: 'new'
    end
  end

  def show
    @promise = Promise.find(params[:id])
  end

  def edit
    @promise = Promise.find(params[:id])
  end

  def update
    @promise = Promise.find(params[:id])
    redirect_to promises_url if @promise.user != current_user
    if @promise.update_attributes(params[:promise])
      redirect_to promises_url, notice: I18n.t('promise.updated')
    else
      redirect_to promises_url
    end
  end
end