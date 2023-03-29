# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

def random_price
  rand(100..1000)
end


users = User.create(
  [
    { name: "Aathreya", age: 31, email: "athri@gmail.com" },
    { name: "Akhila", age: 23, email: "akhila@gmail.com" }
  ]
)

Product.create(name: "React", user: users.last, price: random_price)
Product.create(name: "JS", user: users.last, price: random_price)
Product.create(name: "HTML", user: users.last, price: random_price)
Product.create(name: "CSS", user: users.last, price: random_price)
Product.create(name: "Python", user: users.last, price: random_price)
Product.create(name: "GitLab", user: users.last, price: random_price)

Product.create(name: "Ruby", user: users.first, price: random_price)
Product.create(name: "Rails", user: users.first, price: random_price)
Product.create(name: "PostgreSQL", user: users.first, price: random_price)
Product.create(name: "Python", user: users.first, price: random_price)
Product.create(name: "GitHub", user: users.first, price: random_price)

(1..5).each do |_|
  invoice = Invoice.new(user: User.take)
  (1..10).each do |_|
    invoice.invoice_items.build(quantity: rand(1..10), product: Product.take)
  end
  invoice.save
end
