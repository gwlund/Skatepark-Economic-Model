# PDF Creation Guide
## Converting Markdown to Professional PDF

**Project:** Bellingham Skatepark Economic Analysis  
**Created:** August 2025  
**Purpose:** Document the process for converting markdown analysis to publication-ready PDF

---

## Overview

This guide documents the process for converting the `Bellingham_Skatepark_Economic_Analysis_Summary.md` file to a professional PDF suitable for municipal presentations and stakeholder distribution.

## Prerequisites

### Required Software Installation

#### 1. Pandoc (Document Converter)
```bash
# Install via Homebrew (macOS)
brew install pandoc

# Verify installation
pandoc --version
```

#### 2. LaTeX Distribution (PDF Engine)
```bash
# Install BasicTeX (lightweight option)
brew install --cask basictex

# Update PATH after installation
eval "$(/usr/libexec/path_helper)"

# Alternative: Full MacTeX (larger but more complete)
# brew install --cask mactex
```

## PDF Conversion Process

### Method 1: Standard Conversion (Recommended)

**Command:**
```bash
cd "/Users/gil-lund/Library/CloudStorage/OneDrive-SharedLibraries-Onedrive/Documents/001-Bellingham/2023-12 NWSC Waterfront Skatepark/Skatepark Economic Model"

pandoc Bellingham_Skatepark_Economic_Analysis_Summary.md \
  -o Bellingham_Skatepark_Analysis.pdf \
  --variable geometry:margin=1in \
  --variable fontsize=11pt \
  --variable documentclass=article \
  --table-of-contents \
  --number-sections
```

**Features:**
- Professional 1-inch margins
- 11-point font size
- Automatic table of contents
- Numbered sections
- Article document class

### Method 2: Emoji-Compatible Conversion

If the markdown contains emoji characters (🎯, 📊, etc.), LaTeX cannot process them directly. Use this approach:

**Command:**
```bash
# Create emoji-free version and convert in one step
sed 's/🎯/TARGET:/g; s/📊/DATA:/g; s/💰/INVESTMENT:/g; s/📈/GROWTH:/g; s/🏞️/INFRASTRUCTURE:/g; s/💡/INSIGHT:/g; s/✅/APPROVED:/g; s/🔍/ANALYSIS:/g; s/🚀/GROWTH:/g; s/🏆/LEADER:/g; s/📍/LOCATION:/g; s/🎉/SUCCESS:/g; s/❌/ERROR:/g; s/⚠️/WARNING:/g' Bellingham_Skatepark_Economic_Analysis_Summary.md | \
pandoc -o Bellingham_Skatepark_Analysis.pdf \
  --variable geometry:margin=1in \
  --variable fontsize=11pt \
  --table-of-contents \
  --number-sections
```

## Image Requirements

### Prerequisites for Image Inclusion

1. **Generate Images First:**
   - Run Cell 29 in `bellingham_skatepark_economic_model.ipynb`
   - This creates the `images/` directory with required PNG files

2. **Required Image Files:**
   ```
   images/
   ├── global_market_trends.png
   ├── climate_analysis.png
   └── economic_impact_summary.png
   ```

3. **Verify Images Exist:**
   ```bash
   ls -la images/
   ```

### Image Specifications
- **Format:** PNG
- **Resolution:** 300 DPI
- **Background:** White
- **Size:** Optimized for document inclusion

## Troubleshooting

### Common Issues and Solutions

#### Issue 1: "pdflatex not found"
**Solution:** Install LaTeX distribution
```bash
brew install --cask basictex
eval "$(/usr/libexec/path_helper)"
```

#### Issue 2: "Unicode character not set up for use with LaTeX"
**Cause:** Emoji characters in markdown  
**Solution:** Use Method 2 (Emoji-Compatible Conversion)

#### Issue 3: Images not appearing in PDF
**Cause:** Missing image files or incorrect paths  
**Solution:** 
1. Run notebook Cell 29 to generate images
2. Verify `images/` directory exists in same location as markdown file

#### Issue 4: Poor formatting or layout
**Solution:** Adjust Pandoc variables
```bash
# Custom formatting options
--variable geometry:margin=0.75in \
--variable fontsize=12pt \
--variable linestretch=1.2 \
--variable documentclass=report
```

## Advanced Options

