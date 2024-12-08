partSystem = part_system_create()
partEmitter = part_emitter_create(partSystem)
partType = part_type_create()

part_emitter_region(partSystem, partEmitter, 0, display_get_width(), 0, display_get_height(), ps_shape_rectangle, ps_distr_linear)
part_emitter_stream(partSystem, partEmitter, partType, 8)

part_type_alpha3(partType, 1, 5, 1)
part_type_color3(partType, c_white, c_white, c_ltgray)
part_type_life(partType, global.oneSecond * 5, global.oneSecond * 10)
part_type_scale(partType, 1, 1) // lets do random scale in the future
part_type_gravity(partType, 0.01, 180)
