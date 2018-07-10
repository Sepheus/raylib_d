/*******************************************************************************************
*
*   raygui v2.0 - A simple and easy-to-use immedite-mode-gui library for raylib (www.raylib.com)
*
*   DESCRIPTION:
*
*   raygui is a library for creating simple IMGUI interfaces using raylib, intended for tools dev.
*
*   Basic controls provided:
*
*       - WindowBox
*       - GroupBox
*       - Line
*       - Panel
*       - Label
*       - Button
*       - LabelButton
*       - ImageButton
*       - ImageButtonEx
*       - ToggleButton
*       - ToggleGroup
*       - CheckBox
*       - ComboBox
*       - DropdownBox
*       - Spinner
*       - ValueBox
*       - TextBox
*       - TextBoxMulti
*       - Slider
*       - SliderBar
*       - ProgressBar
*       - StatusBar
*       - ScrollPanel
*       - ListView
*       - ColorPicker
*       - MessageBox
*       - DummyRec
*       - Grid
*
*   It also provides a set of functions for styling the controls based on its properties (size, color).
*
*   CONFIGURATION:
*
*   #define RAYGUI_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define RAYGUI_STATIC (defined by default)
*       The generated implementation will stay private inside implementation file and all
*       internal symbols and functions will only be visible inside that file.
*
*   #define RAYGUI_STANDALONE
*       Avoid raylib.h header inclusion in this file. Data types defined on raylib are defined
*       internally in the library and input management and drawing functions must be provided by
*       the user (check library implementation for further details).
*
*   #define RAYGUI_STYLE_SAVE_LOAD
*       Include style customization and save/load functions, useful when required.
*
*
*   VERSIONS HISTORY:
*       2.0 (01-May-2018) Lot of rework and redesign! Lots of new controls!
*       1.5 (21-Jun-2017) Working in an improved styles system
*       1.4 (15-Jun-2017) Rewritten all GUI functions (removed useless ones)
*       1.3 (12-Jun-2017) Redesigned styles system
*       1.1 (01-Jun-2017) Complete review of the library
*       1.0 (07-Jun-2016) Converted to header-only by Ramon Santamaria.
*       0.9 (07-Mar-2016) Reviewed and tested by Albert Martos, Ian Eito, Sergio Martinez and Ramon Santamaria.
*       0.8 (27-Aug-2015) Initial release. Implemented by Kevin Gato, Daniel Nicolás and Ramon Santamaria.
*
*   CONTRIBUTORS:
*       Ramon Santamaria:   Supervision, review, redesign, update and maintenance...
*       Kevin Gato:         Initial implementation of basic components (2014)
*       Daniel Nicolas:     Initial implementation of basic components (2014)
*       Albert Martos:      Review and testing of the library (2015)
*       Ian Eito:           Review and testing of the library (2015)
*       Sergio Martinez:    Review and testing of the library (2015)
*       Adria Arranz:       Testing and Implementation of additional controls (2018)
*       Jordi Jorba:        Testing and Implementation of additional controls (2018)
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

module raygui;

import raylib;

extern (C): // Functions just visible to module including this file

// Functions visible from other files (no name mangling of functions in C++)

// Functions visible from other files

// Required for: atoi()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
enum NUM_PROPERTIES = 155;

extern (D) auto VALIGN_OFFSET(T)(auto ref T h)
{
    return cast(int) h % 2;
} // Vertical alignment for pixel perfect

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Some types are required for RAYGUI_STANDALONE usage
//----------------------------------------------------------------------------------

// Boolean type

// Vector2 type

// Vector3 type

// Color type, RGBA (32bit)

// Rectangle type

// Gui properties enumeration
enum GuiProperty
{
    //--------------------------------------------
    // NOTE: This first set of properties is for general style,
    // following control-specific properties overwritte those styles
    DEFAULT_BACKGROUND_COLOR = 0,
    DEFAULT_LINES_COLOR = 1,
    DEFAULT_TEXT_FONT = 2,
    DEFAULT_TEXT_SIZE = 3,
    DEFAULT_BORDER_WIDTH = 4,
    DEFAULT_BORDER_COLOR_NORMAL = 5,
    DEFAULT_BASE_COLOR_NORMAL = 6,
    DEFAULT_TEXT_COLOR_NORMAL = 7,
    DEFAULT_BORDER_COLOR_FOCUSED = 8,
    DEFAULT_BASE_COLOR_FOCUSED = 9,
    DEFAULT_TEXT_COLOR_FOCUSED = 10,
    DEFAULT_BORDER_COLOR_PRESSED = 11,
    DEFAULT_BASE_COLOR_PRESSED = 12,
    DEFAULT_TEXT_COLOR_PRESSED = 13,
    DEFAULT_BORDER_COLOR_DISABLED = 14,
    DEFAULT_BASE_COLOR_DISABLED = 15,
    DEFAULT_TEXT_COLOR_DISABLED = 16,
    //--------------------------------------------
    // Label
    LABEL_TEXT_COLOR_NORMAL = 17,
    LABEL_TEXT_COLOR_FOCUSED = 18,
    LABEL_TEXT_COLOR_PRESSED = 19,
    LABEL_TEXT_COLOR_DISABLED = 20,
    // Button
    BUTTON_BORDER_WIDTH = 21,
    BUTTON_BORDER_COLOR_NORMAL = 22,
    BUTTON_BASE_COLOR_NORMAL = 23,
    BUTTON_TEXT_COLOR_NORMAL = 24,
    BUTTON_BORDER_COLOR_FOCUSED = 25,
    BUTTON_BASE_COLOR_FOCUSED = 26,
    BUTTON_TEXT_COLOR_FOCUSED = 27,
    BUTTON_BORDER_COLOR_PRESSED = 28,
    BUTTON_BASE_COLOR_PRESSED = 29,
    BUTTON_TEXT_COLOR_PRESSED = 30,
    BUTTON_BORDER_COLOR_DISABLED = 31,
    BUTTON_BASE_COLOR_DISABLED = 32,
    BUTTON_TEXT_COLOR_DISABLED = 33,
    // Toggle
    TOGGLE_BORDER_WIDTH = 34,
    TOGGLE_BORDER_COLOR_NORMAL = 35,
    TOGGLE_BASE_COLOR_NORMAL = 36,
    TOGGLE_TEXT_COLOR_NORMAL = 37,
    TOGGLE_BORDER_COLOR_FOCUSED = 38,
    TOGGLE_BASE_COLOR_FOCUSED = 39,
    TOGGLE_TEXT_COLOR_FOCUSED = 40,
    TOGGLE_BORDER_COLOR_PRESSED = 41,
    TOGGLE_BASE_COLOR_PRESSED = 42,
    TOGGLE_TEXT_COLOR_PRESSED = 43,
    TOGGLE_BORDER_COLOR_DISABLED = 44,
    TOGGLE_BASE_COLOR_DISABLED = 45,
    TOGGLE_TEXT_COLOR_DISABLED = 46,
    TOGGLEGROUP_PADDING = 47,
    // Slider
    SLIDER_BORDER_WIDTH = 48,
    SLIDER_SLIDER_WIDTH = 49,
    SLIDER_BORDER_COLOR_NORMAL = 50,
    SLIDER_BASE_COLOR_NORMAL = 51,
    SLIDER_BORDER_COLOR_FOCUSED = 52,
    SLIDER_BASE_COLOR_FOCUSED = 53,
    SLIDER_BORDER_COLOR_PRESSED = 54,
    SLIDER_BASE_COLOR_PRESSED = 55,
    SLIDER_BORDER_COLOR_DISABLED = 56,
    SLIDER_BASE_COLOR_DISABLED = 57,
    // SliderBar
    SLIDERBAR_INNER_PADDING = 58,
    SLIDERBAR_BORDER_WIDTH = 59,
    SLIDERBAR_BORDER_COLOR_NORMAL = 60,
    SLIDERBAR_BASE_COLOR_NORMAL = 61,
    SLIDERBAR_BORDER_COLOR_FOCUSED = 62,
    SLIDERBAR_BASE_COLOR_FOCUSED = 63,
    SLIDERBAR_BORDER_COLOR_PRESSED = 64,
    SLIDERBAR_BASE_COLOR_PRESSED = 65,
    SLIDERBAR_BORDER_COLOR_DISABLED = 66,
    SLIDERBAR_BASE_COLOR_DISABLED = 67,
    // ProgressBar
    PROGRESSBAR_INNER_PADDING = 68,
    PROGRESSBAR_BORDER_WIDTH = 69,
    PROGRESSBAR_BORDER_COLOR_NORMAL = 70,
    PROGRESSBAR_BASE_COLOR_NORMAL = 71,
    PROGRESSBAR_BORDER_COLOR_FOCUSED = 72,
    PROGRESSBAR_BASE_COLOR_FOCUSED = 73,
    PROGRESSBAR_BORDER_COLOR_PRESSED = 74,
    PROGRESSBAR_BASE_COLOR_PRESSED = 75,
    PROGRESSBAR_BORDER_COLOR_DISABLED = 76,
    PROGRESSBAR_BASE_COLOR_DISABLED = 77,
    // ValueBox
    VALUEBOX_BUTTON_PADDING = 78,
    VALUEBOX_BUTTONS_WIDTH = 79,
    VALUEBOX_BORDER_COLOR_NORMAL = 80,
    VALUEBOX_BASE_COLOR_NORMAL = 81,
    VALUEBOX_TEXT_COLOR_NORMAL = 82,
    VALUEBOX_BORDER_COLOR_FOCUSED = 83,
    VALUEBOX_BASE_COLOR_FOCUSED = 84,
    VALUEBOX_TEXT_COLOR_FOCUSED = 85,
    VALUEBOX_BORDER_COLOR_PRESSED = 86,
    VALUEBOX_BASE_COLOR_PRESSED = 87,
    VALUEBOX_TEXT_COLOR_PRESSED = 88,
    VALUEBOX_BORDER_COLOR_DISABLED = 89,
    VALUEBOX_BASE_COLOR_DISABLED = 90,
    VALUEBOX_TEXT_COLOR_DISABLED = 91,
    // ComboBox
    COMBOBOX_BORDER_WIDTH = 92,
    COMBOBOX_BUTTON_PADDING = 93,
    COMBOBOX_SELECTOR_WIDTH = 94,
    COMBOBOX_BORDER_COLOR_NORMAL = 95,
    COMBOBOX_BASE_COLOR_NORMAL = 96,
    COMBOBOX_TEXT_COLOR_NORMAL = 97,
    COMBOBOX_BORDER_COLOR_FOCUSED = 98,
    COMBOBOX_BASE_COLOR_FOCUSED = 99,
    COMBOBOX_TEXT_COLOR_FOCUSED = 100,
    COMBOBOX_BORDER_COLOR_PRESSED = 101,
    COMBOBOX_BASE_COLOR_PRESSED = 102,
    COMBOBOX_TEXT_COLOR_PRESSED = 103,
    COMBOBOX_BORDER_COLOR_DISABLED = 104,
    COMBOBOX_BASE_COLOR_DISABLED = 105,
    COMBOBOX_TEXT_COLOR_DISABLED = 106,
    // CheckBox
    CHECKBOX_BORDER_WIDTH = 107,
    CHECKBOX_INNER_PADDING = 108,
    CHECKBOX_BORDER_COLOR_NORMAL = 109,
    CHECKBOX_BASE_COLOR_NORMAL = 110,
    CHECKBOX_BORDER_COLOR_FOCUSED = 111,
    CHECKBOX_BASE_COLOR_FOCUSED = 112,
    CHECKBOX_BORDER_COLOR_PRESSED = 113,
    CHECKBOX_BASE_COLOR_PRESSED = 114,
    CHECKBOX_BORDER_COLOR_DISABLED = 115,
    CHECKBOX_BASE_COLOR_DISABLED = 116,
    // TextBox
    TEXTBOX_BORDER_WIDTH = 117,
    TEXTBOX_BORDER_COLOR_NORMAL = 118,
    TEXTBOX_BASE_COLOR_NORMAL = 119,
    TEXTBOX_TEXT_COLOR_NORMAL = 120,
    TEXTBOX_BORDER_COLOR_FOCUSED = 121,
    TEXTBOX_BASE_COLOR_FOCUSED = 122,
    TEXTBOX_TEXT_COLOR_FOCUSED = 123,
    TEXTBOX_BORDER_COLOR_PRESSED = 124,
    TEXTBOX_BASE_COLOR_PRESSED = 125,
    TEXTBOX_TEXT_COLOR_PRESSED = 126,
    TEXTBOX_BORDER_COLOR_DISABLED = 127,
    TEXTBOX_BASE_COLOR_DISABLED = 128,
    TEXTBOX_TEXT_COLOR_DISABLED = 129,
    // ColorPicker
    COLORPICKER_BARS_THICK = 130,
    COLORPICKER_BARS_PADDING = 131,
    COLORPICKER_BORDER_COLOR_NORMAL = 132,
    COLORPICKER_BASE_COLOR_NORMAL = 133,
    COLORPICKER_BORDER_COLOR_FOCUSED = 134,
    COLORPICKER_BASE_COLOR_FOCUSED = 135,
    COLORPICKER_BORDER_COLOR_PRESSED = 136,
    COLORPICKER_BASE_COLOR_PRESSED = 137,
    COLORPICKER_BORDER_COLOR_DISABLED = 138,
    COLORPICKER_BASE_COLOR_DISABLED = 139,
    // ListView
    LISTVIEW_ELEMENTS_HEIGHT = 140,
    LISTVIEW_ELEMENTS_PADDING = 141,
    LISTVIEW_BAR_WIDTH = 142,
    LISTVIEW_BORDER_COLOR_NORMAL = 143,
    LISTVIEW_BASE_COLOR_NORMAL = 144,
    LISTVIEW_TEXT_COLOR_NORMAL = 145,
    LISTVIEW_BORDER_COLOR_FOCUSED = 146,
    LISTVIEW_BASE_COLOR_FOCUSED = 147,
    LISTVIEW_TEXT_COLOR_FOCUSED = 148,
    LISTVIEW_BORDER_COLOR_PRESSED = 149,
    LISTVIEW_BASE_COLOR_PRESSED = 150,
    LISTVIEW_TEXT_COLOR_PRESSED = 151,
    LISTVIEW_BORDER_COLOR_DISABLED = 152,
    LISTVIEW_BASE_COLOR_DISABLED = 153,
    LISTVIEW_TEXT_COLOR_DISABLED = 154
}

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
// ...

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------

// Global gui modification functions
void GuiEnable (); // Enable gui controls (global state)
void GuiDisable (); // Disable gui controls (global state)
void GuiFade (float alpha); // Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f

// Style set/get functions
void GuiSetStyleProperty (int guiProperty, int value); // Set one style property
int GuiGetStyleProperty (int guiProperty); // Get one style property

// Container/separator controls, useful for controls organization
bool GuiWindowBox (Rectangle bounds, const(char)* text); // Window Box control, shows a window that can be closed
void GuiGroupBox (Rectangle bounds, const(char)* text); // Group Box control with title name
void GuiLine (Rectangle bounds, int thick); // Line separator control
void GuiPanel (Rectangle bounds); // Panel control, useful to group controls
Vector2 GuiScrollPanel (Rectangle bounds, Rectangle content, Vector2 viewScroll); // Scroll Panel control

// Basic controls set
void GuiLabel (Rectangle bounds, const(char)* text); // Label control, shows text
bool GuiButton (Rectangle bounds, const(char)* text); // Button control, returns true when clicked
bool GuiLabelButton (Rectangle bounds, const(char)* text); // Label button control, show true when clicked
bool GuiImageButton (Rectangle bounds, Texture2D texture); // Image button control, returns true when clicked
bool GuiImageButtonEx (Rectangle bounds, Texture2D texture, Rectangle texSource, const(char)* text); // Image button extended control, returns true when clicked
bool GuiToggleButton (Rectangle bounds, const(char)* text, bool toggle); // Toggle Button control, returns true when active
int GuiToggleGroup (Rectangle bounds, const(char*)* text, int count, int active); // Toggle Group control, returns toggled button index
bool GuiCheckBox (Rectangle bounds, bool checked); // Check Box control, returns true when active
bool GuiCheckBoxEx (Rectangle bounds, bool checked, const(char)* text); // Check Box control with text, returns true when active
int GuiComboBox (Rectangle bounds, const(char*)* text, int count, int active); // Combo Box control, returns selected item index
int GuiDropdownBox (Rectangle bounds, const(char*)* text, int count, int active); // Dropdown Box control, returns selected item
int GuiSpinner (Rectangle bounds, int value, int maxValue, int btnWidth); // Spinner control, returns selected value
int GuiValueBox (Rectangle bounds, int value, int maxValue); // Value Box control, updates input text with numbers
bool GuiTextBox (Rectangle bounds, char* text, int textSize, bool freeEdit); // Text Box control, updates input text
bool GuiTextBoxMulti (Rectangle bounds, char* text, int textSize, bool editMode); // Text Box control with multiple lines
float GuiSlider (Rectangle bounds, float value, float minValue, float maxValue); // Slider control, returns selected value
float GuiSliderEx (Rectangle bounds, float value, float minValue, float maxValue, const(char)* text, bool showValue); // Slider control, returns selected value
float GuiSliderBar (Rectangle bounds, float value, float minValue, float maxValue); // Slider Bar control, returns selected value
float GuiSliderBarEx (Rectangle bounds, float value, float minValue, float maxValue, const(char)* text, bool showValue); // Slider Bar control, returns selected value
float GuiProgressBar (Rectangle bounds, float value, float minValue, float maxValue); // Progress Bar control, shows current progress value
float GuiProgressBarEx (Rectangle bounds, float value, float minValue, float maxValue, bool showValue); // Progress Bar control, shows current progress value
void GuiStatusBar (Rectangle bounds, const(char)* text, int offsetX); // Status Bar control, shows info text
void GuiDummyRec (Rectangle bounds, const(char)* text); // Dummy control for placeholders

// Advance controls set
int GuiListView (Rectangle bounds, const(char*)* text, int count, int active); // List View control, returns selected list element index
Color GuiColorPicker (Rectangle bounds, Color color); // Color Picker control
bool GuiMessageBox (Rectangle bounds, const(char)* windowTitle, const(char)* message); // Message Box control, displays a message

// Save style file (.rgs), text or binary
// Load style file (.rgs), text or binary
// Load style from an image style file
// Load style from a color palette array (14 values required)
// Updates full style properties set with generic values

// RAYGUI_H

/***********************************************************************************
*
*   RAYGUI IMPLEMENTATION
*
************************************************************************************/

