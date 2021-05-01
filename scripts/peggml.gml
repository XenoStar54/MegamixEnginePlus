#define peggml_init

gml_pragma("global", "global._peggml_loaded = false;")

if (!global._peggml_loaded)
{
    global._peggml_loaded = true
}
else
{
    // already initialized.
    exit
}

var dllName = "libpeggml.dll";
if (os_type == os_linux)
{
    dllName = "libpeggml.so"
}
var callType = dll_cdecl;
var minVersion = 1.0

global._peggml_abi_test = external_define(dllName, "peggml_abi_test", callType, ty_string,   0);

// test abi
if (global._peggml_abi_test < 0 || external_call(global._peggml_abi_test) != "gml-peglib")
{
    show_debug_message("peggml abi unable to be loaded")
    exit
}

global._peggml_version = external_define(dllName, "peggml_version", callType, ty_real,   0);
var version = external_call(global._peggml_version)
// check version min
if (version < minVersion)
{
    show_debug_message("peggml version mismatch; expected at least " + string(minVersion) + ", but shared library version is " + string(version))
    exit
}

// error declarations
global._peggml_error = external_define(dllName, "peggml_error", callType, ty_real, 0);
global._peggml_error_str = external_define(dllName, "peggml_error_str", callType, ty_string, 0);
global._peggml_set_error = external_define(dllName, "peggml_set_error", callType, ty_real, 1, ty_string);
global._peggml_clear_error = external_define(dllName, "peggml_clear_error", callType, ty_real, 0);

// remaining declarations
global._peggml_set_stack_size = external_define(dllName, "peggml_set_stack_size", callType, ty_real, 1, ty_real);
global._peggml_parser_create = external_define(dllName, "peggml_parser_create", callType, ty_real, 1, ty_string);
global._peggml_parser_destroy = external_define(dllName, "peggml_parser_destroy", callType, ty_real, 1, ty_real);
global._peggml_parser_enable_packrat = external_define(dllName, "peggml_parser_enable_packrat", callType, ty_real, 0);
global._peggml_parser_set_symbol_id = external_define(dllName, "peggml_parser_set_symbol_id", callType, ty_real, 3, ty_real, ty_string, ty_real);
global._peggml_parse_begin = external_define(dllName, "peggml_parse_begin", callType, ty_real, 2, ty_real, ty_string);
global._peggml_parse_next = external_define(dllName, "peggml_parse_next", callType, ty_real, 0);
global._peggml_parse_elt_get_uuid = external_define(dllName, "peggml_parse_elt_get_uuid", callType, ty_real, 0);
global._peggml_parse_elt_get_string = external_define(dllName, "peggml_parse_elt_get_string", callType, ty_string, 0);
global._peggml_parse_elt_get_string_offset = external_define(dllName, "peggml_parse_elt_get_string_offset", callType, ty_real, 0);
global._peggml_parse_elt_get_string_line = external_define(dllName, "peggml_parse_elt_get_string_line", callType, ty_real, 0);
global._peggml_parse_elt_get_string_column = external_define(dllName, "peggml_parse_elt_get_string_column", callType, ty_real, 0);
global._peggml_parse_elt_get_choice = external_define(dllName, "peggml_parse_elt_get_choice", callType, ty_real, 0);
global._peggml_parse_elt_get_child_count = external_define(dllName, "peggml_parse_elt_get_child_count", callType, ty_real, 0);
global._peggml_parse_elt_get_child_uuid = external_define(dllName, "peggml_parse_elt_get_child_uuid", callType, ty_real, 1, ty_real);
global._peggml_parse_elt_get_token_count = external_define(dllName, "peggml_parse_elt_get_token_count", callType, ty_real, 0);
global._peggml_parse_elt_get_token_offset = external_define(dllName, "peggml_parse_elt_get_token_offset", callType, ty_real, 1, ty_real);
global._peggml_parse_elt_get_token_string = external_define(dllName, "peggml_parse_elt_get_token_string", callType, ty_string, 1, ty_real);
global._peggml_parse_elt_get_token_number = external_define(dllName, "peggml_parse_elt_get_token_number", callType, ty_real, 0);
global._peggml_get_root_uuid = external_define(dllName, "peggml_get_root_uuid", callType, ty_real, 0);
global._peggml_next_symbol_id = 1

#define peggml_version
return external_call(global._peggml_version)

#define peggml_error
return external_call(global._peggml_error)

#define peggml_error_str
return external_call(global._peggml_error_str)

#define peggml_set_error
return external_call(global._peggml_set_error, argument0)

#define peggml_clear_error
return external_call(global._peggml_clear_error)

#define peggml_set_stack_size
peggml_init()
return external_call(global._peggml_set_stack_size, argument0)

#define peggml_parser_create
peggml_init()
var handle = external_call(global._peggml_parser_create, argument0)
global._peggml_handler_map[handle] = ds_map_create()
return handle

