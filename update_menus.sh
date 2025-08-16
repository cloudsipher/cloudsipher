#!/bin/bash

# Script to update all HTML files with the new menu structure
# This script will:
# 1. Update the Company -> Services submenu with the new service pages
# 2. Hide the Products and Events mega menus

echo "Starting menu updates for all HTML files..."

# List of HTML files to update (excluding already updated ones)
HTML_FILES=$(find Autoscripts/html -name "*.html" -type f | grep -v "index.html" | grep -v "02_company.html" | grep -v "04_works.html" | grep -v "services.html")

# New Services submenu content
NEW_SERVICES_MENU='							<li class="menu-item-has-children">
								<a href="#">
									Services
								</a>
								<ul class="sub-menu">
									<li>
										<a href="services.html">All Services</a>
									</li>
									<li>
										<a href="software_development.html">Software Development</a>
									</li>
									<li>
										<a href="web_development.html">Web Development</a>
									</li>
									<li>
										<a href="mobile_app_development.html">Mobile App Development</a>
									</li>
									<li>
										<a href="api_development.html">API Development</a>
									</li>
									<li>
										<a href="database_solutions.html">Database Solutions</a>
									</li>
									<li>
										<a href="devops_automation.html">DevOps Automation</a>
									</li>
									<li>
										<a href="cloud_migration.html">Cloud Migration</a>
									</li>
									<li>
										<a href="cybersecurity.html">Cybersecurity</a>
									</li>
									<li>
										<a href="infrastructure_services.html">Infrastructure Services</a>
									</li>
									<li>
										<a href="digital_transformation.html">Digital Transformation</a>
									</li>
									<li>
										<a href="it_consulting.html">IT Consulting</a>
									</li>
									<li>
										<a href="it_outsourcing.html">IT Outsourcing</a>
									</li>
									<li>
										<a href="it_support.html">IT Support</a>
									</li>
									<li>
										<a href="technical_support.html">Technical Support</a>
									</li>
								</ul>
							</li>'

# Old Services submenu pattern to replace
OLD_SERVICES_PATTERN='							<li class="menu-item-has-children">
								<a href="#">
									Services
								</a>
								<ul class="sub-menu">
									<li>
										<a href="08_events.html">Events</a>
									</li>
									<li>
										<a href="05_case_details_ver_01.html">Case Details V1</a>
									</li>

									<li>
										<a href="06_case_details_ver_02.html">Case Details V2</a>
									</li>

									<li>
										<a href="07_case_details_ver_03.html">Case Details V3</a>
									</li>
									<li>
										<a href="11_events_details_lesson.html">Events Lesson</a>
									</li>
									<li>
										<a href="12_events_details_presentation.html">Events Presentation</a>
									</li>

									<li>
										<a href="13_events_details_training.html">Events Training</a>
									</li>

									<li>
										<a href="14_events_details_webinar.html">Events Webinar</a>
									</li>
								</ul>
							</li>'

# Products mega menu pattern to hide
PRODUCTS_MENU_START='					<li class="menu-item-has-mega-menu menu-item-has-children">
						<a href="#">Products</a>
						<div class="megamenu with-products">'

PRODUCTS_MENU_END='					</li>'

# Events mega menu pattern to hide
EVENTS_MENU_START='					<li class="menu-item-has-mega-menu menu-item-has-children">
						<a href="#">Events</a>

						<div class="megamenu" style="background-image: url('\''img/menu-bg.jpg'\'');">'

EVENTS_MENU_END='					</li>'

# Counter for tracking progress
TOTAL_FILES=$(echo "$HTML_FILES" | wc -l)
CURRENT_FILE=0

for file in $HTML_FILES; do
    CURRENT_FILE=$((CURRENT_FILE + 1))
    echo "Processing file $CURRENT_FILE/$TOTAL_FILES: $file"
    
    # Check if file has the old Services menu structure
    if grep -q "08_events.html.*Events" "$file"; then
        echo "  - Updating Services menu..."
        # Create a temporary file
        temp_file=$(mktemp)
        
        # Replace the old Services menu with the new one
        sed '/							<li class="menu-item-has-children">/,/							<\/li>/c\'"$NEW_SERVICES_MENU" "$file" > "$temp_file"
        mv "$temp_file" "$file"
    fi
    
    # Check if file has Products mega menu
    if grep -q "menu-item-has-mega-menu.*Products" "$file"; then
        echo "  - Hiding Products mega menu..."
        # Create a temporary file
        temp_file=$(mktemp)
        
        # Comment out the Products mega menu
        sed '/					<li class="menu-item-has-mega-menu menu-item-has-children">/,/					<\/li>/s/^/					<!-- Products menu hidden\n/' "$file" > "$temp_file"
        sed '/					<!-- Products menu hidden/,/					<\/li>/s/^					<\/li>/					-->\n					<\/li>/' "$temp_file" > "$file"
        rm "$temp_file"
    fi
    
    # Check if file has Events mega menu
    if grep -q "menu-item-has-mega-menu.*Events" "$file"; then
        echo "  - Hiding Events mega menu..."
        # Create a temporary file
        temp_file=$(mktemp)
        
        # Comment out the Events mega menu
        sed '/					<li class="menu-item-has-mega-menu menu-item-has-children">/,/					<\/li>/s/^/					<!-- Events menu hidden\n/' "$file" > "$temp_file"
        sed '/					<!-- Events menu hidden/,/					<\/li>/s/^					<\/li>/					-->\n					<\/li>/' "$temp_file" > "$file"
        rm "$temp_file"
    fi
done

echo "Menu updates completed for all HTML files!" 