Rental.destroy_all
ProductCategory.destroy_all
Product.destroy_all
Category.destroy_all
Salon.destroy_all

user_owner = User.create!(
  first_name: 'Maria',
  last_name: 'Grechko',
  email: 'mariahrechka3@gmail.com',
  role_type: 'owner',
  phone: '+375293785894',
  address: 'Vostochnaya street, 40',
  password: 'strongPWD123'
)

user_admin = User.create!(
  first_name: 'Alex',
  last_name: 'Potapenko',
  email: 'wedding.salon777@gmail.com',
  role_type: 'admin',
  phone: '+375296107007',
  address: 'Korsh-sablina street, 33',
  password: 'strongPWD123'
)

user = User.create!(
  first_name: 'Darya',
  last_name: 'Mandrik',
  email: 'reexdeath@gmail.com',
  role_type: 'user',
  phone: '+375293336512',
  address: 'Yantarnaya street, 14',
  password: 'strongPWD123'
)

bride_salon = Salon.create!(
  name: 'Marianne',
  description: 'Welcome to our charming bridal salon! We offer a handpicked selection of beautiful wedding gowns and bridal accessories to make sure you look and feel your best on your special day. Come and discover your perfect dress in our cozy and intimate boutique.',
  owner_id: user_owner.id
)

groom_salon = Salon.create!(
  name: 'Freidreich',
  description: 'Our salon offers a range of services including haircuts, shaves, facials, grooming treatments, and even massages to help grooms look and feel their best. The atmosphere is masculine and relaxing, with comfortable seating and a friendly, experienced staff.',
  owner_id: user_owner.id
)

Product.create!([{
                   name: 'Valerie',
                   description: 'This stunning dress features delicate lace appliques and a sweetheart neckline, with a figure-flattering silhouette that accentuates your curves.',
                   price: 300,
                   salon_id: bride_salon.id
                  },
                  {
                    name: 'Anfisa',
                    description: 'Embrace your inner princess with this ethereal ballgown, complete with a delicate lace bodice and a full tulle skirt fit for a fairytale ending.',
                    price: 450,
                    salon_id: bride_salon.id
                   },
                   {
                    name: 'Amish suit',
                    description: 'A light gray suit with a simple five-button waistcoat and a white shirt with no tie and a wildflower boutonniere. The groomsmen are sans jackets and wear dark grey or black suspenders with dark solid colored and loosened ties.',
                    price: 990,
                    salon_id: groom_salon.id
                   }
                 ])

groom_category = Category.create!([{
                  name: 'Groom suits',
                  description: 'Discover our collection of stylish and comfortable groom suits, perfect for your big day. Made from high-quality materials with a range of styles, c
                  olors, and sizes to choose from, our suits are designed to make you look and feel your best. Whether you are going for a classic or modern look, we have the perfect suit for you.
                  Shop now and find the perfect groom suit for your wedding day.',
                  products: [Product.last]
                 }])

bride_category = Category.create!([{
                  name: 'Bridal dresses',
                  description: 'Get ready to say "I do" in style with our stunning collection of bridal dresses. With a variety of styles, colors, and sizes to choose from, you are sure to find the perfect dress to make your special day even more magical. From timeless classics to modern designs, our dresses are crafted from the finest materials to ensure that you look and feel your best. Whether you are dreaming of a grand ballgown or a sleek and elegant sheath, we have the perfect dress for you. Shop now and find your dream bridal dress today.',
                  products: Product.first(2)
                 }])


