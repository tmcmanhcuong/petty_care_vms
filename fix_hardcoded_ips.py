import os
import re

fe_dir = 'petty_FE/src'

for root, dirs, files in os.walk(fe_dir):
    for file in files:
        if not file.endswith(('.js', '.vue')): continue
        filepath = os.path.join(root, file)
        with open(filepath, 'r') as f:
            content = f.read()
        
        # replace VITE_API_BASE in api.js to use VITE_API_BASE_URL to match deploy-fe.yml
        if "VITE_API_BASE" in content and "VITE_API_BASE_URL" not in content:
            content = content.replace("VITE_API_BASE", "VITE_API_BASE_URL")
            
        orig = content
        
        # Replace case 1: "http://127.0.0.1:8000/api/..."
        content = re.sub(r'(["\'])http://127\.0\.0\.1:8000/api', r'import.meta.env.VITE_API_BASE_URL + \1', content)
        
        # Replace case 2: "http://127.0.0.1:8000/storage/..."
        content = re.sub(r'(["\'])http://127\.0\.0\.1:8000/storage', r'import.meta.env.VITE_API_BASE_URL.replace("/api", "") + \1/storage', content)
        
        # Replace case 3: "http://127.0.0.1:8000/..."
        content = re.sub(r'(["\'])http://127\.0\.0\.1:8000', r'import.meta.env.VITE_API_BASE_URL.replace("/api", "") + \1', content)
        
        if orig != content:
            with open(filepath, 'w') as f:
                f.write(content)
            print(f"Fixed {filepath}")
