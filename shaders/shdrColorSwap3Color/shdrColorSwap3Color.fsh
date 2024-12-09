/*
    Simple color replace shader by Xor (@XorDev)
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 color_old1;//r,g,b of color1 to replace, tolerance between 0 and 1.
uniform vec3 color_new1;//r,g,b of the new color1.

uniform vec4 color_old2;//r,g,b of color2 to replace, tolerance between 0 and 1.
uniform vec3 color_new2;//r,g,b of the new color2.

uniform vec4 color_old3;//r,g,b of color3 to replace, tolerance between 0 and 1.
uniform vec3 color_new3;//r,g,b of the new color3.

void main()
{
    //Sample the texture.
    vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord);
   
    //Find the color difference between the sample and the color_old1.
    float diff = dot(abs(sample - color_old1).rgb, vec3(1. / 3.));
    //Set the color_new1 when the the difference is greater than the tolerence.
    vec3 color = mix(sample.rgb, color_new1, step(diff, color_old1.w));
   
    //Find the color difference between the sample and the color_old2.
    diff = dot(abs(sample - color_old2).rgb, vec3(1. / 3.));
    //Set the color_new2 when the the difference is greater than the tolerence.
    color = mix(color, color_new2, step(diff, color_old2.w));
	
	//Find the color difference between the sample and the color_old3.
    diff = dot(abs(sample - color_old3).rgb, vec3(1. / 3.));
    //Set the color_new3 when the the difference is greater than the tolerence.
    color = mix(color, color_new3, step(diff, color_old3.w));
   
    //This can be repeated as necessary.
   
    //Use the new color with the sample alpha and the vertex color (v_vColour).
    gl_FragColor = v_vColour * vec4(color, sample.a);
}