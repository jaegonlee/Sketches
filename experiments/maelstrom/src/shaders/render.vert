// render.vert

precision highp float;
attribute vec3 aVertexPosition;
attribute vec3 aNormal;
attribute vec2 aTextureCoord;
attribute vec2 aUV;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;
uniform sampler2D textureCurr;
uniform sampler2D textureNext;
uniform sampler2D textureExtra;
uniform float percent;
uniform float time;
uniform vec2 uViewport;

varying vec4 vColor;
varying vec3 vNormal;
varying vec2 vTextureCoord;

const float radius = 0.01;

void main(void) {
	// vec2 uv      = aVertexPosition.xy;
	vec3 posCurr = texture2D(textureCurr, aUV).rgb;
	vec3 posNext = texture2D(textureNext, aUV).rgb;
	vec3 pos     = mix(posCurr, posNext, percent);
	vec3 extra   = texture2D(textureExtra, aUV).rgb;

	vec3 position = aVertexPosition + pos;

	gl_Position  = uProjectionMatrix * uViewMatrix * uModelMatrix * vec4(position, 1.0);
	
	
	

	float g 	 = sin(extra.r + time * mix(extra.b, 1.0, .5));
	g 			 = smoothstep(0.0, 1.0, g);
	g 			 = mix(g, 1.0, .5);
	vColor       = vec4(vec3(g), 1.0);

	vNormal 	 = aNormal;
	vTextureCoord = aTextureCoord;
}