#define peggml_parser_destroy
var handle = argument0
ds_map_destroy(global._peggml_handler_map[handle])
global._peggml_handler_map[handle] = -1
return external_call(global._peggml_parser_destroy, handle)

#define peggml_parser_enable_packrat
return external_call(global._peggml_parser_enable_packrat, argument0)

#define peggml_parser_set_symbol_id
return external_call(global._peggml_parser_set_symbol_id, argument0, argument1, argument2)

#define peggml_parse_begin
return external_call(global._peggml_parse_begin, argument0, argument1)

#define peggml_parse_next
return external_call(global._peggml_parse_next)

#define peggml_parse_elt_get_uuid
return external_call(global._peggml_parse_elt_get_uuid)

#define peggml_parse_elt_get_string
return external_call(global._peggml_parse_elt_get_string)

#define peggml_parse_elt_get_string_offset
return external_call(global._peggml_parse_elt_get_string_offset)

#define peggml_parse_elt_get_string_line
return external_call(global._peggml_parse_elt_get_string_line)

#define peggml_parse_elt_get_string_column
return external_call(global._peggml_parse_elt_get_string_column)

#define peggml_parse_elt_get_choice
return external_call(global._peggml_parse_elt_get_choice)

#define peggml_parse_elt_get_child_count
return external_call(global._peggml_parse_elt_get_child_count)

#define peggml_parse_elt_get_child_uuid
var index = 0
if (argument_count > 0) index = argument[0]
return external_call(global._peggml_parse_elt_get_child_uuid, index)

#define peggml_parse_elt_get_child_value
var index = 0
if (argument_count > 0) index = argument[0]
return global._peggml_sv_map[? peggml_parse_elt_get_child_uuid(index)]

#define peggml_parse_elt_get_token_count
return external_call(global._peggml_parse_elt_get_token_count)

#define peggml_parse_elt_get_token_offset
var index = 0
if (argument_count > 0) index = argument[0]
return external_call(global._peggml_parse_elt_get_token_offset, index)

#define peggml_parse_elt_get_token_string
var index = 0
if (argument_count > 0) index = argument[0]
return external_call(global._peggml_parse_elt_get_token_string, index)

#define peggml_parse_elt_get_token_number
return external_call(global._peggml_parse_elt_get_token_number)

#define peggml_get_root_uuid
return external_call(global._peggml_get_root_uuid)

#define peggml_parser_set_handler
/// peggml_parser_set_handler(parser, symbol:string, script, args...)
/// sets the given symbol to be handled by the given script.
/// The script has access to all peggml_parse_elt* functions, can return any value,
/// and will be passed all 'args...'

var parser = argument[0]
var symbol = argument[1]
var script = argument[2]
var symbol_id = global._peggml_next_symbol_id++
peggml_parser_set_symbol_id(parser, symbol, symbol_id)

var handler_map = global._peggml_handler_map[parser]

var args
args[0] = script
for (var i = 0; i < argument_count; ++i)
{
    args[i + 1] = argument[i + 3]
}

handler_map[? symbol_id] = args

#define peggml_parse
/// peggml_parse(parser, string)
/// parses string and returns root's semantic value, or undefined on error.
/// (if an error occurs, check peggml_error and peggml_error_str)
var parser = argument0

global._peggml_sv_map = ds_map_create();
var handler_map = global._peggml_handler_map[parser]

if (peggml_parse_begin(parser, argument1)) exit

var value;
while (true)
{
    var symbol_id = peggml_parse_next();
    if (symbol_id == 0) break;
    var uuid = peggml_parse_elt_get_uuid();
    if (ds_map_exists(handler_map, symbol_id))
    {
        var params = handler_map[? symbol_id]
        if (script_exists(params[0]) || typeof(params[0]) == "function")
        {
            switch (array_length_1d(params))
            {
            case 1:
                value = script_execute(params[0])
                break;
            case 2:
                value = script_execute(params[0], params[1])
                break;
            case 3:
                value = script_execute(params[0], params[1], params[2])
                break;
            case 4:
                value = script_execute(params[0], params[1], params[2], params[3])
                break;
            case 5:
                value = script_execute(params[0], params[1], params[2], params[3], params[4])
                break;
            case 6:
                value = script_execute(params[0], params[1], params[2], params[3], params[4], params[5])
                break;
            default:
                peggml_set_error("cannot support handler with " + string(array_length_1d(params)) + " arguments")
                exit
            }
        }
        else
        {
            peggml_set_error("cannot support handler with " + string(array_length_1d(params)) + " arguments")
            exit
        }
    }
    else
    {
        peggml_set_error("no handler found for elt with uuid " + string(uuid))
        exit
    }
    
    global._peggml_sv_map[? uuid] = value
}

value = global._peggml_sv_map[? peggml_get_root_uuid()]

ds_map_destroy(global._peggml_sv_map)

return value