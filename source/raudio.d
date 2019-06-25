/**********************************************************************************************
*
*   raudio - A simple and easy-to-use audio library based on mini_al
*
*   FEATURES:
*       - Manage audio device (init/close)
*       - Load and unload audio files
*       - Format wave data (sample rate, size, channels)
*       - Play/Stop/Pause/Resume loaded audio
*       - Manage mixing channels
*       - Manage raw audio context
*
*   DEPENDENCIES:
*       miniaudio.h  - Audio device management lib (https://github.com/dr-soft/miniaudio)
*       stb_vorbis.h - Ogg audio files loading (http://www.nothings.org/stb_vorbis/)
*       dr_mp3.h     - MP3 audio file loading (https://github.com/mackron/dr_libs)
*       dr_flac.h    - FLAC audio file loading (https://github.com/mackron/dr_libs)
*       jar_xm.h     - XM module file loading
*       jar_mod.h    - MOD audio file loading
*
*   CONTRIBUTORS:
*       David Reid (github: @mackron) (Nov. 2017):
*           - Complete port to mini_al library
*
*       Joshua Reisenauer (github: @kd7tck) (2015)
*           - XM audio module support (jar_xm)
*           - MOD audio module support (jar_mod)
*           - Mixing channels support
*           - Raw audio context support
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2014-2019 Ramon Santamaria (@raysan5)
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
module raudio;
import raylib;

import core.stdc.stdlib : calloc, malloc, free;

extern (C):

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
// Allow custom memory allocators

alias RL_MALLOC = malloc;

alias RL_CALLOC = calloc;

alias RL_FREE = free;

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------

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

// Prevents name mangling of functions

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------
void InitAudioDevice (); // Initialize audio device and context
void CloseAudioDevice (); // Close the audio device and context
bool IsAudioDeviceReady (); // Check if audio device has been initialized successfully
void SetMasterVolume (float volume); // Set master volume (listener)

Wave LoadWave (const(char)* fileName); // Load wave data from file
Wave LoadWaveEx (void* data, int sampleCount, int sampleRate, int sampleSize, int channels); // Load wave data from raw array data
Sound LoadSound (const(char)* fileName); // Load sound from file
Sound LoadSoundFromWave (Wave wave); // Load sound from wave data
void UpdateSound (Sound sound, const(void)* data, int samplesCount); // Update sound buffer with new data
void UnloadWave (Wave wave); // Unload wave data
void UnloadSound (Sound sound); // Unload sound
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

// RAUDIO_H
