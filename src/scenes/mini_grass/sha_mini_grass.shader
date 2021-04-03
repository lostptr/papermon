shader_type spatial;
render_mode cull_disabled;
render_mode unshaded;

uniform vec4 color_top: hint_color = vec4(1, 1, 1, 1);
uniform vec4 color_bottom: hint_color = vec4(0, 0, 0, 1);

void vertex() {
	vec3 vertex = VERTEX;
	vertex.xz *= INSTANCE_CUSTOM.x;
	vertex.y *= INSTANCE_CUSTOM.y;
	COLOR = mix(color_bottom, color_top, vertex.y);
	VERTEX = vertex;
}

void fragment() {
	ALBEDO = COLOR.rgb;
}