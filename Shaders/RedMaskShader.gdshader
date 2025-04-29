shader_type canvas_item;

varying vec2 worldPos;

uniform float waterSize = 0.01;
uniform sampler2D rMaskTexture : filter_nearest, repeat_enable;
uniform vec4 rOverlayColor : source_color;
uniform vec3 redMaskColor : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	
	mat4 matrix = MODEL_MATRIX;
	vec2 point = VERTEX;
	vec3 matrixPoint = (matrix * vec4(vec3(point, 0.0), 1.0)).xyz;
	
	worldPos = vec2(matrixPoint.xy);
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 globalUV = floor(worldPos) * waterSize;
	
	//uv *= 2.;
	//uv -= 1.;
	vec4 texColor = texture(TEXTURE, UV);
	vec4 redMask = vec4(texColor.rrr, texColor.a);
	vec4 redOverlay = texture(rMaskTexture, globalUV) * rOverlayColor;
	
	redMask.rgb = redMask.rgb * redMaskColor; //mix(redMask.rgb, redMaskColor, redMask.b);
	
	redMask.rgb = mix(redMask.rgb, redOverlay.rgb, redOverlay.a);
	
	
	vec4 finalColor = vec4(0., texColor.g, texColor.b, clamp(redMask.a - 1.0, 0., 1.)) + redMask;
	
	COLOR = finalColor;
}
