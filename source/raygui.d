/*******************************************************************************************
*
*   raygui v2.5 - A simple and easy-to-use immedite-mode-gui library
*
*   DESCRIPTION:
*
*   raygui is a tools-dev-focused immediate-mode-gui library based on raylib but also possible
*   to be used as a standalone library, as long as input and drawing functions are provided.
*
*   Controls provided:
*
*   # Container/separators Controls
*       - WindowBox
*       - GroupBox
*       - Line
*       - Panel
*
*   # Basic Controls
*       - Label
*       - Button
*       - LabelButton   --> Label
*       - ImageButton   --> Button
*       - ImageButtonEx --> Button
*       - Toggle
*       - ToggleGroup   --> Toggle
*       - CheckBox
*       - ComboBox
*       - DropdownBox
*       - TextBox
*       - TextBoxMulti
*       - ValueBox      --> TextBox
*       - Spinner       --> Button, ValueBox
*       - Slider
*       - SliderBar     --> Slider
*       - ProgressBar
*       - StatusBar
*       - ScrollBar
*       - ScrollPanel
*       - DummyRec
*       - Grid
*
*   # Advance Controls
*       - ListView      --> ListElement
*       - ColorPicker   --> ColorPanel, ColorBarHue
*       - MessageBox    --> Label, Button
*       - TextInputBox  --> Label, TextBox, Button
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
*   #define RAYGUI_RICONS_SUPPORT
*       Includes ricons.h header defining a set of 128 icons (binary format) to be used on
*       multiple controls and following raygui styles
*
*   #define RAYGUI_TEXTBOX_EXTENDED
*       Enables the advance GuiTextBox()/GuiValueBox()/GuiSpinner() implementation with
*       text selection support and text copy/cut/paste support
*
*   VERSIONS HISTORY:
*       2.5 (28-May-2019) Implemented extended GuiTextBox(), GuiValueBox(), GuiSpinner()
*       2.3 (29-Apr-2019) Added rIcons auxiliar library and support for it, multiple controls reviewed
*                         Refactor all controls drawing mechanism to use control state
*       2.2 (05-Feb-2019) Added GuiScrollBar(), GuiScrollPanel(), reviewed GuiListView(), removed Gui*Ex() controls
*       2.1 (26-Dec-2018) Redesign of GuiCheckBox(), GuiComboBox(), GuiDropdownBox(), GuiToggleGroup() > Use combined text string
*                         Complete redesign of style system (breaking change)
*       2.0 (08-Nov-2018) Support controls guiLock and custom fonts, reviewed GuiComboBox(), GuiListView()...
*       1.9 (09-Oct-2018) Controls review: GuiGrid(), GuiTextBox(), GuiTextBoxMulti(), GuiValueBox()...
*       1.8 (01-May-2018) Lot of rework and redesign to align with rGuiStyler and rGuiLayout
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
*       Vlad Adrian:        Complete rewrite of GuiTextBox() to support extended features (2019)
*       Sergio Martinez:    Review, testing (2015) and redesign of multiple controls (2018)
*       Adria Arranz:       Testing and Implementation of additional controls (2018)
*       Jordi Jorba:        Testing and Implementation of additional controls (2018)
*       Albert Martos:      Review and testing of the library (2015)
*       Ian Eito:           Review and testing of the library (2015)
*       Kevin Gato:         Initial implementation of basic components (2014)
*       Daniel Nicolas:     Initial implementation of basic components (2014)
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

module raygui;
import raylib;

extern (C):

enum RAYGUI_VERSION = "2.5-dev";

// We are building raygui as a Win32 shared library (.dll).
// We are using raygui as a Win32 shared library (.dll)

// Functions visible from other files (no name mangling of functions in C++) // Functions visible from other files

// Functions just visible to module including this file

// Required for: atoi()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
extern (D) auto VALIGN_OFFSET(T)(auto ref T h)
{
    return cast(int) h % 2;
} // Vertical alignment for pixel perfect

enum TEXTEDIT_CURSOR_BLINK_FRAMES = 20; // Text edit controls cursor blink timming

enum NUM_CONTROLS = 16; // Number of standard controls
enum NUM_PROPS_DEFAULT = 16; // Number of standard properties
enum NUM_PROPS_EXTENDED = 8; // Number of extended properties

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Some types are required for RAYGUI_STANDALONE usage
//----------------------------------------------------------------------------------

// Boolean type

// Vector2 type

// Vector3 type

// Color type, RGBA (32bit)

// Rectangle type

// Texture2D type

// Font type

// Gui text box state data

// Cursor position in text
// Text start position (from where we begin drawing the text)
// Text start index (index inside the text of `start` always in sync)
// Marks position of cursor when selection has started

// Gui control state
enum GuiControlState
{
    GUI_STATE_NORMAL = 0,
    GUI_STATE_FOCUSED = 1,
    GUI_STATE_PRESSED = 2,
    GUI_STATE_DISABLED = 3
}

// Gui control text alignment
enum GuiTextAlignment
{
    GUI_TEXT_ALIGN_LEFT = 0,
    GUI_TEXT_ALIGN_CENTER = 1,
    GUI_TEXT_ALIGN_RIGHT = 2
}

// Gui controls
enum GuiControl
{
    DEFAULT = 0,
    LABEL = 1, // LABELBUTTON
    BUTTON = 2, // IMAGEBUTTON
    TOGGLE = 3, // TOGGLEGROUP
    SLIDER = 4, // SLIDERBAR
    PROGRESSBAR = 5,
    CHECKBOX = 6,
    COMBOBOX = 7,
    DROPDOWNBOX = 8,
    TEXTBOX = 9, // TEXTBOXMULTI
    VALUEBOX = 10,
    SPINNER = 11,
    LISTVIEW = 12,
    COLORPICKER = 13,
    SCROLLBAR = 14,
    RESERVED = 15
}

// Gui base properties for every control
enum GuiControlProperty
{
    BORDER_COLOR_NORMAL = 0,
    BASE_COLOR_NORMAL = 1,
    TEXT_COLOR_NORMAL = 2,
    BORDER_COLOR_FOCUSED = 3,
    BASE_COLOR_FOCUSED = 4,
    TEXT_COLOR_FOCUSED = 5,
    BORDER_COLOR_PRESSED = 6,
    BASE_COLOR_PRESSED = 7,
    TEXT_COLOR_PRESSED = 8,
    BORDER_COLOR_DISABLED = 9,
    BASE_COLOR_DISABLED = 10,
    TEXT_COLOR_DISABLED = 11,
    BORDER_WIDTH = 12,
    INNER_PADDING = 13,
    TEXT_ALIGNMENT = 14,
    RESERVED02 = 15
}

// Gui extended properties depend on control
// NOTE: We reserve a fixed size of additional properties per control

// DEFAULT properties
enum GuiDefaultProperty
{
    TEXT_SIZE = 16,
    TEXT_SPACING = 17,
    LINE_COLOR = 18,
    BACKGROUND_COLOR = 19
}

// Label
//typedef enum { } GuiLabelProperty;

// Button
//typedef enum { } GuiButtonProperty;

// Toggle / ToggleGroup
enum GuiToggleProperty
{
    GROUP_PADDING = 16
}

// Slider / SliderBar
enum GuiSliderProperty
{
    SLIDER_WIDTH = 16,
    TEXT_PADDING = 17
}

// ProgressBar
//typedef enum { } GuiProgressBarProperty;

// CheckBox
enum GuiCheckBoxProperty
{
    CHECK_TEXT_PADDING = 16
}

// ComboBox
enum GuiComboBoxProperty
{
    SELECTOR_WIDTH = 16,
    SELECTOR_PADDING = 17
}

// DropdownBox
enum GuiDropdownBoxProperty
{
    ARROW_RIGHT_PADDING = 16
}

// TextBox / TextBoxMulti / ValueBox / Spinner
enum GuiTextBoxProperty
{
    MULTILINE_PADDING = 16,
    COLOR_SELECTED_FG = 17,
    COLOR_SELECTED_BG = 18
}

enum GuiSpinnerProperty
{
    SELECT_BUTTON_WIDTH = 16,
    SELECT_BUTTON_PADDING = 17,
    SELECT_BUTTON_BORDER_WIDTH = 18
}

// ScrollBar
enum GuiScrollBarProperty
{
    ARROWS_SIZE = 16,
    SLIDER_PADDING = 17,
    SLIDER_SIZE = 18,
    SCROLL_SPEED = 19,
    SHOW_SPINNER_BUTTONS = 20
}

// ScrollBar side
enum GuiScrollBarSide
{
    SCROLLBAR_LEFT_SIDE = 0,
    SCROLLBAR_RIGHT_SIDE = 1
}

// ListView
enum GuiListViewProperty
{
    ELEMENTS_HEIGHT = 16,
    ELEMENTS_PADDING = 17,
    SCROLLBAR_WIDTH = 18,
    SCROLLBAR_SIDE = 19 // This property defines vertical scrollbar side (SCROLLBAR_LEFT_SIDE or SCROLLBAR_RIGHT_SIDE)
}

// ColorPicker
enum GuiColorPickerProperty
{
    COLOR_SELECTOR_SIZE = 16,
    BAR_WIDTH = 17, // Lateral bar width
    BAR_PADDING = 18, // Lateral bar separation from panel
    BAR_SELECTOR_HEIGHT = 19, // Lateral bar selector height
    BAR_SELECTOR_PADDING = 20 // Lateral bar selector outer padding
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
void GuiLock (); // Lock gui controls (global state)
void GuiUnlock (); // Unlock gui controls (global state)
void GuiState (int state); // Set gui state (global state)
void GuiFont (Font font); // Set gui custom font (global state)
void GuiFade (float alpha); // Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f

// Style set/get functions
void GuiSetStyle (int control, int property, int value); // Set one style property
int GuiGetStyle (int control, int property); // Get one style property

// GuiTextBox() extended functions
// Sets the active textbox
// Get bounds of active textbox
// Set cursor position of active textbox
// Get cursor position of active textbox
// Set selection of active textbox
// Get selection of active textbox (x - selection start  y - selection length)
// Returns true if a textbox control with specified `bounds` is the active textbox
// Get state for the active textbox
// Set state for the active textbox (state must be valid else things will break)
// Select all characters in the active textbox (same as pressing `CTRL` + `A`)
// Copy selected text to clipboard from the active textbox (same as pressing `CTRL` + `C`)
// Paste text from clipboard into the textbox (same as pressing `CTRL` + `V`)
// Cut selected text in the active textbox and copy it to clipboard (same as pressing `CTRL` + `X`)
// Deletes a character or selection before from the active textbox (depending on `before`). Returns bytes deleted.
// Get the byte index for a character starting at position `from` with index `start` until position `to`.

// Container/separator controls, useful for controls organization
bool GuiWindowBox (Rectangle bounds, const(char)* text); // Window Box control, shows a window that can be closed
void GuiGroupBox (Rectangle bounds, const(char)* text); // Group Box control with title name
void GuiLine (Rectangle bounds, const(char)* text); // Line separator control, could contain text
void GuiPanel (Rectangle bounds); // Panel control, useful to group controls
Rectangle GuiScrollPanel (Rectangle bounds, Rectangle content, Vector2* scroll); // Scroll Panel control

// Basic controls set
void GuiLabel (Rectangle bounds, const(char)* text); // Label control, shows text
bool GuiButton (Rectangle bounds, const(char)* text); // Button control, returns true when clicked
bool GuiLabelButton (Rectangle bounds, const(char)* text); // Label button control, show true when clicked
bool GuiImageButton (Rectangle bounds, Texture2D texture); // Image button control, returns true when clicked
bool GuiImageButtonEx (Rectangle bounds, Texture2D texture, Rectangle texSource, const(char)* text); // Image button extended control, returns true when clicked
bool GuiToggle (Rectangle bounds, const(char)* text, bool active); // Toggle Button control, returns true when active
int GuiToggleGroup (Rectangle bounds, const(char)* text, int active); // Toggle Group control, returns active toggle index
bool GuiCheckBox (Rectangle bounds, const(char)* text, bool checked); // Check Box control, returns true when active
int GuiComboBox (Rectangle bounds, const(char)* text, int active); // Combo Box control, returns selected item index
bool GuiDropdownBox (Rectangle bounds, const(char)* text, int* active, bool editMode); // Dropdown Box control, returns selected item
bool GuiSpinner (Rectangle bounds, int* value, int minValue, int maxValue, bool editMode); // Spinner control, returns selected value
bool GuiValueBox (Rectangle bounds, int* value, int minValue, int maxValue, bool editMode); // Value Box control, updates input text with numbers
bool GuiTextBox (Rectangle bounds, char* text, int textSize, bool editMode); // Text Box control, updates input text
bool GuiTextBoxMulti (Rectangle bounds, char* text, int textSize, bool editMode); // Text Box control with multiple lines
float GuiSlider (Rectangle bounds, const(char)* text, float value, float minValue, float maxValue, bool showValue); // Slider control, returns selected value
float GuiSliderBar (Rectangle bounds, const(char)* text, float value, float minValue, float maxValue, bool showValue); // Slider Bar control, returns selected value
float GuiProgressBar (Rectangle bounds, const(char)* text, float value, float minValue, float maxValue, bool showValue); // Progress Bar control, shows current progress value
void GuiStatusBar (Rectangle bounds, const(char)* text); // Status Bar control, shows info text
void GuiDummyRec (Rectangle bounds, const(char)* text); // Dummy control for placeholders
int GuiScrollBar (Rectangle bounds, int value, int minValue, int maxValue); // Scroll Bar control
Vector2 GuiGrid (Rectangle bounds, float spacing, int subdivs); // Grid

// Advance controls set
bool GuiListView (Rectangle bounds, const(char)* text, int* active, int* scrollIndex, bool editMode); // List View control, returns selected list element index
bool GuiListViewEx (Rectangle bounds, const(char*)* text, int count, int* enabled, int* active, int* focus, int* scrollIndex, bool editMode); // List View with extended parameters
int GuiMessageBox (Rectangle bounds, const(char)* windowTitle, const(char)* message, const(char)* buttons); // Message Box control, displays a message
int GuiTextInputBox (Rectangle bounds, const(char)* windowTitle, const(char)* message, char* text, const(char)* buttons); // Text Input Box control, ask for text
Color GuiColorPicker (Rectangle bounds, Color color); // Color Picker control

// Styles loading functions
void GuiLoadStyle (const(char)* fileName); // Load style file (.rgs)
void GuiLoadStyleProps (const(int)* props, int count); // Load style properties from array
void GuiLoadStyleDefault (); // Load style default over global style
void GuiUpdateStyleComplete (); // Updates full style properties set with default values

/*
typedef GuiStyle (unsigned int *)
RAYGUIDEF GuiStyle LoadGuiStyle(const char *fileName);          // Load style from file (.rgs)
RAYGUIDEF void UnloadGuiStyle(GuiStyle style);                  // Unload style
*/

