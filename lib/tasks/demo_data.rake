namespace :demo_data do

  desc 'Wipe DB data'
  task wipe: :environment do
    Answer.delete_all
    Question.delete_all
    User.delete_all
    Topic.delete_all
  end

  desc 'Fill DB with random data'
  task seed: :wipe do
    def get_random_batch(model_klass, max_batch_size = nil)
      total_count = model_klass.count
      offset = rand((total_count * 0.6).round)
      max_count = max_batch_size || (total_count * 0.3).round
      count = rand(max_count).succ
      model_klass.skip(offset).limit(count)
    end

    intros = ['How to', 'When it''s best to', 'Is it possible to', 'Does anybody']
    topics = 8.times.map do
      Topic.create(title: Faker::Commerce.unique.department)
    end

    20.times do
      user = User.create!(name: Faker::Name.name, title: Faker::Job.title) do |u|
        u.avatar_url = Faker::Avatar.image(u.name.parameterize)
        u.email = Faker::Internet.unique.email(u.name)
        u.password = u.password_confirmation = '111111111'
      end

      15.times do
        user.questions.create!(text: "#{intros.sample} #{Faker::Company.bs}?", anonymous: rand.round.zero?, topic: topics.sample)
      end
    end

    Question.all.each do |question|
      other_users = User.where(:id.ne => question.user_id)
      others_count = other_users.count.pred
      (3+rand(5)).times do
        random_user = other_users.skip(rand(others_count)).first
        question.answers.create!(user: random_user) do |a|
          a.text = Faker::Lorem.paragraph(2, true, 3)
        end
      end
    end

    get_random_batch(Question).each do |q|
      q.voters = get_random_batch(User, 9).pluck(:id)
      q.save!
    end
    get_random_batch(Question).each do |q|
      q.followers = get_random_batch(User, 9).pluck(:id)
      q.save!
    end

    get_random_batch(Answer).each do |a|
      a.voters = get_random_batch(User, 5).pluck(:id)
      a.save!
    end

    get_random_batch(User).each do |followed|
      get_random_batch(User, 6).each do |follower|
        followed.follow_by follower
      end
      followed.save!
    end

  end

end