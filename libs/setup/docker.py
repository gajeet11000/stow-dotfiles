import os
import subprocess


def docker_setup():
    """
    Set up Docker by creating the docker group, adding the current user to it, and enabling Docker services.
    """
    try:
        subprocess.run(["sudo", "groupadd", "docker"], check=False)
        subprocess.run(
            ["sudo", "usermod", "-aG", "docker", os.getenv("USER")], check=True
        )
        subprocess.run(["sudo", "systemctl", "enable", "docker.service"], check=True)
        subprocess.run(
            ["sudo", "systemctl", "enable", "containerd.service"], check=True
        )
        print(
            "Docker setup completed. Please log out and log back in for group changes to take effect."
        )
    except subprocess.CalledProcessError as e:
        print(f"Error setting up Docker: {e}")