const(char)* GuiIconText (int iconId, const(char)* text); // Get text with icon id prepended

// RAYGUI_H

/***********************************************************************************
*
*   RAYGUI IMPLEMENTATION
*
************************************************************************************/

// Required for: raygui icons

// Required for: FILE, fopen(), fclose(), fprintf(), feof(), fscanf(), vsprintf()
// Required for: strlen() on GuiTextBox()

// Required for: va_list, va_start(), vfprintf(), va_end()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
//...

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------
// Gui control property style element
enum GuiPropertyElement
{
    BORDER = 0,
    BASE = 1,
    TEXT = 2,
    OTHER = 3
}

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
extern __gshared GuiControlState guiState;

extern __gshared Font guiFont; // NOTE: Highly coupled to raylib
extern __gshared bool guiLocked;
extern __gshared float guiAlpha;

// Global gui style array (allocated on heap by default)
// NOTE: In raygui we manage a single int array with all the possible style properties.
// When a new style is loaded, it loads over the global style... but default gui style
// could always be recovered with GuiLoadStyleDefault()
extern __gshared uint[384] guiStyle;
extern __gshared bool guiStyleLoaded;

// Area of the currently active textbox
// Keeps state of the active textbox

//----------------------------------------------------------------------------------
// Standalone Mode Functions Declaration
//
// NOTE: raygui depend on some raylib input and drawing functions
// To use raygui as standalone library, below functions must be defined by the user
//----------------------------------------------------------------------------------

