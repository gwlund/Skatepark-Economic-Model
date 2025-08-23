#!/usr/bin/env python3
"""
Script to generate plots for markdown integration
Run this to create images that can be included in the markdown summary
"""

import subprocess
import sys
import os

def run_notebook_cell():
    """Run the specific notebook cell that generates plots for markdown"""
    print("🎯 Generating plots for markdown integration...")
    print("="*60)
    
    # Check if jupyter is installed
    try:
        result = subprocess.run(['jupyter', '--version'], 
                              capture_output=True, text=True, check=True)
        print("✅ Jupyter found:", result.stdout.strip())
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("❌ Jupyter not found. Please install with: pip install jupyter")
        return False
    
    # Run the specific cell
    notebook_path = "bellingham_skatepark_economic_model.ipynb"
    
    if not os.path.exists(notebook_path):
        print(f"❌ Notebook not found: {notebook_path}")
        return False
    
    print(f"📂 Processing notebook: {notebook_path}")
    print("🔄 Executing plot generation cell...")
    
    # Execute the notebook cell that generates plots
    cmd = [
        'jupyter', 'nbconvert', 
        '--to', 'notebook',
        '--execute',
        '--inplace',
        notebook_path
    ]
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        print("✅ Notebook executed successfully!")
        
        # Check if images directory was created
        if os.path.exists('images'):
            image_files = [f for f in os.listdir('images') if f.endswith('.png')]
            print(f"✅ Created {len(image_files)} plot images:")
            for img in image_files:
                print(f"   - images/{img}")
        else:
            print("⚠️  Images directory not found. Please run the last cell in the notebook manually.")
            
        return True
        
    except subprocess.CalledProcessError as e:
        print("❌ Error executing notebook:")
        print(e.stderr)
        return False

def main():
    """Main function"""
    print("Bellingham Skatepark Analysis - Plot Generator")
    print("="*60)
    
    success = run_notebook_cell()
    
    if success:
        print("\n🎉 COMPLETE! Your plots are ready for markdown.")
        print("\nNext steps:")
        print("1. The images are now saved in the 'images/' directory")
        print("2. Your markdown file has been updated with image references")
        print("3. When viewing the markdown, make sure the images/ folder is accessible")
        print("\nMarkdown syntax used:")
        print("![Description](images/filename.png)")
    else:
        print("\n❌ Plot generation failed.")
        print("Alternative: Run the last cell in the Jupyter notebook manually.")

if __name__ == "__main__":
    main()
