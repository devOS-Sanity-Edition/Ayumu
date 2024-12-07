varying vec2 v_vTexcoord;
varying vec2 pos;
varying vec4 col;

uniform vec2 u_pos;
uniform float u_str;
uniform float zz;

void main() {
	vec2 dis = pos - u_pos;
	float str = 1.0 / (sqrt(dis.x * dis.x + dis.y * dis.y + zz * zz) -zz);
	
	vec4 frag = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = col * vec4(vec3(str), 1.0) * frag;
}
