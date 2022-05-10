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

//######################_==_YOYO_SHADER_MARKER_==_######################@~// Made by vdweller 

/* Draws a sprite with the colors from the base palette swapped with the colors in the swap palette. */

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D basePalette; // palette sprites must be 32 in width and have "Use for 3D" checked!!!!!!!!!!!!!
uniform sampler2D swapPalette; // palette sprites must be 32 in width and have "Use for 3D" checked!!!!!!!!!!!!!
uniform float paletteLength;

void main()
{
    float paletteHeight = ceil(paletteLength / 32.0);
    
    vec4 spr = texture2D(gm_BaseTexture, v_vTexcoord);
    
    vec4 outp = spr;
    float i = 0.0;
    while (true)
    {
        if (vec3(spr) == vec3(texture2D(basePalette, vec2(mod(i, 32.0) / 32.0, (i / 32.0) / paletteHeight))))
        {
            outp = texture2D(swapPalette, vec2(mod(i, 32.0) / 32.0, (i / 32.0) / paletteHeight)); //32: The color map width
            break;
        }
        
        i++;
        if (i >= paletteLength)
        {
            break;
        }
    }
    
    gl_FragColor = vec4(outp.rgb, spr.a);
}
