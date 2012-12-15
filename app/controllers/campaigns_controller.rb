class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = current_user.campaigns.build
  end

  def create
    @campaign = current_user.campaigns.build(params[:campaign])
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
    if @campaign.update_attributes(params[:campaign])
      redirect_to campaigns_path, notice: I18n.t('campaign.updated')
    else
      render action: 'edit'
    end
  end

  def destroy

  end
end