# capacitor-adyen

Adyen component integration for Capacitor.js

## Install

```bash
# npm
npm install capacitor-adyen

# yarn
yarn add @foodello/capacitor-adyen

# pnpm
pnpm add @foodello/capacitor-adyen

# sync native projects
npx cap sync
```

## Usage

Define `Adyen` plugin configuration in `capacitor.config.json`:

```json
{
  "plugins": {
    "Adyen": {
      "componentsEnvironment": "test", // or "live"
      "clientKey": "your-adyen-client-key",
      "enableAnalytics": true // optional, defaults to false
    }
  }
}
```

Then all components require [payment methods](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods) to be set before presenting the component:

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsJson = await fetchPaymentMethodsFromYourBackend();
await Adyen.setCurrentPaymentMethods({ paymentMethodsJson });
```

After that you can present any of the supported components, for example a Card component:

```typescript
await Adyen.presentCardComponent();
```

To react to component events with your code, add listeners:

```typescript
import { Adyen, PaymentSubmitEventData } from '@foodello/capacitor-adyen';
const listener = await Adyen.addListener('onSubmit', (data: PaymentSubmitEventData) => {
  console.log('Payment submitted:', data);
});
```

### Example on extending Adyen web components

See [example](example) -folder for a full example of how to extend Adyen's web Card component to support native platforms with Capacitor.

## API

<docgen-index>

* [`setCurrentPaymentMethods(...)`](#setcurrentpaymentmethods)
* [`presentCardComponent(...)`](#presentcardcomponent)
* [`hideComponent()`](#hidecomponent)
* [`addListener('onSubmit', ...)`](#addlisteneronsubmit-)
* [`addListener('onCardSubmit', ...)`](#addlisteneroncardsubmit-)
* [`addListener('onCardChange', ...)`](#addlisteneroncardchange-)
* [`addListener('onError', ...)`](#addlisteneronerror-)
* [`addListener('onAction', ...)`](#addlisteneronaction-)
* [`addListener('onComplete', ...)`](#addlisteneroncomplete-)
* [`addListener('onCancel', ...)`](#addlisteneroncancel-)
* [`addListener('onComponentDismissed', ...)`](#addlisteneroncomponentdismissed-)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### setCurrentPaymentMethods(...)

```typescript
setCurrentPaymentMethods(options: { paymentMethodsJson: PaymentMethodsResponse; }) => Promise<void>
```

Set current available payment methods for the Adyen components.

| Param         | Type                                      | Description                                |
| ------------- | ----------------------------------------- | ------------------------------------------ |
| **`options`** | <code>{ paymentMethodsJson: any; }</code> | - Options for creating the card component. |

**Since:** 7.0.0

--------------------


### presentCardComponent(...)

```typescript
presentCardComponent(options?: CardComponentOptions | undefined) => Promise<void>
```

Creates a Adyen Card component for handling card payments.

| Param         | Type                                                                  | Description                                |
| ------------- | --------------------------------------------------------------------- | ------------------------------------------ |
| **`options`** | <code><a href="#cardcomponentoptions">CardComponentOptions</a></code> | - Options for creating the card component. |

**Since:** 7.0.0

--------------------


### hideComponent()

```typescript
hideComponent() => Promise<void>
```

Hides the currently presented Adyen component, if any.

**Since:** 7.0.0

--------------------


### addListener('onSubmit', ...)

```typescript
addListener(eventName: 'onSubmit', listenerFunc: (data: PaymentSubmitEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `submit` events.

| Param              | Type                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onSubmit'</code>                                                                      |
| **`listenerFunc`** | <code>(data: <a href="#paymentsubmiteventdata">PaymentSubmitEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onCardSubmit', ...)

```typescript
addListener(eventName: 'onCardSubmit', listenerFunc: (data: CardSubmitEventData) => void) => Promise<PluginListenerHandle>
```

Listens for Card component `submit` events.

| Param              | Type                                                                                   |
| ------------------ | -------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onCardSubmit'</code>                                                            |
| **`listenerFunc`** | <code>(data: <a href="#cardsubmiteventdata">CardSubmitEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onCardChange', ...)

```typescript
addListener(eventName: 'onCardChange', listenerFunc: (data: CardChangeEventData) => void) => Promise<PluginListenerHandle>
```

Listens for Card component's `change` events.

| Param              | Type                                                                                   |
| ------------------ | -------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onCardChange'</code>                                                            |
| **`listenerFunc`** | <code>(data: <a href="#cardchangeeventdata">CardChangeEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onError', ...)

```typescript
addListener(eventName: 'onError', listenerFunc: (data: PaymentErrorEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `error` events.

| Param              | Type                                                                                       |
| ------------------ | ------------------------------------------------------------------------------------------ |
| **`eventName`**    | <code>'onError'</code>                                                                     |
| **`listenerFunc`** | <code>(data: <a href="#paymenterroreventdata">PaymentErrorEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onAction', ...)

```typescript
addListener(eventName: 'onAction', listenerFunc: (data: PaymentActionEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `action` events.

| Param              | Type                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onAction'</code>                                                                      |
| **`listenerFunc`** | <code>(data: <a href="#paymentactioneventdata">PaymentActionEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onComplete', ...)

```typescript
addListener(eventName: 'onComplete', listenerFunc: (data: PaymentCompleteEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `complete` events.

| Param              | Type                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------ |
| **`eventName`**    | <code>'onComplete'</code>                                                                        |
| **`listenerFunc`** | <code>(data: <a href="#paymentcompleteeventdata">PaymentCompleteEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onCancel', ...)

```typescript
addListener(eventName: 'onCancel', listenerFunc: (data: PaymentCancelEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `cancel` events.

| Param              | Type                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onCancel'</code>                                                                      |
| **`listenerFunc`** | <code>(data: <a href="#paymentcanceleventdata">PaymentCancelEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onComponentDismissed', ...)

```typescript
addListener(eventName: 'onComponentDismissed', listenerFunc: (data: ComponentDissmissEventData) => void) => Promise<PluginListenerHandle>
```

Listens for component `dismiss` events.

| Param              | Type                                                                                                 |
| ------------------ | ---------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'onComponentDismissed'</code>                                                                  |
| **`listenerFunc`** | <code>(data: <a href="#componentdissmisseventdata">ComponentDissmissEventData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


### Type Aliases


#### PaymentMethodsResponse

JSON response from [Adyen API call](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods)

<code>any</code>


#### CardComponentOptions

Options for creating a Adyen Card component.

<code><a href="#baseadyencomponentoptions">BaseAdyenComponentOptions</a> & { amount?: number; countryCode?: string; currencyCode?: string; configuration?: <a href="#cardcomponentconfiguration">CardComponentConfiguration</a>; style?: <a href="#formcomponentstyle">FormComponentStyle</a>; viewOptions?: <a href="#componentviewoptions">ComponentViewOptions</a>; }</code>


#### BaseAdyenComponentOptions

Options for creating a Adyen component.

<code>{ amount?: number; /** ISO-3166-1 alpha-2 format */ countryCode?: string; /** ISO 4217 currency code */ currencyCode?: string; }</code>


#### CardComponentConfiguration

<code>{ showsHolderNameField?: boolean; showsSecurityCodeField?: boolean; showsStorePaymentMethodField?: boolean; supportedCardTypes?: string[]; localizationParameters?: { tableName?: string; keySeparator?: string; }; }</code>


#### FormComponentStyle

Combined style configuration for forms. Includes top-level colours and
nested sub-styles for various form elements. All keys are optional and
unknown keys are ignored.

<code>{ /** Background colour applied to the entire form. */ backgroundColor?: string; /** Tint colour applied to accent elements within the form. */ tintColor?: string; /** Colour of separators between form rows. */ separatorColor?: string; /** Styling for the header text (section title). */ header?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Styling for text input fields. */ textField?: <a href="#textfieldstyledefinition">TextFieldStyleDefinition</a>; /** Styling for toggle rows. Both `switch` and `toggle` keys are supported. */ switch?: <a href="#switchstyledefinition">SwitchStyleDefinition</a>; toggle?: <a href="#switchstyledefinition">SwitchStyleDefinition</a>; /** Styling for hint labels (usually under a field). */ hint?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Styling for footnote labels at the bottom of the form. */ footnote?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Styling for inline link text in informational messages. */ linkText?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Styling for the primary action button. You may use either `button` or `mainButton`. */ button?: <a href="#buttonstyledefinition">ButtonStyleDefinition</a>; /** Styling for the primary action button. Same as `button`. */ mainButton?: <a href="#buttonstyledefinition">ButtonStyleDefinition</a>; /** Styling for a secondary action button. */ secondaryButton?: <a href="#buttonstyledefinition">ButtonStyleDefinition</a>; }</code>


#### TextStyleDefinition

Describes common text styling. Applicable to labels, hints, footers, etc.
You can combine colour, font, background and text alignment.

<code>{ /** Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF'). */ color?: string; /** Font specification for the text. */ font?: <a href="#fontdefinition">FontDefinition</a>; /** Background colour behind the text. */ backgroundColor?: string; /** Alignment for the text within its container. */ textAlignment?: 'left' | 'center' | 'right' | 'justified' | 'natural'; }</code>


#### FontDefinition

Defines a font used within a text element. Both fields are optional; if
omitted, the default system font is used.

<code>{ /** The font size in points. */ size?: number; /** Weight name matching iOS font weights. */ weight?: 'thin' | 'light' | 'regular' | 'medium' | 'semibold' | 'bold' | 'heavy' | 'black'; }</code>


#### TextFieldStyleDefinition

Describes styling for a text field in the form. This includes styling
for the title label, user input text, placeholder text, and trailing icon.

<code>{ /** Styling for the field's title label. */ title?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Colour of the title label (legacy shortcut). */ titleColor?: string; /** Font used for the title label (legacy shortcut). */ titleFont?: <a href="#fontdefinition">FontDefinition</a>; /** Styling for the user-entered text. */ text?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Colour of the user-entered text (legacy shortcut). */ textColor?: string; /** Font for the user-entered text (legacy shortcut). */ textFont?: <a href="#fontdefinition">FontDefinition</a>; /** Styling for the placeholder text. */ placeholder?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Colour of the placeholder text (legacy shortcut). */ placeholderColor?: string; /** Font for the placeholder text (legacy shortcut). */ placeholderFont?: <a href="#fontdefinition">FontDefinition</a>; /** Styling for the trailing icon. */ icon?: { /** Tint colour of the icon. */ tintColor?: string; /** Background colour behind the icon. */ backgroundColor?: string; /** Border colour of the icon container. */ borderColor?: string; /** Border width of the icon container. */ borderWidth?: number; /** Corner radius of the icon container. */ cornerRadius?: number; }; /** Tint colour applied to the text field (cursor/accent). */ tintColor?: string; /** Colour of the separator line beneath the text field. */ separatorColor?: string; /** Background colour of the entire text field cell. */ backgroundColor?: string; /** Colour used to highlight error states. */ errorColor?: string; }</code>


#### SwitchStyleDefinition

Styling for a toggle (switch) row. Supports a title style and colours for
tint, separator and background. This type is used for both the `switch` and
`toggle` keys when specifying form styles.

<code>{ /** Styling for the title label next to the toggle. */ title?: <a href="#textstyledefinition">TextStyleDefinition</a>; /** Colour of the title label (legacy shortcut). */ titleColor?: string; /** Font for the title label (legacy shortcut). */ titleFont?: <a href="#fontdefinition">FontDefinition</a>; /** Tint colour of the toggle when turned on. */ tintColor?: string; /** Colour of the separator line beneath the toggle row. */ separatorColor?: string; /** Background colour of the toggle row. */ backgroundColor?: string; }</code>


#### ButtonStyleDefinition

Defines the styling for a button. These definitions map to
`FormButtonItemStyle.main` in the iOS SDK. All fields are optional.

<code>{ /** Font used for the button's title. */ font?: <a href="#fontdefinition">FontDefinition</a>; /** Colour of the button title text. */ textColor?: string; /** Main background colour of the button. */ backgroundColor?: string; /** Corner radius to round the button's corners. */ cornerRadius?: number; }</code>


#### ComponentViewOptions

Options for customizing the appearance of the component navbar's view.

<code>{ /** Custom text for the title */ title?: string; /** Color for the title text */ titleColor?: string; /** Title bar's background color */ titleBackgroundColor?: string; /** Tint color for buttons in the title bar */ titleTintColor?: string; /** Whether to show a close button in the title bar */ showsCloseButton?: boolean; /** Custom text for the close button */ closeButtonText?: string; /** iOS specific styling options to override defaults */ ios?: { titleColor?: string; titleBackgroundColor?: string; titleTintColor?: string; }; }</code>


#### PaymentSubmitEventData

<code>{ paymentMethod: { [key: string]: any; }; componentType: 'card' | 'dropIn' | 'ideal' | 'paypal' | 'bcmcMobile'; browserInfo?: { userAgent: string; }; order?: { orderData: string; pspReference: string; }; amount?: { value: number; currency: string; }; storePaymentMethod?: boolean; }</code>


#### CardSubmitEventData

<code>{ lastFour: string; finalBIN: string; }</code>


#### CardChangeEventData

<code>{ cardBrands?: <a href="#cardbranddata">CardBrandData</a>; cardBIN?: string; }</code>


#### CardBrandData

<code>{ cardBrands: CardBrand[]; primaryBrand: <a href="#cardbrand">CardBrand</a>; }</code>


#### CardBrand

<code>{ type: string; isSupported: boolean; }</code>


#### PaymentErrorEventData

<code>{ error: string; errorCode: number; errorDomain: string; componentType: string; details?: string; componentName?: string; source?: string; }</code>


#### PaymentActionEventData

<code>{ componentType: 'dropIn'; actionType: 'additionalDetails'; details: { [key: string]: any; }; }</code>


#### PaymentCompleteEventData

<code>{ componentType: 'dropIn'; action: 'actionCompleted' | 'completed'; componentName?: string; }</code>


#### PaymentCancelEventData

<code>{ componentType: 'dropIn'; action: 'cancelled'; }</code>


#### ComponentDissmissEventData

<code>{ reason: 'user_gesture'; }</code>

</docgen-api>
