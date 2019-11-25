FactoryBot.define do

  factory :message do
    body      {"testtext"}
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/testimage.png'))}
    group_id  {1}
    user_id   {1}
  end

end