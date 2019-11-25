FactoryBot.define do

  factory :message do
    body      {"testtext"}
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/testimage.png'))}
    group
    user
  end

end