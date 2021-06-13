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
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const float fadeStep = 0.2;
const vec3 lum = vec3(0.299, 0.587, 0.114); // estimated weights of luminosity for rgb values based on human perception

//uniform float fadeAlpha;
uniform int fadeShift;

void main()
{
    /*It would probably be fine to directly subtract fadeAlpha from the color values with
    shdColorSubtract, but I thought this would look better*/
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    float grey = dot(col.xyz, lum);
    int greyStep = int(floor(grey / fadeStep + 0.5)); // match color to closest brightness "step"
    greyStep = greyStep - fadeShift; // step down the brightness
    float subtract = grey - float(greyStep) * fadeStep; // amount to subtract so it aligns with the new brightness step
    
    vec4 newColor = v_vColour * col;
    newColor.r = newColor.r - subtract;
    if (newColor.r < 0.1) { newColor.r = 0.0; } // round to zero or else colors may linger at full fade
    newColor.g = newColor.g - subtract;
    if (newColor.g < 0.1) { newColor.g = 0.0; }
    newColor.b = newColor.b - subtract;
    if (newColor.b < 0.1) { newColor.b = 0.0; }
    
    gl_FragColor = newColor;
}

