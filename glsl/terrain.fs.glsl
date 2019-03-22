#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsTexcoord;
in vec4 shadowCoord;


uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;


void main() {


	// TANGENT SPACE NORMAL
	vec3 Nt = normalize(texture(normalMap, vcsTexcoord).xyz * 2.0 - 1.0);

	// PRE-CALCS
	vec3 Ni = normalize(vcsNormal);

	vec3 up = vec3(0.0, 1.0, 0.0);
	vec3 T = normalize(cross(Ni, up));
	vec3 B = cross(Ni, T);

	mat3 TBN_matrix = mat3(
		vec3(T.x, B.x, Ni.x),
		vec3(T.y, B.y, Ni.y),
		vec3(T.z, B.z, Ni.z)
	);

	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0))) * TBN_matrix;
	vec3 V = normalize(-vcsPosition) * TBN_matrix;
	vec3 H = normalize((V + L) * 0.5);

	//texture
	vec4 textureColor = texture(colorMap, vcsTexcoord);
	vec4 textureAmb = texture(aoMap, vcsTexcoord);

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient * textureAmb.xyz;

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor;
	vec3 light_DFF = diffuse * max(0.0, dot(Nt, L)) * textureColor.xyz;

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, Nt)), shininess);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF  + light_SPC;

	// shadow
	vec3 sc = shadowCoord.xyz / shadowCoord.w;
	sc = sc * 0.5 + 0.5;
	float closestDpeth = texture(shadowMap, sc.xy).r;
	float currentDepth = sc.z;
    float visibility = 1.0;

if ( closestDpeth < currentDepth){
    visibility = 0.5;
}
	out_FragColor = vec4(TOTAL*visibility, 1.0);
}
