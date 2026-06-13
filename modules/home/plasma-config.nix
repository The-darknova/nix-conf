{ config, pkgs, lib, ... }: {
  programs.plasma = {
    enable = true;
    shortcuts = {
      ActivityManager = {
        switch-to-activity-0697ce4f-696c-43d6-ac6b-dfbbbc0a1939 = [ ];
        switch-to-activity-a3f4700c-f02e-4f64-ad93-6ead5629664e = [ ];
      };
      "KDE Keyboard Layout Switcher" = {
        "Switch keyboard layout to English (US)" = [ ];
        "Switch keyboard layout to French" = [ ];
        "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "Switch to Next Keyboard Layout" = "Meta+Alt+K";
      };
      kaccess."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      kmix = {
        decrease_microphone_volume = "Microphone Volume Down";
        decrease_volume = "Volume Down";
        decrease_volume_small = "Shift+Volume Down";
        increase_microphone_volume = "Microphone Volume Up";
        increase_volume = "Volume Up";
        increase_volume_small = "Shift+Volume Up";
        mic_mute = [
          "Microphone Mute"
          "Meta+Volume Mute"
        ];
        mute = "Volume Mute";
      };
      ksmserver = {
        "Halt Without Confirmation" = [ ];
        "Lock Session" = [
          "Meta+L"
          "Screensaver"
        ];
        "Log Out" = "Ctrl+Alt+Del";
        "Log Out Without Confirmation" = [ ];
        LogOut = [ ];
        Reboot = [ ];
        "Reboot Without Confirmation" = [ ];
        "Shut Down" = [ ];
      };
      kwin = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        ClearLastMouseMark = "Meta+Shift+F12";
        ClearMouseMarks = "Meta+Shift+F11";
        Cube = "Meta+C";
        "Cycle Overview" = [ ];
        "Cycle Overview Opposite" = [ ];
        "Decrease Opacity" = "Meta+Ctrl+PgDown";
        "Edit Tiles" = "Meta+T";
        Expose = [
          "Meta+F9"
          "Ctrl+F9"
        ];
        ExposeAll = [
          "Meta+F10"
          "Launch (C)"
          "Ctrl+F10"
        ];
        ExposeClass = [
          "Meta+F7"
          "Ctrl+F7"
        ];
        ExposeClassCurrentDesktop = [ ];
        "Grid View" = "Meta+G";
        "Increase Opacity" = "Meta+Ctrl+PgUp";
        "Kill Window" = "Meta+Ctrl+Esc";
        "Move Tablet to Next LogicalOutput" = [ ];
        "Move Tablet to Next Output" = [ ];
        MoveMouseToCenter = "Meta+F6";
        MoveMouseToFocus = "Meta+F5";
        MoveZoomDown = [ ];
        MoveZoomLeft = [ ];
        MoveZoomRight = [ ];
        MoveZoomUp = [ ];
        Overview = "Meta+W";
        "Setup Window Shortcut" = [ ];
        "Show Desktop" = "Meta+D";
        "Switch One Desktop Down" = [
          "Meta+Ctrl+Down"
          "Ctrl+Alt+Down"
        ];
        "Switch One Desktop Up" = [
          "Ctrl+Alt+Up"
          "Meta+Ctrl+Up"
        ];
        "Switch One Desktop to the Left" = [
          "Ctrl+Alt+Left"
          "Meta+Ctrl+Left"
        ];
        "Switch One Desktop to the Right" = [
          "Meta+Ctrl+Right"
          "Ctrl+Alt+Right"
        ];
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch to Desktop 1" = "Ctrl+F1";
        "Switch to Desktop 10" = [ ];
        "Switch to Desktop 11" = [ ];
        "Switch to Desktop 12" = [ ];
        "Switch to Desktop 13" = [ ];
        "Switch to Desktop 14" = [ ];
        "Switch to Desktop 15" = [ ];
        "Switch to Desktop 16" = [ ];
        "Switch to Desktop 17" = [ ];
        "Switch to Desktop 18" = [ ];
        "Switch to Desktop 19" = [ ];
        "Switch to Desktop 2" = "Ctrl+F2";
        "Switch to Desktop 20" = [ ];
        "Switch to Desktop 21" = [ ];
        "Switch to Desktop 22" = [ ];
        "Switch to Desktop 23" = [ ];
        "Switch to Desktop 24" = [ ];
        "Switch to Desktop 25" = [ ];
        "Switch to Desktop 3" = "Ctrl+F3";
        "Switch to Desktop 4" = "Ctrl+F4";
        "Switch to Desktop 5" = "Ctrl+F5";
        "Switch to Desktop 6" = "Ctrl+F6";
        "Switch to Desktop 7" = [ ];
        "Switch to Desktop 8" = [ ];
        "Switch to Desktop 9" = [ ];
        "Switch to Next Desktop" = [ ];
        "Switch to Next Screen" = [ ];
        "Switch to Previous Desktop" = [ ];
        "Switch to Previous Screen" = [ ];
        "Switch to Screen 0" = [ ];
        "Switch to Screen 1" = [ ];
        "Switch to Screen 2" = [ ];
        "Switch to Screen 3" = [ ];
        "Switch to Screen 4" = [ ];
        "Switch to Screen 5" = [ ];
        "Switch to Screen 6" = [ ];
        "Switch to Screen 7" = [ ];
        "Switch to Screen Above" = [ ];
        "Switch to Screen Below" = [ ];
        "Switch to Screen to the Left" = [ ];
        "Switch to Screen to the Right" = [ ];
        "Toggle Night Color" = [ ];
        "Toggle Window Raise/Lower" = [ ];
        ToggleMouseClick = "Meta+*";
        TrackMouse = [ ];
        "Walk Through Windows" = [
          "Meta+Tab"
          "Alt+Tab"
        ];
        "Walk Through Windows (Reverse)" = [
          "Meta+Shift+Tab"
          "Alt+Shift+Tab"
        ];
        "Walk Through Windows Alternative" = [ ];
        "Walk Through Windows Alternative (Reverse)" = [ ];
        "Walk Through Windows of Current Application" = [
          "Meta+`"
          "Alt+`"
        ];
        "Walk Through Windows of Current Application (Reverse)" = [
          "Meta+~"
          "Alt+~"
        ];
        "Walk Through Windows of Current Application Alternative" = [ ];
        "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "Window Above Other Windows" = [ ];
        "Window Below Other Windows" = [ ];
        "Window Close" = "Alt+F4";
        "Window Custom Quick Tile Bottom" = [ ];
        "Window Custom Quick Tile Left" = [ ];
        "Window Custom Quick Tile Right" = [ ];
        "Window Custom Quick Tile Top" = [ ];
        "Window Fullscreen" = [ ];
        "Window Grow Horizontal" = [ ];
        "Window Grow Vertical" = [ ];
        "Window Lower" = [ ];
        "Window Maximize" = "Meta+PgUp";
        "Window Maximize Horizontal" = [ ];
        "Window Maximize Vertical" = [ ];
        "Window Minimize" = "Meta+PgDown";
        "Window Move" = [ ];
        "Window Move Center" = [ ];
        "Window No Border" = [ ];
        "Window On All Desktops" = [ ];
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "Window One Screen Down" = [ ];
        "Window One Screen Up" = [ ];
        "Window One Screen to the Left" = [ ];
        "Window One Screen to the Right" = [ ];
        "Window Operations Menu" = "Alt+F3";
        "Window Pack Down" = [ ];
        "Window Pack Left" = [ ];
        "Window Pack Right" = [ ];
        "Window Pack Up" = [ ];
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];
        "Window Raise" = [ ];
        "Window Resize" = [ ];
        "Window Shade" = [ ];
        "Window Shrink Horizontal" = [ ];
        "Window Shrink Vertical" = [ ];
        "Window to Desktop 1" = [ ];
        "Window to Desktop 10" = [ ];
        "Window to Desktop 11" = [ ];
        "Window to Desktop 12" = [ ];
        "Window to Desktop 13" = [ ];
        "Window to Desktop 14" = [ ];
        "Window to Desktop 15" = [ ];
        "Window to Desktop 16" = [ ];
        "Window to Desktop 17" = [ ];
        "Window to Desktop 18" = [ ];
        "Window to Desktop 19" = [ ];
        "Window to Desktop 2" = [ ];
        "Window to Desktop 20" = [ ];
        "Window to Desktop 21" = [ ];
        "Window to Desktop 22" = [ ];
        "Window to Desktop 23" = [ ];
        "Window to Desktop 24" = [ ];
        "Window to Desktop 25" = [ ];
        "Window to Desktop 3" = [ ];
        "Window to Desktop 4" = [ ];
        "Window to Desktop 5" = [ ];
        "Window to Desktop 6" = [ ];
        "Window to Desktop 7" = [ ];
        "Window to Desktop 8" = [ ];
        "Window to Desktop 9" = [ ];
        "Window to Next Desktop" = [ ];
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Desktop" = [ ];
        "Window to Previous Screen" = "Meta+Shift+Left";
        "Window to Screen 0" = "Meta+Ctrl+0";
        "Window to Screen 1" = "Meta+Ctrl+1";
        "Window to Screen 2" = "Meta+Ctrl+2";
        "Window to Screen 3" = "Meta+Ctrl+3";
        "Window to Screen 4" = "Meta+Ctrl+4";
        "Window to Screen 5" = "Meta+Ctrl+5";
        "Window to Screen 6" = "Meta+Ctrl+6";
        "Window to Screen 7" = "Meta+Ctrl+7";
        disableInputCapture = "Meta+Shift+Esc";
        view_actual_size = "Meta+0";
        view_zoom_in = [
          "Meta++"
          "Meta+="
        ];
        view_zoom_out = "Meta+-";
      };
      mediacontrol = {
        mediavolumedown = [ ];
        mediavolumeup = [ ];
        nextmedia = "Media Next";
        pausemedia = "Media Pause";
        playmedia = [ ];
        playpausemedia = "Media Play";
        previousmedia = "Media Previous";
        seekbackwardmedia = "Media Rewind";
        seekbackwardmedialong = [ ];
        seekforwardmedia = "Media Fast Forward";
        seekforwardmedialong = [ ];
        stopmedia = "Media Stop";
      };
      org_kde_powerdevil = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        Hibernate = "Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        PowerDown = "Power Down";
        PowerOff = "Power Off";
        Sleep = "Sleep";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "Turn Off Screen" = "Alt+0";
        powerProfile = [
          "Battery"
          "Meta+B"
        ];
      };
      plasmashell = {
        "Slideshow Wallpaper Next Image" = [ ];
        "activate application launcher" = [
          "Meta"
          "Alt+F1"
        ];
        "activate task manager entry 1" = "Meta+1";
        "activate task manager entry 10" = [ ];
        "activate task manager entry 2" = "Meta+2";
        "activate task manager entry 3" = "Meta+3";
        "activate task manager entry 4" = "Meta+4";
        "activate task manager entry 5" = "Meta+5";
        "activate task manager entry 6" = "Meta+6";
        "activate task manager entry 7" = "Meta+7";
        "activate task manager entry 8" = "Meta+8";
        "activate task manager entry 9" = "Meta+9";
        clear-history = [ ];
        clipboard_action = "Meta+Ctrl+X";
        cycle-panels = "Meta+Alt+P";
        cycleNextAction = [ ];
        cyclePrevAction = [ ];
        edit_clipboard = [ ];
        "manage activities" = "Meta+Q";
        "next activity" = "Meta+A";
        "previous activity" = "Meta+Shift+A";
        repeat_action = [ ];
        "show dashboard" = "Ctrl+F12";
        show-barcode = [ ];
        show-on-mouse-pos = "Meta+V";
        "switch to next activity" = [ ];
        "switch to previous activity" = [ ];
        "toggle do not disturb" = [ ];
      };
      "services/org.kde.plasma-systemmonitor.desktop"._launch = [
        "Meta+Esc"
        "Ctrl+Shift+Esc"
      ];
      "services/org.kde.spectacle.desktop" = {
        CurrentMonitorScreenShot = "Meta+Shift+M";
        FullScreenScreenShot = [
          "Meta+Shift+D"
          "Shift+Print"
        ];
        OpenWithoutScreenshot = [ ];
        RectangularRegionScreenShot = [
          "Meta+Shift+Print"
          "Meta+Shift+S"
        ];
        WindowUnderCursorScreenShot = [
          "Meta+Ctrl+Print"
          "Meta+Shift+C"
        ];
        _launch = "Print";
      };
    };
    configFile = {
      dolphinrc = {
        General.ViewPropsTimestamp = "2026,4,15,19,5,45.108";
        "KFileDialog Settings" = {
          "Places Icons Auto-resize" = false;
          "Places Icons Static Size" = 22;
        };
        PreviewSettings.Plugins = "audiothumbnail,comicbookthumbnail,cursorthumbnail,directorythumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,opendocumentthumbnail,svgthumbnail,windowsexethumbnail,windowsimagethumbnail,fontthumbnail,blenderthumbnail,gsthumbnail,mobithumbnail,rawthumbnail,ffmpegthumbs,gsf-office";
        VersionControl.enabledPlugins = "Git";
      };
      kcminputrc = {
        "Libinput/1739/52907/SYNA30FE:00 06CB:CEAB Touchpad" = {
          NaturalScroll = true;
          PointerAcceleration = 0.400;
        };
        Mouse.cursorTheme = "dotilt-black";
      };
      kdeglobals = {
        General.LastUsedCustomAccentColor = "233,58,154";
        Icons.Theme = "Colorful-Dark-Icons";
        KDE = {
          AnimationDurationFactor = 0.5;
          ShowDeleteCommand = true;
          contrast = 4;
          frameContrast = 0.2;
          widgetStyle = "Darkly";
        };
        "KFileDialog Settings" = {
          "Allow Expansion" = false;
          "Automatically select filename extension" = true;
          "Breadcrumb Navigation" = false;
          "Decoration position" = 2;
          "Show Full Path" = false;
          "Show Inline Previews" = true;
          "Show Preview" = false;
          "Show Speedbar" = true;
          "Show hidden files" = false;
          "Sort by" = "Name";
          "Sort directories first" = true;
          "Sort hidden files last" = false;
          "Sort reversed" = false;
          "Speedbar Width" = 194;
          "View Style" = "DetailTree";
        };
        KScreen = {
          ScreenScaleFactors = "eDP-1=1;DP-1=1;";
          XwaylandClientsScale = false;
        };
        PreviewSettings = {
          EnableRemoteFolderThumbnail = false;
          MaximumRemoteSize = 0;
        };
        WM = {
          activeBackground = "44,55,70";
          activeBlend = "44,55,70";
          activeForeground = "255,255,255";
          inactiveBackground = "44,55,70";
          inactiveBlend = "44,55,70";
          inactiveForeground = "181,182,182";
        };
      };
      kwinrc = {
        Desktops = {
          Id_1 = "33fe9aca-d813-425b-a93a-f116bf568941";
          Id_2 = "e106231a-93b0-4c14-b4fc-3d3a431fb8d1";
          Id_3 = "8eca412d-cbf2-4f6f-af60-ade8a52e8c3c";
          Id_4 = "1b500c9a-64d0-4797-ae8b-583fa04c61b7";
          Number = 4;
          Rows = 2;
        };
        Effect-blur = {
          BlurStrength = 6;
          NoiseStrength = 1;
          Saturation = 224;
        };
        Effect-glide = {
          InDistance = 50;
          InRotationAngle = 10;
        };
        Effect-magiclamp.AnimationDuration = 350;
        Effect-mousemark.Color = "255,192,128";
        Effect-translucency.MoveResize = 70;
        Effect-wobblywindows = {
          Drag = 85;
          Stiffness = 10;
          WobblynessLevel = 1;
        };
        Plugins = {
          blurEnabled = true;
          cubeEnabled = true;
          desktopchangeosdEnabled = true;
          magiclampEnabled = true;
          mouseclickEnabled = true;
          mousemarkEnabled = true;
          squashEnabled = false;
          trackmouseEnabled = true;
          translucencyEnabled = true;
          wobblywindowsEnabled = true;
        };
        TabBox.LayoutName = "coverswitch";
        "Tiling/0219274b-f9e5-4581-aba2-5a4a1180e59e/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/0219274b-f9e5-4581-aba2-5a4a1180e59e/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/0cbf0b95-1e49-4c6b-90a6-652eefabfd76/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/0cbf0b95-1e49-4c6b-90a6-652eefabfd76/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/0b26142a-083d-4e54-9af1-e840461c8dbd" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/5a93c65d-4d3c-4db9-a632-2d508e331885" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/7892a641-8c7d-46b3-a908-c8aa99ae4386" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/857f0fe4-69bc-42df-8654-d8fce3fb3192" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/c1ee67b5-7f3e-4f52-89cb-39477f060378" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/c24ef92e-a683-41dc-83bb-a6d722ce8724" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/cf0ff43c-6787-4b72-ac4c-b8341d2e88a7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/1b500c9a-64d0-4797-ae8b-583fa04c61b7/f505dbeb-ee33-4127-bce7-cf1d4659cc1a" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/0b26142a-083d-4e54-9af1-e840461c8dbd" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/5a93c65d-4d3c-4db9-a632-2d508e331885" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/7892a641-8c7d-46b3-a908-c8aa99ae4386" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/857f0fe4-69bc-42df-8654-d8fce3fb3192" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/c1ee67b5-7f3e-4f52-89cb-39477f060378" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/c24ef92e-a683-41dc-83bb-a6d722ce8724" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/cf0ff43c-6787-4b72-ac4c-b8341d2e88a7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/33fe9aca-d813-425b-a93a-f116bf568941/f505dbeb-ee33-4127-bce7-cf1d4659cc1a" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/72746c49-4d08-4b66-be71-c4bc8bec73c2/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/72746c49-4d08-4b66-be71-c4bc8bec73c2/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/0b26142a-083d-4e54-9af1-e840461c8dbd" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/5a93c65d-4d3c-4db9-a632-2d508e331885" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/7892a641-8c7d-46b3-a908-c8aa99ae4386" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/857f0fe4-69bc-42df-8654-d8fce3fb3192" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/c1ee67b5-7f3e-4f52-89cb-39477f060378" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/c24ef92e-a683-41dc-83bb-a6d722ce8724" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/cf0ff43c-6787-4b72-ac4c-b8341d2e88a7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8eca412d-cbf2-4f6f-af60-ade8a52e8c3c/f505dbeb-ee33-4127-bce7-cf1d4659cc1a" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/0b26142a-083d-4e54-9af1-e840461c8dbd" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/19e0b974-e471-4853-8ce5-4cd385617a49" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/5a93c65d-4d3c-4db9-a632-2d508e331885" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/7892a641-8c7d-46b3-a908-c8aa99ae4386" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/857f0fe4-69bc-42df-8654-d8fce3fb3192" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/bd2d04e4-cc71-453c-9a25-93d7bf8a3253" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/c1ee67b5-7f3e-4f52-89cb-39477f060378" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/c24ef92e-a683-41dc-83bb-a6d722ce8724" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/cf0ff43c-6787-4b72-ac4c-b8341d2e88a7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/e106231a-93b0-4c14-b4fc-3d3a431fb8d1/f505dbeb-ee33-4127-bce7-cf1d4659cc1a" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "org.kde.kdecoration2" = {
          ButtonsOnLeft = "XAI_FS";
          ButtonsOnRight = "EHM";
          theme = "Darkly";
        };
      };
    };
    dataFile = {

    };
  };
}
