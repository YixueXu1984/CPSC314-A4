#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;

uniform vec3 lightDirection;

void main( void ) {
  out_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
