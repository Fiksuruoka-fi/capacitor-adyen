/**
 * Options for customizing the appearance of the component navbar's view.
 * @group Styling
 */
export type ComponentViewOptions = {
  /** Custom text for the title */
  title?: string;
  /** Color for the title text */
  titleColor?: string;
  /** Title bar's background color */
  titleBackgroundColor?: string;
  /** Tint color for buttons in the title bar */
  titleTintColor?: string;
  /** Whether to show a close button in the title bar */
  showsCloseButton?: boolean;
  /** Custom text for the close button */
  closeButtonText?: string;
  /** iOS specific styling options to override defaults */
  ios?: {
    titleColor?: string;
    titleBackgroundColor?: string;
    titleTintColor?: string;
  };
};

/**
 * Defines a font used within a text element. Both fields are optional; if
 * omitted, the default system font is used.
 * @group Styling
 */
export type FontDefinition = {
  /** The font size in points. */
  size?: number;
  /** Weight name matching iOS font weights. */
  weight?: 'thin' | 'light' | 'regular' | 'medium' | 'semibold' | 'bold' | 'heavy' | 'black';
};

/**
 * Describes common text styling. Applicable to labels, hints, footers, etc.
 * You can combine colour, font, background and text alignment.
 * @group Styling
 */
export type TextStyleDefinition = {
  /** Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF'). */
  color?: string;
  /** Font specification for the text. */
  font?: FontDefinition;
  /** Background colour behind the text. */
  backgroundColor?: string;
  /** Alignment for the text within its container. */
  textAlignment?: 'left' | 'center' | 'right' | 'justified' | 'natural';
};

/**
 * Describes styling for a text field in the form. This includes styling
 * for the title label, user input text, placeholder text, and trailing icon.
 * @group Styling
 */
export type TextFieldStyleDefinition = {
  /** Styling for the field's title label. */
  title?: TextStyleDefinition;
  /** Colour of the title label (legacy shortcut). */
  titleColor?: string;
  /** Font used for the title label (legacy shortcut). */
  titleFont?: FontDefinition;

  /** Styling for the user-entered text. */
  text?: TextStyleDefinition;
  /** Colour of the user-entered text (legacy shortcut). */
  textColor?: string;
  /** Font for the user-entered text (legacy shortcut). */
  textFont?: FontDefinition;

  /** Styling for the placeholder text. */
  placeholder?: TextStyleDefinition;
  /** Colour of the placeholder text (legacy shortcut). */
  placeholderColor?: string;
  /** Font for the placeholder text (legacy shortcut). */
  placeholderFont?: FontDefinition;

  /** Styling for the trailing icon. */
  icon?: {
    /** Tint colour of the icon. */
    tintColor?: string;
    /** Background colour behind the icon. */
    backgroundColor?: string;
    /** Border colour of the icon container. */
    borderColor?: string;
    /** Border width of the icon container. */
    borderWidth?: number;
    /** Corner radius of the icon container. */
    cornerRadius?: number;
  };

  /** Tint colour applied to the text field (cursor/accent). */
  tintColor?: string;
  /** Colour of the separator line beneath the text field. */
  separatorColor?: string;
  /** Background colour of the entire text field cell. */
  backgroundColor?: string;
  /** Colour used to highlight error states. */
  errorColor?: string;
};

/**
 * Styling for a toggle (switch) row. Supports a title style and colours for
 * tint, separator and background. This type is used for both the `switch` and
 * `toggle` keys when specifying form styles.
 * @group Styling
 */
export type SwitchStyleDefinition = {
  /** Styling for the title label next to the toggle. */
  title?: TextStyleDefinition;
  /** Colour of the title label (legacy shortcut). */
  titleColor?: string;
  /** Font for the title label (legacy shortcut). */
  titleFont?: FontDefinition;
  /** Tint colour of the toggle when turned on. */
  tintColor?: string;
  /** Colour of the separator line beneath the toggle row. */
  separatorColor?: string;
  /** Background colour of the toggle row. */
  backgroundColor?: string;
};

/**
 * Defines the styling for a button. These definitions map to
 * `FormButtonItemStyle.main` in the iOS SDK. All fields are optional.
 * @group Styling
 */
export type ButtonStyleDefinition = {
  /** Font used for the button's title. */
  font?: FontDefinition;
  /** Colour of the button title text. */
  textColor?: string;
  /** Main background colour of the button. */
  backgroundColor?: string;
  /** Corner radius to round the button's corners. */
  cornerRadius?: number;
};

/**
 * Combined style configuration for forms. Includes top-level colours and
 * nested sub-styles for various form elements. All keys are optional and
 * unknown keys are ignored.
 * @group Styling
 */
export type FormComponentStyle = {
  /** Background colour applied to the entire form. */
  backgroundColor?: string;
  /** Tint colour applied to accent elements within the form. */
  tintColor?: string;
  /** Colour of separators between form rows. */
  separatorColor?: string;

  /** Styling for the header text (section title). */
  header?: TextStyleDefinition;
  /** Styling for text input fields. */
  textField?: TextFieldStyleDefinition;

  /** Styling for toggle rows. Both `switch` and `toggle` keys are supported. */
  switch?: SwitchStyleDefinition;
  toggle?: SwitchStyleDefinition;

  /** Styling for hint labels (usually under a field). */
  hint?: TextStyleDefinition;
  /** Styling for footnote labels at the bottom of the form. */
  footnote?: TextStyleDefinition;
  /** Styling for inline link text in informational messages. */
  linkText?: TextStyleDefinition;

  /** Styling for the primary action button. You may use either `button` or `mainButton`. */
  button?: ButtonStyleDefinition;
  /** Styling for the primary action button. Same as `button`. */
  mainButton?: ButtonStyleDefinition;
  /** Styling for a secondary action button. */
  secondaryButton?: ButtonStyleDefinition;
};
