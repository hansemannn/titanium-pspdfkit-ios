# PSPDFKit for Titanium iOS

The repository contains the WiP of the revamped PSPDFKit module for Titanium. It represents an example of
using the new Swift-based module-architecture in Titanium by showing common usages and best practices for
modern Titanium module development.

> ⚠️ The module is currently WiP and should **not** be used in production, yet!

## Getting Started

### Carthage (Recommended)

  1. Change the API key inside the `Cartfile` to match your PSPDFKit API key
  2. Run `Carthage build --platform iOS`
  3. Copy the resulting frameworks `PSPDFKit.framework` and `PSPDFKitUI.framework` to `platform`
  4. Done!

### Manual

  1. Download your copy from [here](https://pspdfkit.com/guides/ios/current/getting-started/integrating-pspdfkit/)
  2. Unzip and copy the resulting frameworks `PSPDFKit.framework` and `PSPDFKitUI.framework` to `platform`
  3. Done!

## Example

```js
import PSPDFKit from 'ti.pspdfkit';

const win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
 
const btn = Ti.UI.createButton({
    title: 'Open PDF Document'
});
 
btn.addEventListener('click', () => {
    PSPDFKit.present('PSPDFKit.pdf', {
        documentLabelEnabled: true
    });
});
 
win.add(btn);
win.open();

```

## Build the Module

```sh
appc run -p ios --build-only
```

## Author

Hans Knöchel

## License

MIT
