require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  if coupons.length > 0
    coupons.each do |coupon|
      cart.each do |item|
        if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
          item[:count] = (item[:count] - coupon[:num])
            
        clearance_state = item[:clearance]
            
        cart << {
          :item => "#{coupon[:item]} W/COUPON",
          :price => (coupon[:cost] / coupon[:num]).round(2),
          :clearance => clearance_state,
          :count => coupon[:num]
        }
        end
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true
      discounted_price = (item[:price] * 0.8)
      item[:price] = discounted_price.round(2)
    end
  end
end

def checkout(cart, coupons)
  
  grand_total = 0

  consolidated_cart = consolidate_cart(cart)
  cart_with_applied_coupons = apply_coupons(consolidated_cart,coupons)
  cart_with_clearance = apply_clearance(cart_with_applied_coupons)
  
  cart_with_clearance.each do |item_overview|
    grand_total += (item_overview[:price] * item_overview[:count])
  end
  
  if grand_total > 100
    grand_total *= 0.9
  end

  grand_total.round(2)

end
