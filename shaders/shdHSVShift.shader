//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
//varying vec4 v_vColour;   unused in this shader

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    //v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
uniform vec3 vHSV;

// Fast branchless RGB-HSV conversion by sam hocevar
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 P = mix(vec4(vec2(c.b, c.g), vec2(K.w, K.z)), vec4(vec2(c.g, c.b), K.xy), step(c.b, c.g));
    vec4 Q = mix(vec4(vec3(P.x, P.y, P.w), c.r), vec4(c.r, vec3(P.y, P.z, P.x)), step(P.x, c.r));
    
    float d = Q.x - min(Q.w, Q.y);
    float e = 1.0 * pow(10.0, -10.0);
    return vec3(abs(Q.z + (Q.w - Q.y) / (6.0 * d + e)), d / (Q.x + e), Q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 P = abs(fract(vec3(c.x, c.x, c.x) + K.xyz) * 6.0 - vec3(K.w, K.w, K.w));
    return c.z * mix(vec3(K.x, K.x, K.x), clamp(P - vec3(K.x, K.x, K.x), 0.0, 1.0), c.y);
}

// do the thing
void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    vec3 fragRGB = col.rgb;
    vec3 fragHSV = rgb2hsv(fragRGB).xyz;
    fragHSV.x = mod(fragHSV.x + vHSV.x, 1.0);
    fragHSV.y = clamp(fragHSV.y + vHSV.y, 0.0, 1.0);
    fragHSV.z = clamp(fragHSV.z + vHSV.z, 0.0, 1.0);
    fragRGB = hsv2rgb(fragHSV);
    
    gl_FragColor = vec4(fragRGB, col.w);
}

