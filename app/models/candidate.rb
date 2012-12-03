class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :promises
end