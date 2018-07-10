/**********************************************************************************************
*
*   raylib - A simple and easy-to-use library to learn videogames programming (www.raylib.com)
*
*   FEATURES:
*       - NO external dependencies, all required libraries included with raylib
*       - Multiple platforms support: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly, MacOS, UWP, Android, Raspberry Pi, HTML5.
*       - Written in plain C code (C99) in PascalCase/camelCase notation
*       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES2 - choose at compile)
*       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
*       - Powerful fonts module with Fonts support (XNA fonts, AngelCode fonts, TTF)
*       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
*       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
*       - Flexible Materials system, supporting classic maps and PBR maps
*       - Shaders support, including Model shaders and Postprocessing shaders
*       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
*       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
*       - VR stereo rendering with configurable HMD device parameters
*       - Complete bindings to LUA (raylib-lua) and Go (raylib-go)
*
*   NOTES:
*       One custom font is loaded by default when InitWindow() [core]
*       If using OpenGL 3.3 or ES2, one default shader is loaded automatically (internally defined) [rlgl]
*       If using OpenGL 3.3 or ES2, several vertex buffers (VAO/VBO) are created to manage lines-triangles-quads
*
*   DEPENDENCIES (included):
*       rglfw (github.com/glfw/glfw) for window/context management and input (only PLATFORM_DESKTOP) [core]
*       glad (github.com/Dav1dde/glad) for OpenGL extensions loading (3.3 Core profile, only PLATFORM_DESKTOP) [rlgl]
*       mini_al (github.com/dr-soft/mini_al) for audio device/context management [audio]
*
*   OPTIONAL DEPENDENCIES (included):
*       stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...) [textures]
*       stb_image_resize (Sean Barret) for image resizing algorythms [textures]
*       stb_image_write (Sean Barret) for image writting (PNG) [utils]
*       stb_truetype (Sean Barret) for ttf fonts loading [text]
*       stb_rect_pack (Sean Barret) for rectangles packing [text]
*       stb_vorbis (Sean Barret) for OGG audio loading [audio]
*       stb_perlin (Sean Barret) for Perlin noise image generation [textures]
*       par_shapes (Philip Rideout) for parametric 3d shapes generation [models]
*       jar_xm (Joshua Reisenauer) for XM audio module loading [audio]
*       jar_mod (Joshua Reisenauer) for MOD audio module loading [audio]
*       dr_flac (David Reid) for FLAC audio file loading [audio]
*       dr_mp3 (David Reid) for MP3 audio file loading [audio]
*       rgif (Charlie Tangora, Ramon Santamaria) for GIF recording [core]
*
*
*   LICENSE: zlib/libpng
*
*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software:
*
*   Copyright (c) 2013-2018 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/

module raylib;

pragma(lib, "raylib");

extern (C):

// We are building raylib as a Win32 shared library (.dll)

// We are using raylib as a Win32 shared library (.dll) // We are building or using raylib as a static library (or Linux shared library)

//----------------------------------------------------------------------------------
// Some basic Defines
//----------------------------------------------------------------------------------

enum PI = 3.14159265358979323846f;

enum DEG2RAD = PI / 180.0f;
enum RAD2DEG = 180.0f / PI;

// raylib Config Flags
enum FLAG_SHOW_LOGO = 1; // Set to show raylib logo at startup
enum FLAG_FULLSCREEN_MODE = 2; // Set to run program in fullscreen
enum FLAG_WINDOW_RESIZABLE = 4; // Set to allow resizable window
enum FLAG_WINDOW_UNDECORATED = 8; // Set to disable window decoration (frame and buttons)
enum FLAG_WINDOW_TRANSPARENT = 16; // Set to allow transparent window
enum FLAG_MSAA_4X_HINT = 32; // Set to try enabling MSAA 4X
enum FLAG_VSYNC_HINT = 64; // Set to try enabling V-Sync on GPU

// Keyboard Function Keys
enum KEY_SPACE = 32;
enum KEY_ESCAPE = 256;
enum KEY_ENTER = 257;
enum KEY_TAB = 258;
enum KEY_BACKSPACE = 259;
enum KEY_INSERT = 260;
enum KEY_DELETE = 261;
enum KEY_RIGHT = 262;
enum KEY_LEFT = 263;
enum KEY_DOWN = 264;
enum KEY_UP = 265;
enum KEY_PAGE_UP = 266;
enum KEY_PAGE_DOWN = 267;
enum KEY_HOME = 268;
enum KEY_END = 269;
enum KEY_CAPS_LOCK = 280;
enum KEY_SCROLL_LOCK = 281;
enum KEY_NUM_LOCK = 282;
enum KEY_PRINT_SCREEN = 283;
enum KEY_PAUSE = 284;
enum KEY_F1 = 290;
enum KEY_F2 = 291;
enum KEY_F3 = 292;
enum KEY_F4 = 293;
enum KEY_F5 = 294;
enum KEY_F6 = 295;
enum KEY_F7 = 296;
enum KEY_F8 = 297;
enum KEY_F9 = 298;
enum KEY_F10 = 299;
enum KEY_F11 = 300;
enum KEY_F12 = 301;
enum KEY_LEFT_SHIFT = 340;
enum KEY_LEFT_CONTROL = 341;
enum KEY_LEFT_ALT = 342;
enum KEY_RIGHT_SHIFT = 344;
enum KEY_RIGHT_CONTROL = 345;
enum KEY_RIGHT_ALT = 346;
enum KEY_GRAVE = 96;
enum KEY_SLASH = 47;
enum KEY_BACKSLASH = 92;

// Keyboard Alpha Numeric Keys
enum KEY_ZERO = 48;
enum KEY_ONE = 49;
enum KEY_TWO = 50;
enum KEY_THREE = 51;
enum KEY_FOUR = 52;
enum KEY_FIVE = 53;
enum KEY_SIX = 54;
enum KEY_SEVEN = 55;
enum KEY_EIGHT = 56;
enum KEY_NINE = 57;
enum KEY_A = 65;
enum KEY_B = 66;
enum KEY_C = 67;
enum KEY_D = 68;
enum KEY_E = 69;
enum KEY_F = 70;
enum KEY_G = 71;
enum KEY_H = 72;
enum KEY_I = 73;
enum KEY_J = 74;
enum KEY_K = 75;
enum KEY_L = 76;
enum KEY_M = 77;
enum KEY_N = 78;
enum KEY_O = 79;
enum KEY_P = 80;
enum KEY_Q = 81;
enum KEY_R = 82;
enum KEY_S = 83;
enum KEY_T = 84;
enum KEY_U = 85;
enum KEY_V = 86;
enum KEY_W = 87;
enum KEY_X = 88;
enum KEY_Y = 89;
enum KEY_Z = 90;

// Android Physical Buttons
enum KEY_BACK = 4;
enum KEY_MENU = 82;
enum KEY_VOLUME_UP = 24;
enum KEY_VOLUME_DOWN = 25;

// Mouse Buttons
enum MOUSE_LEFT_BUTTON = 0;
enum MOUSE_RIGHT_BUTTON = 1;
enum MOUSE_MIDDLE_BUTTON = 2;

// Touch points registered
enum MAX_TOUCH_POINTS = 2;

// Gamepad Number
enum GAMEPAD_PLAYER1 = 0;
enum GAMEPAD_PLAYER2 = 1;
enum GAMEPAD_PLAYER3 = 2;
enum GAMEPAD_PLAYER4 = 3;

// Gamepad Buttons/Axis

// PS3 USB Controller Buttons
enum GAMEPAD_PS3_BUTTON_TRIANGLE = 0;
enum GAMEPAD_PS3_BUTTON_CIRCLE = 1;
enum GAMEPAD_PS3_BUTTON_CROSS = 2;
enum GAMEPAD_PS3_BUTTON_SQUARE = 3;
enum GAMEPAD_PS3_BUTTON_L1 = 6;
enum GAMEPAD_PS3_BUTTON_R1 = 7;
enum GAMEPAD_PS3_BUTTON_L2 = 4;
enum GAMEPAD_PS3_BUTTON_R2 = 5;
enum GAMEPAD_PS3_BUTTON_START = 8;
enum GAMEPAD_PS3_BUTTON_SELECT = 9;
enum GAMEPAD_PS3_BUTTON_UP = 24;
enum GAMEPAD_PS3_BUTTON_RIGHT = 25;
enum GAMEPAD_PS3_BUTTON_DOWN = 26;
enum GAMEPAD_PS3_BUTTON_LEFT = 27;
enum GAMEPAD_PS3_BUTTON_PS = 12;

// PS3 USB Controller Axis
enum GAMEPAD_PS3_AXIS_LEFT_X = 0;
enum GAMEPAD_PS3_AXIS_LEFT_Y = 1;
enum GAMEPAD_PS3_AXIS_RIGHT_X = 2;
enum GAMEPAD_PS3_AXIS_RIGHT_Y = 5;
enum GAMEPAD_PS3_AXIS_L2 = 3; // [1..-1] (pressure-level)
enum GAMEPAD_PS3_AXIS_R2 = 4; // [1..-1] (pressure-level)

// Xbox360 USB Controller Buttons
enum GAMEPAD_XBOX_BUTTON_A = 0;
enum GAMEPAD_XBOX_BUTTON_B = 1;
enum GAMEPAD_XBOX_BUTTON_X = 2;
enum GAMEPAD_XBOX_BUTTON_Y = 3;
enum GAMEPAD_XBOX_BUTTON_LB = 4;
enum GAMEPAD_XBOX_BUTTON_RB = 5;
enum GAMEPAD_XBOX_BUTTON_SELECT = 6;
enum GAMEPAD_XBOX_BUTTON_START = 7;
enum GAMEPAD_XBOX_BUTTON_UP = 10;
enum GAMEPAD_XBOX_BUTTON_RIGHT = 11;
enum GAMEPAD_XBOX_BUTTON_DOWN = 12;
enum GAMEPAD_XBOX_BUTTON_LEFT = 13;
enum GAMEPAD_XBOX_BUTTON_HOME = 8;

// Android Gamepad Controller (SNES CLASSIC)
enum GAMEPAD_ANDROID_DPAD_UP = 19;
enum GAMEPAD_ANDROID_DPAD_DOWN = 20;
enum GAMEPAD_ANDROID_DPAD_LEFT = 21;
enum GAMEPAD_ANDROID_DPAD_RIGHT = 22;
enum GAMEPAD_ANDROID_DPAD_CENTER = 23;

enum GAMEPAD_ANDROID_BUTTON_A = 96;
enum GAMEPAD_ANDROID_BUTTON_B = 97;
enum GAMEPAD_ANDROID_BUTTON_C = 98;
enum GAMEPAD_ANDROID_BUTTON_X = 99;
enum GAMEPAD_ANDROID_BUTTON_Y = 100;
enum GAMEPAD_ANDROID_BUTTON_Z = 101;
enum GAMEPAD_ANDROID_BUTTON_L1 = 102;
enum GAMEPAD_ANDROID_BUTTON_R1 = 103;
enum GAMEPAD_ANDROID_BUTTON_L2 = 104;
enum GAMEPAD_ANDROID_BUTTON_R2 = 105;

// Xbox360 USB Controller Axis
// NOTE: For Raspberry Pi, axis must be reconfigured

// [-1..1] (left->right)
// [-1..1] (up->down)
// [-1..1] (left->right)
// [-1..1] (up->down)
// [-1..1] (pressure-level)
// [-1..1] (pressure-level)

enum GAMEPAD_XBOX_AXIS_LEFT_X = 0; // [-1..1] (left->right)
enum GAMEPAD_XBOX_AXIS_LEFT_Y = 1; // [1..-1] (up->down)
enum GAMEPAD_XBOX_AXIS_RIGHT_X = 2; // [-1..1] (left->right)
enum GAMEPAD_XBOX_AXIS_RIGHT_Y = 3; // [1..-1] (up->down)
enum GAMEPAD_XBOX_AXIS_LT = 4; // [-1..1] (pressure-level)
enum GAMEPAD_XBOX_AXIS_RT = 5; // [-1..1] (pressure-level)

// NOTE: MSC C++ compiler does not support compound literals (C99 feature)
// Plain structures in C++ (without constructors) can be initialized from { } initializers.

alias CLITERAL = Color;

// Some Basic Colors
// NOTE: Custom raylib color palette for amazing visuals on WHITE background
enum Color LIGHTGRAY = Color(200, 200, 200, 255);   // Light Gray
enum Color GRAY = Color(130, 130, 130, 255);   // Gray
enum Color DARKGRAY = Color(80, 80, 80, 255);      // Dark Gray
enum Color YELLOW = Color(253, 249, 0, 255);     // Yellow
enum Color GOLD = Color(255, 203, 0, 255);     // Gold
enum Color ORANGE = Color(255, 161, 0, 255);     // Orange
enum Color PINK = Color(255, 109, 194, 255);   // Pink
enum Color RED = Color(230, 41, 55, 255);     // Red
enum Color MAROON = Color(190, 33, 55, 255);     // Maroon
enum Color GREEN = Color(0, 228, 48, 255);      // Green
enum Color LIME = Color(0, 158, 47, 255);      // Lime
enum Color DARKGREEN = Color(0, 117, 44, 255);      // Dark Green
enum Color SKYBLUE = Color(102, 191, 255, 255);   // Sky Blue
enum Color BLUE = Color(0, 121, 241, 255);     // Blue
enum Color DARKBLUE = Color(0, 82, 172, 255);      // Dark Blue
enum Color PURPLE = Color(200, 122, 255, 255);   // Purple
enum Color VIOLET = Color(135, 60, 190, 255);    // Violet
enum Color DARKPURPLE = Color(112, 31, 126, 255);    // Dark Purple
enum Color BEIGE = Color(211, 176, 131, 255);   // Beige
enum Color BROWN = Color(127, 106, 79, 255);    // Brown
enum Color DARKBROWN = Color(76, 63, 47, 255);      // Dark Brown

enum Color WHITE = Color(255, 255, 255, 255);   // White
enum Color BLACK = Color(0, 0, 0, 255);         // Black
enum Color BLANK = Color(0, 0, 0, 0);           // Blank (Transparent)
enum Color MAGENTA = Color(255, 0, 255, 255);     // Magenta
enum Color RAYWHITE = Color(245, 245, 245, 255);   // My own White (raylib logo)ss

// Shader and material limits
enum MAX_SHADER_LOCATIONS = 32; // Maximum number of predefined locations stored in shader struct
enum MAX_MATERIAL_MAPS = 12; // Maximum number of texture maps stored in shader struct

//----------------------------------------------------------------------------------
// Structures Definition
//----------------------------------------------------------------------------------

// Vector2 type
struct Vector2
{
    float x;
    float y;
}

// Vector3 type
struct Vector3
{
    float x;
    float y;
    float z;
}

// Vector4 type
struct Vector4
{
    float x;
    float y;
    float z;
    float w;
}

alias Quaternion = Vector4;

// Matrix type (OpenGL style 4x4 - right handed, column major)
struct Matrix
{
    float m0;
    float m4;
    float m8;
    float m12;
    float m1;
    float m5;
    float m9;
    float m13;
    float m2;
    float m6;
    float m10;
    float m14;
    float m3;
    float m7;
    float m11;
    float m15;
}

// Color type, RGBA (32bit)
struct Color
{
    ubyte r;
    ubyte g;
    ubyte b;
    ubyte a;
}

// Rectangle type
struct Rectangle
{
    float x;
    float y;
    float width;
    float height;
}

// Image type, bpp always RGBA (32bit)
// NOTE: Data stored in CPU memory (RAM)
struct Image
{
    void* data; // Image raw data
    int width; // Image base width
    int height; // Image base height
    int mipmaps; // Mipmap levels, 1 by default
    int format; // Data format (PixelFormat type)
}

// Texture2D type
// NOTE: Data stored in GPU memory
struct Texture2D
{
    uint id; // OpenGL texture id
    int width; // Texture base width
    int height; // Texture base height
    int mipmaps; // Mipmap levels, 1 by default
    int format; // Data format (PixelFormat type)
}

// RenderTexture2D type, for texture rendering
struct RenderTexture2D
{
    uint id; // OpenGL Framebuffer Object (FBO) id
    Texture2D texture; // Color buffer attachment texture
    Texture2D depth; // Depth buffer attachment texture
}

// Font character info
struct CharInfo
{
    int value; // Character value (Unicode)
    Rectangle rec; // Character rectangle in sprite font
    int offsetX; // Character offset X when drawing
    int offsetY; // Character offset Y when drawing
    int advanceX; // Character advance position X
    ubyte* data; // Character pixel data (grayscale)
}

// Font type, includes texture and charSet array data
struct Font
{
    Texture2D texture; // Font texture
    int baseSize; // Base size (default chars height)
    int charsCount; // Number of characters
    CharInfo* chars; // Characters info data
}

alias SpriteFont = Font; // SpriteFont type fallback, defaults to Font

// Camera type, defines a camera position/orientation in 3d space
struct Camera3D
{
    Vector3 position; // Camera position
    Vector3 target; // Camera target it looks-at
    Vector3 up; // Camera up vector (rotation over its axis)
    float fovy; // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
    int type; // Camera type, defines projection type: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

alias Camera = Camera3D; // Camera type fallback, defaults to Camera3D

// Camera2D type, defines a 2d camera
struct Camera2D
{
    Vector2 offset; // Camera offset (displacement from target)
    Vector2 target; // Camera target (rotation and zoom origin)
    float rotation; // Camera rotation in degrees
    float zoom; // Camera zoom (scaling), should be 1.0f by default
}

// Bounding box type
struct BoundingBox
{
    Vector3 min; // Minimum vertex box-corner
    Vector3 max; // Maximum vertex box-corner
}

// Vertex data definning a mesh
// NOTE: Data stored in CPU memory (and GPU)
struct Mesh
{
    int vertexCount; // Number of vertices stored in arrays
    int triangleCount; // Number of triangles stored (indexed or not)

    float* vertices; // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float* texcoords; // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    float* texcoords2; // Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
    float* normals; // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    float* tangents; // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    ubyte* colors; // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    ushort* indices; // Vertex indices (in case vertex data comes indexed)

    uint vaoId; // OpenGL Vertex Array Object id
    uint[7] vboId; // OpenGL Vertex Buffer Objects id (7 types of vertex data)
}

// Shader type (generic)
struct Shader
{
    uint id; // Shader program id
    int[MAX_SHADER_LOCATIONS] locs; // Shader locations array
}

// Material texture map
struct MaterialMap
{
    Texture2D texture; // Material map texture
    Color color; // Material map color
    float value; // Material map value
}

// Material type (generic)
struct Material
{
    Shader shader; // Material shader
    MaterialMap[MAX_MATERIAL_MAPS] maps; // Material maps
    float* params; // Material generic parameters (if required)
}

// Model type
struct Model
{
    Mesh mesh; // Vertex data buffers (RAM and VRAM)
    Matrix transform; // Local transform matrix
    Material material; // Shader and textures data
}

// Ray type (useful for raycast)
struct Ray
{
    Vector3 position; // Ray position (origin)
    Vector3 direction; // Ray direction
}

// Raycast hit information
struct RayHitInfo
{
    bool hit; // Did the ray hit something?
    float distance; // Distance to nearest hit
    Vector3 position; // Position of nearest hit
    Vector3 normal; // Surface normal of hit
}

// Wave type, defines audio wave data
struct Wave
{
    uint sampleCount; // Number of samples
    uint sampleRate; // Frequency (samples per second)
    uint sampleSize; // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    uint channels; // Number of channels (1-mono, 2-stereo)
    void* data; // Buffer data pointer
}

// Sound source type
struct Sound
{
    void* audioBuffer; // Pointer to internal data used by the audio system

    uint source; // Audio source id
    uint buffer; // Audio buffer id
    int format; // Audio format specifier
}

// Music type (file streaming from memory)
// NOTE: Anything longer than ~10 seconds should be streamed
struct MusicData;
alias Music = MusicData*;

// Audio stream type
// NOTE: Useful to create custom audio streams not bound to a specific file
struct AudioStream
{
    uint sampleRate; // Frequency (samples per second)
    uint sampleSize; // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    uint channels; // Number of channels (1-mono, 2-stereo)

    void* audioBuffer; // Pointer to internal data used by the audio system.

    int format; // Audio format specifier
    uint source; // Audio source id
    uint[2] buffers; // Audio buffers (double buffering)
}

// Head-Mounted-Display device parameters
struct VrDeviceInfo
{
    int hResolution; // HMD horizontal resolution in pixels
    int vResolution; // HMD vertical resolution in pixels
    float hScreenSize; // HMD horizontal size in meters
    float vScreenSize; // HMD vertical size in meters
    float vScreenCenter; // HMD screen center in meters
    float eyeToScreenDistance; // HMD distance between eye and display in meters
    float lensSeparationDistance; // HMD lens separation distance in meters
    float interpupillaryDistance; // HMD IPD (distance between pupils) in meters
    float[4] lensDistortionValues; // HMD lens distortion constant parameters
    float[4] chromaAbCorrection; // HMD chromatic aberration correction parameters
}

//----------------------------------------------------------------------------------
// Enumerators Definition
//----------------------------------------------------------------------------------
// Trace log type
enum LogType
{
    LOG_INFO = 1,
    LOG_WARNING = 2,
    LOG_ERROR = 4,
    LOG_DEBUG = 8,
    LOG_OTHER = 16
}

// Shader location point type
enum ShaderLocationIndex
{
    LOC_VERTEX_POSITION = 0,
    LOC_VERTEX_TEXCOORD01 = 1,
    LOC_VERTEX_TEXCOORD02 = 2,
    LOC_VERTEX_NORMAL = 3,
    LOC_VERTEX_TANGENT = 4,
    LOC_VERTEX_COLOR = 5,
    LOC_MATRIX_MVP = 6,
    LOC_MATRIX_MODEL = 7,
    LOC_MATRIX_VIEW = 8,
    LOC_MATRIX_PROJECTION = 9,
    LOC_VECTOR_VIEW = 10,
    LOC_COLOR_DIFFUSE = 11,
    LOC_COLOR_SPECULAR = 12,
    LOC_COLOR_AMBIENT = 13,
    LOC_MAP_ALBEDO = 14, // LOC_MAP_DIFFUSE
    LOC_MAP_METALNESS = 15, // LOC_MAP_SPECULAR
    LOC_MAP_NORMAL = 16,
    LOC_MAP_ROUGHNESS = 17,
    LOC_MAP_OCCLUSION = 18,
    LOC_MAP_EMISSION = 19,
    LOC_MAP_HEIGHT = 20,
    LOC_MAP_CUBEMAP = 21,
    LOC_MAP_IRRADIANCE = 22,
    LOC_MAP_PREFILTER = 23,
    LOC_MAP_BRDF = 24
}

enum LOC_MAP_DIFFUSE = ShaderLocationIndex.LOC_MAP_ALBEDO;
enum LOC_MAP_SPECULAR = ShaderLocationIndex.LOC_MAP_METALNESS;

// Material map type
enum TexmapIndex
{
    MAP_ALBEDO = 0, // MAP_DIFFUSE
    MAP_METALNESS = 1, // MAP_SPECULAR
    MAP_NORMAL = 2,
    MAP_ROUGHNESS = 3,
    MAP_OCCLUSION = 4,
    MAP_EMISSION = 5,
    MAP_HEIGHT = 6,
    MAP_CUBEMAP = 7, // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MAP_IRRADIANCE = 8, // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MAP_PREFILTER = 9, // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MAP_BRDF = 10
}

enum MAP_DIFFUSE = TexmapIndex.MAP_ALBEDO;
enum MAP_SPECULAR = TexmapIndex.MAP_METALNESS;

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
enum PixelFormat
{
    UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
    UNCOMPRESSED_GRAY_ALPHA = 2, // 8*2 bpp (2 channels)
    UNCOMPRESSED_R5G6B5 = 3, // 16 bpp
    UNCOMPRESSED_R8G8B8 = 4, // 24 bpp
    UNCOMPRESSED_R5G5B5A1 = 5, // 16 bpp (1 bit alpha)
    UNCOMPRESSED_R4G4B4A4 = 6, // 16 bpp (4 bit alpha)
    UNCOMPRESSED_R8G8B8A8 = 7, // 32 bpp
    UNCOMPRESSED_R32 = 8, // 32 bpp (1 channel - float)
    UNCOMPRESSED_R32G32B32 = 9, // 32*3 bpp (3 channels - float)
    UNCOMPRESSED_R32G32B32A32 = 10, // 32*4 bpp (4 channels - float)
    COMPRESSED_DXT1_RGB = 11, // 4 bpp (no alpha)
    COMPRESSED_DXT1_RGBA = 12, // 4 bpp (1 bit alpha)
    COMPRESSED_DXT3_RGBA = 13, // 8 bpp
    COMPRESSED_DXT5_RGBA = 14, // 8 bpp
    COMPRESSED_ETC1_RGB = 15, // 4 bpp
    COMPRESSED_ETC2_RGB = 16, // 4 bpp
    COMPRESSED_ETC2_EAC_RGBA = 17, // 8 bpp
    COMPRESSED_PVRT_RGB = 18, // 4 bpp
    COMPRESSED_PVRT_RGBA = 19, // 4 bpp
    COMPRESSED_ASTC_4x4_RGBA = 20, // 8 bpp
    COMPRESSED_ASTC_8x8_RGBA = 21 // 2 bpp
}

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
enum TextureFilterMode
{
    FILTER_POINT = 0, // No filter, just pixel aproximation
    FILTER_BILINEAR = 1, // Linear filtering
    FILTER_TRILINEAR = 2, // Trilinear filtering (linear with mipmaps)
    FILTER_ANISOTROPIC_4X = 3, // Anisotropic filtering 4x
    FILTER_ANISOTROPIC_8X = 4, // Anisotropic filtering 8x
    FILTER_ANISOTROPIC_16X = 5 // Anisotropic filtering 16x
}

// Texture parameters: wrap mode
enum TextureWrapMode
{
    WRAP_REPEAT = 0,
    WRAP_CLAMP = 1,
    WRAP_MIRROR = 2
}

// Color blending modes (pre-defined)
enum BlendMode
{
    BLEND_ALPHA = 0,
    BLEND_ADDITIVE = 1,
    BLEND_MULTIPLIED = 2
}

// Gestures type
// NOTE: It could be used as flags to enable only some gestures
enum Gestures
{
    GESTURE_NONE = 0,
    GESTURE_TAP = 1,
    GESTURE_DOUBLETAP = 2,
    GESTURE_HOLD = 4,
    GESTURE_DRAG = 8,
    GESTURE_SWIPE_RIGHT = 16,
    GESTURE_SWIPE_LEFT = 32,
    GESTURE_SWIPE_UP = 64,
    GESTURE_SWIPE_DOWN = 128,
    GESTURE_PINCH_IN = 256,
    GESTURE_PINCH_OUT = 512
}

// Camera system modes
enum CameraMode
{
    CAMERA_CUSTOM = 0,
    CAMERA_FREE = 1,
    CAMERA_ORBITAL = 2,
    CAMERA_FIRST_PERSON = 3,
    CAMERA_THIRD_PERSON = 4
}

// Camera projection modes
enum CameraType
{
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC = 1
}

// Head Mounted Display devices
enum VrDeviceType
{
    HMD_DEFAULT_DEVICE = 0,
    HMD_OCULUS_RIFT_DK2 = 1,
    HMD_OCULUS_RIFT_CV1 = 2,
    HMD_OCULUS_GO = 3,
    HMD_VALVE_HTC_VIVE = 4,
    HMD_SONY_PSVR = 5
}

// Prevents name mangling of functions

//------------------------------------------------------------------------------------
// Global Variables Definition
//------------------------------------------------------------------------------------
// It's lonely here...

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

// Window-related functions
void InitWindow (int width, int height, const(char)* title); // Initialize window and OpenGL context
void CloseWindow (); // Close window and unload OpenGL context
bool IsWindowReady (); // Check if window has been initialized successfully
bool WindowShouldClose (); // Check if KEY_ESCAPE pressed or Close icon pressed
bool IsWindowMinimized (); // Check if window has been minimized (or lost focus)
void ToggleFullscreen (); // Toggle fullscreen mode (only PLATFORM_DESKTOP)
void SetWindowIcon (Image image); // Set icon for window (only PLATFORM_DESKTOP)
void SetWindowTitle (const(char)* title); // Set title for window (only PLATFORM_DESKTOP)
void SetWindowPosition (int x, int y); // Set window position on screen (only PLATFORM_DESKTOP)
void SetWindowMonitor (int monitor); // Set monitor for the current window (fullscreen mode)
void SetWindowMinSize (int width, int height); // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
void SetWindowSize (int width, int height); // Set window dimensions
int GetScreenWidth (); // Get current screen width
int GetScreenHeight (); // Get current screen height

// Cursor-related functions
void ShowCursor (); // Shows cursor
void HideCursor (); // Hides cursor
bool IsCursorHidden (); // Check if cursor is not visible
void EnableCursor (); // Enables cursor (unlock cursor)
void DisableCursor (); // Disables cursor (lock cursor)

// Drawing-related functions
void ClearBackground (Color color); // Set background color (framebuffer clear color)
void BeginDrawing (); // Setup canvas (framebuffer) to start drawing
void EndDrawing (); // End canvas drawing and swap buffers (double buffering)
void BeginMode2D (Camera2D camera); // Initialize 2D mode with custom camera (2D)
void EndMode2D (); // Ends 2D mode with custom camera
void BeginMode3D (Camera3D camera); // Initializes 3D mode with custom camera (3D)
void EndMode3D (); // Ends 3D mode and returns to default 2D orthographic mode
void BeginTextureMode (RenderTexture2D target); // Initializes render texture for drawing
void EndTextureMode (); // Ends drawing to render texture

// Screen-space-related functions
Ray GetMouseRay (Vector2 mousePosition, Camera3D camera); // Returns a ray trace from mouse position
Vector2 GetWorldToScreen (Vector3 position, Camera3D camera); // Returns the screen space position for a 3d world space position
Matrix GetCameraMatrix (Camera3D camera); // Returns camera transform matrix (view matrix)

// Timming-related functions
void SetTargetFPS (int fps); // Set target FPS (maximum)
int GetFPS (); // Returns current FPS
float GetFrameTime (); // Returns time in seconds for last frame drawn
double GetTime (); // Returns elapsed time in seconds since InitWindow()

// Color-related functions
int ColorToInt (Color color); // Returns hexadecimal value for a Color
Vector4 ColorNormalize (Color color); // Returns color normalized as float [0..1]
Vector3 ColorToHSV (Color color); // Returns HSV values for a Color
Color GetColor (int hexValue); // Returns a Color struct from hexadecimal value
Color Fade (Color color, float alpha); // Color fade-in or fade-out, alpha goes from 0.0f to 1.0f

// Misc. functions
void ShowLogo (); // Activate raylib logo at startup (can be done with flags)
void SetConfigFlags (ubyte flags); // Setup window configuration flags (view FLAGS)
void SetTraceLog (ubyte types); // Enable trace log message types (bit flags based)
void TraceLog (int logType, const(char)* text, ...); // Show trace log messages (LOG_INFO, LOG_WARNING, LOG_ERROR, LOG_DEBUG)
void TakeScreenshot (const(char)* fileName); // Takes a screenshot of current screen (saved a .png)
int GetRandomValue (int min, int max); // Returns a random value between min and max (both included)

// Files management functions
bool IsFileExtension (const(char)* fileName, const(char)* ext); // Check file extension
const(char)* GetExtension (const(char)* fileName); // Get pointer to extension for a filename string
const(char)* GetFileName (const(char)* filePath); // Get pointer to filename for a path string
const(char)* GetDirectoryPath (const(char)* fileName); // Get full path for a given fileName (uses static string)
const(char)* GetWorkingDirectory (); // Get current working directory (uses static string)
bool ChangeDirectory (const(char)* dir); // Change working directory, returns true if success
bool IsFileDropped (); // Check if a file has been dropped into window
char** GetDroppedFiles (int* count); // Get dropped files names
void ClearDroppedFiles (); // Clear dropped files paths buffer

// Persistent storage management
void StorageSaveValue (int position, int value); // Save integer value to storage file (to defined position)
int StorageLoadValue (int position); // Load integer value from storage file (from defined position)

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
bool IsKeyPressed (int key); // Detect if a key has been pressed once
bool IsKeyDown (int key); // Detect if a key is being pressed
bool IsKeyReleased (int key); // Detect if a key has been released once
bool IsKeyUp (int key); // Detect if a key is NOT being pressed
int GetKeyPressed (); // Get latest key pressed
void SetExitKey (int key); // Set a custom key to exit program (default is ESC)

// Input-related functions: gamepads
bool IsGamepadAvailable (int gamepad); // Detect if a gamepad is available
bool IsGamepadName (int gamepad, const(char)* name); // Check gamepad name (if available)
const(char)* GetGamepadName (int gamepad); // Return gamepad internal name id
bool IsGamepadButtonPressed (int gamepad, int button); // Detect if a gamepad button has been pressed once
bool IsGamepadButtonDown (int gamepad, int button); // Detect if a gamepad button is being pressed
bool IsGamepadButtonReleased (int gamepad, int button); // Detect if a gamepad button has been released once
bool IsGamepadButtonUp (int gamepad, int button); // Detect if a gamepad button is NOT being pressed
int GetGamepadButtonPressed (); // Get the last gamepad button pressed
int GetGamepadAxisCount (int gamepad); // Return gamepad axis count for a gamepad
float GetGamepadAxisMovement (int gamepad, int axis); // Return axis movement value for a gamepad axis

// Input-related functions: mouse
bool IsMouseButtonPressed (int button); // Detect if a mouse button has been pressed once
bool IsMouseButtonDown (int button); // Detect if a mouse button is being pressed
bool IsMouseButtonReleased (int button); // Detect if a mouse button has been released once
bool IsMouseButtonUp (int button); // Detect if a mouse button is NOT being pressed
int GetMouseX (); // Returns mouse position X
int GetMouseY (); // Returns mouse position Y
Vector2 GetMousePosition (); // Returns mouse position XY
void SetMousePosition (Vector2 position); // Set mouse position XY
void SetMouseScale (float scale); // Set mouse scaling
int GetMouseWheelMove (); // Returns mouse wheel movement Y

// Input-related functions: touch
int GetTouchX (); // Returns touch position X for touch point 0 (relative to screen size)
int GetTouchY (); // Returns touch position Y for touch point 0 (relative to screen size)
Vector2 GetTouchPosition (int index); // Returns touch position XY for a touch point index (relative to screen size)

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: gestures)
//------------------------------------------------------------------------------------
void SetGesturesEnabled (uint gestureFlags); // Enable a set of gestures using flags
bool IsGestureDetected (int gesture); // Check if a gesture have been detected
int GetGestureDetected (); // Get latest detected gesture
int GetTouchPointsCount (); // Get touch points count
float GetGestureHoldDuration (); // Get gesture hold time in milliseconds
Vector2 GetGestureDragVector (); // Get gesture drag vector
float GetGestureDragAngle (); // Get gesture drag angle
Vector2 GetGesturePinchVector (); // Get gesture pinch delta
float GetGesturePinchAngle (); // Get gesture pinch angle

//------------------------------------------------------------------------------------
// Camera System Functions (Module: camera)
//------------------------------------------------------------------------------------
void SetCameraMode (Camera3D camera, int mode); // Set camera mode (multiple camera modes available)
void UpdateCamera (Camera3D* camera); // Update camera position for selected mode

void SetCameraPanControl (int panKey); // Set camera pan key to combine with mouse movement (free camera)
void SetCameraAltControl (int altKey); // Set camera alt key to combine with mouse movement (free camera)
void SetCameraSmoothZoomControl (int szKey); // Set camera smooth zoom key to combine with mouse (free camera)
void SetCameraMoveControls (int frontKey, int backKey, int rightKey, int leftKey, int upKey, int downKey); // Set camera move controls (1st person and 3rd person cameras)

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------

// Basic shapes drawing functions
void DrawPixel (int posX, int posY, Color color); // Draw a pixel
void DrawPixelV (Vector2 position, Color color); // Draw a pixel (Vector version)
void DrawLine (int startPosX, int startPosY, int endPosX, int endPosY, Color color); // Draw a line
void DrawLineV (Vector2 startPos, Vector2 endPos, Color color); // Draw a line (Vector version)
void DrawLineEx (Vector2 startPos, Vector2 endPos, float thick, Color color); // Draw a line defining thickness
void DrawLineBezier (Vector2 startPos, Vector2 endPos, float thick, Color color); // Draw a line using cubic-bezier curves in-out
void DrawCircle (int centerX, int centerY, float radius, Color color); // Draw a color-filled circle
void DrawCircleGradient (int centerX, int centerY, float radius, Color color1, Color color2); // Draw a gradient-filled circle
void DrawCircleV (Vector2 center, float radius, Color color); // Draw a color-filled circle (Vector version)
void DrawCircleLines (int centerX, int centerY, float radius, Color color); // Draw circle outline
void DrawRectangle (int posX, int posY, int width, int height, Color color); // Draw a color-filled rectangle
void DrawRectangleV (Vector2 position, Vector2 size, Color color); // Draw a color-filled rectangle (Vector version)
void DrawRectangleRec (Rectangle rec, Color color); // Draw a color-filled rectangle
void DrawRectanglePro (Rectangle rec, Vector2 origin, float rotation, Color color); // Draw a color-filled rectangle with pro parameters
void DrawRectangleGradientV (int posX, int posY, int width, int height, Color color1, Color color2); // Draw a vertical-gradient-filled rectangle
void DrawRectangleGradientH (int posX, int posY, int width, int height, Color color1, Color color2); // Draw a horizontal-gradient-filled rectangle
void DrawRectangleGradientEx (Rectangle rec, Color col1, Color col2, Color col3, Color col4); // Draw a gradient-filled rectangle with custom vertex colors
void DrawRectangleLines (int posX, int posY, int width, int height, Color color); // Draw rectangle outline
void DrawRectangleLinesEx (Rectangle rec, int lineThick, Color color); // Draw rectangle outline with extended parameters
void DrawTriangle (Vector2 v1, Vector2 v2, Vector2 v3, Color color); // Draw a color-filled triangle
void DrawTriangleLines (Vector2 v1, Vector2 v2, Vector2 v3, Color color); // Draw triangle outline
void DrawPoly (Vector2 center, int sides, float radius, float rotation, Color color); // Draw a regular polygon (Vector version)
void DrawPolyEx (Vector2* points, int numPoints, Color color); // Draw a closed polygon defined by points
void DrawPolyExLines (Vector2* points, int numPoints, Color color); // Draw polygon lines

// Basic shapes collision detection functions
bool CheckCollisionRecs (Rectangle rec1, Rectangle rec2); // Check collision between two rectangles
bool CheckCollisionCircles (Vector2 center1, float radius1, Vector2 center2, float radius2); // Check collision between two circles
bool CheckCollisionCircleRec (Vector2 center, float radius, Rectangle rec); // Check collision between circle and rectangle
Rectangle GetCollisionRec (Rectangle rec1, Rectangle rec2); // Get collision rectangle for two rectangles collision
bool CheckCollisionPointRec (Vector2 point, Rectangle rec); // Check if point is inside rectangle
bool CheckCollisionPointCircle (Vector2 point, Vector2 center, float radius); // Check if point is inside circle
bool CheckCollisionPointTriangle (Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3); // Check if point is inside a triangle

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image/Texture2D data loading/unloading/saving functions
Image LoadImage (const(char)* fileName); // Load image from file into CPU memory (RAM)
Image LoadImageEx (Color* pixels, int width, int height); // Load image from Color array data (RGBA - 32bit)
Image LoadImagePro (void* data, int width, int height, int format); // Load image from raw data with parameters
Image LoadImageRaw (const(char)* fileName, int width, int height, int format, int headerSize); // Load image from RAW file data
void ExportImage (const(char)* fileName, Image image); // Export image as a PNG file
Texture2D LoadTexture (const(char)* fileName); // Load texture from file into GPU memory (VRAM)
Texture2D LoadTextureFromImage (Image image); // Load texture from image data
RenderTexture2D LoadRenderTexture (int width, int height); // Load texture for rendering (framebuffer)
void UnloadImage (Image image); // Unload image from CPU memory (RAM)
void UnloadTexture (Texture2D texture); // Unload texture from GPU memory (VRAM)
void UnloadRenderTexture (RenderTexture2D target); // Unload render texture from GPU memory (VRAM)
Color* GetImageData (Image image); // Get pixel data from image as a Color struct array
Vector4* GetImageDataNormalized (Image image); // Get pixel data from image as Vector4 array (float normalized)
int GetPixelDataSize (int width, int height, int format); // Get pixel data size in bytes (image or texture)
Image GetTextureData (Texture2D texture); // Get pixel data from GPU texture and return an Image
void UpdateTexture (Texture2D texture, const(void)* pixels); // Update GPU texture with new data

// Image manipulation functions
Image ImageCopy (Image image); // Create an image duplicate (useful for transformations)
void ImageToPOT (Image* image, Color fillColor); // Convert image to POT (power-of-two)
void ImageFormat (Image* image, int newFormat); // Convert image data to desired format
void ImageAlphaMask (Image* image, Image alphaMask); // Apply alpha mask to image
void ImageAlphaClear (Image* image, Color color, float threshold); // Clear alpha channel to desired color
void ImageAlphaCrop (Image* image, float threshold); // Crop image depending on alpha value
void ImageAlphaPremultiply (Image* image); // Premultiply alpha channel
void ImageCrop (Image* image, Rectangle crop); // Crop an image to a defined rectangle
void ImageResize (Image* image, int newWidth, int newHeight); // Resize image (bilinear filtering)
void ImageResizeNN (Image* image, int newWidth, int newHeight); // Resize image (Nearest-Neighbor scaling algorithm)
void ImageResizeCanvas (Image* image, int newWidth, int newHeight, int offsetX, int offsetY, Color color); // Resize canvas and fill with color
void ImageMipmaps (Image* image); // Generate all mipmap levels for a provided image
void ImageDither (Image* image, int rBpp, int gBpp, int bBpp, int aBpp); // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
Image ImageText (const(char)* text, int fontSize, Color color); // Create an image from text (default font)
Image ImageTextEx (Font font, const(char)* text, float fontSize, float spacing, Color tint); // Create an image from text (custom sprite font)
void ImageDraw (Image* dst, Image src, Rectangle srcRec, Rectangle dstRec); // Draw a source image within a destination image
void ImageDrawRectangle (Image* dst, Vector2 position, Rectangle rec, Color color); // Draw rectangle within an image
void ImageDrawText (Image* dst, Vector2 position, const(char)* text, int fontSize, Color color); // Draw text (default font) within an image (destination)
void ImageDrawTextEx (Image* dst, Vector2 position, Font font, const(char)* text, float fontSize, float spacing, Color color); // Draw text (custom sprite font) within an image (destination)
void ImageFlipVertical (Image* image); // Flip image vertically
void ImageFlipHorizontal (Image* image); // Flip image horizontally
void ImageRotateCW (Image* image); // Rotate image clockwise 90deg
void ImageRotateCCW (Image* image); // Rotate image counter-clockwise 90deg
void ImageColorTint (Image* image, Color color); // Modify image color: tint
void ImageColorInvert (Image* image); // Modify image color: invert
void ImageColorGrayscale (Image* image); // Modify image color: grayscale
void ImageColorContrast (Image* image, float contrast); // Modify image color: contrast (-100 to 100)
void ImageColorBrightness (Image* image, int brightness); // Modify image color: brightness (-255 to 255)
void ImageColorReplace (Image* image, Color color, Color replace); // Modify image color: replace color

// Image generation functions
Image GenImageColor (int width, int height, Color color); // Generate image: plain color
Image GenImageGradientV (int width, int height, Color top, Color bottom); // Generate image: vertical gradient
Image GenImageGradientH (int width, int height, Color left, Color right); // Generate image: horizontal gradient
Image GenImageGradientRadial (int width, int height, float density, Color inner, Color outer); // Generate image: radial gradient
Image GenImageChecked (int width, int height, int checksX, int checksY, Color col1, Color col2); // Generate image: checked
Image GenImageWhiteNoise (int width, int height, float factor); // Generate image: white noise
Image GenImagePerlinNoise (int width, int height, int offsetX, int offsetY, float scale); // Generate image: perlin noise
Image GenImageCellular (int width, int height, int tileSize); // Generate image: cellular algorithm. Bigger tileSize means bigger cells

// Texture2D configuration functions
void GenTextureMipmaps (Texture2D* texture); // Generate GPU mipmaps for a texture
void SetTextureFilter (Texture2D texture, int filterMode); // Set texture scaling filter mode
void SetTextureWrap (Texture2D texture, int wrapMode); // Set texture wrapping mode

// Texture2D drawing functions
void DrawTexture (Texture2D texture, int posX, int posY, Color tint); // Draw a Texture2D
void DrawTextureV (Texture2D texture, Vector2 position, Color tint); // Draw a Texture2D with position defined as Vector2
void DrawTextureEx (Texture2D texture, Vector2 position, float rotation, float scale, Color tint); // Draw a Texture2D with extended parameters
void DrawTextureRec (Texture2D texture, Rectangle sourceRec, Vector2 position, Color tint); // Draw a part of a texture defined by a rectangle
void DrawTexturePro (Texture2D texture, Rectangle sourceRec, Rectangle destRec, Vector2 origin, float rotation, Color tint); // Draw a part of a texture defined by a rectangle with 'pro' parameters

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
Font GetFontDefault (); // Get the default Font
Font LoadFont (const(char)* fileName); // Load font from file into GPU memory (VRAM)
Font LoadFontEx (const(char)* fileName, int fontSize, int charsCount, int* fontChars); // Load font from file with extended parameters
CharInfo* LoadFontData (const(char)* fileName, int fontSize, int* fontChars, int charsCount, bool sdf); // Load font data for further use
Image GenImageFontAtlas (CharInfo* chars, int fontSize, int charsCount, int padding, int packMethod); // Generate image font atlas using chars info
void UnloadFont (Font font); // Unload Font from GPU memory (VRAM)

// Text drawing functions
void DrawFPS (int posX, int posY); // Shows current FPS
void DrawText (const(char)* text, int posX, int posY, int fontSize, Color color); // Draw text (using default font)
void DrawTextEx (Font font, const(char)* text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters

// Text misc. functions
int MeasureText (const(char)* text, int fontSize); // Measure string width for default font
Vector2 MeasureTextEx (Font font, const(char)* text, float fontSize, float spacing); // Measure string size for Font
const(char)* FormatText (const(char)* text, ...); // Formatting of text with variables to 'embed'
const(char)* SubText (const(char)* text, int position, int length); // Get a piece of a text string
int GetGlyphIndex (Font font, int character); // Get index position for a unicode character on sprite font

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
void DrawLine3D (Vector3 startPos, Vector3 endPos, Color color); // Draw a line in 3D world space
void DrawCircle3D (Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space
void DrawCube (Vector3 position, float width, float height, float length, Color color); // Draw cube
void DrawCubeV (Vector3 position, Vector3 size, Color color); // Draw cube (Vector version)
void DrawCubeWires (Vector3 position, float width, float height, float length, Color color); // Draw cube wires
void DrawCubeTexture (Texture2D texture, Vector3 position, float width, float height, float length, Color color); // Draw cube textured
void DrawSphere (Vector3 centerPos, float radius, Color color); // Draw sphere
void DrawSphereEx (Vector3 centerPos, float radius, int rings, int slices, Color color); // Draw sphere with extended parameters
void DrawSphereWires (Vector3 centerPos, float radius, int rings, int slices, Color color); // Draw sphere wires
void DrawCylinder (Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone
void DrawCylinderWires (Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires
void DrawPlane (Vector3 centerPos, Vector2 size, Color color); // Draw a plane XZ
void DrawRay (Ray ray, Color color); // Draw a ray line
void DrawGrid (int slices, float spacing); // Draw a grid (centered at (0, 0, 0))
void DrawGizmo (Vector3 position); // Draw simple gizmo
//DrawTorus(), DrawTeapot() could be useful?

//------------------------------------------------------------------------------------
// Model 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model loading/unloading functions
Model LoadModel (const(char)* fileName); // Load model from files (mesh and material)
Model LoadModelFromMesh (Mesh mesh); // Load model from generated mesh
void UnloadModel (Model model); // Unload model from memory (RAM and/or VRAM)

// Mesh loading/unloading functions
Mesh LoadMesh (const(char)* fileName); // Load mesh from file
void UnloadMesh (Mesh* mesh); // Unload mesh from memory (RAM and/or VRAM)
void ExportMesh (const(char)* fileName, Mesh mesh); // Export mesh as an OBJ file

// Mesh manipulation functions
BoundingBox MeshBoundingBox (Mesh mesh); // Compute mesh bounding box limits
void MeshTangents (Mesh* mesh); // Compute mesh tangents
void MeshBinormals (Mesh* mesh); // Compute mesh binormals

// Mesh generation functions
Mesh GenMeshPlane (float width, float length, int resX, int resZ); // Generate plane mesh (with subdivisions)
Mesh GenMeshCube (float width, float height, float length); // Generate cuboid mesh
Mesh GenMeshSphere (float radius, int rings, int slices); // Generate sphere mesh (standard sphere)
Mesh GenMeshHemiSphere (float radius, int rings, int slices); // Generate half-sphere mesh (no bottom cap)
Mesh GenMeshCylinder (float radius, float height, int slices); // Generate cylinder mesh
Mesh GenMeshTorus (float radius, float size, int radSeg, int sides); // Generate torus mesh
Mesh GenMeshKnot (float radius, float size, int radSeg, int sides); // Generate trefoil knot mesh
Mesh GenMeshHeightmap (Image heightmap, Vector3 size); // Generate heightmap mesh from image data
Mesh GenMeshCubicmap (Image cubicmap, Vector3 cubeSize); // Generate cubes-based map mesh from image data

// Material loading/unloading functions
Material LoadMaterial (const(char)* fileName); // Load material from file
Material LoadMaterialDefault (); // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
void UnloadMaterial (Material material); // Unload material from GPU memory (VRAM)

// Model drawing functions
void DrawModel (Model model, Vector3 position, float scale, Color tint); // Draw a model (with texture if set)
void DrawModelEx (Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters
void DrawModelWires (Model model, Vector3 position, float scale, Color tint); // Draw a model wires (with texture if set)
void DrawModelWiresEx (Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters
void DrawBoundingBox (BoundingBox box, Color color); // Draw bounding box (wires)
void DrawBillboard (Camera3D camera, Texture2D texture, Vector3 center, float size, Color tint); // Draw a billboard texture
void DrawBillboardRec (Camera3D camera, Texture2D texture, Rectangle sourceRec, Vector3 center, float size, Color tint); // Draw a billboard texture defined by sourceRec

// Collision detection functions
bool CheckCollisionSpheres (Vector3 centerA, float radiusA, Vector3 centerB, float radiusB); // Detect collision between two spheres
bool CheckCollisionBoxes (BoundingBox box1, BoundingBox box2); // Detect collision between two bounding boxes
bool CheckCollisionBoxSphere (BoundingBox box, Vector3 centerSphere, float radiusSphere); // Detect collision between box and sphere
bool CheckCollisionRaySphere (Ray ray, Vector3 spherePosition, float sphereRadius); // Detect collision between ray and sphere
bool CheckCollisionRaySphereEx (Ray ray, Vector3 spherePosition, float sphereRadius, Vector3* collisionPoint); // Detect collision between ray and sphere, returns collision point
bool CheckCollisionRayBox (Ray ray, BoundingBox box); // Detect collision between ray and box
RayHitInfo GetCollisionRayModel (Ray ray, Model* model); // Get collision info between ray and model
RayHitInfo GetCollisionRayTriangle (Ray ray, Vector3 p1, Vector3 p2, Vector3 p3); // Get collision info between ray and triangle
RayHitInfo GetCollisionRayGround (Ray ray, float groundHeight); // Get collision info between ray and ground plane (Y-normal plane)

//------------------------------------------------------------------------------------
// Shaders System Functions (Module: rlgl)
// NOTE: This functions are useless when using OpenGL 1.1
//------------------------------------------------------------------------------------

// Shader loading/unloading functions
char* LoadText (const(char)* fileName); // Load chars array from text file
Shader LoadShader (const(char)* vsFileName, const(char)* fsFileName); // Load shader from files and bind default locations
Shader LoadShaderCode (char* vsCode, char* fsCode); // Load shader from code strings and bind default locations
void UnloadShader (Shader shader); // Unload shader from GPU memory (VRAM)

Shader GetShaderDefault (); // Get default shader
Texture2D GetTextureDefault (); // Get default texture

// Shader configuration functions
int GetShaderLocation (Shader shader, const(char)* uniformName); // Get shader uniform location
void SetShaderValue (Shader shader, int uniformLoc, const(float)* value, int size); // Set shader uniform value (float)
void SetShaderValuei (Shader shader, int uniformLoc, const(int)* value, int size); // Set shader uniform value (int)
void SetShaderValueMatrix (Shader shader, int uniformLoc, Matrix mat); // Set shader uniform value (matrix 4x4)
void SetMatrixProjection (Matrix proj); // Set a custom projection matrix (replaces internal projection matrix)
void SetMatrixModelview (Matrix view); // Set a custom modelview matrix (replaces internal modelview matrix)
Matrix GetMatrixModelview (); // Get internal modelview matrix

// Texture maps generation (PBR)
// NOTE: Required shaders should be provided
Texture2D GenTextureCubemap (Shader shader, Texture2D skyHDR, int size); // Generate cubemap texture from HDR texture
Texture2D GenTextureIrradiance (Shader shader, Texture2D cubemap, int size); // Generate irradiance texture using cubemap data
Texture2D GenTexturePrefilter (Shader shader, Texture2D cubemap, int size); // Generate prefilter texture using cubemap data
Texture2D GenTextureBRDF (Shader shader, Texture2D cubemap, int size); // Generate BRDF texture using cubemap data

// Shading begin/end functions
void BeginShaderMode (Shader shader); // Begin custom shader drawing
void EndShaderMode (); // End custom shader drawing (use default shader)
void BeginBlendMode (int mode); // Begin blending mode (alpha, additive, multiplied)
void EndBlendMode (); // End blending mode (reset to default: alpha blending)

// VR control functions
VrDeviceInfo GetVrDeviceInfo (int vrDeviceType); // Get VR device information for some standard devices
void InitVrSimulator (VrDeviceInfo info); // Init VR simulator for selected device parameters
void CloseVrSimulator (); // Close VR simulator for current device
bool IsVrSimulatorReady (); // Detect if VR simulator is ready
void SetVrDistortionShader (Shader shader); // Set VR distortion shader for stereoscopic rendering
void UpdateVrTracking (Camera3D* camera); // Update VR tracking (position and orientation) and camera
void ToggleVrMode (); // Enable/Disable VR experience
void BeginVrDrawing (); // Begin VR simulator stereo rendering
void EndVrDrawing (); // End VR simulator stereo rendering

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------

// Audio device management functions
void InitAudioDevice (); // Initialize audio device and context
void CloseAudioDevice (); // Close the audio device and context
bool IsAudioDeviceReady (); // Check if audio device has been initialized successfully
void SetMasterVolume (float volume); // Set master volume (listener)

// Wave/Sound loading/unloading functions
Wave LoadWave (const(char)* fileName); // Load wave data from file
Wave LoadWaveEx (void* data, int sampleCount, int sampleRate, int sampleSize, int channels); // Load wave data from raw array data
Sound LoadSound (const(char)* fileName); // Load sound from file
Sound LoadSoundFromWave (Wave wave); // Load sound from wave data
void UpdateSound (Sound sound, const(void)* data, int samplesCount); // Update sound buffer with new data
void UnloadWave (Wave wave); // Unload wave data
void UnloadSound (Sound sound); // Unload sound

// Wave/Sound management functions
void PlaySound (Sound sound); // Play a sound
void PauseSound (Sound sound); // Pause a sound
void ResumeSound (Sound sound); // Resume a paused sound
void StopSound (Sound sound); // Stop playing a sound
bool IsSoundPlaying (Sound sound); // Check if a sound is currently playing
void SetSoundVolume (Sound sound, float volume); // Set volume for a sound (1.0 is max level)
void SetSoundPitch (Sound sound, float pitch); // Set pitch for a sound (1.0 is base level)
void WaveFormat (Wave* wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format
Wave WaveCopy (Wave wave); // Copy a wave to a new wave
void WaveCrop (Wave* wave, int initSample, int finalSample); // Crop a wave to defined samples range
float* GetWaveData (Wave wave); // Get samples data from wave as a floats array

// Music management functions
Music LoadMusicStream (const(char)* fileName); // Load music stream from file
void UnloadMusicStream (Music music); // Unload music stream
void PlayMusicStream (Music music); // Start music playing
void UpdateMusicStream (Music music); // Updates buffers for music streaming
void StopMusicStream (Music music); // Stop music playing
void PauseMusicStream (Music music); // Pause music playing
void ResumeMusicStream (Music music); // Resume playing paused music
bool IsMusicPlaying (Music music); // Check if music is playing
void SetMusicVolume (Music music, float volume); // Set volume for music (1.0 is max level)
void SetMusicPitch (Music music, float pitch); // Set pitch for a music (1.0 is base level)
void SetMusicLoopCount (Music music, int count); // Set music loop count (loop repeats)
float GetMusicTimeLength (Music music); // Get music time length (in seconds)
float GetMusicTimePlayed (Music music); // Get current music time played (in seconds)

// AudioStream management functions
AudioStream InitAudioStream (uint sampleRate, uint sampleSize, uint channels); // Init audio stream (to stream raw audio pcm data)
void UpdateAudioStream (AudioStream stream, const(void)* data, int samplesCount); // Update audio stream buffers with data
void CloseAudioStream (AudioStream stream); // Close audio stream and free memory
bool IsAudioBufferProcessed (AudioStream stream); // Check if any audio stream buffers requires refill
void PlayAudioStream (AudioStream stream); // Play audio stream
void PauseAudioStream (AudioStream stream); // Pause audio stream
void ResumeAudioStream (AudioStream stream); // Resume audio stream
bool IsAudioStreamPlaying (AudioStream stream); // Check if audio stream is playing
void StopAudioStream (AudioStream stream); // Stop audio stream
void SetAudioStreamVolume (AudioStream stream, float volume); // Set volume for audio stream (1.0 is max level)
void SetAudioStreamPitch (AudioStream stream, float pitch); // Set pitch for audio stream (1.0 is base level)

// RAYLIB_H
