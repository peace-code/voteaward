class Y2012::VotesController < Y2012::Y2012Controller
  def index
    @votes = Vote.all
    @events = Event.all
  end

  def new
    @vote = current_user.votes.build()
  end

  def create
    unless user_signed_in? && current_user.votes.empty?
      redirect_to votes_url
      return nil
    end

    @vote = current_user.votes.build(vote_params)
    if @vote.save
      message = I18n.t('vote.share', username: current_user.name, title: @vote.title, content: @vote.content, seq: @vote.seq)
      if current_user.omniauth_provider == :twitter
        current_user.twitter.update([vote_url(@vote), message, I18n.t('g.hashtag')].join(' '))
      else
        current_user.facebook.put_wall_post(message, {name: I18n.t('g.title'), link: vote_url(@vote)})
      end
      redirect_to votes_url, notice: I18n.t('vote.created')
    else
      render action: 'new'
    end
  end

  def edit
    @vote = current_user.votes.find(params[:id])
  end

  def update
    @vote = current_user.votes.find(params[:id])
    if @vote.update_attributes(vote_params)
     redirect_to votes_url, notice: I18n.t('vote.updated')
    else
      render action: 'edit'
    end
  end

  def show
    @vote = Vote.find(params[:id])
    @vote.comments.build
    @promises = @vote.user.promises
  end

  def like
    @vote = Vote.find(params[:id])
    @vote.inc(:likes, 1)
    @vote.event.inc(:likes, 1) unless @vote.event.blank?
  end

private
  def vote_params
    params.require(:vote).permit(:image, :title, :content, :event)
  end
end
