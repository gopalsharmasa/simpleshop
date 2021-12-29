# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Doorkeeper::Application.count.zero?
	application = Doorkeeper::Application.create({
						name: "Android client",
						scopes: "read write",
						confidential: false,
						redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
					})
	
	# get apps credientials
	# client_id of the application
	#Doorkeeper::Application.find_by(name: "Android client").uid

	# client_secret of the application
	#Doorkeeper::Application.find_by(name: "Android client").secret
end

role_admin = Role.create(title: "admin")
role_customer = Role.create(title: "customer")

user_admin = User.create(email: "user.admin@example.com", password: "123456", name: "Harry Potter")
user_customer = User.create(email: "user.customer@example.com", password: "123456", name: "Jack Martin")

# Customer role automatically assing to created user from callback in User model.
# We just need to assign admin role to user.
Assignment.create(user_id: user_admin.id, role_id: role_admin.id)

regions = Region.create([
				{ title: "Central Region", country: "Thailand", currency: "INR", tax: 10 },
				{ title: "East Region", country: "Thailand", currency: "INR", tax: 10 },
				{ title: "West Region", country: "Singapore", currency: "INR", tax: 10 },
				{ title: "South Region", country: "Singapore", currency: "INR", tax: 10 },
			])

shops = Shop.create([
				{ region_id: regions.first.id, title: "Zara Store"},
				{ region_id: regions.last.id, title: "Super Store"},
			])

products = Product.create([
				{
					title: "tshirt",
					description: "tshirt",
					image_url: "http://res.cloudinary.com/defenceplexus/image/upload/v1640348697/xmwzso30bm36ixdc5nmb.jpg",
					price: 320,
					sku: "pices",
					stock: 22,
					shop_id: shops.first.id
				},
				{
					title: "pants",
					description: "pants",
					image_url: "http://res.cloudinary.com/defenceplexus/image/upload/v1640348697/xmwzso30bm36ixdc5nmb.jpg",
					price: 350,
					sku: "pices",
					stock: 10,
					shop_id: shops.first.id
				},
				{
					title: "mugs",
					description: "mugs",
					image_url: "http://res.cloudinary.com/defenceplexus/image/upload/v1640348697/xmwzso30bm36ixdc5nmb.jpg",
					price: 300,
					sku: "pices",
					stock: 5,
					shop_id: shops.last.id
				},
				{
					title: "watches",
					description: "watches",
					image_url: "http://res.cloudinary.com/defenceplexus/image/upload/v1640348697/xmwzso30bm36ixdc5nmb.jpg",
					price: 400,
					sku: "pices",
					stock: 10,
					shop_id: shops.last.id
				},
			])