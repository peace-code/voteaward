class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :promises
  field :name
  field :party
  field :number
end