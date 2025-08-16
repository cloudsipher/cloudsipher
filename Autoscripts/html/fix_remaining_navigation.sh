#!/bin/bash

# List of files that need manual fixing
files=(
    "06_case_details_ver_02.html"
    "07_case_details_ver_03.html"
    "09_events_details_conference_workshops.html"
    "10_events_details_course.html"
    "11_events_details_lesson.html"
    "12_events_details_presentation.html"
    "13_events_details_training.html"
    "14_events_details_webinar.html"
    "21_block_of_slides.html"
    "22_faqs-slides.html"
    "29_headers.html"
    "30_search_dark.html"
    "30_search_light.html"
    "31_search_full_screen_dark.html"
    "31_search_full_screen_light.html"
    "33_slides.html"
    "typography.html"
    "16_news_backup.html"
    "technical_support.html"
)

echo "Fixing remaining navigation updates..."

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Fixing $file..."
        
        # Use perl for more precise multi-line pattern matching
        perl -i -pe '
            BEGIN { undef $/; }
            s|(<li>\s*<a href="03_products\.html">\s*Products\s*</a>\s*</li>)|<!-- $1 -->|gs;
            s|(<li>\s*<a href="09_events_details_conference_workshops\.html">\s*Conference\s*</a>\s*</li>)|<!-- $1 -->|gs;
            s|(<li[^>]*>\s*<a href="10_events_details_course\.html">\s*Course\s*</a>\s*</li>)|<!-- $1 -->|gs;
            s|(<li>\s*<a href="04_works\.html">\s*Cases\s*</a>\s*</li>)|<!-- $1 -->|gs;
        ' "$file"
        
        echo "Fixed $file"
    else
        echo "File $file not found, skipping..."
    fi
done

echo "Navigation fixes completed!"