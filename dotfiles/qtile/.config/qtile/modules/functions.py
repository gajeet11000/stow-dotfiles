class Helper:
    @staticmethod
    def is_not_master_window(window):
        return window.info()["x"] != 8 and window.info()["y"] != 8

    @staticmethod
    def killall_windows(group):
        window_list = group.windows[:]
        for win in window_list:
            win.kill()


class Custom:
    # Group management functions
    @staticmethod
    def custom_next_group(qtile):
        current_group_index = int(qtile.current_group.name) - 1
        i = current_group_index + 1

        # if its -1 then it means it's acutal index is 9
        if current_group_index == -1:
            current_group_index = 9
            # so the next index starts from 0
            i = 0

        total_groups = 10
        while i != current_group_index:
            if i < total_groups:
                if len(qtile.groups[i].windows[:]) != 0:
                    if i == 9:
                        qtile.current_screen.toggle_group("0")
                    else:
                        qtile.current_screen.toggle_group(str(i + 1))
                    break
                i += 1
            else:
                i = 0

    @staticmethod
    def custom_prev_group(qtile):
        current_group_index = int(qtile.current_group.name) - 1

        # previous group index
        i = current_group_index - 1

        # if its -1 then it means it's acutal index is 9
        if current_group_index == -1:
            current_group_index = 9
            # so the previous index is 8
            i = 8

        while i != current_group_index:
            if i >= 0:
                if len(qtile.groups[i].windows[:]) != 0:
                    if i == 9:
                        qtile.current_screen.toggle_group("0")
                    else:
                        qtile.current_screen.toggle_group(str(i + 1))
                    break
                i -= 1
            else:
                i = 9

    @staticmethod
    def regular_custom_next_group(qtile):
        current_group_no = int(qtile.current_group.name)
        if current_group_no == 0:
            qtile.current_screen.toggle_group("1")
        else:
            qtile.current_screen.next_group()

    @staticmethod
    def regular_custom_prev_group(qtile):
        current_group_no = int(qtile.current_group.name)
        if current_group_no == 1:
            qtile.current_screen.toggle_group("0")
        else:
            qtile.current_screen.prev_group()

    # Window management functions
    @staticmethod
    def window_to_prev_group(qtile):
        if qtile.currentWindow is not None:
            i = qtile.groups.index(qtile.currentGroup)
            qtile.currentWindow.togroup(qtile.groups[i - 1].name)

    @staticmethod
    def window_to_next_group(qtile):
        if qtile.currentWindow is not None:
            i = qtile.groups.index(qtile.currentGroup)
            qtile.currentWindow.togroup(qtile.groups[i + 1].name)

    @staticmethod
    def minimize_all(qtile):
        for win in qtile.current_group.windows[:]:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()

    @staticmethod
    def minimize_others(qtile):
        focused_window = qtile.current_window
        current_group = qtile.current_group
        current_group_windows = current_group.windows[:]
        restore_group = qtile.groups[int(current_group.name) - 1 + 5]
        restore_group_windows = restore_group.windows[:]

        no_of_windows = len(current_group_windows)

        if (no_of_windows == 0 or no_of_windows == 1) or (
            no_of_windows == 2 and Helper.is_not_master_window(focused_window)
        ):
            for win in restore_group_windows:
                win.togroup(current_group.name)

        else:
            for win in current_group_windows:
                if (
                    win != focused_window
                    and Helper.is_not_master_window(win)
                    and Helper.is_not_master_window(focused_window)
                ):
                    win.togroup(restore_group.name)

    @staticmethod
    def toggle_current_minimized_groups(qtile):
        current_group_index = int(qtile.current_group.name) - 1

        print(current_group_index)

        if current_group_index < 5:
            qtile.current_screen.toggle_group(
                qtile.groups[current_group_index + 5].name
            )
        else:
            qtile.current_screen.toggle_group(
                qtile.groups[current_group_index - 5].name
            )

    @staticmethod
    def clear_minimized_group(qtile):
        current_group_index = int(qtile.current_group.name) - 1
        Custom.killall_windows(qtile.groups[current_group_index + 5])

    @staticmethod
    def clear_current_group(qtile):
        Custom.killall_windows(qtile.groups[int(qtile.current_group.name - 1)])

    @staticmethod
    def maximize_by_switching_layout(qtile):
        current_layout = qtile.current_group.layout.name

        no_of_windows = len(qtile.current_group.windows[:])

        if no_of_windows > 1:
            if current_layout == "monadtall":
                qtile.current_group.layout = "max"
            elif current_layout == "max":
                qtile.current_group.layout = "monadtall"

    @staticmethod
    def toggle_window_original_restore(qtile):
        current_group_index = int(qtile.current_group.name) - 1
        focused_window = qtile.current_window

        if current_group_index < 5:
            focused_window.togroup(qtile.groups[current_group_index + 5].name)
        else:
            focused_window.togroup(qtile.groups[current_group_index - 5].name)

    @staticmethod
    def get_main_pane(qtile):
        windows = qtile.current_group.windows[:]
        for win in windows:
            if not Helper.is_not_master_window(win):
                return win

    @staticmethod
    def resize_window(qtile, key):
        focused_window = qtile.current_window
        is_master = not Helper.is_not_master_window(focused_window)

        current_layout = qtile.current_group.layout

        if current_layout.name == "monadtall":
            if is_master:
                if key == "h":
                    current_layout.shrink()
                elif key == "l":
                    current_layout.grow()
            else:
                if key == "j":
                    current_layout.grow()
                elif key == "k":
                    current_layout.shrink()
                elif key == "h":
                    current_layout.shrink_main()
                else:
                    current_layout.grow_main()
        elif current_layout.name == "monadwide":
            if is_master:
                if key == "k":
                    current_layout.shrink()
                elif key == "j":
                    current_layout.grow()
            else:
                if key == "h":
                    current_layout.grow()
                elif key == "l":
                    current_layout.shrink()
                elif key == "j":
                    current_layout.shrink_main()
                else:
                    current_layout.grow_main()

    # Screen management functions
    @staticmethod
    def float_to_front(qtile):
        for group in qtile.groups:
            for window in group.windows:
                if window.floating:
                    window.bring_to_front()

    @staticmethod
    def switch_max_to_monadtall(qtile):
        layout_name = qtile.current_layout.name

        if layout_name == "max":
            qtile.current_group.layout = "monadtall"

    @staticmethod
    def window_to_previous_screen(qtile):
        i = qtile.screens.index(qtile.current_screen)
        if i != 0:
            group = qtile.screens[i - 1].group.name
            qtile.current_window.togroup(group)

    @staticmethod
    def window_to_next_screen(qtile):
        i = qtile.screens.index(qtile.current_screen)
        if i + 1 != len(qtile.screens):
            group = qtile.screens[i + 1].group.name
            qtile.current_window.togroup(group)

    @staticmethod
    def switch_screens(qtile):
        i = qtile.screens.index(qtile.current_screen)
        group = qtile.screens[i - 1].group
        qtile.current_screen.set_group(group)
