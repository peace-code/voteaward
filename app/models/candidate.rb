class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :election
  has_many :promises

  field :name
  field :party
  field :number

  validates_presence_of :name, :election_id

end