// White -- GuiColorBarAlpha()
// Black -- GuiColorBarAlpha()
// My own White (raylib logo)
// Gray -- GuiColorBarAlpha()

// raylib functions already implemented in raygui
//-------------------------------------------------------------------------------
// Returns a Color struct from hexadecimal value
// Returns hexadecimal value for a Color
// Color fade-in or fade-out, alpha goes from 0.0f to 1.0f
// Check if point is inside rectangle
// Formatting of text with variables to 'embed'
//-------------------------------------------------------------------------------

// Input required functions
//-------------------------------------------------------------------------------

// -- GuiTextBox()
//-------------------------------------------------------------------------------

// Drawing required functions
//-------------------------------------------------------------------------------
/* TODO */

/* TODO */

/* TODO */ // -- GuiColorPicker()
// -- GuiColorPicker()
// -- GuiColorPicker()
// -- GuiColorPicker()

/* TODO */ // -- GuiDropdownBox()
/* TODO */ // -- GuiScrollBar()

// -- GuiImageButtonEx()
//-------------------------------------------------------------------------------

// Text required functions
//-------------------------------------------------------------------------------
// --  GetTextWidth()

// -- GetTextWidth(), GuiTextBoxMulti()
// -- GuiDrawText()
//-------------------------------------------------------------------------------

