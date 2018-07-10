/**********************************************************************************************
*
*   raylib.gestures - Gestures system, gestures processing based on input events (touch/mouse)
*
*   NOTE: Memory footprint of this library is aproximately 128 bytes (global variables)
*
*   CONFIGURATION:
*
*   #define GESTURES_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define GESTURES_STANDALONE
*       If defined, the library can be used as standalone to process gesture events with
*       no external dependencies.
*
*   CONTRIBUTORS:
*       Marc Palau:         Initial implementation (2014)
*       Albert Martos:      Complete redesign and testing (2015)
*       Ian Eito:           Complete redesign and testing (2015)
*       Ramon Santamaria:   Supervision, review, update and maintenance
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2014-2018 Ramon Santamaria (@raysan5)
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

module gestures;

import raylib;

extern (C):

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Below types are required for GESTURES_STANDALONE usage
//----------------------------------------------------------------------------------

// Boolean type

// Vector2 type

// Gestures type
// NOTE: It could be used as flags to enable only some gestures

enum TouchAction
{
    TOUCH_UP = 0,
    TOUCH_DOWN = 1,
    TOUCH_MOVE = 2
}

// Gesture events
// NOTE: MAX_TOUCH_POINTS fixed to 4
struct GestureEvent
{
    int touchAction;
    int pointCount;
    int[4] pointerId;
    Vector2[4] position;
}

// Prevents name mangling of functions

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------
void ProcessGestureEvent (GestureEvent event); // Process gesture event and translate it into gestures
void UpdateGestures (); // Update gestures detected (must be called every frame)

// Enable a set of gestures using flags
// Check if a gesture have been detected
// Get latest detected gesture
// Get touch points count
// Get gesture hold time in milliseconds
// Get gesture drag vector
// Get gesture drag angle
// Get gesture pinch delta
// Get gesture pinch angle

// GESTURES_H

/***********************************************************************************
*
*   GESTURES IMPLEMENTATION
*
************************************************************************************/

// Functions required to query time on Windows

// Required for CLOCK_MONOTONIC if compiled with c99 without gnu ext.

// Required for: timespec
// Required for: clock_gettime()

// Required for: atan2(), sqrt()
// Required for: uint64_t

// macOS also defines __MACH__
// Required for: clock_get_time()
// Required for: mach_timespec_t

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
// Measured in normalized screen units/time
// Measured in normalized screen units (0.0f to 1.0f)
// Measured in normalized screen units (0.0f to 1.0f)
// Time in milliseconds
// Time in milliseconds
// Measured in normalized screen units (0.0f to 1.0f)

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------
// ...

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------

// Touch gesture variables

// Touch points counter
// Touch id for first touch point
// Time stamp when an event happened

// Tap gesture variables
// TAP counter (one tap implies TOUCH_DOWN and TOUCH_UP actions)

// Hold gesture variables
// HOLD reset to get first touch point again
// HOLD duration in milliseconds

// Drag gesture variables
// DRAG vector (between initial and current position)
// DRAG angle (relative to x-axis)
// DRAG distance (from initial touch point to final) (normalized [0..1])
// DRAG intensity, how far why did the DRAG (pixels per frame)

// Swipe gestures variables
// SWIPE used to define when start measuring swipeTime
// SWIPE time to calculate drag intensity

// Pinch gesture variables
// PINCH vector (between first and second touch points)
// PINCH angle (relative to x-axis)
// PINCH displacement distance (normalized [0..1])

// Current detected gesture

// Enabled gestures flags, all gestures enabled by default 

//----------------------------------------------------------------------------------
// Module specific Functions Declaration
//----------------------------------------------------------------------------------

// Some required math functions provided by raymath.h

//----------------------------------------------------------------------------------
// Module Functions Definition
//----------------------------------------------------------------------------------

// Enable only desired getures to be detected

// Check if a gesture have been detected

// Process gesture event and translate it into gestures

// Reset required variables
// Required on UpdateGestures()

// Tap counter

// Detect GESTURE_DOUBLE_TAP

// Detect GESTURE_TAP

// NOTE: dragIntensity dependend on the resolution of the screen

// Detect GESTURE_SWIPE

// NOTE: Angle should be inverted in Y

// Right
// Up
// Left
// Down

// Detect GESTURE_DRAG

// Two touch points

//pinchDistance = Vector2Distance(touchDownPosition, touchDownPosition2);

// NOTE: Angle should be inverted in Y

// Update gestures detected (must be called every frame)

// NOTE: Gestures are processed through system callbacks on touch events

// Detect GESTURE_HOLD

// Detect GESTURE_NONE

// Get number of touch points

// NOTE: point count is calculated when ProcessGestureEvent(GestureEvent event) is called

// Get latest detected gesture

// Get current gesture only if enabled

// Hold time measured in ms

// NOTE: time is calculated on current gesture HOLD

// Get drag vector (between initial touch point to current)

// NOTE: drag vector is calculated on one touch points TOUCH_MOVE

// Get drag angle
// NOTE: Angle in degrees, horizontal-right is 0, counterclock-wise

// NOTE: drag angle is calculated on one touch points TOUCH_UP

// Get distance between two pinch points

// NOTE: The position values used for pinchDistance are not modified like the position values of [core.c]-->GetTouchPosition(int index)
// NOTE: pinch distance is calculated on two touch points TOUCH_MOVE

// Get angle beween two pinch points
// NOTE: Angle in degrees, horizontal-right is 0, counterclock-wise

// NOTE: pinch angle is calculated on two touch points TOUCH_MOVE

//----------------------------------------------------------------------------------
// Module specific Functions Definition
//----------------------------------------------------------------------------------

// Returns angle from two-points vector with X-axis

// Calculate distance between two Vector2

// Time measure returned are milliseconds

// BE CAREFUL: Costly operation!

// Time in miliseconds

// NOTE: Only for Linux-based systems

// Time in nanoseconds

// Time in miliseconds

//#define CLOCK_REALTIME  CALENDAR_CLOCK    // returns UTC time since 1970-01-01
//#define CLOCK_MONOTONIC SYSTEM_CLOCK      // returns the time since boot time

// NOTE: OS X does not have clock_gettime(), using clock_get_time()

// Time in nanoseconds

// Time in miliseconds    

// GESTURES_IMPLEMENTATION
