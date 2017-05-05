class Election
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :candidates
  has_many :promises
  has_many :sequences
  has_many :votes
  has_many :awards
  has_many :events

  field :title
  field :content

  validates_presence_of :title, :content

  default_scope -> { order(_id: :desc) }
end
