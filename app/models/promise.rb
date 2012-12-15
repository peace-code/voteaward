class Promise
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :candidate

  # fields
  field :show_candidate, type: Boolean, default: true
  field :seq, type: Integer
  field :reason
  field :area
  field :sex
  field :age
  field :likes, type: Integer, default: 0

  # validation
  validates_presence_of :reason, :area, :sex, :age
  validates_uniqueness_of :user_id

  # scope
  default_scope desc(:_id)

  # callbacks
  before_create :assign_id

  private

  def assign_id
    self.seq = Sequence.generate_id(:promise)
  end
end