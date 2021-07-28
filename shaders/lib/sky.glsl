#ifdef FRAG


#include "/lib/fog.glsl"
#include "/bug_test/sky_render_bug.fsh"

void render() {
	// render stars and sky normally
	vec3 color;
	if (starData.a > 0.5) {
		color = starData.rgb;
	} else {
		// calculate pos
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0);
		pos = gbufferProjectionInverse * pos;
		// calculate the sky color
		color = calcSkyColor(normalize(pos.xyz)) * (1 - blindness);
	}

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}

#ifdef DEFAULT
void main() {
	render();
}
#endif


#endif



#ifdef VERT


out vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

void render() {
	gl_Position = ftransform();
	starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
}

#ifdef DEFAULT
void main() {
	render();
}
#endif


#endif
