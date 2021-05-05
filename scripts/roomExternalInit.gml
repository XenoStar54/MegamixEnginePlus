/// roomExternalInit

global.roomExternalCache = ds_map_create()
global.roomExternalFileName = ds_map_create()
global.roomExternalSetupMap = ds_map_create()

// used to store room properties
global._roomExternalRoomProps = ds_map_create()
global._roomExternalBackgrounds = ds_list_create()
global._roomExternalTiles = ds_list_create()
global._roomExternalViews = ds_list_create()
global._roomExternalInstances = ds_list_create()
global._roomExternalXMLMaps[0] = _roomExternalBackgrounds
global._roomExternalXMLMaps[1] = _roomExternalTiles
global._roomExternalXMLMaps[2] = _roomExternalViews
global._roomExternalXMLMaps[3] = _roomExternalInstances
global._roomExternalCustomObjectHandlerMap = ds_map_create()

global.roomExternalParser = peggml_parser_create("
    ROOMPROP <- RP_CAPTION /
            RP_WIDTH /
            RP_CODE /
            RP_CODE_BEGIN /
            RP_HEIGHT /
            RP_SPEED /
            RP_PERSISTENT /
            RP_COLOUR / 
            RP_SHOWCOLOUR /
            RP_ENABLEVIEWS /
            RP_BACKGROUND /
            RP_TILE /
            RP_VIEW /
            RP_INSTANCE
        RP_WIDTH <- '<width>'i NUMBER '</width>'i
        RP_HEIGHT <- '<height>'i NUMBER '</height>'i
        RP_CAPTION <- '<caption>'i TEXT '</caption>'i
        RP_SPEED <- '<speed>'i NUMBER '</speed>'i
        RP_PERSISTENT <- '<persistent>'i NUMBER '</persistent>'i
        RP_COLOUR <- '<colour>'i NUMBER '</colour>'i / '<color>'i NUMBER '<color>'i
        RP_SHOWCOLOUR <- '<showcolour>'i NUMBER '</showcolour>'i / '<showcolor>'i NUMBER '<showcolor>'i
        RP_CODE <- '<code>'i TEXT? '</code>'i
        RP_CODE_BEGIN <- '<code>'i TEXT?
        RP_ENABLEVIEWS <- '<enableviews>'i NUMBER '</enableviews>'i
        RP_BACKGROUND <- '<background ' ATTRIBUTE* '/>'
        RP_TILE <- '<tile ' ATTRIBUTE* '/>'
        RP_VIEW <- '<view ' ATTRIBUTE* '/>'
        RP_INSTANCE <- '<instance ' ATTRIBUTE* '/>'
        ATTRIBUTE <- ATTRNAME '=' '" + global.doubleQuote + "' ATTRVAL '" + global.doubleQuote + "'
            ATTRNAME <- < [a-zA-Z0-9]+ >
            ATTRVAL <- [^" + global.doubleQuote + "]*
    TEXT <- ([^<>&] / ESCAPED_CHAR)+
    ESCAPED_CHAR <- '&' [^a-zA-Z0-9]+ ';'
    COMMENT <- '<!--' [^>]* '>'
    NUMBER <- < ('-')? [0-9]+ > / < ('-')? [0-9]* '.'? [0-9]+ >
    %whitespace  <-  [ \t\r\n]*
") // ((~COMMENT* RP_OTHER ~COMMENT*)* / TEXT)

assert(global.roomExternalParser >= 0, "roomExternalInit: peggml error: " + peggml_error_str())

peggml_parser_enable_packrat(global.roomExternalParser)

{/*!#lamdef __lf_roomExternalInit_roomExternalParseLines*/}

{/*!#lamdef __lf_roomExternalInit__roomExternalInit_handle_tag*/}

{/*!#lamdef __lf_roomExternalInit__roomExternalInit_handle_value*/}

{/*!#lamdef __lf_roomExternalInit__roomExternalInit_handle_NUMBER*/}

{/*!#lamdef __lf_roomExternalInit__roomExternalInit_handle_TEXT*/}

{/*!#lamdef __lf_roomExternalInit__roomExternalInit_handle_CODE_BEGIN*/}

peggml_parser_set_handler(global.roomExternalParser, "NUMBER", __lf_roomExternalInit__roomExternalInit_handle_NUMBER)
peggml_parser_set_handler(global.roomExternalParser, "RP_WIDTH", __lf_roomExternalInit__roomExternalInit_handle_value, "width")
peggml_parser_set_handler(global.roomExternalParser, "RP_HEIGHT", __lf_roomExternalInit__roomExternalInit_handle_value, "height")
peggml_parser_set_handler(global.roomExternalParser, "RP_CAPTION", __lf_roomExternalInit__roomExternalInit_handle_value, "caption")
peggml_parser_set_handler(global.roomExternalParser, "RP_SPEED", __lf_roomExternalInit__roomExternalInit_handle_value, "speed")
peggml_parser_set_handler(global.roomExternalParser, "RP_PERSISTENT", __lf_roomExternalInit__roomExternalInit_handle_value, "persistent")
peggml_parser_set_handler(global.roomExternalParser, "RP_COLOUR", __lf_roomExternalInit__roomExternalInit_handle_value, "colour")
peggml_parser_set_handler(global.roomExternalParser, "RP_SHOWCOLOUR", __lf_roomExternalInit__roomExternalInit_handle_value, "showColour")
peggml_parser_set_handler(global.roomExternalParser, "RP_CODE", __lf_roomExternalInit__roomExternalInit_handle_value, "code")
peggml_parser_set_handler(global.roomExternalParser, "RP_CODE_BEGIN", __lf_roomExternalInit__roomExternalInit_handle_CODE_BEGIN)
peggml_parser_set_handler(global.roomExternalParser, "RP_ENABLEVIEWS", __lf_roomExternalInit__roomExternalInit_handle_value, "enableViews")
peggml_parser_set_handler(global.roomExternalParser, "RP_BACKGROUND", __lf_roomExternalInit__roomExternalInit_handle_tag, global._roomExternalBackgrounds)
peggml_parser_set_handler(global.roomExternalParser, "RP_TILE", __lf_roomExternalInit__roomExternalInit_handle_tag, global._roomExternalTiles)
peggml_parser_set_handler(global.roomExternalParser, "RP_VIEW", __lf_roomExternalInit__roomExternalInit_handle_tag, global._roomExternalViews)
peggml_parser_set_handler(global.roomExternalParser, "RP_INSTANCE", __lf_roomExternalInit__roomExternalInit_handle_tag, global._roomExternalInstances)
peggml_parser_set_handler(global.roomExternalParser, "TEXT", __lf_roomExternalInit__roomExternalInit_handle_TEXT)

show_debug_message("about to parse...")

// just a test.
roomExternalParseBegin()
var value = __lf_roomExternalInit_roomExternalParseLines('
<!--This Document is generated by GameMaker, if you edit it by hand then you do so at your own risk!-->
<room>
  <caption>hello</caption>
  <width>256</width>
  <height>224</height>
  <vsnap>32</vsnap>
  <hsnap>32</hsnap>
  <isometric>0</isometric>
  <speed>60</speed>
  <persistent>0</persistent>
  <colour>35</colour>
  <showcolour>-1</showcolour>
  <code>
    test = 4
    test2 = 5;
  </code>
  <enableViews>-1</enableViews>
  <clearViewBackground>-1</clearViewBackground>
  <clearDisplayBuffer>-1</clearDisplayBuffer>
  <makerSettings>
    <isSet>0</isSet>
    <w>0</w>
    <h>0</h>
    <showGrid>0</showGrid>
    <showObjects>0</showObjects>
    <showTiles>0</showTiles>
    <showBackgrounds>0</showBackgrounds>
    <showForegrounds>0</showForegrounds>
    <showViews>0</showViews>
    <deleteUnderlyingObj>0</deleteUnderlyingObj>
    <deleteUnderlyingTiles>0</deleteUnderlyingTiles>
    <page>0</page>
    <xoffset>0</xoffset>
    <yoffset>0</yoffset>
  </makerSettings>
  <backgrounds>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
    <background visible="0" foreground="0" name="" x="0" y="0" htiled="-1" vtiled="-1" hspeed="0" vspeed="0" stretch="0"/>
  </backgrounds>
  <views>
    <view visible="-1" objName="&lt;undefined&gt;" xview="0" yview="0" wview="256" hview="224" xport="0" yport="0" wport="768" hport="672" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
  </views>
  <instances>
    <instance objName="objGlobalControl" x="0" y="0" name="inst_3334DD84" locked="0" code="" scaleX="1" scaleY="1" colour="4294967295" rotation="0"/>
  </instances>
   <tiles>
    <tile bgName="tstFlashman" x="1280" y="64" w="16" h="16" xo="64" yo="48" id="11288555" name="inst_70BECDDC" depth="100000001" locked="0" colour="4294967295" scaleX="1" scaleY="1"/>
    <tile bgName="tstFlashman" x="1264" y="64" w="16" h="16" xo="64" yo="48" id="11288556" name="inst_000365F1" depth="100000001" locked="0" colour="4294967295" scaleX="1" scaleY="1"/>
  </tiles>
  <PhysicsWorld>0</PhysicsWorld>
  <PhysicsWorldTop>0</PhysicsWorldTop>
  <PhysicsWorldLeft>0</PhysicsWorldLeft>
  <PhysicsWorldRight>1024</PhysicsWorldRight>
  <PhysicsWorldBottom>768</PhysicsWorldBottom>
  <PhysicsWorldGravityX>0</PhysicsWorldGravityX>
  <PhysicsWorldGravityY>10</PhysicsWorldGravityY>
  <PhysicsWorldPixToMeters>0.100000001490116</PhysicsWorldPixToMeters>
</room>
')

/*
show_debug_message("width: " + string(roomExternalParseGetProp("width")))
show_debug_message("height: " + string(roomExternalParseGetProp("height", 100)))
show_debug_message("caption: " + string(roomExternalParseGetProp("caption", "(no caption)")))
show_debug_message("colour: " + string(roomExternalParseGetProp("colour")))
show_debug_message("showColour: " + string(roomExternalParseGetProp("showColour")))
show_debug_message("code: " + string(roomExternalParseGetProp("code", "(no code)")))
show_debug_message("backgrounds: " + string(ds_list_size(global._roomExternalBackgrounds)))
show_debug_message("views: " + string(ds_list_size(global._roomExternalViews)))
show_debug_message("instances: " + string(ds_list_size(global._roomExternalInstances)))
show_debug_message("tiles: " + string(ds_list_size(global._roomExternalTiles)))
*/

roomExternalParseEnd()

show_debug_message("parsed. stack usage was: " + string(peggml_estimate_stack_usage()))