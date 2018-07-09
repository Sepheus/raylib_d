module raylib;

pragma(lib, "raylib");

extern (C):

/* --- begin manual inserts */

enum float PI = 3.14159265358979323846f;

enum float DEG2RAD = (PI/180.0f);
enum float RAD2DEG = (180.0f/PI);

// raylib Config Flags
enum int FLAG_SHOW_LOGO            =  1;       // Set to show raylib logo at startup
enum int FLAG_FULLSCREEN_MODE      =  2;       // Set to run program in fullscreen
enum int FLAG_WINDOW_RESIZABLE     =  4;       // Set to allow resizable window
enum int FLAG_WINDOW_UNDECORATED   =  8;       // Set to disable window decoration (frame and buttons)
enum int FLAG_WINDOW_TRANSPARENT   = 16;       // Set to allow transparent window
enum int FLAG_MSAA_4X_HINT         = 32;       // Set to try enabling MSAA 4X
enum int FLAG_VSYNC_HINT           = 64;       // Set to try enabling V-Sync on GPU

// Keyboard Function Keys
enum int KEY_SPACE          =  32;
enum int KEY_ESCAPE         = 256;
enum int KEY_ENTER          = 257;
enum int KEY_TAB            = 258;
enum int KEY_BACKSPACE      = 259;
enum int KEY_INSERT         = 260;
enum int KEY_DELETE         = 261;
enum int KEY_RIGHT          = 262;
enum int KEY_LEFT           = 263;
enum int KEY_DOWN           = 264;
enum int KEY_UP             = 265;
enum int KEY_PAGE_UP        = 266;
enum int KEY_PAGE_DOWN      = 267;
enum int KEY_HOME           = 268;
enum int KEY_END            = 269;
enum int KEY_CAPS_LOCK      = 280;
enum int KEY_SCROLL_LOCK    = 281;
enum int KEY_NUM_LOCK       = 282;
enum int KEY_PRINT_SCREEN   = 283;
enum int KEY_PAUSE          = 284;
enum int KEY_F1             = 290;
enum int KEY_F2             = 291;
enum int KEY_F3             = 292;
enum int KEY_F4             = 293;
enum int KEY_F5             = 294;
enum int KEY_F6             = 295;
enum int KEY_F7             = 296;
enum int KEY_F8             = 297;
enum int KEY_F9             = 298;
enum int KEY_F10            = 299;
enum int KEY_F11            = 300;
enum int KEY_F12            = 301;
enum int KEY_LEFT_SHIFT     = 340;
enum int KEY_LEFT_CONTROL   = 341;
enum int KEY_LEFT_ALT       = 342;
enum int KEY_RIGHT_SHIFT    = 344;
enum int KEY_RIGHT_CONTROL  = 345;
enum int KEY_RIGHT_ALT      = 346;
enum int KEY_GRAVE          =  96;
enum int KEY_SLASH          =  47;
enum int KEY_BACKSLASH      =  92;

// Keyboard Alpha Numeric Keys
enum int KEY_ZERO            = 48;
enum int KEY_ONE             = 49;
enum int KEY_TWO             = 50;
enum int KEY_THREE           = 51;
enum int KEY_FOUR            = 52;
enum int KEY_FIVE            = 53;
enum int KEY_SIX             = 54;
enum int KEY_SEVEN           = 55;
enum int KEY_EIGHT           = 56;
enum int KEY_NINE            = 57;
enum int KEY_A               = 65;
enum int KEY_B               = 66;
enum int KEY_C               = 67;
enum int KEY_D               = 68;
enum int KEY_E               = 69;
enum int KEY_F               = 70;
enum int KEY_G               = 71;
enum int KEY_H               = 72;
enum int KEY_I               = 73;
enum int KEY_J               = 74;
enum int KEY_K               = 75;
enum int KEY_L               = 76;
enum int KEY_M               = 77;
enum int KEY_N               = 78;
enum int KEY_O               = 79;
enum int KEY_P               = 80;
enum int KEY_Q               = 81;
enum int KEY_R               = 82;
enum int KEY_S               = 83;
enum int KEY_T               = 84;
enum int KEY_U               = 85;
enum int KEY_V               = 86;
enum int KEY_W               = 87;
enum int KEY_X               = 88;
enum int KEY_Y               = 89;
enum int KEY_Z               = 90;

// Android Physical Buttons
enum int KEY_BACK            =  4;
enum int KEY_MENU            = 82;
enum int KEY_VOLUME_UP       = 24;
enum int KEY_VOLUME_DOWN     = 25;

