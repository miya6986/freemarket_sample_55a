crumb :root do
  link "メルカリ", root_path
end

crumb :product_show do |product|
  link product.name, product_path(product)
  parent :root
end

crumb :product_edit do |product|
  link product.name, edit_product_path(product)
  parent :root
end

crumb :mypage do 
  link "マイページ", users_path
  parent :root
end

crumb :likes do 
  link "いいね！一覧", likes_path
  parent :mypage
end

crumb :selling_products_users do 
  link "出品した商品 - 出品中", selling_products_users_path
  parent :mypage
end

crumb :sold_products_users do 
  link "出品した商品 - 売却済", sold_products_users_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", edit_user_path
  parent :mypage
end

crumb :creditcards_index do
  link "支払い方法", creditcards_path
  parent :mypage
end

crumb :identification_users do
  link "本人情報の登録", identification_users_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_page_users_path
  parent :mypage
end

crumb :category_index do 
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :category_show do |category|
  link category.name, category_path(category)
  parent :category_index
end


