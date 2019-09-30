
User.create email: 'example@example.com', password: '123456'

31.times do
  Product.create title: FFaker::Product.product_name,
                 brand: FFaker::Product.brand,
                 description: FFaker::Product.product,
                 price: rand(9..99)
end