// RAYGUI_STANDALONE

//----------------------------------------------------------------------------------
// Module specific Functions Declaration
//----------------------------------------------------------------------------------

// List Element control, returns element state
bool GuiListElement (Rectangle bounds, const(char)* text, bool active, bool editMode);

Vector3 ConvertHSVtoRGB (Vector3 hsv); // Convert color data from HSV to RGB
Vector3 ConvertRGBtoHSV (Vector3 rgb); // Convert color data from RGB to HSV

// Gui get text width using default font
// TODO: GetTextSize()

// TODO: Consider text icon width here???
int GetTextWidth (const(char)* text);

// Get text bounds considering control bounds

// TODO: Special cases (no label): COMBOBOX, DROPDOWNBOX, SPINNER, LISTVIEW (scrollbar?)
// More special cases (label side): CHECKBOX, SLIDER
Rectangle GetTextBounds (int control, Rectangle bounds);

// Get text icon if provided and move text cursor

// Maybe we have an icon!

// Move text pointer after icon
// WARNING: If only icon provided, it could point to EOL character!
const(char)* GetTextIcon (const(char)* text, int* iconId);

// Gui draw text using default font

// Check text for icon and move cursor

// Get text position depending on alignment and iconId
//---------------------------------------------------------------------------------

// NOTE: We get text size after icon been processed

// WARNING: If only icon provided, text could be pointing to eof character!

// Check guiTextAlign global variables

//---------------------------------------------------------------------------------

// Draw text (with icon if available)
//---------------------------------------------------------------------------------

// NOTE: We consider icon height, probably different than text size

//---------------------------------------------------------------------------------
void GuiDrawText (
    const(char)* text,
    Rectangle bounds,
    int alignment,
    Color tint);
enum ICON_TEXT_PADDING = 4;

