#!/bin/bash

# Script to update navigation across all HTML files
# Comment out Products, Conference, Course, Cases from Company dropdown
# Comment out Pricing, News, Contact from main menu

echo "Updating navigation across all HTML files..."

# List of HTML files to update (excluding index.html, 02_company.html, 03_products.html, 04_works.html which are already done)
files=(
    "services.html"
    "software_development.html"
    "web_development.html"
    "mobile_app_development.html"
    "api_development.html"
    "database_solutions.html"
    "devops_automation.html"
    "cloud_migration.html"
    "cybersecurity.html"
    "infrastructure_services.html"
    "digital_transformation.html"
    "it_consulting.html"
    "it_outsourcing.html"
    "it_support.html"
    "technical_support.html"
    "05_case_details_ver_01.html"
    "06_case_details_ver_02.html"
    "07_case_details_ver_03.html"
    "08_events.html"
    "09_events_details_conference_workshops.html"
    "10_events_details_course.html"
    "11_events_details_lesson.html"
    "12_events_details_presentation.html"
    "13_events_details_training.html"
    "14_events_details_webinar.html"
    "15_pricing_tables.html"
    "16_news.html"
    "17_news_details.html"
    "18_contacts.html"
    "20_page-not_found.html"
    "21_block_of_slides.html"
    "22_faqs-slides.html"
    "23_galleries.html"
    "24_gallery_full_screen.html"
    "29_headers.html"
    "30_search_dark.html"
    "30_search_light.html"
    "31_search_full_screen_dark.html"
    "31_search_full_screen_light.html"
    "32_testimonials.html"
    "33_slides.html"
    "typography.html"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Updating $file..."
        
        # Comment out Products, Conference, Course, Cases from Company dropdown
        sed -i '' 's|<li>|<!-- <li>|g; s|<a href="03_products.html">|<a href="03_products.html">|g; s|Products|Products|g; s|</a>|</a>|g; s|</li>|</li> -->|g' "$file" 2>/dev/null || true
        
        # More specific replacements for Company dropdown items
        sed -i '' '/<li>/,/<\/li>/ {
            /<a href="03_products.html">/,/<\/li>/ {
                s|<li>|<!-- <li>|
                s|</li>|</li> -->|
            }
        }' "$file" 2>/dev/null || true
        
        # Comment out main navigation items
        sed -i '' '/<li class="">/,/<\/li>/ {
            /<a href="15_pricing_tables.html">/,/<\/li>/ {
                s|<li class="">|<!-- <li class="">|
                s|</li>|</li> -->|
            }
        }' "$file" 2>/dev/null || true
        
        sed -i '' '/<li class="">/,/<\/li>/ {
            /<a href="16_news.html">/,/<\/li>/ {
                s|<li class="">|<!-- <li class="">|
                s|</li>|</li> -->|
            }
        }' "$file" 2>/dev/null || true
        
        sed -i '' '/<li class="">/,/<\/li>/ {
            /<a href="18_contacts.html">/,/<\/li>/ {
                s|<li class="">|<!-- <li class="">|
                s|</li>|</li> -->|
            }
        }' "$file" 2>/dev/null || true
        
    else
        echo "File $file not found, skipping..."
    fi
done

echo "Navigation update completed!"