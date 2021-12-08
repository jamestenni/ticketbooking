class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :ticket_available?

  def ticket_available?
    if self.product.nil? or self.product.type != "Ticket"
      return
    end
    if self.product.is_owned?
      errors.add :product, "(ticket has already taken)"
    end
  end
end
