#!/bin/bash
# PDF Generation Script for Bellingham Skatepark Analysis
# Usage: ./generate_pdf.sh

set -e  # Exit on error

echo "🔄 Generating PDF from markdown..."

# Check prerequisites
if ! command -v pandoc &> /dev/null; then
    echo "❌ Pandoc not found. Install with: brew install pandoc"
    exit 1
fi

# Check for LaTeX
if ! command -v pdflatex &> /dev/null; then
    echo "❌ LaTeX not found. Install with: brew install --cask basictex"
    echo "   Then run: eval \"\$(/usr/libexec/path_helper)\""
    exit 1
fi

# Check for images
if [ ! -d "images" ]; then
    echo "⚠️  Images directory not found. Run notebook Cell 29 first."
    echo "   This will generate the required PNG files for the PDF."
    exit 1
fi

# Check for source markdown file
if [ ! -f "Bellingham_Skatepark_Economic_Analysis_Summary.md" ]; then
    echo "❌ Source markdown file not found."
    echo "   Expected: Bellingham_Skatepark_Economic_Analysis_Summary.md"
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
    echo ""
    echo "🎯 Next steps:"
    echo "   - Review the PDF: open Bellingham_Skatepark_Analysis.pdf"
    echo "   - Share with stakeholders"
    echo "   - Archive with project documentation"
else
    echo "❌ PDF creation failed"
    exit 1
fi