// Required for: FILE, fopen(), fclose(), fprintf(), feof(), fscanf(), vsprintf()
// Required for: NAN
// Required for: strlen() on GuiTextBox()

// Required for: va_list, va_start(), vfprintf(), va_end()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------

// GUI controls state

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------

// Current GUI style (light or dark)

//----------------------------------------------
// DEFAULT_BACKGROUND_COLOR
// DEFAULT_LINES_COLOR
// DEFAULT_TEXT_FONT
// DEFAULT_TEXT_SIZE
// DEFAULT_BORDER_WIDTH
// DEFAULT_BORDER_COLOR_NORMAL
// DEFAULT_BASE_COLOR_NORMAL
// DEFAULT_TEXT_COLOR_NORMAL
// DEFAULT_BORDER_COLOR_FOCUSED
// DEFAULT_BASE_COLOR_FOCUSED
// DEFAULT_TEXT_COLOR_FOCUSED
// DEFAULT_BORDER_COLOR_PRESSED
// DEFAULT_BASE_COLOR_PRESSED
// DEFAULT_TEXT_COLOR_PRESSED
// DEFAULT_BORDER_COLOR_DISABLED
// DEFAULT_BASE_COLOR_DISABLED
// DEFAULT_TEXT_COLOR_DISABLED
//----------------------------------------------
// LABEL_TEXT_COLOR_NORMAL -----> DEFAULT_TEXT_COLOR_NORMAL
// LABEL_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// LABEL_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// LABEL_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// BUTTON_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// BUTTON_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// BUTTON_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// BUTTON_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// BUTTON_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// BUTTON_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// BUTTON_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// BUTTON_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// BUTTON_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// BUTTON_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// BUTTON_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// BUTTON_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// BUTTON_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// TOGGLE_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// TOGGLE_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// TOGGLE_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// TOGGLE_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// TOGGLE_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// TOGGLE_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// TOGGLE_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// TOGGLE_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// TOGGLE_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// TOGGLE_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// TOGGLE_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// TOGGLE_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TOGGLE_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// TOGGLEGROUP_PADDING
// SLIDER_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// SLIDER_SLIDER_WIDTH 
// SLIDER_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// SLIDER_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// SLIDER_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// SLIDER_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// SLIDER_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// SLIDER_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// SLIDER_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// SLIDER_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// SLIDERBAR_INNER_PADDING
// SLIDERBAR_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// SLIDERBAR_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// SLIDERBAR_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// SLIDERBAR_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// SLIDERBAR_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// SLIDERBAR_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// SLIDERBAR_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// SLIDERBAR_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// SLIDERBAR_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// PROGRESSBAR_INNER_PADDING
// PROGRESSBAR_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// PROGRESSBAR_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// PROGRESSBAR_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_PRESSED
// PROGRESSBAR_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// PROGRESSBAR_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// PROGRESSBAR_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// PROGRESSBAR_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// PROGRESSBAR_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// PROGRESSBAR_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// VALUEBOX_BUTTON_PADDING
// VALUEBOX_BUTTONS_WIDTH
// VALUEBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// VALUEBOX_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// VALUEBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// VALUEBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// VALUEBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// VALUEBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// VALUEBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// VALUEBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// VALUEBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// VALUEBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// VALUEBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// VALUEBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// COMBOBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// COMBOBOX_BUTTON_PADDING
// COMBOBOX_SELECTOR_WIDTH
// COMBOBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// COMBOBOX_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// COMBOBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// COMBOBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// COMBOBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// COMBOBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// COMBOBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// COMBOBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// COMBOBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// COMBOBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// COMBOBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// COMBOBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// CHECKBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// CHECKBOX_INNER_PADDING
// CHECKBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// CHECKBOX_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// CHECKBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// CHECKBOX_BASE_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// CHECKBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// CHECKBOX_BASE_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// CHECKBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// CHECKBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TEXTBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// TEXTBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// TEXTBOX_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// TEXTBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// TEXTBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// TEXTBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// TEXTBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// TEXTBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// TEXTBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// TEXTBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// TEXTBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// TEXTBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TEXTBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// COLORPICKER_BARS_THICK
// COLORPICKER_BARS_PADDING
// COLORPICKER_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// COLORPICKER_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// COLORPICKER_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// COLORPICKER_BASE_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// COLORPICKER_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// COLORPICKER_BASE_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// COLORPICKER_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// COLORPICKER_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// LISTVIEW_ELEMENTS_HEIGHT
// LISTVIEW_ELEMENTS_PADDING
// LISTVIEW_BAR_WIDTH
// LISTVIEW_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// LISTVIEW_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// LISTVIEW_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// LISTVIEW_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// LISTVIEW_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// LISTVIEW_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// LISTVIEW_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// LISTVIEW_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// LISTVIEW_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// LISTVIEW_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// LISTVIEW_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// LISTVIEW_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED

