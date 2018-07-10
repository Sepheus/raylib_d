/*******************************************************************************************
*
*   raylib easings (header only file)
*
*   Useful easing functions for values animation
*
*   This header uses:
*       #define EASINGS_STATIC_INLINE       // Inlines all functions code, so it runs faster.
*                                           // This requires lots of memory on system.
*   How to use:
*   The four inputs t,b,c,d are defined as follows:
*   t = current time (in any unit measure, but same unit as duration)
*   b = starting value to interpolate
*   c = the total change in value of b that needs to occur
*   d = total time it should take to complete (duration)
*
*   Example:
*
*   int currentTime = 0;
*   int duration = 100;
*   float startPositionX = 0.0f;
*   float finalPositionX = 30.0f;
*   float currentPositionX = startPositionX;
*
*   while (currentPositionX < finalPositionX)
*   {
*       currentPositionX = EaseSineIn(currentTime, startPositionX, finalPositionX - startPositionX, duration);
*       currentTime++;
*   }
*
*   A port of Robert Penner's easing equations to C (http://robertpenner.com/easing/)
*
*   Robert Penner License
*   ---------------------------------------------------------------------------------
*   Open source under the BSD License.
*
*   Copyright (c) 2001 Robert Penner. All rights reserved.
*
*   Redistribution and use in source and binary forms, with or without modification,
*   are permitted provided that the following conditions are met:
*
*       - Redistributions of source code must retain the above copyright notice,
*         this list of conditions and the following disclaimer.
*       - Redistributions in binary form must reproduce the above copyright notice,
*         this list of conditions and the following disclaimer in the documentation
*         and/or other materials provided with the distribution.
*       - Neither the name of the author nor the names of contributors may be used
*         to endorse or promote products derived from this software without specific
*         prior written permission.
*
*   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
*   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
*   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
*   IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
*   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*   BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
*   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
*   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
*   OF THE POSSIBILITY OF SUCH DAMAGE.
*   ---------------------------------------------------------------------------------
*
*   Copyright (c) 2015 Ramon Santamaria
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

// #define EASINGS_STATIC_INLINE     // NOTE: By default, compile functions as static inline

// Required for: sin(), cos(), sqrt(), pow()

// Prevents name mangling of functions

// Linear Easing functions
float EaseLinearNone (float t, float b, float c, float d);
float EaseLinearIn (float t, float b, float c, float d);
float EaseLinearOut (float t, float b, float c, float d);
float EaseLinearInOut (float t, float b, float c, float d);

// Sine Easing functions
float EaseSineIn (float t, float b, float c, float d);
float EaseSineOut (float t, float b, float c, float d);
float EaseSineInOut (float t, float b, float c, float d);

// Circular Easing functions
float EaseCircIn (float t, float b, float c, float d);
float EaseCircOut (float t, float b, float c, float d);
float EaseCircInOut (float t, float b, float c, float d);

// Cubic Easing functions
float EaseCubicIn (float t, float b, float c, float d);
float EaseCubicOut (float t, float b, float c, float d);
float EaseCubicInOut (float t, float b, float c, float d);

// Quadratic Easing functions
float EaseQuadIn (float t, float b, float c, float d);
float EaseQuadOut (float t, float b, float c, float d);
float EaseQuadInOut (float t, float b, float c, float d);

// Exponential Easing functions
float EaseExpoIn (float t, float b, float c, float d);
float EaseExpoOut (float t, float b, float c, float d);
float EaseExpoInOut (float t, float b, float c, float d);

// Back Easing functions
float EaseBackIn (float t, float b, float c, float d);

float EaseBackOut (float t, float b, float c, float d);

float EaseBackInOut (float t, float b, float c, float d);

// Bounce Easing functions
float EaseBounceOut (float t, float b, float c, float d);

float EaseBounceIn (float t, float b, float c, float d);
float EaseBounceInOut (float t, float b, float c, float d);

// Elastic Easing functions
float EaseElasticIn (float t, float b, float c, float d);

float EaseElasticOut (float t, float b, float c, float d);

float EaseElasticInOut (float t, float b, float c, float d);

// EASINGS_H
