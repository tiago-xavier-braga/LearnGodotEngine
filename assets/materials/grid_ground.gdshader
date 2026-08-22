shader_type spatial;
render_mode unshaded;

uniform vec2 cell_size = vec2(2.5, 10.0);
uniform float line_thickness : hint_range(0.01, 0.5) = 0.06;
uniform vec3 line_color : source_color = vec3(1.0, 1.0, 1.0);
uniform vec3 base_color : source_color = vec3(0.12, 0.12, 0.15);

varying vec2 world_xz;

void vertex() {
	world_xz = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
}

void fragment() {
	vec2 cell = world_xz / cell_size;
	vec2 dist_to_edge = abs(fract(cell) - 0.5);
	float line = step(0.5 - line_thickness, max(dist_to_edge.x, dist_to_edge.y));
	ALBEDO = mix(base_color, line_color, line);
}