//----------------------------------------------
// DEFAULT_BACKGROUND_COLOR
// DEFAULT_LINES_COLOR
// DEFAULT_TEXT_FONT
// DEFAULT_TEXT_SIZE
// DEFAULT_BORDER_WIDTH
// DEFAULT_BORDER_COLOR_NORMAL
// DEFAULT_BASE_COLOR_NORMAL
// DEFAULT_TEXT_COLOR_NORMAL
// DEFAULT_BORDER_COLOR_FOCUSED
// DEFAULT_BASE_COLOR_FOCUSED
// DEFAULT_TEXT_COLOR_FOCUSED
// DEFAULT_BORDER_COLOR_PRESSED
// DEFAULT_BASE_COLOR_PRESSED
// DEFAULT_TEXT_COLOR_PRESSED
// DEFAULT_BORDER_COLOR_DISABLED
// DEFAULT_BASE_COLOR_DISABLED
// DEFAULT_TEXT_COLOR_DISABLED
//----------------------------------------------
// LABEL_TEXT_COLOR_NORMAL -----> DEFAULT_TEXT_COLOR_NORMAL
// LABEL_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// LABEL_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// LABEL_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// BUTTON_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// BUTTON_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// BUTTON_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// BUTTON_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// BUTTON_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// BUTTON_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// BUTTON_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// BUTTON_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// BUTTON_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// BUTTON_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// BUTTON_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// BUTTON_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// BUTTON_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// TOGGLE_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// TOGGLE_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// TOGGLE_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// TOGGLE_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// TOGGLE_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// TOGGLE_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// TOGGLE_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// TOGGLE_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// TOGGLE_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// TOGGLE_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// TOGGLE_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// TOGGLE_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TOGGLE_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// TOGGLEGROUP_PADDING
// SLIDER_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// SLIDER_SLIDER_WIDTH 
// SLIDER_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// SLIDER_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// SLIDER_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// SLIDER_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// SLIDER_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// SLIDER_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// SLIDER_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// SLIDER_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// SLIDERBAR_INNER_PADDING
// SLIDERBAR_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// SLIDERBAR_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// SLIDERBAR_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// SLIDERBAR_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// SLIDERBAR_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// SLIDERBAR_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// SLIDERBAR_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// SLIDERBAR_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// SLIDERBAR_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// PROGRESSBAR_INNER_PADDING
// PROGRESSBAR_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// PROGRESSBAR_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// PROGRESSBAR_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_PRESSED
// PROGRESSBAR_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// PROGRESSBAR_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// PROGRESSBAR_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// PROGRESSBAR_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// PROGRESSBAR_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// PROGRESSBAR_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// VALUEBOX_BUTTON_PADDING
// VALUEBOX_BUTTONS_WIDTH
// VALUEBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// VALUEBOX_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// VALUEBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// VALUEBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// VALUEBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// VALUEBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// VALUEBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// VALUEBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// VALUEBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// VALUEBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// VALUEBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// VALUEBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// COMBOBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// COMBOBOX_BUTTON_PADDING
// COMBOBOX_SELECTOR_WIDTH
// COMBOBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// COMBOBOX_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// COMBOBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// COMBOBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// COMBOBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// COMBOBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// COMBOBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// COMBOBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// COMBOBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// COMBOBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// COMBOBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// COMBOBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// CHECKBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// CHECKBOX_INNER_PADDING
// CHECKBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// CHECKBOX_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// CHECKBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// CHECKBOX_BASE_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// CHECKBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// CHECKBOX_BASE_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// CHECKBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// CHECKBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TEXTBOX_BORDER_WIDTH ----> DEFAULT_BORDER_WIDTH
// TEXTBOX_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// TEXTBOX_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// TEXTBOX_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// TEXTBOX_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// TEXTBOX_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// TEXTBOX_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// TEXTBOX_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// TEXTBOX_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// TEXTBOX_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// TEXTBOX_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// TEXTBOX_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// TEXTBOX_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED
// COLORPICKER_BARS_THICK
// COLORPICKER_BARS_PADDING
// COLORPICKER_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// COLORPICKER_BASE_COLOR_NORMAL ----> DEFAULT_BACKGROUND_COLOR
// COLORPICKER_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// COLORPICKER_BASE_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// COLORPICKER_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// COLORPICKER_BASE_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// COLORPICKER_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// COLORPICKER_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// LISTVIEW_ELEMENTS_HEIGHT
// LISTVIEW_ELEMENTS_PADDING
// LISTVIEW_BAR_WIDTH
// LISTVIEW_BORDER_COLOR_NORMAL ----> DEFAULT_BORDER_COLOR_NORMAL
// LISTVIEW_BASE_COLOR_NORMAL ----> DEFAULT_BASE_COLOR_NORMAL
// LISTVIEW_TEXT_COLOR_NORMAL ----> DEFAULT_TEXT_COLOR_NORMAL
// LISTVIEW_BORDER_COLOR_FOCUSED ----> DEFAULT_BORDER_COLOR_FOCUSED
// LISTVIEW_BASE_COLOR_FOCUSED ----> DEFAULT_BASE_COLOR_FOCUSED
// LISTVIEW_TEXT_COLOR_FOCUSED ----> DEFAULT_TEXT_COLOR_FOCUSED
// LISTVIEW_BORDER_COLOR_PRESSED ----> DEFAULT_BORDER_COLOR_PRESSED
// LISTVIEW_BASE_COLOR_PRESSED ----> DEFAULT_BASE_COLOR_PRESSED
// LISTVIEW_TEXT_COLOR_PRESSED ----> DEFAULT_TEXT_COLOR_PRESSED
// LISTVIEW_BORDER_COLOR_DISABLED ----> DEFAULT_BORDER_COLOR_DISABLED
// LISTVIEW_BASE_COLOR_DISABLED ----> DEFAULT_BASE_COLOR_DISABLED
// LISTVIEW_TEXT_COLOR_DISABLED ----> DEFAULT_TEXT_COLOR_DISABLED

