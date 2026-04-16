import os
import shutil
import re

fe_path = 'petty_FE'
public_assets = os.path.join(fe_path, 'public', 'src_assets')

# Directories to copy
dirs_to_copy = ['img_imports', 'svg', 'images']

for d in dirs_to_copy:
    src_dir = os.path.join(fe_path, 'src', 'assets', d)
    dest_dir = os.path.join(public_assets, d)
    if os.path.exists(src_dir):
        if not os.path.exists(dest_dir):
            shutil.copytree(src_dir, dest_dir, dirs_exist_ok=True)
            print(f"Copied {src_dir} to {dest_dir}")

# Find all .vue files and replace
vue_files = []
for root, dirs, files in os.walk(os.path.join(fe_path, 'src')):
    for f in files:
        if f.endswith('.vue'):
            vue_files.append(os.path.join(root, f))

for f in vue_files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Replace absolute /src/assets/ and relative ./src/assets/ to /src_assets/
    new_content = re.sub(r'(["\'])/src/assets/', r'\1/src_assets/', content)
    new_content = re.sub(r'(["\'])\./src/assets/', r'\1/src_assets/', new_content)
    
    if new_content != content:
        with open(f, 'w', encoding='utf-8') as file:
            file.write(new_content)
        print(f"Updated {f}")

print("Fix completed!")
