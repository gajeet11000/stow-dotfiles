import subprocess

subprocess.run(
    [
        "sudo",
        "reflector",
        "--verbose",
        "-c",
        "NL",
        "-c",
        "SG",
        "-c",
        "US",
        "--protocol",
        "https",
        "--sort",
        "age",
        "--latest",
        "20",
        "--download-timeout",
        "5",
    ]
)
