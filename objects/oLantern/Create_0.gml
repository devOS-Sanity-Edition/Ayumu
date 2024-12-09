//event_inherited()

darkPaletteR = color_get_red(darkPaletteColor)
darkPaletteG = color_get_green(darkPaletteColor)
darkPaletteB = color_get_blue(darkPaletteColor)
brightPaletteR = color_get_red(brightPaletteColor)
brightPaletteG = color_get_green(brightPaletteColor)
brightPaletteB = color_get_blue(brightPaletteColor)

// Shader Color Swap
colorSwapSetup()

light = instance_create_layer(x + relativeX, y + relativeY, "Light", oLight)