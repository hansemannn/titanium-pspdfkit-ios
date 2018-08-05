import PSPDFKit from 'ti.pspdfkit';

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
 
var btn = Ti.UI.createButton({
    title: 'Open PDF Document'
});
 
btn.addEventListener('click', () => {
    PSPDFKit.present('PSPDFKit.pdf', {
        documentLabelEnabled: true
    });
});
 
win.add(btn);
win.open();
