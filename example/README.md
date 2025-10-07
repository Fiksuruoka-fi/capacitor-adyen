# Capacitor Adyen Example

This example demonstrates how to integrate the `@foodello/capacitor-adyen` plugin in a React application with native iOS and Android support.

## Prerequisites

- **Node.js** v18+
- **iOS Development**: Xcode 14+ and iOS 13+ target device/simulator
- **Android Development**: Android Studio with API level 21+ target device/emulator

## Project Setup

### 1. Install Dependencies

```bash
# Install project dependencies
npm install

# Install iOS native dependencies (if developing for iOS)
cd ios/app && pod install && cd ../..
```

### 2. Configure Environment Variables

Copy the example environment file and configure your Adyen credentials:

```bash
# Copy environment template
cp .env.example .env.local

# Edit with your actual Adyen credentials
# VITE_ADYEN_ENVIRONMENT=test
# VITE_ADYEN_CLIENT_KEY=your_actual_client_key_here
# ...
```

Adyen keys requires a whitelisted domain to allow Card component rendering.
For local testing, you can use a custom domain by adding it to your `/etc/hosts` file
and whitelisting it in your Adyen Customer Area (remember to add your port there as well).

```bash
# 127.0.0.1 <YOUR WHITELISTED DOMAIN>
sudo nano /etc/hosts
# Then add: 127.0.0.1 capacitor-adyen-example.com
# and exit nano with CTRL+X, Y, ENTER
```

Then, update the `.env.local` file with your chosen domain and port (if different from 5173):

```bash
VITE_ADYEN_TEST_DOMAIN=capacitor-adyen-example.com
VITE_ADYEN_TEST_PORT=80
```

### 3. Run the Application with Custom Domain

```bash
npm run preview
```

## Development

### Web Development

Start the development server for web testing:

```bash
# Start Vite development server
npm run dev
```

The app will be available at `http://localhost:5173`. Note that native presentation buttons will be disabled in web mode.

### Native Development

#### iOS Development

1. **Build and sync to iOS**:

   ```bash
   # Build web assets and sync to native iOS project
   npm run build
   npx cap sync ios
   ```

2. **Open in Xcode**:

   ```bash
   npx cap open ios
   ```

3. **Run from Xcode**: Select your target device/simulator and run the project.

#### Android Development

1. **Build and sync to Android**:

   ```bash
   # Build web assets and sync to native Android project
   npm run build
   npx cap sync android
   ```

2. **Open in Android Studio**:

   ```bash
   npx cap open android
   ```

3. **Run from Android Studio**: Select your target device/emulator and run the project.

## Features Demonstrated

### Form Styling Themes

- **Default Theme**: Standard Adyen styling
- **Blue Theme**: Custom blue accent colors with dark titles
- **Dark Theme**: Dark mode with white text and green accents
- **Golden Theme**: Warm amber theme with custom fonts
- **Sky Theme**: Light blue theme with styled icons
- **Pink Theme**: Pink theme with Visa-only configuration

### Configuration Options

- **Custom amounts**: Different payment amounts in EUR, GBP, USD
- **Field visibility**: Toggle holder name, security code, and store payment fields
- **Card type filtering**: Restrict to specific card brands (Visa, Mastercard)
- **Title customization**: Custom navigation bar titles with theme-matching colors
- **Close button control**: Toggle close button visibility

### Native Presentation Styles

- **Form Sheet**: Modal presentation on smaller screen area
- **Page Sheet**: iOS 15+ style modal presentation
- **Full Screen**: Complete screen takeover for high-value payments
- **Automatic**: iOS system default presentation

## Troubleshooting

### Common Issues

**iOS Build Errors**:

```bash
# Clean and reinstall pods
cd ios/App && rm -rf Pods Podfile.lock && pod install
```

**Android Build Errors**:

```bash
# Clean Gradle cache
cd android && ./gradlew clean && cd ..
npx cap sync android
```

**Web Assets Not Updating**:

```bash
# Force rebuild and sync
npm run build --force
npx cap sync
```

### Platform-Specific Testing

- **iOS Simulator**: Test different device sizes and iOS versions
- **Android Emulator**: Test different API levels and screen densities
- **Physical Devices**: Required for testing payment hardware integration

## Documentation

- [Capacitor Adyen Plugin Documentation](../README.md)
- [Adyen iOS SDK Documentation](https://docs.adyen.com/online-payments/build-your-integration/ios/)
- [Capacitor Documentation](https://capacitorjs.com/docs)
