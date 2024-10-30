class_name SpeedupPush
extends CameraControllerBase

@export var push_ratio:float = 0.7
@export var pushbox_top_left:Vector2 = Vector2(-5,-10)
@export var pushbox_bottom_right:Vector2 = Vector2(5,10)
@export var speedup_zone_top_left:Vector2 = Vector2(-5,-10)
@export var speedup_zone_bottom_right:Vector2 = Vector2(5,10)



func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true

func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	# Left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left.y)
	var diff_between_left_edges_in = (tpos.x - target.WIDTH / 2.0) - (cpos.x + speedup_zone_top_left.y)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	elif diff_between_left_edges > 0 and diff_between_left_edges_in < 0 and target.velocity.x < 0:
		#print("In speedup zone")
		global_position.x += target.velocity.x * push_ratio * delta
	
	# Right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.y)
	var diff_between_right_edges_in = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.y)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	elif diff_between_right_edges < 0 and diff_between_right_edges_in > 0 and target.velocity.x > 0:
		global_position.x += target.velocity.x * push_ratio * delta
		
		
	# Top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + pushbox_top_left.x)
	var diff_between_top_edges_in = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + speedup_zone_top_left.x)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	elif diff_between_top_edges > 0 and diff_between_top_edges_in < 0 and target.velocity.z < 0:
		global_position.z += target.velocity.z * push_ratio * delta
		
	# Bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_bottom_right.x)
	var diff_between_bottom_edges_in = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_zone_bottom_right.x)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
	elif diff_between_bottom_edges < 0 and diff_between_bottom_edges_in > 0 and target.velocity.z > 0:
		global_position.z += target.velocity.z * push_ratio * delta
	
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = pushbox_top_left.y
	var right:float = pushbox_bottom_right.y
	var top:float = pushbox_top_left.x
	var bottom:float = pushbox_bottom_right.x
	
	var left_in:float = speedup_zone_top_left.y
	var right_in:float = speedup_zone_bottom_right.y
	var top_in:float = speedup_zone_top_left.x
	var bottom_in:float = speedup_zone_bottom_right.x
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(right_in, 0, top_in))
	immediate_mesh.surface_add_vertex(Vector3(right_in, 0, bottom_in))
	
	immediate_mesh.surface_add_vertex(Vector3(right_in, 0, bottom_in))
	immediate_mesh.surface_add_vertex(Vector3(left_in, 0, bottom_in))
	
	immediate_mesh.surface_add_vertex(Vector3(left_in, 0, bottom_in))
	immediate_mesh.surface_add_vertex(Vector3(left_in, 0, top_in))
	
	immediate_mesh.surface_add_vertex(Vector3(left_in, 0, top_in))
	immediate_mesh.surface_add_vertex(Vector3(right_in, 0, top_in))
	immediate_mesh.surface_end()
	
	

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
