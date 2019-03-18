#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;
out vec2 vcsCoord;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	vcsCoord = uv;

	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
