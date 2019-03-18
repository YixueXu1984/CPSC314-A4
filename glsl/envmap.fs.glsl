#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsCoord;

uniform vec3 lightDirection;
uniform samplerCube sb;

void main( void ) {

    vec3 Ni = normalize(vcsNormal);
    vec3 V = normalize(vcsPosition);

    vec3 R = reflect(V,Ni);
    R = vec3(vec4(R, 0.0) * viewMatrix);
    vec4 env = textureCube(sb, R);

  out_FragColor = env;
}
