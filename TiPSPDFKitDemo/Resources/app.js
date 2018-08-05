var PSPDFKit = require('ti.pspdfkit');

PSPDFKit.licenseKey = 'N6BDETU3kyU7V+2Tsimo/29hWqjovfQkbWHTPhk0B9zYehp1JPLhYdMPg0AkkjwW0t0vToEUJJdxWKiZJuKGpKBdV0jwP4e9Kax3mOxEwIB5iDlrT7XXCdl0dlZKGrtQfX6A8xJqaeCkQy0oyAJ2T9CufQIFr8zhBKYQkVcGXkd5q9zaoG5li7sTHbGsENUajp5OSV9AXqHIbzNB72/sFwb5JqzCR4tyKNSlE5ZgqV/W/hCEeeVC48Kul1pcz2yV8JjeH8YCyRDtTzb7OTuN/p2E0BWvNZSdLGbNUTJw/HEOLvqJaIz3SUEHAWqmxo4wo5ceYmWRl/QvjzcdoQl5e8yMUEg/DWGmKnUrHQoiBPuhGw6Xgjsk89Oc6HHYqTYl2Tq3DuhQJwRzTAZ4Fy1f2jWTox4j8jT8lVghUsmeVg4+K172U76+ZTXVYdzSeptn'

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
 
var btn = Ti.UI.createButton({
    title: 'Open PDF Document'
});
 
btn.addEventListener('click', () => {
                     const file = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, 'PSPDFKit.pdf');
    PSPDFKit.present(file, {
        documentLabelEnabled: true
    });
});
 
win.add(btn);
win.open();