### Custom Styling
```bash
# With custom CSS styling
pandoc input.md -o output.pdf \
  --css=custom-style.css \
  --variable geometry:margin=1in

# With specific fonts (requires XeLaTeX)
pandoc input.md -o output.pdf \
  --pdf-engine=xelatex \
  --variable mainfont="Times New Roman"
```

### Alternative PDF Engines
```bash
# Using different PDF engines
--pdf-engine=pdflatex    # Default, good compatibility
--pdf-engine=xelatex     # Better Unicode support, custom fonts
--pdf-engine=lualatex    # Modern LaTeX engine
--pdf-engine=wkhtmltopdf # HTML-based rendering
```

## Quality Assurance

### Post-Conversion Checklist

- [ ] **File Size:** Reasonable size (typically 1-3 MB for this document)
- [ ] **Images:** All plots visible and properly sized
- [ ] **Tables:** Properly formatted and readable
- [ ] **Table of Contents:** Generated and functional
- [ ] **Page Numbers:** Present and sequential
- [ ] **Margins:** Consistent and professional
- [ ] **Text:** No encoding issues or missing characters

### Verification Commands
```bash
# Check file was created
ls -la *.pdf

# Open for visual inspection
open Bellingham_Skatepark_Analysis.pdf

# Check file size (should be ~1MB)
du -h Bellingham_Skatepark_Analysis.pdf
```

## File Management

### Generated Files
- **Primary Output:** `Bellingham_Skatepark_Analysis.pdf`
- **Temporary Files:** `*_PDF.md` (auto-cleaned)
- **Source Images:** `images/*.png` (preserved)

### Version Control
```bash
# Add PDF to git (if desired)
git add Bellingham_Skatepark_Analysis.pdf
git commit -m "Add PDF version of economic analysis"

# Or exclude from version control
echo "*.pdf" >> .gitignore
```

## Automation Script

For repeated conversions, save this as `generate_pdf.sh`:

```bash
#!/bin/bash
# PDF Generation Script for Bellingham Skatepark Analysis

set -e  # Exit on error

echo "🔄 Generating PDF from markdown..."

# Check prerequisites
if ! command -v pandoc &> /dev/null; then
    echo "❌ Pandoc not found. Install with: brew install pandoc"
    exit 1
fi

# Check for images
if [ ! -d "images" ]; then
    echo "⚠️  Images directory not found. Run notebook Cell 29 first."
    exit 1
fi

# Convert with emoji handling
echo "📄 Converting markdown to PDF..."
sed 's/🎯/TARGET:/g; s/📊/DATA:/g; s/💰/INVESTMENT:/g; s/📈/GROWTH:/g; s/🏞️/INFRASTRUCTURE:/g; s/💡/INSIGHT:/g; s/✅/APPROVED:/g; s/🔍/ANALYSIS:/g; s/🚀/GROWTH:/g; s/🏆/LEADER:/g; s/📍/LOCATION:/g; s/🎉/SUCCESS:/g; s/❌/ERROR:/g; s/⚠️/WARNING:/g' Bellingham_Skatepark_Economic_Analysis_Summary.md | \
pandoc -o Bellingham_Skatepark_Analysis.pdf \
  --variable geometry:margin=1in \
  --variable fontsize=11pt \
  --table-of-contents \
  --number-sections

# Verify output
if [ -f "Bellingham_Skatepark_Analysis.pdf" ]; then
    echo "✅ PDF created successfully!"
    echo "📊 File size: $(du -h Bellingham_Skatepark_Analysis.pdf | cut -f1)"
    echo "📂 Location: $(pwd)/Bellingham_Skatepark_Analysis.pdf"
else
    echo "❌ PDF creation failed"
    exit 1
fi
```

**Usage:**
```bash
chmod +x generate_pdf.sh
./generate_pdf.sh
```

## Alternative Methods

### Online Converters (Quick Option)
- **Markdown to PDF**: https://md-to-pdf.fly.dev/
- **Dillinger**: https://dillinger.io/
- **StackEdit**: https://stackedit.io/

**Note:** Online converters may not handle local images properly.

### VS Code/Cursor Extension
1. Install "Markdown PDF" extension by yzane
2. Open markdown file
3. Right-click → "Markdown PDF: Export (pdf)"

---

## Document History

| Date | Version | Changes |
|------|---------|---------|
| Aug 2025 | 1.0 | Initial PDF creation process documentation |

---

*This guide ensures consistent, professional PDF generation for the Bellingham Skatepark Economic Analysis and can be adapted for future municipal reports.*
