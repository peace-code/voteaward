class Y2012::AwardsController < Y2012::Y2012Controller
  def index
    @awards = Award.where(election: current_election)
  end

  def new
    @award = Award.new(user: current_user, election: current_election)
  end

  def create
    @award = Award.new(award_params.merge({user: current_user, election: current_election}))
    if @award.save
      message = I18n.t('award.share', username: current_user.name, title: @award.title, content: @award.content, prize: @award.prize)
      if current_user.omniauth_provider == :twitter
        current_user.twitter.update([awards_url, message, I18n.t('g.hashtag')].join(' '))
      else
        current_user.facebook.put_wall_post(message, {name: I18n.t('g.title'), link: awards_url})
      end
      redirect_to awards_url, notice: I18n.t('award.created')
    else
      render action: 'new'
    end
  end

  def show
    @award = Award.find(params[:id])
    @award.comments.build
    @promises = Promise.where(user: @award.user, election: current_election)
  end

  def destroy
    @award = Award.find(params[:id])
    if current_user.admin? && @award.destroy
      redirect_to awards_url
    end
  end

  def edit
    @award = Award.find(params[:id])
    @promises = current_election.promises
  end

  def update
    award = Award.find(params[:id])
    if current_user.admin? || award.user == current_user
      award.update_attributes(award_params)
    end
    redirect_to award
  end

private
  def award_params
    params.require(:award).permit(:title, :content, :prize, :url, :address)
  end
end