// Split controls text into multiple strings
// Also check for multiple columns (required by GuiToggleGroup())
const(char*)* GuiTextSplit (const(char)* text, int* count, int* textRow);
//----------------------------------------------------------------------------------
// Module Functions Definition
//----------------------------------------------------------------------------------

// Enable gui global state

// Disable gui global state

// Lock gui global state

// Unlock gui global state

// Set gui state (global state)

// Define custom gui font

// Set gui controls alpha global state

// Set control style property value

// Get control style property value

// Sets the active textbox (reseting state of the previous active textbox)

// Gets bounds of active textbox

// Set cursor position of active textbox

// Mark this to be recalculated

// Get cursor position of active textbox

// Set selection of active textbox

// Get selection of active textbox

// Returns true if a textbox control with specified `bounds` is the active textbox

// NOTE: should we check if state values are valid ?!?

// Window Box control

// Update control
//--------------------------------------------------------------------
// NOTE: Logic is directly managed by button
//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw window base

// Draw window header as status bar

// Draw window close button

//--------------------------------------------------------------------
enum WINDOW_CLOSE_BUTTON_PADDING = 2;
enum WINDOW_STATUSBAR_HEIGHT = 24;

// Group Box control with title name

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------
enum GROUPBOX_LINE_THICK = 1;
enum GROUPBOX_TEXT_PADDING = 10;
enum GROUPBOX_PADDING = 2;

// Line control

// Draw control
//--------------------------------------------------------------------

// TODO: Consider text icon

// Draw line with embedded text label: "--- text --------------"

//--------------------------------------------------------------------
enum LINE_THICK = 1;
enum LINE_TEXT_PADDING = 10;
enum LINE_TEXT_SPACING = 2;

// Panel control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------
enum PANEL_BORDER_WIDTH = 1;

// Scroll Panel control

// Recheck to account for the other scrollbar being visible

// Calculate view area (area without the scrollbars)

// Clip view area to the actual content size

// TODO: Review!

// Update control
//--------------------------------------------------------------------

// Check button state

// Normalize scroll values

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw background

// Save size of the scrollbar slider

// Draw horizontal scrollbar if visible

// Change scrollbar slider size to show the diff in size between the content width and the widget width

// Draw vertical scrollbar if visible

// Change scrollbar slider size to show the diff in size between the content height and the widget height

// Draw detail corner rectangle if both scroll bars are visible

// TODO: Consider scroll bars side

// Set scrollbar slider size back to the way it was before

// Draw scrollbar lines depending on current state

//--------------------------------------------------------------------

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

// Check checkbox state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Image button control, returns true when clicked
// Image button control, returns true when clicked

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

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Toggle Group control, returns toggled button index

// Get substrings elements from text (elements pointers)

// Check Box control, returns true when active

// TODO: Consider text icon

// Update control
//--------------------------------------------------------------------

// Check checkbox state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// NOTE: Forced left text alignment

//--------------------------------------------------------------------

// Combo Box control, returns selected item index

// Get substrings elements from text (elements pointers, lengths and count)

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw combo box main

// Draw selector using a custom button
// NOTE: BORDER_WIDTH and TEXT_ALIGNMENT forced values

//--------------------------------------------------------------------

// Dropdown Box control, returns selected item

// Get substrings elements from text (elements pointers, lengths and count)

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// TODO: Review this ugly hack... DROPDOWNBOX depends on GuiListElement() that uses DEFAULT_TEXT_ALIGNMENT

// TODO: Avoid this function, use icon instead or 'v'

//GuiDrawText("v", (Rectangle){ bounds.x + bounds.width - GuiGetStyle(DROPDOWNBOX, ARROW_RIGHT_PADDING), bounds.y + bounds.height/2 - 2, 10, 10 },
//            GUI_TEXT_ALIGN_CENTER, Fade(GetColor(GuiGetStyle(DROPDOWNBOX, TEXT + (state*3))), guiAlpha));  
//--------------------------------------------------------------------

// Spinner control, returns selected value
// NOTE: Requires static variables: timer, valueSpeed - ERROR!

// Min 200ms delay

// Get current time

// Update control
//--------------------------------------------------------------------

// This becomes the active textbox when mouse is pressed or held inside bounds

// Reset timer when one of the buttons is clicked (without this, holding the button down will not behave correctly)

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Set our spinner as the active textbox

// Revert change

// Draw value selector custom buttons
// NOTE: BORDER_WIDTH and TEXT_ALIGNMENT forced values

// NOTE: also decrease value when the button is held down

// NOTE: also increase value when the button is held down

//--------------------------------------------------------------------

// Reset timer

// Value Box control, updates input text with numbers

// Required by GuiTextBox()
// Highly synchronized with calculations in DrawTextRecEx()

// Get gui font properties

// Offset between characters

// Current character
// Index position in sprite font

// Check if the mouse pointer is inside the glyph rect

// Smooth selection by dividing the glyph rectangle into 2 equal parts and checking where the mouse resides

// Required by GuiTextBoxEx()
// Highly synchronized with calculations in DrawTextRecEx()

// Get gui font properties

