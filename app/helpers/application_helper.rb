module ApplicationHelper
  def current_election
    Election.where(title: '제19대 대통령선거').first
  end
end