//----------------------------------------------------------------------------------
// Module specific Functions Declaration
//----------------------------------------------------------------------------------

// White
// Black
// Light Gray
// My own White (raylib logo)

// This functions are directly implemented in raygui
// Returns a Color struct from hexadecimal value
// Returns hexadecimal value for a Color
// Color fade-in or fade-out, alpha goes from 0.0f to 1.0f
// Check if point is inside rectangle
// Formatting of text with variables to 'embed'

// raygui depend on some raylib input and drawing functions
// NOTE: To use raygui as standalone library, below functions must be defined by the user

/* TODO */
/* TODO */
/* TODO */

// Input related functions

// -- GuiSpinner(), GuiColorPicker()
// -- GuiTextBox()
// -- GuiTextBox()
// -- GuiColorPicker()

// Control specific functions
/* TODO */ // -- GuiColorPicker() *
// -- GuiColorPicker() *
// -- GuiColorPicker() *
// -- GuiColorPicker()

// -- GuiTexture()

// -- GuiLoadStyleImage()
// -- GuiLoadStyleImage()
// -- GuiLoadStyleImage()

// RAYGUI_STANDALONE

// List Element control, returns element state

// Convert color data from HSV to RGB
// Convert color data from RGB to HSV

//----------------------------------------------------------------------------------
// Module Functions Definition
//----------------------------------------------------------------------------------

