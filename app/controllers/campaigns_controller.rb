class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = current_user.campaigns.build
  end

  def create
    @campaign = current_user.campaigns.build(campaign_params)
    if @campaign.save
      redirect_to campaigns_path, notice: I18n.t('campaign.created')
    else
      render action: 'new'
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(campaign)
      redirect_to campaigns_path, notice: I18n.t('campaign.updated')
    else
      render action: 'edit'
    end
  end

  def destroy

  end

private
  def campaign_params
    params.require(:campaign).permit()
  end
end
