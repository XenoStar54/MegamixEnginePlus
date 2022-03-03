//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const vec3 lum = vec3(0.299, 0.587, 0.114);

uniform sampler2D palette; // palette sprites must be 32 in width and have "Used for 3D" checked!!!!!!!!
uniform float paletteLength;

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    float grey = dot(col.xyz, lum);
    float paletteHeight = ceil(paletteLength / 32.0);
    
    // find closest luminosity value
    
    float index = 0.0;
    float i = 1.0;
    while (true)
    {
        if (abs(grey - dot(texture2D(palette, vec2(mod(i, 32.0) / 32.0, (i / 32.0) / paletteHeight)).rgb, lum))
            < abs(grey - dot(texture2D(palette, vec2(mod(index, 32.0) / 32.0, (index / 32.0) / paletteHeight)).rgb, lum)))
        {
            index = i;
        }
        
        i++;
        if (i >= paletteLength)
        {
            break;
        }
    }
    
    // replace
    gl_FragColor = vec4(texture2D(palette, vec2(mod(index, 32.0) / 32.0, (index / 32.0) / paletteHeight)).rgb, col.a);
}
