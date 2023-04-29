SEED_DATA = 100

SEED_DATA.times do |n|
  Article.create(
    id: n + 1,
    title: "test#{n + 1}",
    content: "テストだよ",
    status: 'public'
  )
end