/*******************************************************************************************
*
*   raylib.camera - Camera system with multiple modes support
*
*   NOTE: Memory footprint of this library is aproximately 52 bytes (global variables)
*
*   CONFIGURATION:
*
*   #define CAMERA_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define CAMERA_STANDALONE
*       If defined, the library can be used as standalone as a camera system but some
*       functions must be redefined to manage inputs accordingly.
*
*   CONTRIBUTORS:
*       Marc Palau:         Initial implementation (2014)
*       Ramon Santamaria:   Supervision, review, update and maintenance
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2015-2017 Ramon Santamaria (@raysan5)
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

extern (C):

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Below types are required for CAMERA_STANDALONE usage
//----------------------------------------------------------------------------------

// Camera modes

// Vector2 type

// Vector3 type

// Camera type, defines a camera position/orientation in 3d space

// Prevents name mangling of functions

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------

// Set camera mode (multiple camera modes available)
// Update camera position for selected mode

// Set camera pan key to combine with mouse movement (free camera)
// Set camera alt key to combine with mouse movement (free camera)
// Set camera smooth zoom key to combine with mouse (free camera)

// Set camera move controls (1st person and 3rd person cameras)

// CAMERA_H

/***********************************************************************************
*
*   CAMERA IMPLEMENTATION
*
************************************************************************************/

// Required for: sqrt(), sin(), cos()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
// Camera mouse movement sensitivity

// FREE_CAMERA

// ORBITAL_CAMERA
// Radians per frame

// FIRST_PERSON
//#define CAMERA_FIRST_PERSON_MOUSE_SENSITIVITY           0.003f

// THIRD_PERSON
//#define CAMERA_THIRD_PERSON_MOUSE_SENSITIVITY           0.003f

// PLAYER (used by camera)

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------
// Camera move modes (first person and third person cameras)

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
// TODO: Remove! Compute it in UpdateCamera()
// TODO: Remove! Compute it in UpdateCamera()
// Default player eyes position from ground (in meters) 

// raylib: MOUSE_MIDDLE_BUTTON
// raylib: KEY_LEFT_ALT
// raylib: KEY_LEFT_CONTROL

// Current camera mode

//----------------------------------------------------------------------------------
// Module specific Functions Declaration
//----------------------------------------------------------------------------------

// NOTE: Camera controls depend on some raylib input functions
// TODO: Set your own input functions (used in UpdateCamera())
// Unlock cursor
// Lock cursor

//----------------------------------------------------------------------------------
// Module Functions Definition
//----------------------------------------------------------------------------------

// Select camera mode (multiple camera modes available)

// TODO: cameraTargetDistance and cameraAngle should be 
// calculated using camera parameters on UpdateCamera()

// Camera angle calculation
// Camera angle in plane XZ (0 aligned with Z, move positive CCW)
// Camera angle in plane XY (0 aligned with X, move positive CW)

// NOTE: Just testing what cameraAngle means
//cameraAngle.x = 0.0f*DEG2RAD;       // Camera angle in plane XZ (0 aligned with Z, move positive CCW)
//cameraAngle.y = -60.0f*DEG2RAD;     // Camera angle in plane XY (0 aligned with X, move positive CW)

// Lock cursor for first person and third person cameras

// Update camera depending on selected mode
// NOTE: Camera controls depend on some raylib functions:
//       System: EnableCursor(), DisableCursor()
//       Mouse: IsMouseButtonDown(), GetMousePosition(), GetMouseWheelMove()
//       Keys:  IsKeyDown()
// TODO: Port to quaternion-based camera

// Used for 1st person swinging movement

// TODO: Compute cameraTargetDistance and cameraAngle here

// Mouse movement detection

// Keys input detection

// TODO: Consider touch inputs for camera

// Support for multiple automatic camera modes

// Camera zoom

// Camera looking down
// TODO: Review, weird comparisson of cameraTargetDistance == 120.0f?

// if (camera->target.y < 0) camera->target.y = -0.001;

// Camera looking up
// TODO: Review, weird comparisson of cameraTargetDistance == 120.0f?

// if (camera->target.y > 0) camera->target.y = 0.001;

// Input keys checks

// Alternative key behaviour

// Camera smooth zoom

// Camera rotation

// Angle clamp

// Camera panning

// Camera orbit angle
// Camera zoom

// Camera distance clamp

// Required for swinging

// Camera orientation calculation

// Angle clamp

// Camera zoom

// Camera distance clamp

// Camera is always looking at player

// CAMERA_FIRST_PERSON

// Angle clamp

// Camera is always looking at player

// Camera position update
// NOTE: On CAMERA_FIRST_PERSON player Y-movement is limited to player 'eyes position'

// Update camera position with changes

// TODO: It seems camera->position is not correctly updated or some rounding issue makes the camera move straight to camera->target...

// Set camera pan key to combine with mouse movement (free camera)

// Set camera alt key to combine with mouse movement (free camera)

// Set camera smooth zoom key to combine with mouse (free camera)

// Set camera move controls (1st person and 3rd person cameras)

// CAMERA_IMPLEMENTATION
