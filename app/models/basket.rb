# frozen_string_literal: true

class Basket < ActiveRecord::Base
  after_initialize :set_defaults

  STATUSES = {
    initiated: 'initiated',
    completed: 'completed',
    canceled: 'canceled'
  }.freeze

  validates :status, presence: true, inclusion: { in: STATUSES.values }

  has_many :basket_products, inverse_of: :basket
  has_many :products, through: :basket_products

  private def set_defaults
    self.status ||= STATUSES[:initiated]
    self.total_cents ||= 0
    self.total_paid_cents ||= 0
  end

  def total
    Money.new(total_cents, total_currency)
  end

  def total=(value)
    self.total_cents = value.cents
    self.currency = value.currency.iso_code
  end

  def total_paid
    Money.new(total_paid_cents, total_paid_currency)
  end

  def total_paid=(value)
    self.total_paid_cents = value.cents
    self.total_paid_currency = value.currency.iso_code
  end
end
