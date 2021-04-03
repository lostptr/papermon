shader_type spatial;

uniform vec4 base_color: hint_color;
uniform vec3 center = vec3(0.0, 0.0, 0.0);
uniform float cutoff: hint_range(0, 3);
uniform float height: hint_range(0, 3);

void vertex(){
	VERTEX.y += (1.0 - smoothstep(0.0, cutoff, distance(VERTEX.xz, center.xz)));
}

void fragment(){
	ALBEDO = base_color.rgb;
	ALPHA = base_color.a;
}