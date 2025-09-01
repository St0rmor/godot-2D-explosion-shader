extends Sprite2D
class_name Explosion

#property
const process_speed:float = 3
const vanish_speed:float = 2
const flame_speed:float = 2

#variable
var seed:float = 0.0
var process:float = 0.0
var vanish:float = 0.0
var flame:float = 0.0
var exploding:bool = false



func _input(event):
	if !exploding: _start_exploding()



func _process(delta):
	if exploding:
		_exploding(delta)



func _start_exploding():
	seed = randf_range(0,1.0)
	process = 0.0
	vanish = 0.0
	flame = 0.0
	material.set_shader_parameter("seed", seed)
	material.set_shader_parameter("process", process)
	material.set_shader_parameter("vanish", vanish)
	material.set_shader_parameter("flame", flame)
	exploding = true



func _exploding(delta):
	flame = move_toward(flame, 2.0, flame_speed * delta)
	process = move_toward(process, 1.0, process_speed * delta)
	material.set_shader_parameter("flame", flame)
	material.set_shader_parameter("process", process)
	if process >= 0.7:
		vanish = move_toward(vanish, 1.0, vanish_speed * delta)
		material.set_shader_parameter("vanish", vanish)
	if vanish >= 1.0:
		exploding = false;
