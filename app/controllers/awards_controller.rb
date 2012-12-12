class AwardsController < ApplicationController
  def index
    @awards = Award.all
  end

  def new
    @award = current_user.awards.build
  end

  def create
    @award = current_user.awards.build(params[:award])
    if @award.save
      current_user.facebook.put_wall_post(
        I18n.t('award.share', username: current_user.name, title: @award.title, content: @award.content, prize: @award.prize),
        { name: I18n.t('g.title'), link: awards_url }
      )
      redirect_to awards_url, notice: I18n.t('award.created')
    else
      render action: 'new'
    end
  end

  def destroy
    @award = Award.find(params[:id])
    if current_user.admin? && @award.destroy
      redirect_to awards_url
    end
  end
end