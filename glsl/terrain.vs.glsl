#version 300 es

uniform mat4 lightViewMatrixUniform;
uniform mat4 lightProjectMatrixUniform;

out vec3 vcsNormal;
out vec3 vcsPosition;
out vec2 vcsTexcoord;

out vec4 shadowCoord;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	vcsTexcoord = uv;

	mat4 biasMatrix  = mat4(
    vec4(0.5, 0.0, 0.0, 0.0),
    vec4(0.0, 0.5, 0.0, 0.0),
    vec4(0.0, 0.0, 0.5, 0.0),
    vec4(0.5, 0.5, 0.5, 1.0)
    );

	shadowCoord = lightProjectMatrixUniform * lightViewMatrixUniform * modelMatrix * vec4(position, 1.0);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
