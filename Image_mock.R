# indlæs
image1 <- load.image("Data/berserk_vol1.jpg")
plot(image1)
image2 <- load.image("Data/IMG_2618.HEIC")
plot(image2)

# strøllese (row/col)
df1 <- as.data.frame(image1)
nrow(df1)
ncol(df1)


df2 <- as.data.frame(image2)
nrow(df2) / 3 # / 3 fordi der er 3 color channels per pic
df2$value <- round(df2$value*244,0)

# ind specifik pixel
df1$value <- round(df1$value*244,0)
df1 %>% filter(x==3000,y==2500) %>% print()


# samlign billeder (er de det samme? rowSum, ColSum)
mean(df1$value)
mean(df2$value)

# image 2 is brighter



# do some stuff where its in a list
    # like df[[1]][300,500,1,1] 