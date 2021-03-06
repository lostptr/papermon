shader_type spatial;

uniform sampler2D worley_tex: hint_white;

vec2 random2(vec2 p) {
	return fract(sin(vec2(
		dot(p, vec2(127.32, 231.4)),
		dot(p, vec2(12.3, 146.3))
	)) * 231.23);
}

float worley2(vec2 p) {	
	float d = 1.0;

	vec2 i_p = floor(p);
	vec2 f_p = fract(p);

	for (int y = -1; y <= 1; y++){
		for (int x = -1; x <= 1; x++){
			vec2 n = vec2(float(x), float(y));
			vec2 diff = n + random2(i_p + n) - f_p;
			d = min(d, length(diff));
		}
	}

	return d;
}

float worley(vec2 p) {
	p = p / 10.0;
	return texture(worley_tex, p).x;
}

void fragment(){
	ALBEDO = vec3(worley((UV * 2.0) + (TIME * vec2(1.0, 0.0))));
}