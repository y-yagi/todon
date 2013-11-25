unless Tag.first
  Tag.create!(name: '仕事', deleted: false)
  Tag.create!(name: '趣味', deleted: false)
end
