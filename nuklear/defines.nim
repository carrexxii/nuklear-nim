from std/strformat import `&`

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

when defined NkIncludeDefaultAllocator  : {.passC: "-DNK_INCLUDE_DEFAULT_ALLOCATOR"   .}
when defined NkIncludeDefaultFont       : {.passC: "-DNK_INCLUDE_DEFAULT_FONT"        .}
when defined NkIncludeFontBaking        : {.passC: "-DNK_INCLUDE_FONT_BAKING"         .}
when defined NkIncludeVertexBufferOutput: {.passC: "-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT".}

{.passC: &"""-DNK_MAX_LAYOUT_ROW_TEMPLATE_COLUMNS={NkMaxLayoutRowTemplateColumns}""".}
