#version 300 es

out vec4 out_FragColor;

uniform samplerCube skybox;

void main() {
	out_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}