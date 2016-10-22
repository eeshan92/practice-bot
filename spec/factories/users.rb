FactoryGirl.define do
  factory :user do
    email 'eeshansim@gmail.com'
    password 'eeshansim' 
    authentication_token { "A1fd_pydJxjE3Qqe#{email[0..3]}" }
    invite_code 'never enough'
  end
end
