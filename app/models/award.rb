class Award
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user

  #fields
  field :title
  field :condition
  field :prize

  # validations
  validates_presence_of :title, :condition, :prize

  # scopes
  default_scope desc(:_id)
end