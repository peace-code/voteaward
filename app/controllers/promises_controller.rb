class PromisesController < ApplicationController
  before_action :current_candidates
  before_action :current_promises, only: [:index]

  def index
  end

  def new
    @promise = Promise.new(user: current_user, election: current_election)
  end

  def create
    @promise = Promise.new(promise_params.merge({user: current_user, election: current_election, }))
    if @promise.save
      message = I18n.t('promise.share', username: current_user.name, reason: @promise.reason, seq: @promise.seq)
      # if current_user.omniauth_provider == :twitter
      #   current_user.twitter.update([promises_url, message, I18n.t('g.hashtag')].join(' '))
      # else
      #   current_user.facebook.put_wall_post(message, {name: I18n.t('g.title'), link: promises_url})
      # end
      redirect_to promises_path, notice: I18n.t('promise.created')
    else
      render action: 'new'
    end
  end

  def show
    @promise = Promise.find(params[:id])
  end

  def edit
    @promise = Promise.where(user: current_user, election: current_election).first
  end

  def update
    @promise = Promise.where(user: current_user, election: current_election).first
    redirect_to promises_url if @promise.user != current_user
    if @promise.update_attributes(promise_params)
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
    params.require(:promise).permit(:reason, :area, :sex, :age, :candidate_id, :show_candidate)
  end

  def current_candidates
    @candidates = current_election.candidates
  end

  def current_promises
    @promises = current_election.promises
  end
end
