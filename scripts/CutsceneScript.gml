/// scripting language for cutscene support

#define cuts_init
/// cuts_init

peggml_init()

global._cuts_parser = peggml_parser_create("

")

#define _cuts_test
/// automated test of the cutscene logic

var example_cuts = "

// waits until the condition is met before proceeding.
wait {
    with (objMegaman)
    {
        if (x > 200) return true
    }
    return false
}

lock // locks player movement
persistent // allows cutscene to persist past a single room

dialog portrait:sprMugshots:5
    - here's a bit of dialogue
    > this bit of dialogue is
       multilpe lines long ooh
            very fancy and whitespace is cropped <

dialog portrait:sprMugshots:3
    - I also have a line to say too!

pause // game logic should not tick after this point.
fade out // fades out
skippable { // allow skipping by pressing start
    image bgStarFieldBackground 
    fade in
    
    // configure text region properties
    // x, y, w: rectangle w.r.t. current view
    textconfig x:32 y:16 w:200
    
    text
        - somewhere in the depths of space...
    
    text speed:0.5 // this text appears slower than normal
        - a distant roar...
    
    text speed:0 // 0 has a special meaning, the text appears instantly.
        - oh no!
    
    confirm // waits for player to press a button to continue
}
// fadeout, disable image, then fade in and resume game logic.
fade out
image // disable showing image
fade in
unpause // resume game logic
    
sleep 60 * 0.3 // waits for 0.3 seconds

// some code (runs after dialog completes)
exec {
    // spawn a boss object.
    instance_create(view_xview[0] + view_wview[0] * .75, objMegaman.y, objPharaohMan)
}

// (player movement automatically unlocks)
"