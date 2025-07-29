
const fs = require('fs');
const path = require('path');

const htmlDir = './html';
const optimizationTemplate = `
	<!-- Critical CSS inline for immediate rendering -->
	<style>
		body{margin:0;padding:0;font-family:Arial,sans-serif}
		.header{position:relative;z-index:100}
		.container{max-width:1200px;margin:0 auto;padding:0 15px}
	</style>

	<!-- Preload critical resources -->
	<link rel="preload" href="css/theme-styles.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
	<noscript><link rel="stylesheet" href="css/theme-styles.css"></noscript>
	
	<!-- Load non-critical CSS asynchronously -->
	<link rel="preload" href="css/blocks.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
	<noscript><link rel="stylesheet" href="css/blocks.css"></noscript>
	
	<link rel="preload" href="css/widgets.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
	<noscript><link rel="stylesheet" href="css/widgets.css"></noscript>
	
	<link rel="preload" href="css/plugins/ion.rangeSlider.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
	<noscript><link rel="stylesheet" href="css/plugins/ion.rangeSlider.css"></noscript>
`;

// Get all HTML files
const htmlFiles = fs.readdirSync(htmlDir).filter(file => file.endsWith('.html'));

htmlFiles.forEach(file => {
    const filePath = path.join(htmlDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Skip if already optimized
    if (content.includes('Critical CSS inline')) {
        console.log(`${file} already optimized, skipping...`);
        return;
    }
    
    // Replace CSS links with optimized version
    const cssRegex = /(<link rel="stylesheet"[^>]*href="css\/[^"]*"[^>]*>)/g;
    const matches = content.match(cssRegex);
    
    if (matches && matches.length > 0) {
        // Replace the first CSS link block with optimized version
        content = content.replace(matches[0], optimizationTemplate);
        
        // Remove remaining CSS links that are now handled asynchronously
        for (let i = 1; i < matches.length; i++) {
            content = content.replace(matches[i], '');
        }
        
        // Add lazy loading script before closing body tag
        content = content.replace(
            '</body>',
            '<script defer src="js/lazy-loading.js"></script>\n</body>'
        );
        
        // Make images lazy load by converting src to data-src
        content = content.replace(
            /<img([^>]*)\ssrc="([^"]*)"([^>]*)>/g,
            '<img$1 data-src="$2" src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 1 1\'%3E%3C/svg%3E" class="lazy"$3>'
        );
        
        // Defer JavaScript loading
        content = content.replace(
            /<script src="js\/js-plugins/g,
            '<script defer src="js/js-plugins'
        );
        
        fs.writeFileSync(filePath, content);
        console.log(`Optimized ${file}`);
    }
});

console.log('Memory optimization applied to all HTML files!');
