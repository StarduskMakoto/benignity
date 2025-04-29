shader_type canvas_item;

varying vec2 worldPos;

uniform float redSize = 0.01;
uniform sampler2D rMaskTexture : filter_nearest, repeat_enable;
uniform vec4 rOverlayColor : source_color;
uniform vec3 redMaskColor : source_color;
uniform vec2 rOffSet = vec2(0.);
uniform vec2 rMoveIntensity = vec2(0.);

uniform float greenSize = 0.01;
uniform sampler2D gMaskTexture : filter_nearest, repeat_enable;
uniform vec4 gOverlayColor : source_color;
uniform vec3 greenMaskColor : source_color;
uniform vec2 gOffSet = vec2(0.);
uniform vec2 gMoveIntensity = vec2(0.);

uniform float blueSize = 0.01;
uniform sampler2D bMaskTexture : filter_nearest, repeat_enable;
uniform vec4 bOverlayColor : source_color;
uniform vec3 blueMaskColor : source_color;
uniform vec2 bOffSet = vec2(0.);
uniform vec2 bMoveIntensity = vec2(0.);

void vertex() {
	// Called for every vertex the material is visible on.
	
	mat4 matrix = MODEL_MATRIX;
	vec2 point = VERTEX;
	vec3 matrixPoint = (matrix * vec4(vec3(point, 0.0), 1.0)).xyz;
	
	worldPos = vec2(matrixPoint.xy);
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 rMove = vec2(cos(TIME), sin(TIME)) * rMoveIntensity;
	vec2 gMove = vec2(cos(TIME), sin(TIME)) * gMoveIntensity;
	vec2 bMove = vec2(cos(TIME), sin(TIME)) * bMoveIntensity;
	
	vec2 globalUVr = floor(worldPos + rOffSet + rMove) * redSize;
	vec2 globalUVg = floor(worldPos + gOffSet + gMove) * greenSize;
	vec2 globalUVb = floor(worldPos + bOffSet + bMove) * blueSize;
	
	//uv *= 2.;
	//uv -= 1.;
	vec4 texColor = texture(TEXTURE, UV);
	
	vec4 redMask = vec4(texColor.rrr, texColor.a);
	vec4 redOverlay = texture(rMaskTexture, globalUVr) * rOverlayColor;
	
	redMask.rgb = redMask.rgb * redMaskColor; //mix(redMask.rgb, redMaskColor, redMask.b);
	
	redMask.rgb = mix(redMask.rgb, redOverlay.rgb, redOverlay.a);
	redMask.rgb *= texColor.r;
	
	vec4 greenMask = vec4(texColor.ggg, texColor.a);
	vec4 greenOverlay = texture(gMaskTexture, globalUVg);
	greenOverlay.rgb *= gOverlayColor.rgb;
	
	greenMask.rgb = greenMask.rgb * greenMaskColor; //mix(greenMask.rgb, greenMaskColor, greenMask.b);
	
	greenMask.rgb = mix(greenMask.rgb, greenOverlay.rgb, greenOverlay.a);
	greenMask.rgb *= texColor.g;
	
	vec4 blueMask = vec4(texColor.bbb, texColor.a);
	vec4 blueOverlay = texture(bMaskTexture, globalUVb) * bOverlayColor;
	
	blueMask.rgb = blueMask.rgb * blueMaskColor; //mix(blueMask.rgb, blueMaskColor, blueMask.b);
	
	blueMask.rgb = mix(blueMask.rgb, blueOverlay.rgb, blueOverlay.a);
	blueMask.rgb *= texColor.b;
	
	vec4 finalColor = redMask + greenMask + blueMask;
	
	COLOR = finalColor;
}
