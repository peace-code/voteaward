class Y2012::PagesController < Y2012::Y2012Controller
  def home
    past_election = Election.where(title: '제18대 대통령선거').first
    @promises_count = past_election.promises.count
    @awards_count = past_election.awards.count
    @votes_count = past_election.votes.count
    @events_count = past_election.events.count
  end

  def info
  end

  def discuss
  end
end
