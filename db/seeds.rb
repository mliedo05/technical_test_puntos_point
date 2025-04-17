# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts '🌱 Seed iniciado...'

# Limpiar datos anteriores
[Admin, Client, Category, Product, Purchase, ProductCategory].each(&:destroy_all)

# Crear Admins
puts 'Creando Admins...'
admins = 10.times.map do |i|
  Admin.create!(
    name: "Admin #{i + 1}",
    email: "admin#{i + 1}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

# Crear Clients
puts 'Creando Clients...'
clients = 50.times.map do |i|
  Client.create!(
    name: "Client #{i + 1}",
    email: "client#{i + 1}@example.com",
    phone: "555-12#{format('%03d', i)}",
    address: "Calle Falsa #{i + 1}",
    password: 'password',
    password_confirmation: 'password'
  )
end

# Crear Categorías
puts 'Creando Categorías...'
categories = 20.times.map do |i|
  Category.create!(
    name: "Categoría #{i + 1}",
    description: "Descripción detallada de la categoría #{i + 1}",
    admin: admins.sample
  )
end

# Crear Productos
puts 'Creando Productos...'
products = 100.times.map do |i|
  product = Product.create!(
    name: "Producto #{i + 1}",
    description: "Descripción extensa del producto #{i + 1}, que es excelente y útil.",
    price: rand(500..20_000),
    stock: rand(10..100),
    admin: admins.sample
  )

  # Asociar a 1-4 categorías
  product.categories << categories.sample(rand(1..4))
  product
end

# Crear Compras
puts 'Creando Compras...'
200.times do
  client = clients.sample
  product = products.sample
  quantity = rand(1..10)

  Purchase.create!(
    client: client,
    product: product,
    quantity: quantity,
    total_price: product.price * quantity
  )
end

puts '✅ Seed finalizado con éxito con:'
puts "- #{Admin.count} Admins"
puts "- #{Client.count} Clients"
puts "- #{Category.count} Categorías"
puts "- #{Product.count} Productos"
puts "- #{Purchase.count} Compras"
puts "- #{ProductCategory.count} Relaciones Producto-Categoría"