// Enable gui global state

// Disable gui global state

// Set gui controls alpha global state

// Set one style property value

// Get one style property value

// Window Box control

// Update control
//--------------------------------------------------------------------

// Check button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Group Box control with title name

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control
// NOTE: State not used on this control

//--------------------------------------------------------------------

// Line control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Panel control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Scroll Panel control
// NOTE: bounds define the view area, content defines size of internal data

// TODO: Implement

// Label control

// Update control
//--------------------------------------------------------------------
// ...
//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Button control, returns true when clicked

// Update control
//--------------------------------------------------------------------

// Check button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//------------------------------------------------------------------

// Label button control

// Update control
//--------------------------------------------------------------------

// Check label state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Image button control, returns true when clicked
// TODO: Just provide textureId instead of full Texture2D

// Image button control, returns true when clicked
// TODO: Just provide textureId instead of full Texture2D

// Update control
//--------------------------------------------------------------------

// Check button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//------------------------------------------------------------------

// Toggle Button control, returns true when active

// Update control
//--------------------------------------------------------------------

// Check toggle button state

// TODO: DrawTextureV(texCursor, mousePoint, WHITE);

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Toggle Group control, returns toggled button index

// Check Box control, returns true when active

// Update control
//--------------------------------------------------------------------

// Check checkbox state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Check Box extended control, returns true when active

