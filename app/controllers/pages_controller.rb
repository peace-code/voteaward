class PagesController < ApplicationController
  def home
    @promises_count = current_election.promises.count
    @awards_count = current_election.awards.count
    @votes_count = current_election.votes.count
    @events_count = current_election.events.count
  end

  def info
  end

  def discuss
  end
end
