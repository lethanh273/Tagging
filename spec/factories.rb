Factory.define :post do |post|
  post.title                  "thanh"
  post.body                 "gfresh"
end

Factory.define :user do |user|
  user.sequence(:email) { |n| "test#{n}@example.com" }

  #user.email                 "thanh@e1.com"
  user.password              "foobaraaa"
end

Factory.define :comment do |user|
  user.name                 "thanh@e.com"
  user.body              "foobar"
end


