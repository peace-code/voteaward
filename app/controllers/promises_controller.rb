class PromisesController < ApplicationController
  def index
    @promises = Promise.all
  end

  def new
    @promise = current_user.build_promise
  end

  def create
    @promise = current_user.build_promise(promise_params)
    redirect_to promises_url
    # if @promise.save
    #   message = I18n.t('promise.share', username: current_user.name, reason: @promise.reason, seq: @promise.seq)
    #   if current_user.omniauth_provider == :twitter
    #     current_user.twitter.update([promises_url, message, I18n.t('g.hashtag')].join(' '))
    #   else
    #     current_user.facebook.put_wall_post(message, {name: I18n.t('g.title'), link: promises_url})
    #   end
    #   redirect_to promises_path, notice: I18n.t('promise.created')
    # else
    #   render action: 'new'
    # end
  end

  def show
    @promise = Promise.find(params[:id])
  end

  def edit
    @promise = current_user.promise
  end

  def update
    @promise = current_user.promise
    redirect_to promises_url if @promise.user != current_user
    if @promise.update_attributes(params[:promise])
      redirect_to promises_url, notice: I18n.t('promise.updated')
    else
      redirect_to promises_url
    end
  end

  def like
    @promise = Promise.find(params[:id])
    @promise.inc(:likes, 1)
  end

private
  def promise_params
    params.require(:promise).permit(:reason)
  end
end
