import PSPDFKit from 'ti.pspdfkit';

// Set your license key
PSPDFKit.licenseKey = 'YOUR_LICENSE_KEY';

const win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
 
const btn = Ti.UI.createButton({
    title: 'Open PDF Document'
});

const document = Ti.Filesystem.getFile('PSPSDKit.pdf');
 
btn.addEventListener('click', () => {
    // Show our PDF document
    PSPDFKit.present(document, {
        documentLabelEnabled: true
    });
});
 
win.add(btn);
win.open();