// Mouse Buttons
enum int MOUSE_LEFT_BUTTON    = 0;
enum int MOUSE_RIGHT_BUTTON   = 1;
enum int MOUSE_MIDDLE_BUTTON  = 2;

// Touch points registered
enum int MAX_TOUCH_POINTS      = 2;

// Gamepad Number
enum int GAMEPAD_PLAYER1      = 0;
enum int GAMEPAD_PLAYER2      = 1;
enum int GAMEPAD_PLAYER3      = 2;
enum int GAMEPAD_PLAYER4      = 3;

// Gamepad Buttons/Axis

// PS3 USB Controller Buttons
enum int GAMEPAD_PS3_BUTTON_TRIANGLE =  0;
enum int GAMEPAD_PS3_BUTTON_CIRCLE   =  1;
enum int GAMEPAD_PS3_BUTTON_CROSS    =  2;
enum int GAMEPAD_PS3_BUTTON_SQUARE   =  3;
enum int GAMEPAD_PS3_BUTTON_L1       =  6;
enum int GAMEPAD_PS3_BUTTON_R1       =  7;
enum int GAMEPAD_PS3_BUTTON_L2       =  4;
enum int GAMEPAD_PS3_BUTTON_R2       =  5;
enum int GAMEPAD_PS3_BUTTON_START    =  8;
enum int GAMEPAD_PS3_BUTTON_SELECT   =  9;
enum int GAMEPAD_PS3_BUTTON_UP       = 24;
enum int GAMEPAD_PS3_BUTTON_RIGHT    = 25;
enum int GAMEPAD_PS3_BUTTON_DOWN     = 26;
enum int GAMEPAD_PS3_BUTTON_LEFT     = 27;
enum int GAMEPAD_PS3_BUTTON_PS       = 12;

// PS3 USB Controller Axis
enum int GAMEPAD_PS3_AXIS_LEFT_X    = 0;
enum int GAMEPAD_PS3_AXIS_LEFT_Y    = 1;
enum int GAMEPAD_PS3_AXIS_RIGHT_X   = 2;
enum int GAMEPAD_PS3_AXIS_RIGHT_Y   = 5;
enum int GAMEPAD_PS3_AXIS_L2        = 3;       // [1..-1] (pressure-level)
enum int GAMEPAD_PS3_AXIS_R2        = 4;       // [1..-1] (pressure-level)

// Xbox360 USB Controller Buttons
enum int GAMEPAD_XBOX_BUTTON_A      = 0;
enum int GAMEPAD_XBOX_BUTTON_B      = 1;
enum int GAMEPAD_XBOX_BUTTON_X      = 2;
enum int GAMEPAD_XBOX_BUTTON_Y      = 3;
enum int GAMEPAD_XBOX_BUTTON_LB     = 4;
enum int GAMEPAD_XBOX_BUTTON_RB     = 5;
enum int GAMEPAD_XBOX_BUTTON_SELECT = 6;
enum int GAMEPAD_XBOX_BUTTON_START  = 7;
enum int GAMEPAD_XBOX_BUTTON_UP     = 10;
enum int GAMEPAD_XBOX_BUTTON_RIGHT  = 11;
enum int GAMEPAD_XBOX_BUTTON_DOWN   = 12;
enum int GAMEPAD_XBOX_BUTTON_LEFT   = 13;
enum int GAMEPAD_XBOX_BUTTON_HOME   = 8;

// Android Gamepad Controller (SNES CLASSIC)
enum int GAMEPAD_ANDROID_DPAD_UP       = 19;
enum int GAMEPAD_ANDROID_DPAD_DOWN     = 20;
enum int GAMEPAD_ANDROID_DPAD_LEFT     = 21;
enum int GAMEPAD_ANDROID_DPAD_RIGHT    = 22;
enum int GAMEPAD_ANDROID_DPAD_CENTER   = 23;

enum int GAMEPAD_ANDROID_BUTTON_A      = 96;
enum int GAMEPAD_ANDROID_BUTTON_B      = 97;
enum int GAMEPAD_ANDROID_BUTTON_C      = 98;
enum int GAMEPAD_ANDROID_BUTTON_X      = 99;
enum int GAMEPAD_ANDROID_BUTTON_Y      = 100;
enum int GAMEPAD_ANDROID_BUTTON_Z      = 101;
enum int GAMEPAD_ANDROID_BUTTON_L1     = 102;
enum int GAMEPAD_ANDROID_BUTTON_R1     = 103;
enum int GAMEPAD_ANDROID_BUTTON_L2     = 104;
enum int GAMEPAD_ANDROID_BUTTON_R2     = 105;

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
enum Color RAYWHITE = Color(245, 245, 245, 255);   // My own White (raylib logo)

