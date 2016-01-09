class Giveup
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user

  # fields
  field :reason
  field :area
  field :sex
  field :age

  # validation
  validates_presence_of :reason, :area, :sex, :age

  # scopes
  default_scope -> { order(_id: :desc) }
end