// Update control
//--------------------------------------------------------------------

// Check checkbox state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Combo Box control, returns selected item index

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Dropdown Box control, returns selected item

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Spinner control, returns selected value
// NOTE: Requires static variables: framesCounter, valueSpeed - ERROR!

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Value Box control, updates input text with numbers
// NOTE: Requires static variables: framesCounter

// Required for blinking cursor

// Update control
//--------------------------------------------------------------------

// GLFW BACKSPACE: 3 + 256

// NOTE: PRESSED state is not used on this control

// NOTE: Only allow keys in range [32..125]

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control

//--------------------------------------------------------------------

// Text Box control, updates input text
// NOTE 1: Requires static variables: framesCounter
// NOTE 2: Returns if KEY_ENTER pressed (useful for data validation)

// Deleting speed

// Required for blinking cursor

// Update control
//--------------------------------------------------------------------

// GLFW BACKSPACE: 3 + 256

// NOTE: PRESSED state is not used on this control

// NOTE: Only allow keys in range [32..125]

// if (IsKeyPressed(KEY_BACKSPACE_TEXT))
// {
// keyCount--;
// text[keyCount] = '\0';

// if (keyCount < 0) keyCount = 0;
// }

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control

//--------------------------------------------------------------------

// Text Box control with multiple lines

