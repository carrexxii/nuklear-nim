from std/strformat import `&`

const
    NkUtfSize*             = 4'i32
    NkUtfInvalid*          = 0xFFFD'u32
    NkPi*                  = 3.141592654'f32
    NkMaxFloatPrecision*   = 2'i32
    NkWidgetDisableFactor* = 0.5'f32
    # Hardcoded due to recursive issues
    NkValuePageCapacity* = max(480, 464) div (sizeof cuint) div 2 # max(sizeof Window, sizeof Panel) div (sizeof cuint) div 2

const
    NkMaxLayoutRowTemplateColumns* {.intdefine.} = 16
    NkWindowMaxName*               {.intdefine.} = 64
    NkMaxNumberBuffer*             {.intdefine.} = 64
    NkInputMax*                    {.intdefine.} = 16

    NkButtonBehaviourStackSize* {.intdefine.} = 8
    NkUserFontStackSize*        {.intdefine.} = 8
    NkStyleItemStackSize*       {.intdefine.} = 16
    NkFloatStackSize*           {.intdefine.} = 32
    NkVec2StackSize*            {.intdefine.} = 16
    NkFlagStackSize*            {.intdefine.} = 32
    NkColourStackSize*          {.intdefine.} = 32

    NkTextEditUndoStateCount*   {.intdefine.} = 99
    NkTextEditUndoCharCount*    {.intdefine.} = 999

    NkPoolDefaultCapacity*      {.intdefine.} = 16
    NkDefaultCommandBufferSize* {.intdefine.} = 4 * 1024
    NkBufferDefaultInitialSize* {.intdefine.} = 4 * 1024

    NkChartMaxSlots* {.intdefine.} = 4'i32

when defined NkIncludeDefaultAllocator  : {.passC: "-DNK_INCLUDE_DEFAULT_ALLOCATOR"   .}
when defined NkIncludeDefaultFont       : {.passC: "-DNK_INCLUDE_DEFAULT_FONT"        .}
when defined NkIncludeFontBaking        : {.passC: "-DNK_INCLUDE_FONT_BAKING"         .}
when defined NkIncludeVertexBufferOutput: {.passC: "-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT".}
when defined NkIncludeCommandUserData   : {.passC: "-DNK_INCLUDE_COMMAND_USER_DATA"   .}
when defined NkUintDrawIndex            : {.passC: "-DNK_UINT_DRAW_INDEX"             .}
when defined NkIncludeStandardIo        : {.passC: "-DNK_INCLUDE_STANDARD_IO"         .}
when defined NkButtonTriggerOnRelease   : {.passC: "-DNK_BUTTON_TRIGGER_ON_RELEASE"   .}
when defined NkIncludeStandardVarargs   : {.passC: "-DNK_INCLUDE_STANDARD_VARARGS"    .}

{.passC: "-DNK_INCLUDE_STANDARD_BOOL".}
{.passC: &"-DNK_MAX_LAYOUT_ROW_TEMPLATE_COLUMNS={NkMaxLayoutRowTemplateColumns}".}
