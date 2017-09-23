FactoryGirl.define do
  factory :service do
  	name {FFaker::NameMX.full_name}
  	initial_price {((rand + 1)*100).round(2)}
  	subsequent_price {((rand + 1)*100).round(2)}
  	community_price {((rand + 1)*100).round(2)}
    
  end
end
