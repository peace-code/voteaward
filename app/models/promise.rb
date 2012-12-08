class Promise
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :candidate

  # fields
  field :seq, type: Integer
  field :reason
  field :area
  field :sex
  field :age

  # validation
  validates_presence_of :reason, :area, :sex, :age

  # scope
  default_scope desc(:_id)

  # callbacks
  before_create :assign_id

  private

  def assign_id
    self.seq = Sequence.generate_id(:promise)
  end
end