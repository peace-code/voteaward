class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  has_many :votes

  # fields
  field :title
  field :content
  field :limit, type: Integer, default: 10
  field :likes, type: Integer, default: 0
  mount_uploader :image, ImageUploader

  # validation
  validates_presence_of :title, :content

  # scope
  default_scope desc(:_id)
end