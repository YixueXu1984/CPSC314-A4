#version 300 es

uniform samplerCube sb;

out vec4 out_FragColor;
in vec3 sbpos;

void main() {

    vec3 p = normalize(sbpos);
    vec4 textureColor = texture(sb, p);

	out_FragColor = textureColor;
}