shader_type spatial;
render_mode unshaded, cull_back;

uniform float dash_length : hint_range(0.05, 5.0) = 1.0;
uniform float gap_length : hint_range(0.05, 5.0) = 1.0;
uniform vec3 line_color : source_color = vec3(1.0, 0.7607843, 0.078431375);

varying float local_z;

void vertex() {
	local_z = VERTEX.z;
}

void fragment() {
	float period = dash_length + gap_length;
	float pos = mod(local_z + period * 0.5, period);
	if (pos > dash_length) {
		discard;
	}
	ALBEDO = line_color;
}
