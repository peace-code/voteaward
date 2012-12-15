class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user

  # fields
  field :seq, type: Integer
  field :title
  field :content
  mount_uploader :image, ImageUploader

  # validation
  validates_presence_of :title, :content

  # scope
  default_scope desc(:_id)

  # callbacks
  before_create :assign_id

  # methods
  private

  def assign_id
    self.seq = Sequence.generate_id(:vote)
  end
end