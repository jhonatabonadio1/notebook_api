class ContactSerializer < ActiveModel::Serializer
  attributes :id, :email, :birthdate #, :author

  # def author
  #   "Jhonata Bonadio"
  # end

  #Associações
  belongs_to :kind do
    link(:related) {kind_url(object.kind.id)}
  end
  has_many :phones
  has_one :address

  link(:self) {contact_url(object.id)}

  meta do
    {author: "Jhonata"}
  end

  def attributes(*args)
    h = super(*args)
    #h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end

end