// Shader and material limits
enum int MAX_SHADER_LOCATIONS       = 32;      // Maximum number of predefined locations stored in shader struct
enum int MAX_MATERIAL_MAPS          = 12;      // Maximum number of texture maps stored in shader struct


/* --- end manual inserts */

// alias Vector2 Vector2;
// alias Vector3 Vector3;
// alias Vector4 Vector4;
// alias Matrix Matrix;
// alias Color Color;
// alias Rectangle Rectangle;
// alias Image Image;
// alias Texture2D Texture2D;
// alias RenderTexture2D RenderTexture2D;
// alias CharInfo CharInfo;
// alias SpriteFont SpriteFont;
// alias CameraType CameraType;
// alias Camera Camera;
// alias Camera2D Camera2D;
// alias BoundingBox BoundingBox;
// alias Mesh Mesh;
// alias Shader Shader;
// alias MaterialMap MaterialMap;
// alias Material Material;
// alias Model Model;
// alias Ray Ray;
// alias RayHitInfo RayHitInfo;
// alias Wave Wave;
// alias Sound Sound;
alias MusicData* Music;
// alias AudioStream AudioStream;
// alias VrDeviceInfo VrDeviceInfo;
// alias LogType LogType;
// alias ShaderLocationIndex ShaderLocationIndex;
// alias TexmapIndex TexmapIndex;
// alias PixelFormat PixelFormat;
// alias TextureFilterMode TextureFilterMode;
// alias TextureWrapMode TextureWrapMode;
// alias BlendMode BlendMode;
// alias Gestures Gestures;
// alias CameraMode CameraMode;
// alias VrDeviceType VrDeviceType;

enum CameraType
{
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC = 1
}

enum LogType
{
    LOG_INFO = 1,
    LOG_WARNING = 2,
    LOG_ERROR = 4,
    LOG_DEBUG = 8,
    LOG_OTHER = 16
}

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
    LOC_MAP_ALBEDO = 14,
    LOC_MAP_METALNESS = 15,
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

enum TexmapIndex
{
    MAP_ALBEDO = 0,
    MAP_METALNESS = 1,
    MAP_NORMAL = 2,
    MAP_ROUGHNESS = 3,
    MAP_OCCLUSION = 4,
    MAP_EMISSION = 5,
    MAP_HEIGHT = 6,
    MAP_CUBEMAP = 7,
    MAP_IRRADIANCE = 8,
    MAP_PREFILTER = 9,
    MAP_BRDF = 10
}

enum PixelFormat
{
    UNCOMPRESSED_GRAYSCALE = 1,
    UNCOMPRESSED_GRAY_ALPHA = 2,
    UNCOMPRESSED_R5G6B5 = 3,
    UNCOMPRESSED_R8G8B8 = 4,
    UNCOMPRESSED_R5G5B5A1 = 5,
    UNCOMPRESSED_R4G4B4A4 = 6,
    UNCOMPRESSED_R8G8B8A8 = 7,
    UNCOMPRESSED_R32 = 8,
    UNCOMPRESSED_R32G32B32 = 9,
    UNCOMPRESSED_R32G32B32A32 = 10,
    COMPRESSED_DXT1_RGB = 11,
    COMPRESSED_DXT1_RGBA = 12,
    COMPRESSED_DXT3_RGBA = 13,
    COMPRESSED_DXT5_RGBA = 14,
    COMPRESSED_ETC1_RGB = 15,
    COMPRESSED_ETC2_RGB = 16,
    COMPRESSED_ETC2_EAC_RGBA = 17,
    COMPRESSED_PVRT_RGB = 18,
    COMPRESSED_PVRT_RGBA = 19,
    COMPRESSED_ASTC_4x4_RGBA = 20,
    COMPRESSED_ASTC_8x8_RGBA = 21
}

enum TextureFilterMode
{
    FILTER_POINT = 0,
    FILTER_BILINEAR = 1,
    FILTER_TRILINEAR = 2,
    FILTER_ANISOTROPIC_4X = 3,
    FILTER_ANISOTROPIC_8X = 4,
    FILTER_ANISOTROPIC_16X = 5
}

