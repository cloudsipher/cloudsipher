#!/bin/bash

# List of files that need navigation updates
files=(
    "05_case_details_ver_01.html"
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

echo "Starting navigation updates..."

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Updating $file..."
        
        # Use sed to comment out the Products, Conference, Course, and Cases menu items
        # This pattern looks for the specific structure and comments it out
        sed -i '' '
            /<li>/{N;N;N;N;
                /<a href="03_products.html">.*Products.*<\/a>.*<\/li>/{
                    s/<li>/<!-- <li>/
                    s/<\/li>/<\/li> -->/
                }
            }
            /<li>/{N;N;N;N;
                /<a href="09_events_details_conference_workshops.html">.*Conference.*<\/a>.*<\/li>/{
                    s/<li>/<!-- <li>/
                    s/<\/li>/<\/li> -->/
                }
            }
            /<li[^>]*>/{N;N;N;N;
                /<a href="10_events_details_course.html">.*Course.*<\/a>.*<\/li>/{
                    s/<li[^>]*>/<!-- &/
                    s/<\/li>/<\/li> -->/
                }
            }
            /<li>/{N;N;N;N;
                /<a href="04_works.html">.*Cases.*<\/a>.*<\/li>/{
                    s/<li>/<!-- <li>/
                    s/<\/li>/<\/li> -->/
                }
            }
        ' "$file"
        
        echo "Updated $file"
    else
        echo "File $file not found, skipping..."
    fi
done

echo "Navigation updates completed!"