// Offset between characters

// Current character
// Index position in sprite font

// Calculate cursor coordinates based on the cursor position `pos` inside the `text`.

// Calculate cursor position in textbox based on mouse coordinates.

// Calculates how many characters is the textbox able to draw inside rec

// Returns total number of characters(codepoints) in a UTF8 encoded `text` until `\0` or a `\n` is found.
// NOTE: If a invalid UTF8 sequence is encountered a `?`(0x3f) codepoint is counted instead. 

// FIXME: Counting codepoints each time we press the key is expensive, find another way

// Delete selection

// Convert to byte indexes

// Adjust text box state
// Always set cursor to start of selection
// Force to recalculate on the next frame

// Delete character before cursor

// Force to recalculate on the next frame

// Delete character after cursor

// Always deselect

// Force recalculate on the next frame

// Convert to byte indexes

// FIXME: `TextSubtext()` only lets use copy MAX_TEXT_BUFFER_LENGTH (1024) bytes
// maybe modify `SetClipboardText()` so we can use it only on part of a string

// Paste text from clipboard into the active textbox.
// `text` is the pointer to the buffer used by the textbox while `textSize` is the text buffer max size

// GLFW guaratees this should be UTF8 encoded!

// If there's a selection we'll have to delete it first

// We want the length in bytes

// Calculate how many bytes can we copy from clipboard text before we run out of space

// Make room by shifting to right the bytes after cursor

// Set the NULL char

// At long last copy the clipboard text

// Set cursor position at the end of the pasted text

// Force to recalculate on the next frame

// First copy selection to clipboard;

// Convert to byte indexes

// FIXME: `TextSubtext()` only lets use copy MAX_TEXT_BUFFER_LENGTH (1024) bytes
// maybe modify `SetClipboardText()` so we can use it only on parts of a string

// Now delete selection (copy data over it)

// Adjust text box state
// Always set cursor to start of selection
// Force to recalculate
// Deselect

// A text box control supporting text selection, cursor positioning and commonly used keyboard shortcuts.
// NOTE 1: Requires static variables: framesCounter
// NOTE 2: Returns if KEY_ENTER pressed (useful for data validation)

// Controls  the cursor movement/selection speed when movement keys are held/pressed
// Required for blinking cursor

// Make sure length doesn't exceed `textSize`. `textSize` is actually the max amount of characters the textbox can handle.

// Make sure we have enough room to draw at least 1 character

// Center the text vertically

// Make sure the height is sufficient

// Calculate the drawing area for the text inside the control `bounds`

// This holds the coordinates inside textRec of the cursor at current position and will be recalculated later
// Check if this textbox is the global active textbox

// Update control
//--------------------------------------------------------------------

// Check if we are the global active textbox
// A textbox becomes active when the user clicks it :)

// Hurray!!! we just became the active textbox

// When active and the right mouse is clicked outside the textbox we should deactivate it
// Set a dummy rect as the active textbox bounds

// Make sure state doesn't have invalid values

// Check textbox state for changes and recalculate if necesary

// Set cursor to last visible character in textbox

// Force recalculate text start position and text start index

// NOTE: start and index are always in sync 
// start will hold the starting character position from where the text will be drawn 
// while index will hold the byte index inside the text for that character

// No need to recalculate

// -----------------
// HANDLE KEY INPUT
// -----------------
// * -> | LSHIFT + -> move cursor to the right | increase selection by one
// * <- | LSHIFT + <- move cursor to the left | decrease selection by one
// * HOME | LSHIFT + HOME moves cursor to start of text | selects text from cursor to start of text
// * END | LSHIFT + END move cursor to end of text | selects text from cursor until end of text
// * CTRL + A select all characters in text
// * CTRL + C copy selected text
// * CTRL + X cut selected text
// * CTRL + V remove selected text, if any, then paste clipboard data
// * DEL delete character or selection after cursor
// * BACKSPACE delete character or selection before cursor
// TODO: add more shortcuts (insert mode, select word, moveto/select prev/next word ...)

// Selecting
// Mark selection start

// Deselect and move cursor to end of selection

// Move cursor to the right

// Selecting
// Mark selection start

// Deselect and move cursor to start of selection

// Recalculate byte index

// Move cursor to the left

// Select from start of text to cursor

// Deselect everything

// Move cursor to start of text

// Deselect everything

// `CTRL + A` Select all

// `CTRL + C` Copy selected text to clipboard

// `CTRL + X` Cut selected text

// `CTRL + V` Paste clipboard text

// Delete selection

// Decode codepoint

// -------------
// HANDLE MOUSE 
// -------------

// Clicked outside the `textRec` but still inside bounds

// Clicked outside the `textRec` but still inside bounds, this means that we must move the text

// Mark start of selection

// Move the text when cursor is positioned before or after the text

// Calculate X coordinate of the blinking cursor

// Update variables

// We aren't drawing all of the text so make sure `DrawTextRecEx()` is selecting things correctly

// If active copy all text to clipboard even when disabled

