uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float blindness;
uniform float isEyeInWater;

in vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

vec3 calcSkyColor(vec3 pos) {
	float upDot = dot(pos, gbufferModelView[1].xyz); //not much, what's up with you?
	float fog = fogify(max(upDot, 0.0), 0.25);
	vec3 color;
	
	if (isEyeInWater == 0) { // render sky normally
		color = mix(skyColor, fogColor, fog);
	} else { // render underwater fog
		// https://github.com/IrisShaders/Iris/issues/645
		// According to this bug, the following code should render a completely black sky, not the fog color as specified below.
		color = fogColor;
	}

	return color;
}
