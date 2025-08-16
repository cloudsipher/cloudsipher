#!/bin/bash

# Script to add custom navigation CSS to all HTML files

echo "Adding custom navigation CSS to all HTML files..."

# Find all HTML files and add the custom CSS link
for file in *.html; do
    if [ "$file" != "index.html" ] && [ "$file" != "web_development.html" ]; then
        echo "Processing: $file"
        
        # Check if the custom CSS is already included
        if ! grep -q "custom-navigation-fix.css" "$file"; then
            # Find the line with swiper.min.css and add our CSS after it
            sed -i '' '/css\/plugins\/swiper.min.css/a\
	<link rel="stylesheet" type="text/css" href="css/custom-navigation-fix.css">' "$file"
            echo "  ✓ Added custom CSS to $file"
        else
            echo "  - Custom CSS already exists in $file"
        fi
    fi
done

echo "✓ Custom navigation CSS added to all HTML files!"