// Backup textbox state

// If no selection then mark all text to be copied to clipboard

// Restore textbox state

// Draw control
//--------------------------------------------------------------------

// Draw the blinking cursor

// Finally draw the text and selection

// !RAYGUI_TEXTBOX_EXTENDED

// Spinner control, returns selected value
// NOTE: Requires static variables: framesCounter, valueSpeed - ERROR!

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// TODO: Set Spinner properties for ValueBox

// Draw value selector custom buttons
// NOTE: BORDER_WIDTH and TEXT_ALIGNMENT forced values

//--------------------------------------------------------------------

// Value Box control, updates input text with numbers
// NOTE: Requires static variables: framesCounter

// Required for blinking cursor

// Update control
//--------------------------------------------------------------------

// Only allow keys in range [48..57]

// Delete text

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------
enum VALUEBOX_MAX_CHARS = 32;

// Text Box control, updates input text
// NOTE 1: Requires static variables: framesCounter
// NOTE 2: Returns if KEY_ENTER pressed (useful for data validation)

// Required for blinking cursor

// Update control
//--------------------------------------------------------------------

// Only allow keys in range [32..125]

// Delete text

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw blinking cursor

//--------------------------------------------------------------------

// Text Box control with multiple lines

// Required for blinking cursor

//const char *numChars = NULL;

// Update control
//--------------------------------------------------------------------

//numChars = TextFormat("%i/%i", keyCount, textSize - 1);

// Only allow keys in range [32..125]

// Delete text

// Introduce automatic new line if necessary

// Counting how many new lines

// Changing edit mode

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw text cursor

// Draw characters counter
//GuiDrawText(numChars, (Vector2){ bounds.x + bounds.width - GetTextWidth(numChars) - GuiGetStyle(TEXTBOX, INNER_PADDING), bounds.y + bounds.height - GuiGetStyle(DEFAULT, TEXT_SIZE) - GuiGetStyle(TEXTBOX, INNER_PADDING) }, Fade(GetColor(GuiGetStyle(TEXTBOX, TEXT_COLOR_PRESSED)), guiAlpha/2));

//--------------------------------------------------------------------

// Slider control with pro parameters
// NOTE: Other GuiSlider*() controls use this one

// Slider

// SliderBar

// TODO: Consider text icon

// Update control
//--------------------------------------------------------------------

// Get equivalent value and slider position from mousePoint.x

// Slider
// SliderBar

// Bar limits check
// Slider

// SliderBar

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw slider internal bar (depends on state)

// TODO: Review showValue parameter, really ugly...

//--------------------------------------------------------------------

// Slider control extended, returns selected value and has text

// Slider Bar control extended, returns selected value

// Progress Bar control extended, shows current progress value

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw slider internal progress bar (depends on state)

//--------------------------------------------------------------------

// Status Bar control

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Dummy rectangle control, intended for placeholding

// Update control
//--------------------------------------------------------------------

// Check button state

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

//------------------------------------------------------------------

// Scroll Bar control

// Is the scrollbar horizontal or vertical?

// The size (width or height depending on scrollbar type) of the spinner buttons

// Spinner buttons [<] [>] [∧] [∨]

// Actual area of the scrollbar excluding the spinner buttons
//  ------------
// Slider bar that moves     --[///]-----

// Normalize value

// Calculate rectangles for all of the components

// Make sure the slider won't get outside of the scrollbar

// Make sure the slider won't get outside of the scrollbar

// Update control
//--------------------------------------------------------------------

// Handle mouse wheel

// Normalize value

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw the background
// Draw the scrollbar active area background

// Draw the slider bar

// Draw arrows using lines

//coordinates for <     0,1,2

//coordinates for >     3,4,5

//coordinates for ∧     6,7,8

//coordinates for ∨     9,10,11

// Draw ∧

// Draw ∨

// Draw <

// Draw >

//--------------------------------------------------------------------

// List Element control, returns element state

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw element rectangle

// Draw text depending on state

//--------------------------------------------------------------------

// List View control

// List View control extended parameters
// NOTE: Elements could be disabled individually and focused element could be obtained:
//  int *enabled defines an array with enabled elements inside the list
//  int *focus returns focused element (may be not pressed)

// Update control
//--------------------------------------------------------------------
// All the elements fit inside ListView and dont need scrollbar.

// Calculate position X and width to draw each element.

// Area without the scrollbar

// && !guiLocked

// Change active with keys

// Get focused element

// Save default slider size

// Calculate percentage of visible elements and apply same percentage to scrollbar

// Change slider size

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw background

// Draw scrollBar

// Save default scroll speed
// Hack to make the spinner buttons work

// Reset scroll speed to default
// Reset slider size to default

// FIXME: Quick hack to make this thing work, think of a better way

// Draw ListView states

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

//--------------------------------------------------------------------

// Color Bar Alpha control
// NOTE: Returns alpha value normalized [0..1]

// Update control
//--------------------------------------------------------------------

