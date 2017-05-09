class Y2012::Y2012Controller < ActionController::Base
  layout 'y2012'
  protect_from_forgery

  def current_election
    Election.where(title: '제18대 대통령선거').first
  end
end
