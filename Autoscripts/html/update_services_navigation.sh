#!/bin/bash

# List of service pages that need navigation updates
SERVICE_PAGES=(
    "software_development.html"
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
    "services.html"
    "02_company.html"
)

# Function to update navigation in a file
update_navigation() {
    local file="$1"
    echo "Updating navigation in $file..."
    
    # Create backup
    cp "$file" "${file}.backup"
    
    # Use sed to replace the old navigation structure with the new one
    sed -i '' '
    /<li class="">/,/<\/li>/ {
        /<a href="#">Company<\/a>/,/<\/li>/ {
            /<a href="#">Company<\/a>/ {
                s/<a href="#">Company<\/a>/<a href="02_company.html">Company<\/a>/
                N
                s/<ul class="sub-menu">/<!-- Company submenu removed -->/
                :loop
                N
                /<\/ul>/!b loop
                s/<\/ul>/<!-- End company submenu -->/
                a\
					</li>\
\
					<li class="menu-item-has-children">\
						<a href="#">Services</a>\
						<ul class="sub-menu">\
							<li>\
								<a href="services.html">All Services</a>\
							</li>\
							<li>\
								<a href="software_development.html">Software Development</a>\
							</li>\
							<li>\
								<a href="web_development.html">Web Development</a>\
							</li>\
							<li>\
								<a href="mobile_app_development.html">Mobile App Development</a>\
							</li>\
							<li>\
								<a href="api_development.html">API Development</a>\
							</li>\
							<li>\
								<a href="database_solutions.html">Database Solutions</a>\
							</li>\
							<li>\
								<a href="devops_automation.html">DevOps Automation</a>\
							</li>\
							<li>\
								<a href="cloud_migration.html">Cloud Migration</a>\
							</li>\
							<li>\
								<a href="cybersecurity.html">Cybersecurity</a>\
							</li>\
							<li>\
								<a href="infrastructure_services.html">Infrastructure Services</a>\
							</li>\
							<li>\
								<a href="digital_transformation.html">Digital Transformation</a>\
							</li>\
							<li>\
								<a href="it_consulting.html">IT Consulting</a>\
							</li>\
							<li>\
								<a href="it_outsourcing.html">IT Outsourcing</a>\
							</li>\
							<li>\
								<a href="it_support.html">IT Support</a>\
							</li>\
							<li>\
								<a href="technical_support.html">Technical Support</a>\
							</li>\
						</ul>
            }
        }
    }' "$file"
    
    echo "Navigation updated in $file"
}

# Update navigation for each service page
for page in "${SERVICE_PAGES[@]}"; do
    if [ -f "$page" ]; then
        update_navigation "$page"
    else
        echo "Warning: $page not found"
    fi
done

echo "Navigation update completed for all service pages!"