enum TextureWrapMode
{
    WRAP_REPEAT = 0,
    WRAP_CLAMP = 1,
    WRAP_MIRROR = 2
}

enum BlendMode
{
    BLEND_ALPHA = 0,
    BLEND_ADDITIVE = 1,
    BLEND_MULTIPLIED = 2
}

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

enum CameraMode
{
    CAMERA_CUSTOM = 0,
    CAMERA_FREE = 1,
    CAMERA_ORBITAL = 2,
    CAMERA_FIRST_PERSON = 3,
    CAMERA_THIRD_PERSON = 4
}

enum VrDeviceType
{
    HMD_DEFAULT_DEVICE = 0,
    HMD_OCULUS_RIFT_DK2 = 1,
    HMD_OCULUS_RIFT_CV1 = 2,
    HMD_OCULUS_GO = 3,
    HMD_VALVE_HTC_VIVE = 4,
    HMD_SONY_PSVR = 5
}

struct Vector2
{
    float x;
    float y;
}

struct Vector3
{
    float x;
    float y;
    float z;
}

struct Vector4
{
    float x;
    float y;
    float z;
    float w;
}

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

struct Color
{
    ubyte r;
    ubyte g;
    ubyte b;
    ubyte a;
}

struct Rectangle
{
    int x;
    int y;
    int width;
    int height;
}

struct Image
{
    void* data;
    int width;
    int height;
    int mipmaps;
    int format;
}

struct Texture2D
{
    uint id;
    int width;
    int height;
    int mipmaps;
    int format;
}

struct RenderTexture2D
{
    uint id;
    Texture2D texture;
    Texture2D depth;
}

struct CharInfo
{
    int value;
    Rectangle rec;
    int offsetX;
    int offsetY;
    int advanceX;
}

struct SpriteFont
{
    Texture2D texture;
    int baseSize;
    int charsCount;
    CharInfo* chars;
}

struct Camera
{
    Vector3 position;
    Vector3 target;
    Vector3 up;
    float fovy;
    CameraType type;
}

struct Camera2D
{
    Vector2 offset;
    Vector2 target;
    float rotation;
    float zoom;
}

struct BoundingBox
{
    Vector3 min;
    Vector3 max;
}

struct Mesh
{
    int vertexCount;
    int triangleCount;
    float* vertices;
    float* texcoords;
    float* texcoords2;
    float* normals;
    float* tangents;
    ubyte* colors;
    ushort* indices;
    uint vaoId;
    uint[7] vboId;
}

struct Shader
{
    uint id;
    int[32] locs;
}

struct MaterialMap
{
    Texture2D texture;
    Color color;
    float value;
}

struct Material
{
    Shader shader;
    MaterialMap[12] maps;
    float* params;
}

struct Model
{
    Mesh mesh;
    Matrix transform;
    Material material;
}

struct Ray
{
    Vector3 position;
    Vector3 direction;
}

struct RayHitInfo
{
    bool hit;
    float distance;
    Vector3 position;
    Vector3 normal;
}

struct Wave
{
    uint sampleCount;
    uint sampleRate;
    uint sampleSize;
    uint channels;
    void* data;
}

struct Sound
{
    void* audioBuffer;
    uint source;
    uint buffer;
    int format;
}

struct AudioStream
{
    uint sampleRate;
    uint sampleSize;
    uint channels;
    void* audioBuffer;
    int format;
    uint source;
    uint[2] buffers;
}

struct VrDeviceInfo
{
    int hResolution;
    int vResolution;
    float hScreenSize;
    float vScreenSize;
    float vScreenCenter;
    float eyeToScreenDistance;
    float lensSeparationDistance;
    float interpupillaryDistance;
    float[4] lensDistortionValues;
    float[4] chromaAbCorrection;
}

struct MusicData;


