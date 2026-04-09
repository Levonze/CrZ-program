shader_type canvas_item;
render_mode blend_mix;

uniform float point_count = 12.0;
uniform float dot_size = 4.0;
uniform float max_connection_dist = 100.0;
uniform float line_thickness = 2.0;
uniform vec4 dot_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 line_color = vec4(0.4, 0.6, 1.0, 0.5);
uniform vec4 background_color = vec4(0.05, 0.05, 0.12, 1.0);
uniform float speed = 0.8;
uniform float move_range = 60.0;

const int MAX_POINTS = 16;

float hash(float n) { return fract(sin(n) * 43758.5453123); }
vec2 hash2(float n) { return vec2(hash(n), hash(n + 123.456)); }

vec2 get_point_pos(int i, float t, vec2 screen_size) {
	vec2 base = hash2(float(i)) * screen_size;
	return base + vec2(
		sin(t + float(i) * 1.7),
		cos(t * 0.9 + float(i) * 2.1)
	) * move_range;
}

void fragment() {
	vec2 uv = FRAGCOORD.xy;
	// Универсальный способ: работает в Godot 3.x и 4.x
	vec2 screen_size = vec2(1.0) / SCREEN_PIXEL_SIZE;
	
	float t = TIME * speed;
	int count = int(point_count);

	vec3 col = background_color.rgb;
	float alpha = background_color.a;

	// Точки
	for (int i = 0; i < count; i++) {
		vec2 p = get_point_pos(i, t, screen_size);
		float d = length(uv - p);
		float a = 1.0 - smoothstep(0.0, dot_size, d);
		if (a > 0.0) {
			col = mix(col, dot_color.rgb, a * dot_color.a);
			alpha = max(alpha, a * dot_color.a);
		}
	}

	// Линии
	for (int i = 0; i < count; i++) {
		vec2 p1 = get_point_pos(i, t, screen_size);
		for (int j = i + 1; j < count; j++) {
			vec2 p2 = get_point_pos(j, t, screen_size);
			float dist = length(p1 - p2);
			
			if (dist < max_connection_dist) {
				vec2 line_vec = p2 - p1;
				float line_len = length(line_vec);
				vec2 line_dir = line_vec / line_len;
				vec2 to_uv = uv - p1;
				float proj = clamp(dot(to_uv, line_dir), 0.0, line_len);
				vec2 closest = p1 + line_dir * proj;
				float dist_to_line = length(uv - closest);

				float line_a = 1.0 - smoothstep(0.0, line_thickness, dist_to_line);
				float conn_fade = 1.0 - smoothstep(0.0, max_connection_dist, dist);
				float a = line_a * conn_fade * line_color.a;

				if (a > 0.0) {
					col = mix(col, line_color.rgb, a);
					alpha = max(alpha, a);
				}
			}
		}
	}

	COLOR = vec4(col, alpha);
}