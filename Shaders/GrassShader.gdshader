shader_type canvas_item;

varying vec2 worldPos;

uniform float waterSize = 0.01;
uniform sampler2D gMaskTexture : filter_nearest, repeat_enable;
uniform vec4 gOverlayColor : source_color;
uniform vec3 greenMaskColor : source_color;

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
	vec4 greenMask = vec4(texColor.ggg, texColor.a);
	vec4 greenOverlay = texture(gMaskTexture, globalUV) * gOverlayColor;
	
	greenMask.rgb = greenMask.rgb * greenMaskColor; //mix(greenMask.rgb, greenMaskColor, greenMask.b);
	
	greenMask.rgb = mix(greenMask.rgb, greenOverlay.rgb, greenOverlay.a);
	
	
	vec4 finalColor = vec4(vec3(texColor.r, 0., texColor.b), clamp(greenMask.a - 1.0, 0., 1.)) + greenMask;
	
	COLOR = finalColor;
}