void InitWindow (int width, int height, const(char)* title);
void CloseWindow ();
bool IsWindowReady ();
bool WindowShouldClose ();
bool IsWindowMinimized ();
void ToggleFullscreen ();
void SetWindowIcon (Image image);
void SetWindowTitle (const(char)* title);
void SetWindowPosition (int x, int y);
void SetWindowMonitor (int monitor);
void SetWindowMinSize (int width, int height);
void SetWindowSize (int width, int height);
int GetScreenWidth ();
int GetScreenHeight ();
void ShowCursor ();
void HideCursor ();
bool IsCursorHidden ();
void EnableCursor ();
void DisableCursor ();
void ClearBackground (Color color);
void BeginDrawing ();
void EndDrawing ();
void Begin2dMode (Camera2D camera);
void End2dMode ();
void Begin3dMode (Camera camera);
void End3dMode ();
void BeginTextureMode (RenderTexture2D target);
void EndTextureMode ();
Ray GetMouseRay (Vector2 mousePosition, Camera camera);
Vector2 GetWorldToScreen (Vector3 position, Camera camera);
Matrix GetCameraMatrix (Camera camera);
void SetTargetFPS (int fps);
int GetFPS ();
float GetFrameTime ();
double GetTime ();
float* ColorToFloat (Color color);
int ColorToInt (Color color);
Vector3 ColorToHSV (Color color);
Color GetColor (int hexValue);
Color Fade (Color color, float alpha);
void ShowLogo ();
void SetConfigFlags (ubyte flags);
void SetTraceLog (ubyte types);
void TraceLog (int logType, const(char)* text, ...);
void TakeScreenshot (const(char)* fileName);
int GetRandomValue (int min, int max);
bool IsFileExtension (const(char)* fileName, const(char)* ext);
const(char)* GetExtension (const(char)* fileName);
const(char)* GetFileName (const(char)* filePath);
const(char)* GetDirectoryPath (const(char)* fileName);
const(char)* GetWorkingDirectory ();
bool ChangeDirectory (const(char)* dir);
bool IsFileDropped ();
char** GetDroppedFiles (int* count);
void ClearDroppedFiles ();
void StorageSaveValue (int position, int value);
int StorageLoadValue (int position);
bool IsKeyPressed (int key);
bool IsKeyDown (int key);
bool IsKeyReleased (int key);
bool IsKeyUp (int key);
int GetKeyPressed ();
void SetExitKey (int key);
bool IsGamepadAvailable (int gamepad);
bool IsGamepadName (int gamepad, const(char)* name);
const(char)* GetGamepadName (int gamepad);
bool IsGamepadButtonPressed (int gamepad, int button);
bool IsGamepadButtonDown (int gamepad, int button);
bool IsGamepadButtonReleased (int gamepad, int button);
bool IsGamepadButtonUp (int gamepad, int button);
int GetGamepadButtonPressed ();
int GetGamepadAxisCount (int gamepad);
float GetGamepadAxisMovement (int gamepad, int axis);
bool IsMouseButtonPressed (int button);
bool IsMouseButtonDown (int button);
bool IsMouseButtonReleased (int button);
bool IsMouseButtonUp (int button);
int GetMouseX ();
int GetMouseY ();
Vector2 GetMousePosition ();
void SetMousePosition (Vector2 position);
void SetMouseScale (float scale);
int GetMouseWheelMove ();
int GetTouchX ();
int GetTouchY ();
Vector2 GetTouchPosition (int index);
void SetGesturesEnabled (uint gestureFlags);
bool IsGestureDetected (int gesture);
int GetGestureDetected ();
int GetTouchPointsCount ();
float GetGestureHoldDuration ();
Vector2 GetGestureDragVector ();
float GetGestureDragAngle ();
Vector2 GetGesturePinchVector ();
float GetGesturePinchAngle ();
void SetCameraMode (Camera camera, int mode);
void UpdateCamera (Camera* camera);
void SetCameraPanControl (int panKey);
void SetCameraAltControl (int altKey);
void SetCameraSmoothZoomControl (int szKey);
void SetCameraMoveControls (int frontKey, int backKey, int rightKey, int leftKey, int upKey, int downKey);
void DrawPixel (int posX, int posY, Color color);
void DrawPixelV (Vector2 position, Color color);
void DrawLine (int startPosX, int startPosY, int endPosX, int endPosY, Color color);
void DrawLineV (Vector2 startPos, Vector2 endPos, Color color);
void DrawLineEx (Vector2 startPos, Vector2 endPos, float thick, Color color);
void DrawLineBezier (Vector2 startPos, Vector2 endPos, float thick, Color color);
void DrawCircle (int centerX, int centerY, float radius, Color color);
void DrawCircleGradient (int centerX, int centerY, float radius, Color color1, Color color2);
void DrawCircleV (Vector2 center, float radius, Color color);
void DrawCircleLines (int centerX, int centerY, float radius, Color color);
void DrawRectangle (int posX, int posY, int width, int height, Color color);
void DrawRectangleV (Vector2 position, Vector2 size, Color color);
void DrawRectangleRec (Rectangle rec, Color color);
void DrawRectanglePro (Rectangle rec, Vector2 origin, float rotation, Color color);
void DrawRectangleGradientV (int posX, int posY, int width, int height, Color color1, Color color2);
void DrawRectangleGradientH (int posX, int posY, int width, int height, Color color1, Color color2);
void DrawRectangleGradientEx (Rectangle rec, Color col1, Color col2, Color col3, Color col4);
void DrawRectangleLines (int posX, int posY, int width, int height, Color color);
void DrawRectangleLinesEx (Rectangle rec, int lineThick, Color color);
void DrawTriangle (Vector2 v1, Vector2 v2, Vector2 v3, Color color);
void DrawTriangleLines (Vector2 v1, Vector2 v2, Vector2 v3, Color color);
void DrawPoly (Vector2 center, int sides, float radius, float rotation, Color color);
void DrawPolyEx (Vector2* points, int numPoints, Color color);
void DrawPolyExLines (Vector2* points, int numPoints, Color color);
bool CheckCollisionRecs (Rectangle rec1, Rectangle rec2);
bool CheckCollisionCircles (Vector2 center1, float radius1, Vector2 center2, float radius2);
bool CheckCollisionCircleRec (Vector2 center, float radius, Rectangle rec);
Rectangle GetCollisionRec (Rectangle rec1, Rectangle rec2);
bool CheckCollisionPointRec (Vector2 point, Rectangle rec);
bool CheckCollisionPointCircle (Vector2 point, Vector2 center, float radius);
bool CheckCollisionPointTriangle (Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);
Image LoadImage (const(char)* fileName);
Image LoadImageEx (Color* pixels, int width, int height);
Image LoadImagePro (void* data, int width, int height, int format);
Image LoadImageRaw (const(char)* fileName, int width, int height, int format, int headerSize);
Texture2D LoadTexture (const(char)* fileName);
Texture2D LoadTextureFromImage (Image image);
RenderTexture2D LoadRenderTexture (int width, int height);
void UnloadImage (Image image);
void UnloadTexture (Texture2D texture);
void UnloadRenderTexture (RenderTexture2D target);
Color* GetImageData (Image image);
int GetPixelDataSize (int width, int height, int format);
Image GetTextureData (Texture2D texture);
void UpdateTexture (Texture2D texture, const(void)* pixels);
void SaveImageAs (const(char)* fileName, Image image);
Image ImageCopy (Image image);
void ImageToPOT (Image* image, Color fillColor);
void ImageFormat (Image* image, int newFormat);
void ImageAlphaMask (Image* image, Image alphaMask);
void ImageAlphaClear (Image* image, Color color, float threshold);
void ImageAlphaCrop (Image* image, float threshold);
void ImageAlphaPremultiply (Image* image);
void ImageCrop (Image* image, Rectangle crop);
void ImageResize (Image* image, int newWidth, int newHeight);
void ImageResizeNN (Image* image, int newWidth, int newHeight);
void ImageMipmaps (Image* image);
void ImageDither (Image* image, int rBpp, int gBpp, int bBpp, int aBpp);
Image ImageText (const(char)* text, int fontSize, Color color);
Image ImageTextEx (SpriteFont font, const(char)* text, float fontSize, int spacing, Color tint);
void ImageDraw (Image* dst, Image src, Rectangle srcRec, Rectangle dstRec);
void ImageDrawText (Image* dst, Vector2 position, const(char)* text, int fontSize, Color color);
void ImageDrawTextEx (Image* dst, Vector2 position, SpriteFont font, const(char)* text, float fontSize, int spacing, Color color);
void ImageFlipVertical (Image* image);
void ImageFlipHorizontal (Image* image);
void ImageColorTint (Image* image, Color color);
void ImageColorInvert (Image* image);
void ImageColorGrayscale (Image* image);
void ImageColorContrast (Image* image, float contrast);
void ImageColorBrightness (Image* image, int brightness);
Image GenImageColor (int width, int height, Color color);
Image GenImageGradientV (int width, int height, Color top, Color bottom);
Image GenImageGradientH (int width, int height, Color left, Color right);
Image GenImageGradientRadial (int width, int height, float density, Color inner, Color outer);
Image GenImageChecked (int width, int height, int checksX, int checksY, Color col1, Color col2);
Image GenImageWhiteNoise (int width, int height, float factor);
Image GenImagePerlinNoise (int width, int height, int offsetX, int offsetY, float scale);
Image GenImageCellular (int width, int height, int tileSize);
void GenTextureMipmaps (Texture2D* texture);
void SetTextureFilter (Texture2D texture, int filterMode);
void SetTextureWrap (Texture2D texture, int wrapMode);
void DrawTexture (Texture2D texture, int posX, int posY, Color tint);
void DrawTextureV (Texture2D texture, Vector2 position, Color tint);
void DrawTextureEx (Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
void DrawTextureRec (Texture2D texture, Rectangle sourceRec, Vector2 position, Color tint);
void DrawTexturePro (Texture2D texture, Rectangle sourceRec, Rectangle destRec, Vector2 origin, float rotation, Color tint);
SpriteFont GetDefaultFont ();
SpriteFont LoadSpriteFont (const(char)* fileName);
SpriteFont LoadSpriteFontEx (const(char)* fileName, int fontSize, int charsCount, int* fontChars);
void UnloadSpriteFont (SpriteFont font);
void DrawFPS (int posX, int posY);
void DrawText (const(char)* text, int posX, int posY, int fontSize, Color color);
void DrawTextEx (SpriteFont font, const(char)* text, Vector2 position, float fontSize, int spacing, Color tint);
int MeasureText (const(char)* text, int fontSize);
Vector2 MeasureTextEx (SpriteFont font, const(char)* text, float fontSize, int spacing);
const(char)* FormatText (const(char)* text, ...);
const(char)* SubText (const(char)* text, int position, int length);
int GetGlyphIndex (SpriteFont font, int character);
void DrawLine3D (Vector3 startPos, Vector3 endPos, Color color);
void DrawCircle3D (Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
void DrawCube (Vector3 position, float width, float height, float length, Color color);
void DrawCubeV (Vector3 position, Vector3 size, Color color);
void DrawCubeWires (Vector3 position, float width, float height, float length, Color color);
void DrawCubeTexture (Texture2D texture, Vector3 position, float width, float height, float length, Color color);
void DrawSphere (Vector3 centerPos, float radius, Color color);
void DrawSphereEx (Vector3 centerPos, float radius, int rings, int slices, Color color);
void DrawSphereWires (Vector3 centerPos, float radius, int rings, int slices, Color color);
void DrawCylinder (Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
void DrawCylinderWires (Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
void DrawPlane (Vector3 centerPos, Vector2 size, Color color);
void DrawRay (Ray ray, Color color);
void DrawGrid (int slices, float spacing);
void DrawGizmo (Vector3 position);
Model LoadModel (const(char)* fileName);
Model LoadModelFromMesh (Mesh mesh);
void UnloadModel (Model model);
Mesh LoadMesh (const(char)* fileName);
void UnloadMesh (Mesh* mesh);
BoundingBox MeshBoundingBox (Mesh mesh);
void MeshTangents (Mesh* mesh);
void MeshBinormals (Mesh* mesh);
Mesh GenMeshPlane (float width, float length, int resX, int resZ);
Mesh GenMeshCube (float width, float height, float length);
Mesh GenMeshSphere (float radius, int rings, int slices);
Mesh GenMeshHemiSphere (float radius, int rings, int slices);
Mesh GenMeshCylinder (float radius, float height, int slices);
Mesh GenMeshTorus (float radius, float size, int radSeg, int sides);
Mesh GenMeshKnot (float radius, float size, int radSeg, int sides);
Mesh GenMeshHeightmap (Image heightmap, Vector3 size);
Mesh GenMeshCubicmap (Image cubicmap, Vector3 cubeSize);
Material LoadMaterial (const(char)* fileName);
Material LoadMaterialDefault ();
void UnloadMaterial (Material material);
void DrawModel (Model model, Vector3 position, float scale, Color tint);
void DrawModelEx (Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
void DrawModelWires (Model model, Vector3 position, float scale, Color tint);
void DrawModelWiresEx (Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
void DrawBoundingBox (BoundingBox box, Color color);
void DrawBillboard (Camera camera, Texture2D texture, Vector3 center, float size, Color tint);
void DrawBillboardRec (Camera camera, Texture2D texture, Rectangle sourceRec, Vector3 center, float size, Color tint);
bool CheckCollisionSpheres (Vector3 centerA, float radiusA, Vector3 centerB, float radiusB);
bool CheckCollisionBoxes (BoundingBox box1, BoundingBox box2);
bool CheckCollisionBoxSphere (BoundingBox box, Vector3 centerSphere, float radiusSphere);
bool CheckCollisionRaySphere (Ray ray, Vector3 spherePosition, float sphereRadius);
bool CheckCollisionRaySphereEx (Ray ray, Vector3 spherePosition, float sphereRadius, Vector3* collisionPoint);
bool CheckCollisionRayBox (Ray ray, BoundingBox box);
RayHitInfo GetCollisionRayMesh (Ray ray, Mesh* mesh);
RayHitInfo GetCollisionRayTriangle (Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
RayHitInfo GetCollisionRayGround (Ray ray, float groundHeight);
char* LoadText (const(char)* fileName);
Shader LoadShader (const(char)* vsFileName, const(char)* fsFileName);
Shader LoadShaderCode (char* vsCode, char* fsCode);
void UnloadShader (Shader shader);
Shader GetShaderDefault ();
Texture2D GetTextureDefault ();
int GetShaderLocation (Shader shader, const(char)* uniformName);
void SetShaderValue (Shader shader, int uniformLoc, const(float)* value, int size);
void SetShaderValuei (Shader shader, int uniformLoc, const(int)* value, int size);
void SetShaderValueMatrix (Shader shader, int uniformLoc, Matrix mat);
void SetMatrixProjection (Matrix proj);
void SetMatrixModelview (Matrix view);
Matrix GetMatrixModelview ();
Texture2D GenTextureCubemap (Shader shader, Texture2D skyHDR, int size);
Texture2D GenTextureIrradiance (Shader shader, Texture2D cubemap, int size);
Texture2D GenTexturePrefilter (Shader shader, Texture2D cubemap, int size);
Texture2D GenTextureBRDF (Shader shader, Texture2D cubemap, int size);
void BeginShaderMode (Shader shader);
void EndShaderMode ();
void BeginBlendMode (int mode);
void EndBlendMode ();
VrDeviceInfo GetVrDeviceInfo (int vrDeviceType);
void InitVrSimulator (VrDeviceInfo info);
void CloseVrSimulator ();
bool IsVrSimulatorReady ();
void SetVrDistortionShader (Shader shader);
void UpdateVrTracking (Camera* camera);
void ToggleVrMode ();
void BeginVrDrawing ();
void EndVrDrawing ();
void InitAudioDevice ();
void CloseAudioDevice ();
bool IsAudioDeviceReady ();
void SetMasterVolume (float volume);
Wave LoadWave (const(char)* fileName);
Wave LoadWaveEx (void* data, int sampleCount, int sampleRate, int sampleSize, int channels);
Sound LoadSound (const(char)* fileName);
Sound LoadSoundFromWave (Wave wave);
void UpdateSound (Sound sound, const(void)* data, int samplesCount);
void UnloadWave (Wave wave);
void UnloadSound (Sound sound);
void PlaySound (Sound sound);
void PauseSound (Sound sound);
void ResumeSound (Sound sound);
void StopSound (Sound sound);
bool IsSoundPlaying (Sound sound);
void SetSoundVolume (Sound sound, float volume);
void SetSoundPitch (Sound sound, float pitch);
void WaveFormat (Wave* wave, int sampleRate, int sampleSize, int channels);
Wave WaveCopy (Wave wave);
void WaveCrop (Wave* wave, int initSample, int finalSample);
float* GetWaveData (Wave wave);
Music LoadMusicStream (const(char)* fileName);
void UnloadMusicStream (Music music);
void PlayMusicStream (Music music);
void UpdateMusicStream (Music music);
void StopMusicStream (Music music);
void PauseMusicStream (Music music);
void ResumeMusicStream (Music music);
bool IsMusicPlaying (Music music);
void SetMusicVolume (Music music, float volume);
void SetMusicPitch (Music music, float pitch);
void SetMusicLoopCount (Music music, int count);
float GetMusicTimeLength (Music music);
float GetMusicTimePlayed (Music music);
AudioStream InitAudioStream (uint sampleRate, uint sampleSize, uint channels);
void UpdateAudioStream (AudioStream stream, const(void)* data, int samplesCount);
void CloseAudioStream (AudioStream stream);
bool IsAudioBufferProcessed (AudioStream stream);
void PlayAudioStream (AudioStream stream);
void PauseAudioStream (AudioStream stream);
void ResumeAudioStream (AudioStream stream);
bool IsAudioStreamPlaying (AudioStream stream);
void StopAudioStream (AudioStream stream);
void SetAudioStreamVolume (AudioStream stream, float volume);
void SetAudioStreamPitch (AudioStream stream, float pitch);
