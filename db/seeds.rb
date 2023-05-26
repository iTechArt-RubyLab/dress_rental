Salon.destroy_all
Product.destroy_all
Category.destroy_all

if User.find_by(email: 'mariahrechka3@gmail.com').destroy
  user = User.create!(
    email: 'mariahrechka3@gmail.com',
    role_type: 'owner',
    password: 'strongPWD123'
  )
end

salon = Salon.create!(
  name: 'Marianne',
  description: 'Welcome to our charming bridal salon! We offer a handpicked selection of beautiful wedding gowns and bridal accessories to make sure you look and feel your best on your special day. Come and discover your perfect dress in our cozy and intimate boutique.',
  owner_id: user.id
)

Product.create!([{
                   name: 'Valerie',
                   description: 'This stunning dress features delicate lace appliques and a sweetheart neckline, with a figure-flattering silhouette that accentuates your curves.',
                   price: 300,
                   salon_id: salon.id
                  }
                 ])