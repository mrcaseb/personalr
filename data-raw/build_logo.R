library(hexSticker)
library(showtext)

## Loading Google fonts (http://www.google.com/fonts)
# font_add_google("Turret Road", "seb")
# font_add_google("Comfortaa", "seb")
font_add_google("Architects Daughter", "seb")
# font_add_google("Russo One", "seb")
## Automatically use showtext to render text for future devices
showtext_auto()

sticker(
  "data-raw/icon.png", # icon is 2000x1600 Pixel
  package = "personalr",
  p_family = "seb",
  # asp = 2000 / 1600,
  # p_size = 20,
  s_x = 1.02,
  s_y = .75,
  s_width = 0.45,
  s_height = (0.45 * 1600 / 2000),
  spotlight = TRUE,
  l_y = 1.5,
  l_alpha = 0.2,
  h_fill = "#2c4f67",
  h_color = "#192D3B",
  h_size = 0.8,
  filename = "data-raw/logo_seb.png"
)
