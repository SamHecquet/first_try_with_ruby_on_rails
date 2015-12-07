FactoryGirl.define do
  factory :chef do
    chefname 'Jean Michel'
    email  'toto@toto.com'
    password 'password'
    admin false
  end
  
  factory :admin, :class => Chef do
    chefname 'Admin'
    email  'toto@toto.com'
    password 'password'
    admin true
  end
end