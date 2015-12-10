FactoryGirl.define do
  factory :chef do
    chefname 'Jean Michel'
    email  'toto@toto.com'
    password 'password'
    admin false
  end
  
  factory :other_chef, :class => Chef do
    chefname 'Jean Paul'
    email  'tata@toto.com'
    password 'password'
    admin false 
  end
  
  factory :third_chef, :class => Chef do
    chefname 'Jean Luc'
    email  'toto@tata.com'
    password 'password'
    admin false 
  end
  
  factory :admin, :class => Chef do
    chefname 'Admin'
    email  'admin@toto.com'
    password 'password'
    admin true
  end
end