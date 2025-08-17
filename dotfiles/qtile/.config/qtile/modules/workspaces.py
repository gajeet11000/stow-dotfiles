from libqtile.config import Group

GROUPS_DATA = [
    ("1", "➊", "monadtall"),
    ("2", "➋", "monadtall"),
    ("3", "➌", "monadtall"),
    ("4", "➍", "monadtall"),
    ("5", "➎", "monadtall"),
    ("6", "α", "monadtall"),
    ("7", "β", "monadtall"),
    ("8", "γ", "monadtall"),
    ("9", "δ", "monadtall"),
    ("0", "ε", "monadtall"),
]


def init_groups():
    return [
        Group(
            name=name,
            label=label,
            layout=layout.lower(),
        )
        for name, label, layout in GROUPS_DATA
    ]
