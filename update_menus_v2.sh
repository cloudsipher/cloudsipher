#!/bin/bash

# Script to update all HTML files with the new menu structure
# This script will:
# 1. Update the Company -> Services submenu with the new service pages
# 2. Hide the Products and Events mega menus

echo "Starting menu updates for all HTML files..."

# List of HTML files to update (excluding already updated ones)
HTML_FILES=$(find Autoscripts/html -name "*.html" -type f | grep -v "index.html" | grep -v "02_company.html" | grep -v "04_works.html" | grep -v "services.html")

# Counter for tracking progress
TOTAL_FILES=$(echo "$HTML_FILES" | wc -l)
CURRENT_FILE=0

for file in $HTML_FILES; do
    CURRENT_FILE=$((CURRENT_FILE + 1))
    echo "Processing file $CURRENT_FILE/$TOTAL_FILES: $file"
    
    # Create a temporary file for this operation
    temp_file=$(mktemp)
    
    # Check if file has the old Services menu structure and update it
    if grep -q "08_events.html.*Events" "$file"; then
        echo "  - Updating Services menu..."
        
        # Use awk to replace the Services submenu
        awk '
        BEGIN { in_services = 0; services_start = 0; }
        /							<li class="menu-item-has-children">/ { 
            if ($0 ~ /Services/) {
                in_services = 1
                services_start = 1
                print "							<li class=\"menu-item-has-children\">"
                print "								<a href=\"#\">"
                print "									Services"
                print "								</a>"
                print "								<ul class=\"sub-menu\">"
                print "									<li>"
                print "										<a href=\"services.html\">All Services</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"software_development.html\">Software Development</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"web_development.html\">Web Development</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"mobile_app_development.html\">Mobile App Development</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"api_development.html\">API Development</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"database_solutions.html\">Database Solutions</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"devops_automation.html\">DevOps Automation</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"cloud_migration.html\">Cloud Migration</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"cybersecurity.html\">Cybersecurity</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"infrastructure_services.html\">Infrastructure Services</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"digital_transformation.html\">Digital Transformation</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"it_consulting.html\">IT Consulting</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"it_outsourcing.html\">IT Outsourcing</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"it_support.html\">IT Support</a>"
                print "									</li>"
                print "									<li>"
                print "										<a href=\"technical_support.html\">Technical Support</a>"
                print "									</li>"
                print "								</ul>"
                print "							</li>"
                next
            }
        }
        /							<\/li>/ { 
            if (in_services && services_start) {
                in_services = 0
                services_start = 0
                next
            }
        }
        { 
            if (!in_services || !services_start) {
                print $0
            }
        }
        ' "$file" > "$temp_file"
        
        mv "$temp_file" "$file"
    fi
    
    # Check if file has Products mega menu and hide it
    if grep -q "menu-item-has-mega-menu.*Products" "$file"; then
        echo "  - Hiding Products mega menu..."
        
        # Use awk to comment out the Products mega menu
        awk '
        BEGIN { in_products = 0; products_start = 0; }
        /					<li class="menu-item-has-mega-menu menu-item-has-children">/ { 
            if ($0 ~ /Products/) {
                in_products = 1
                products_start = 1
                print "					<!-- Products menu hidden"
                print $0
                next
            }
        }
        /					<\/li>/ { 
            if (in_products && products_start) {
                in_products = 0
                products_start = 0
                print "					-->"
                print $0
                next
            }
        }
        { 
            if (in_products && products_start) {
                print $0
            } else if (!in_products || !products_start) {
                print $0
            }
        }
        ' "$file" > "$temp_file"
        
        mv "$temp_file" "$file"
    fi
    
    # Check if file has Events mega menu and hide it
    if grep -q "menu-item-has-mega-menu.*Events" "$file"; then
        echo "  - Hiding Events mega menu..."
        
        # Use awk to comment out the Events mega menu
        awk '
        BEGIN { in_events = 0; events_start = 0; }
        /					<li class="menu-item-has-mega-menu menu-item-has-children">/ { 
            if ($0 ~ /Events/) {
                in_events = 1
                events_start = 1
                print "					<!-- Events menu hidden"
                print $0
                next
            }
        }
        /					<\/li>/ { 
            if (in_events && events_start) {
                in_events = 0
                events_start = 0
                print "					-->"
                print $0
                next
            }
        }
        { 
            if (in_events && events_start) {
                print $0
            } else if (!in_events || !events_start) {
                print $0
            }
        }
        ' "$file" > "$temp_file"
        
        mv "$temp_file" "$file"
    fi
done

echo "Menu updates completed for all HTML files!" 