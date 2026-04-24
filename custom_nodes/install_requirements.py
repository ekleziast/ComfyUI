import os
import subprocess
import sys

root_dir = "."

for dirpath, _, filenames in os.walk(root_dir):
    if "requirements.txt" not in filenames:
        continue

    req_file = os.path.join(dirpath, "requirements.txt")
    print(f"Installing dependencies from {req_file}...")

    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", req_file])
    except subprocess.CalledProcessError as error:
        print(f"Failed to install requirements in {dirpath}: {error}")
