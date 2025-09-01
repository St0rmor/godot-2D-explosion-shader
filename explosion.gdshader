shader_type canvas_item;
render_mode unshaded;

uniform float seed = 0.0;
uniform float start_point : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D noise_texture : hint_default_white, filter_nearest, repeat_enable;
uniform sampler2D noise_texture_2 : hint_default_white, filter_nearest, repeat_enable;
uniform sampler2D curve;
uniform sampler2D color_sample;
uniform float process : hint_range(0.0, 1.0) = 0.0;
uniform float vanish : hint_range(0.0, 1.0) = 0.0;
uniform float flame : hint_range(0.0, 2.0) = 0.0;



void fragment(){
	vec2 center = vec2(0.5,start_point) - vec2(0.0, process * 0.3);
	vec2 random_offset = seed * vec2(1.0, 0.0);
	float dis = distance(UV, center);
	vec2 uv = UV;
	float noise = texture(noise_texture, uv + vec2(0,flame) + random_offset).r;
	float noise_2 = texture(noise_texture_2, uv + 1.0*vec2(0,flame) + random_offset).r - vanish;
	float edge_dist = (0.25 + noise * 0.3) * process;
	float edge_range = 0.0;
	if(dis < edge_dist){
		noise = texture(curve,vec2(noise, 0.0)).r;
		vec4 color = texture(color_sample, vec2(noise, 0.0)) * 5.0;
		float smoothness = 0.1;
		float alpha = smoothstep(edge_dist ,edge_dist - smoothness, dis);
		COLOR.rgb = color.rgb;
		COLOR.a = clamp(alpha * noise_2 * 2.0, 0.0, 1.0);
	}
	else{
		COLOR.a = 0.0;
	}
}