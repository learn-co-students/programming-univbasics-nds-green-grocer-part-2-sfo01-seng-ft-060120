require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  discounted_cart = []
  discounted_item = {}
  cart.each do |cart_item|
    current_item = find_item_by_name_in_collection(cart_item[:item], coupons)
    if current_item
      if cart_item[:count] == current_item[:num]
        cart_item[:count] -= current_item[:num]
        discounted_cart << cart_item
        discounted_item = {
          :item => cart_item[:item] + " W/COUPON",
          :price => current_item[:cost] / current_item[:num],
          :clearance => cart_item[:clearance],
          :count => current_item[:num]
        }
        discounted_cart << discounted_item
      elsif cart_item[:count] > current_item[:num]
        cart_item[:count] -= current_item[:num]
        discounted_cart << cart_item
        discounted_item = {
          :item => cart_item[:item] + " W/COUPON",
          :price => current_item[:cost] / current_item[:num],
          :clearance => cart_item[:clearance],
          :count => current_item[:num]
        }
        discounted_cart << discounted_item
      end 
    else 
      discounted_cart << cart_item
    end 
  end 
  discounted_cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length 
    if cart[counter][:clearance]
      cart[counter][:price] = cart[counter][:price] - (cart[counter][:price] * 0.2)
    end 
    counter += 1
  end 
  cart
end

def checkout(cart, coupons)
  total = 0
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  clearanced_cart.each do |cart_item|
    total += cart_item[:price] * cart_item[:count]
  end 
  if total > 100 
    total *= 0.9
  end 
  total
end
