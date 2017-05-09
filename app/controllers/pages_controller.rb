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

  def count
    @diff = (Time.new(2017, 5, 9, 20, 0, 0, "+09:00") - Time.now).to_i
    render layout: false
    # Time.at(time_diff.round.abs).utc.strftime "%H:%M:%S"
  end
end