//selector.x = bounds.x + (int)(((alpha - 0)/(100 - 0))*(bounds.width - 2*GuiGetStyle(SLIDER, BORDER_WIDTH))) - selector.width/2;

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------
// Draw alpha bar: checked background

//--------------------------------------------------------------------
enum COLORBARALPHA_CHECKED_SIZE = 10;

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

// Draw hue bar:color bars

// Draw hue bar: selector

//--------------------------------------------------------------------

// TODO: Color GuiColorBarSat() [WHITE->color]
// TODO: Color GuiColorBarValue() [BLACK->color], HSV / HSL
// TODO: float GuiColorBarLuminance() [BLACK->WHITE]

// Color Picker control
// NOTE: It's divided in multiple controls:
//      Color GuiColorPanel() - Color select panel
//      float GuiColorBarAlpha(Rectangle bounds, float alpha)
//      float GuiColorBarHue(Rectangle bounds, float value)
// NOTE: bounds define GuiColorPanel() size

//Rectangle boundsAlpha = { bounds.x, bounds.y + bounds.height + GuiGetStyle(COLORPICKER, BARS_PADDING), bounds.width, GuiGetStyle(COLORPICKER, BARS_THICK) };

//color.a = (unsigned char)(GuiColorBarAlpha(boundsAlpha, (float)color.a/255.0f)*255.0f);

// Message Box control

// Returns clicked button from buttons list, 0 refers to closed window button

// Draw control
//--------------------------------------------------------------------

//--------------------------------------------------------------------
enum MESSAGEBOX_BUTTON_HEIGHT = 24;
enum MESSAGEBOX_BUTTON_PADDING = 10;

// Text Input Box control, ask for text

// TODO.

// Grid control
// NOTE: Returns grid mouse-hover selected cell
// About drawing lines at subpixel spacing, simple put, not easy solution:
// https://stackoverflow.com/questions/4435450/2d-opengl-drawing-lines-that-dont-exactly-fit-pixel-raster

// Grid lines alpha amount

// Update control
//--------------------------------------------------------------------

//--------------------------------------------------------------------

// Draw control
//--------------------------------------------------------------------

// Draw vertical grid lines

// Draw horizontal grid lines
enum GRID_COLOR_ALPHA = 0.15f;

//----------------------------------------------------------------------------------
// Styles loading functions
//----------------------------------------------------------------------------------

// Load raygui style file (.rgs)

// Try reading the files as text file first

// DEFAULT control

// If a DEFAULT property is loaded, it is propagated to all controls,
// NOTE: All DEFAULT properties should be defined first in the file

// DEFAULT control

// If a DEFAULT property is loaded, it is propagated to all controls
// NOTE: All DEFAULT properties should be defined first in the file

// Font loading is highly dependant on raylib API to load font data and image
// TODO: Find some mechanism to support it in standalone mode

// Load custom font if available

// 0-Normal, 1-SDF

// Load font white rectangle

// Load font image parameters

// Load font chars data

// Set font texture source rectangle to be used as white texture to draw shapes
// NOTE: This way, all gui can be draw using a single draw call

// Load style from a palette values array

// Load style palette values from array (complete property sets)

// TODO: This code needs review

// Load style palette values from array (uncomplete property set)

// Load style default over global style

// We set this variable first to avoid cyclic function calls
// when calling GuiSetStyle() and GuiGetStyle()

// Initialize default LIGHT style property values

// Populate all controls with default style

// Initialize default font

// Initialize extended property values
// NOTE: By default, extended property values are initialized to 0

// DEFAULT specific property
// DEFAULT specific property

// Updates controls style with default values

// Populate all controls with default style
// NOTE: Extended style properties are ignored

// Get text with icon id prepended
// NOTE: Useful to add icons by name id (enum) instead of
// a number that can change between ricon versions

//----------------------------------------------------------------------------------
// Module specific Functions Definition
//----------------------------------------------------------------------------------

// Split controls text into multiple strings
// Also check for multiple columns (required by GuiToggleGroup())

// NOTE: Current implementation returns a copy of the provided string with '\0' (string end delimiter)
// inserted between strings defined by "delimiter" parameter. No memory is dynamically allocated,
// all used memory is static... it has some limitations:
//      1. Maximum number of possible split strings is set by MAX_SUBSTRINGS_COUNT
//      2. Maximum size of text to split is MAX_TEXT_BUFFER_LENGTH

// Count how many substrings we have on text and point to every one

// Set an end of string at this point
enum MAX_TEXT_BUFFER_LENGTH = 1024;
enum MAX_SUBSTRINGS_COUNT = 64;

// Convert color data from RGB to HSV
// NOTE: Color data should be passed normalized

// Value

// Undefined, maybe NAN?

// NOTE: If max is 0, this divide would cause a crash
// Saturation

// NOTE: If max is 0, then r = g = b = 0, s = 0, h is undefined

// Undefined, maybe NAN?

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

// RAYGUI_STANDALONE

// RAYGUI_IMPLEMENTATION
