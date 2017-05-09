class Campaign
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :candidate

  # fields
  field :url
  field :title
  field :description
  mount_uploader :image, ImageUploader

  # validation
  validates_presence_of :url, :title, :description

  # scope
  default_scope -> { order(_id: :desc) }

  # callbacks
end
