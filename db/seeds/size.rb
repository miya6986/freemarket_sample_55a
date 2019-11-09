# 洋服のサイズ
clothes = Size.create(kind: "洋服のサイズ")
clothes_content = clothes.children.create([{kind: "XXS以下"},{kind: "XS(SS)"},{kind: "S"},{kind: "M"},{kind: "L"},{kind: "XL(LL)"},{kind: "２XL(3L)"},{kind: "３XL(4L)"},{kind: "４XL(5L)以上"},{kind: "FREE SIZE"}])

# 子供服のサイズ
clothes_child = Size.create(kind: "子供服のサイズ")
clothes_child_content = clothes_child.children.create([{kind:"60cm"},{kind:"70cm"},{kind:"80cm"},{kind:"90cm"},{kind:"95cm"},{kind:"100cm"},{kind:"110cm"},{kind:"120cm"},{kind:"130cm"},{kind:"140cm"},{kind:"150cm"},{kind:"160cm"}])

# 女性靴のサイズ
lady_shoes = Size.create(kind:"女性靴のサイズ")
lady_shoes_content = lady_shoes.children.create([{kind:"20cm以下"},{kind:"20.5cm"},{kind:"21cm"},{kind:"21.5cm"},{kind:"22cm"},{kind:"22.5cm"},{kind:"23cm"},{kind:"23.5cm"},{kind:"24cm"},{kind:"24.5cm"},{kind:"25cm"},{kind:"25.5cm"},{kind:"26cm"},{kind:"26.5cm"},{kind:"27cm"},{kind:"27.5cm以上"}])

#男性靴のサイズ
men_shoes = Size.create(kind:"男性靴のサイズ")
men_shoes_content = men_shoes.children.create([{kind:"23.5cm以下"},{kind:"24cm"},{kind:"24.5cm"},{kind:"25cm"},{kind:"25.5cm"},{kind:"26cm"},{kind:"26.5cm"},{kind:"27cm"},{kind:"27.5cm"},{kind:"28cm"},{kind:"28.5cm"},{kind:"29cm"},{kind:"29.5cm"},{kind:"30cm"},{kind:"30.5cm"},{kind:"31cm以上"}])

# 子供靴のサイズ
child_shoes = Size.create(kind:"子供靴のサイズ")
child_shoes_content = child_shoes.children.create([{kind:"10.5cm以下"},{kind:"11cm・11.5cm"},{kind:"12cm・12.5cm"},{kind:"13cm・13.5cm"},{kind:"14cm・14.5cm"},{kind:"15cm・15.5cm"},{kind:"16cm・16.5cm"},{kind:"17cm以上"}])
