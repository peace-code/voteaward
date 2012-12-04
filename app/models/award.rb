class Award
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user

  #fields
  field :title
  field :content
  field :prize

  # validations
  validates_presence_of :title, :content, :prize

  # scopes
  default_scope desc(:_id)
end