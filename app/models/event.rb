class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :candidate

  # fields
  field :url
  field :title
  field :description

  # validation
  validates_presence_of :url, :title, :description

  # scope
  default_scope desc(:_id)

  # callbacks
end