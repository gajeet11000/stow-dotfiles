import subprocess

subprocess.run(
    [
        "sudo",
        "reflector",
        "--verbose",
        "--protocol",
        "https",
        "--latest",
        "50",              # Consider the latest 50 mirrors
        "--download-timeout",
        "5",
        "--sort",
        "rate",            # Benchmark mirrors and sort by download speed
        "--save",
        "/etc/pacman.d/mirrorlist",
    ],
    check=True,
)
