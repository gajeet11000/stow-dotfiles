#!/usr/bin/env python3

import subprocess
import getpass

def create_reflector_sudoers_rule():
    username = getpass.getuser()
    sudoers_rule = f"{username} ALL=(ALL) NOPASSWD: /usr/bin/reflector"

    print("Creating sudoers rule for reflector...")
    subprocess.run(f'echo "{sudoers_rule}" | sudo tee /etc/sudoers.d/reflector-{username}', shell=True)
    subprocess.run(f"sudo chmod 440 /etc/sudoers.d/reflector-{username}", shell=True)
    print("Done! Reflector will now work without password.")
