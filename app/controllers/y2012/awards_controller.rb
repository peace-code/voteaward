class Y2012::AwardsController < Y2012::ApplicationController
  def index
    @awards = Award.all
  end

  def new
    @award = current_user.awards.build
  end

  def create
    @award = current_user.awards.build(award_params)
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
  end

  def destroy
    @award = Award.find(params[:id])
    if current_user.admin? && @award.destroy
      redirect_to awards_url
    end
  end

  def edit
    @award = Award.find(params[:id])
  end

  def update
    award = Award.find(params[:id])
    if current_user.admin? || award.user == current_user
      award.update_attributes(params[:award])
    end
    redirect_to award
  end

private
  def award_params
    params.require(:award).permit(:title, :content, :prize)
  end
end
