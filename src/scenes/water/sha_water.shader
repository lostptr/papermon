shader_type spatial;

uniform vec4 out_color : hint_color;
uniform sampler2D noise: hint_white;
uniform float wave_speed : hint_range(0, 1);
uniform float height_modifier : hint_range(0, 5);


vec3 wave(vec3 vertex, float time) {
//	float xd = texture(noise, vertex.xz + (time);
	float yd = texture(noise, vertex.xz + (time)).x;
//	float zd = texture(noise, vertex.xz + (time);
	vertex.y = (yd * height_modifier) - (height_modifier / 2.0);
	return vertex;
}

void vertex() {
	VERTEX = wave(VERTEX, TIME * wave_speed);
}

void fragment() {
	NORMAL = normalize(cross(dFdx(VERTEX), dFdy(VERTEX)));
	METALLIC = 0.4;
	SPECULAR = 0.8;
	ROUGHNESS = 0.0;
	ALBEDO = out_color.rgb;
}