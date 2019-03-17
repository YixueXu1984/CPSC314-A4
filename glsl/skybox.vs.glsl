#version 300 es

out vec3 sbpos;

void main() {

    sbpos = position;

	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}