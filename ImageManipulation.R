library(imager)
library(dplyr)
library(ggplot2)

# Load images
parrots <- load.example("parrots")
class(parrots)
parrots # see info

parrots_df <- as.data.frame(parrots) 
parrots_df$value <- round(parrots_df$value*244,0) # make into actual RGB values



# Plot
plot(parrots)
  # Manuelle see object in it

dim(parrots)


# images work like a regular array, so regular arithmetic operations work
mean(parrots)
sd(parrots)

colMeans(parrots_df)

layout(t(1:3)) # show all 3 plots under
plot(parrots, rescale = F)
plot(parrots/2) # looks the same as above, due to imager automatically rescaling
plot(parrots/2, rescale = F)
layout(1)

#  Gray scale
parrots_gray <- grayscale(parrots)
parrots_gray # colour channels changed to 1
plot(parrots_gray)

parrots_gray_df <- as.data.frame(parrots_gray) 
parrots_gray_df$value <- round(parrots_gray_df$value*244,0) # make into actual RGB values


# Plots ----
grayscale(parrots) %>% hist(main="Pixel values")
R(parrots) %>% hist(main="red channel values")

parrots_df <- mutate(parrots_df, channel = factor(cc,labels = c("R","G","B")))
parrots_df %>% 
  ggplot(aes(value, col=channel)) + 
  geom_histogram(bins=30) +
  facet_wrap(~channel)
parrots_df %>% group_by(channel) %>% summarise(total = sum(value)) # mosty red in the pic


# edge detection -----
parrots.g <- grayscale(parrots)
gr <- imgradient(parrots.g,"xy")
gr
plot(gr, layout = "row")

imgradient(parrots.g,"xy") %>% enorm %>% plot()