// Internal from raylib line-break space (height + height/2)*scale

// Required for blinking cursor

// Update control
//--------------------------------------------------------------------

// GLFW BACKSPACE: 3 + 256

// NOTE: PRESSED state is not used on this control

// NOTE: Only allow keys in range [32..125]

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control

//--------------------------------------------------------------------

// Slider control, returns selected value

// Update control
//--------------------------------------------------------------------

// Get equivalent value and slider position from mousePoint.x

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Slider control extended, returns selected value and has text

// Update control
//--------------------------------------------------------------------

// Get equivalent value and slider position from mousePoint.x

//slider.x = bounds.x + (int)(((value - minValue)/(maxValue - minValue))*(bounds.width - 2*style[SLIDER_BORDER_WIDTH])) - slider.width/2;

// Snap to limits if mouse down moved outside limits
//if (slider.x < (bounds.x + style[SLIDER_BORDER_WIDTH])) slider.x = bounds.x + style[SLIDER_BORDER_WIDTH];
//else if ((slider.x + slider.width) > (bounds.x + bounds.width - 2*style[SLIDER_BORDER_WIDTH])) slider.x = (bounds.x + bounds.width - 2*style[SLIDER_BORDER_WIDTH]) - slider.width;

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------    

//--------------------------------------------------------------------

// Slider Bar control, returns selected value

// Update control
//--------------------------------------------------------------------

// Get equivalent value and slider width from mousePoint.x

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Slider Bar control extended, returns selected value

// Update control
//--------------------------------------------------------------------

// Get equivalent value and slider width from mousePoint.x

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Progress Bar control, shows current progress value

// TODO

// Update control
//--------------------------------------------------------------------

//if (CheckCollisionPointRec(mousePoint, bounds)) state = FOCUSED;      // State not required on ProgressBar

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control
// NOTE: State not used on this control

//--------------------------------------------------------------------

// Progress Bar control extended, shows current progress value

// TODO

// Update control
//--------------------------------------------------------------------

//if (CheckCollisionPointRec(mousePoint, bounds)) state = FOCUSED;      // State not required on ProgressBar

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: State not used on this control
// NOTE: State not used on this control

//--------------------------------------------------------------------

// Status Bar control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Update control
//--------------------------------------------------------------------

// Check button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//DrawRectangleLines(bounds.x, bounds.y, bounds.width, bounds.height, Fade(GetColor(style[DEFAULT_BORDER_COLOR_NORMAL]), guiAlpha));

//DrawRectangleLines(bounds.x, bounds.y, bounds.width, bounds.height, Fade(GetColor(style[DEFAULT_BORDER_COLOR_DISABLED]), guiAlpha));

//------------------------------------------------------------------

// List Element control, returns element state

// Update control
//--------------------------------------------------------------------

// Check toggle button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// List View control, returns selected list element index  // int *startIndex)

// Update control
//--------------------------------------------------------------------

//active += 1;
//if (active >= count) active = 0;

//(maxIndexCount + indexOffset) > count) ? count : (maxIndexCount + indexOffset)
//if (maxIndexCount + indexOffset) > count) return count;
//else return (maxIndexCount + indexOffset);

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// TODO: Review bar logic when bar size should be shorter than LISTVIEW_ELEMENT_HEIGHT

//--------------------------------------------------------------------

// Color Panel control

// HSV: Saturation
// HSV: Value

// Update control
//--------------------------------------------------------------------

// Calculate color from picker

// Get normalized value on x
// Get normalized value on y

// NOTE: Vector3ToColor() only available on raylib 1.8.1

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw color picker: selector

//DrawRectangleGradientEx(bounds, Fade(BLACK, 0), BLACK, BLACK, Fade(BLACK, 0));

//--------------------------------------------------------------------

// Color Bar Alpha control
// NOTE: Returns alpha value normalized [0..1]

//#define GUICOLORBAR_SELECTOR_THICK          6

// Update control
//--------------------------------------------------------------------

//selector.x = bounds.x + (int)(((alpha - 0)/(100 - 0))*(bounds.width - 2*style[SLIDER_BORDER_WIDTH])) - selector.width/2;

//state = FOCUSED;

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw alpha bar: checked background

//--------------------------------------------------------------------

// Color Bar Hue control
// NOTE: Returns hue value normalized [0..1]

// Update control
//--------------------------------------------------------------------

/*if (IsKeyDown(KEY_UP))
{
    hue -= 2.0f;
    if (hue <= 0.0f) hue = 0.0f;
}
else if (IsKeyDown(KEY_DOWN))
{
    hue += 2.0f;
    if (hue >= 360.0f) hue = 360.0f;
}*/

//--------------------------------------------------------------------
// Draw control
//--------------------------------------------------------------------

//Draw hue bar:color bars

