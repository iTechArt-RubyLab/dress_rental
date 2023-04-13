class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def valid_date
    self.start_date < self.end_date
  end

  def duplicate_rental
    Rental.all.each do |rental|
      if rental.id != self.id 
        if rental.product == self.product
          if self.start_date <= rental.end_date && self.start_date >= rental.start_date || self.end_date <= rental.end_date && self.end_date >= rental.start_date
            true
          end
        end
      end
    end
  end

  def return_available_dates
    Rental.all.each do |rental|
      if self.start_date <= rental.end_date && self.start_date >= rental.start_date || self.end_date <= rental.end_date && self.end_date >= rental.start_date
        return "This product is rented between #{rental.start_date} and #{rental.end_date}. Please, choose another time!"
      end
    end
  end

  def revenue
    "#{(self.end_date - self.start_date).to_i * self.price} $)"
  end
end
