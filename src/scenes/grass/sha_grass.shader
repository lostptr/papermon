shader_type spatial;
render_mode cull_disabled;

uniform vec4 color_top: hint_color = vec4(1, 1, 1, 1);
uniform vec4 color_bottom: hint_color = vec4(0, 0, 0, 1);

uniform float wind_scale = 4.0;
uniform float wind_speed = 1.0;
uniform vec3 wind_dir = vec3(0, 0, -1);

uniform float deg_sway_pitch = 80.0;
uniform float deg_sway_yaw = 45.0;

uniform sampler2D worley_tex: hint_white;

varying float wind;

const vec3 UP = vec3(0,1,0);
const vec3 RIGHT = vec3(1,0,0);

const float PI = 3.14159;
const float DEG2RAD = (PI / 180.0);

mat3 mat3_from_axis_angle(float angle, vec3 axis) {
	float s = sin(angle);
	float c = cos(angle);
	float t = 1.0 - c;
	float x = axis.x;
	float y = axis.y;
	float z = axis.z;
	return mat3(
		vec3(t*x*x+c,t*x*y-s*z,t*x*z+s*y),
		vec3(t*x*y+s*z,t*y*y+c,t*y*z-s*x),
		vec3(t*x*z-s*y,t*y*z+s*z,t*z*z+c)
	);
}

float worley(vec2 p) {
	p = p / 8.0;
	return texture(worley_tex, p).x;
}

void vertex() {
	NORMAL = vec3(0, 1, 0);
	vec3 vertex = VERTEX;
	vec2 uv = (WORLD_MATRIX * vec4(vertex, -1.0)).xz * wind_scale;
	vec3 wind_dir_normalized = normalize(wind_dir);
	float time = TIME * wind_speed;
	uv += wind_dir_normalized.xz * time;
		
	wind = pow(worley(uv), 2.0) * UV2.y;
	
	mat3 to_model = inverse(mat3(WORLD_MATRIX));
	vec3 wind_forward = to_model * wind_dir_normalized;
	vec3 wind_right = normalize(cross(wind_forward, UP));

	float sway_pitch = ((deg_sway_pitch * DEG2RAD) * wind) + INSTANCE_CUSTOM.z;
	float sway_yaw = ((deg_sway_yaw * DEG2RAD) * sin(time) * wind) + INSTANCE_CUSTOM.w;

	mat3 rot_right = mat3_from_axis_angle(sway_pitch, wind_right);
	mat3 rot_forward = mat3_from_axis_angle(sway_yaw, wind_forward);

	vertex.xz *= INSTANCE_CUSTOM.x;
	vertex.y *= INSTANCE_CUSTOM.y;

	vertex = mat3_from_axis_angle(TIME, UP) * vertex;

	VERTEX = rot_right * rot_forward * vertex;
	COLOR = mix(color_bottom, color_top, vertex.y);
}

void fragment() {
	float side = FRONT_FACING ? 1.0 : -1.0;
	NORMAL = NORMAL * side;
	ALBEDO = COLOR.rgb;
	SPECULAR = 0.5;
	ROUGHNESS = clamp(1.0 - (wind * 2.0), 0.0, 1.0);
}