import os
import subprocess

# Root directory where the search starts
root_dir = "."

for dirpath, _, filenames in os.walk(root_dir):
    if "requirements.txt" in filenames:
        req_file = os.path.join(dirpath, "requirements.txt")
        print(f"Installing dependencies from {req_file}...")
        try:
            subprocess.check_call(["pip", "install", "-r", req_file])
        except subprocess.CalledProcessError as e:
            print(f"Failed to install requirements in {dirpath}: {e}")