// Draw hue bar: selector

//--------------------------------------------------------------------

// TODO: Color GuiColorBarSat() [WHITE->color]
// TODO: Color GuiColorBarValue() [BLACK->color]), HSV / HSL
// TODO: float GuiColorBarLuminance() [BLACK->WHITE]

// Color Picker control
// NOTE: It's divided in multiple controls:
//      Color GuiColorPanel() - Color select panel
//      float GuiColorBarAlpha(Rectangle bounds, float alpha)
//      float GuiColorBarHue(Rectangle bounds, float value)
// NOTE: bounds define GuiColorPanel() size

//color.a = (unsigned char)(GuiColorBarAlpha(boundsAlpha, (float)color.a/255.0f)*255.0f);

/*
// Draw control: color select panel
//--------------------------------------------------------------------
if (state != DISABLED)
{
    for (int i = 0; i < 2; i++) DrawRectangle(bounds.x + style[COLORPICKER_BARS_PADDING]*(i%((int)bounds.width/(style[COLORPICKER_BARS_THICK]/2))) + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], bounds.width/(bounds.width/(style[COLORPICKER_BARS_THICK]/2)), style[COLORPICKER_BARS_THICK]/2, (i%2) ? Fade(Fade(GRAY, 0.4f), guiAlpha) : Fade(Fade(RAYWHITE, 0.4f), guiAlpha));
    for (int i = 0; i < 2; i++) DrawRectangle(bounds.x + style[COLORPICKER_BARS_PADDING]*(i%((int)bounds.width/(style[COLORPICKER_BARS_THICK]/2))) + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + style[COLORPICKER_BARS_PADDING] + bounds.height + style[COLORPICKER_BARS_PADDING], bounds.width/(bounds.width/(style[COLORPICKER_BARS_THICK]/2)), style[COLORPICKER_BARS_THICK]/2, (i%2) ? Fade(Fade(RAYWHITE, 0.4f), guiAlpha) : Fade(Fade(GRAY, 0.4f), guiAlpha));
    DrawRectangle(bounds.x + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], style[COLORPICKER_BARS_THICK], style[COLORPICKER_BARS_THICK], Fade(color, guiAlpha));
    DrawRectangleLines(bounds.x + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], style[COLORPICKER_BARS_THICK], style[COLORPICKER_BARS_THICK], Fade(GetColor(style[COLORPICKER_BORDER_COLOR_NORMAL]), guiAlpha));
}
else
{
    //DrawRectangleGradientEx((Rectangle){ bounds.x + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], style[COLORPICKER_BARS_THICK], style[COLORPICKER_BARS_THICK] }, WHITE, GRAY, BLACK, GRAY);
    DrawRectangle(bounds.x + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], style[COLORPICKER_BARS_THICK], style[COLORPICKER_BARS_THICK], Fade(GetColor(style[COLORPICKER_BASE_COLOR_DISABLED]), guiAlpha));
    DrawRectangleLines(bounds.x + bounds.width + style[COLORPICKER_BARS_PADDING], bounds.y + bounds.height + style[COLORPICKER_BARS_PADDING], style[COLORPICKER_BARS_THICK], style[COLORPICKER_BARS_THICK], Fade(GetColor(style[COLORPICKER_BORDER_COLOR_DISABLED]), guiAlpha));
}
//--------------------------------------------------------------------
*/

// Message Box control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Grid control
// NOTE: Returns mouse position on grid

// Grid lines alpha amount

// Update control
//--------------------------------------------------------------------

// Check mouse position if snap

// TODO: Mouse point snap

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw vertical grid lines

// Draw horizontal grid lines

// Save raygui style file (.rgs), text or binary

// Write some header info (12 bytes)
// id: "RGS "       - 4 bytes
// version: 200     - 2 bytes
// NUM_PROPERTIES   - 2 bytes
// reserved         - 4 bytes

// Write some description comments

// Load raygui style file (.rgs), text or binary
// NOTE: File is tried to be loaded as text first

// Text file!

// Update style property

// Load GUI style from an image style file

// NOTE: Image data only defines color properties

// Load generic style color palette

// Update full style with generic values

// Load style from a color palette array (14 values required)

// Load generic style color palette

// Update full style with generic values

// Updates full style property set with generic values
// NOTE: Requires globals style[] and style[]

// Label

// Button

// ToggleButton / ToggleGroup

// Slider

// SliderBar

// ProgressBar

// ValueBox

// ComboBox

// CheckBox

// TextBox

// ColorPicker

// ListView

// defined(RAYGUI_STYLE_SAVE_LOAD)

//----------------------------------------------------------------------------------
// Module specific Functions Definition
//----------------------------------------------------------------------------------

// Convert color data from RGB to HSV
// NOTE: Color data should be passed normalized

// Value

// Undefined, maybe NAN?

// NOTE: If max is 0, this divide would cause a crash
// Saturation

// NOTE: If max is 0, then r = g = b = 0, s = 0, h is undefined

// Undefined

// NOTE: Comparing float values could not work properly
// Between yellow & magenta

// Between cyan & yellow
// Between magenta & cyan

// Convert to degrees

// Convert color data from HSV to RGB
// NOTE: Color data should be passed normalized

// NOTE: Comparing float values could not work properly

// Returns a Color struct from hexadecimal value

// Returns hexadecimal value for a Color

// Check if point is inside rectangle

// Color fade-in or fade-out, alpha goes from 0.0f to 1.0f

// Formatting of text with variables to 'embed'

// RAYGUI_IMPLEMENTATION
