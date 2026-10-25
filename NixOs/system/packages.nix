{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki # Space Repetition System App (NixOS-managed)
    aws-vault # AWS secret keeping
    bluez # Bluetooth manager
    brightnessctl # Brightness control
    rofi # Sway launcher
    dmidecode # Tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    evince # PDF Viewer
    exfatprogs # EXTFat tool
    floorp-bin # Web Browser firefox-like
    gcc # C compiler
    gimp # Image Editor
    glibcLocales # Locale information for the GNU C Library
    gparted # Partition tool
    halloy # IRC Client
    jack2 # JACK audio connection kit, version 2 with jackdbus
    kanshi # Wailand equivalent for Autorandr
    gmetronome # Metronome
    libinput # Handles input devices in Wayland compositors and provides a generic X.Org input driver
    lilypond # Music Notation Language
    lshw # List hardware info
    mako # Notification system developed by swaywm maintainer
    nethogs # Small 'net top' tool, grouping bandwidth by process
    nettools
    nicotine-plus # Soulseek client
    parted # Partitioning tool
    pavucontrol # Pulseaudio control
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    proton-vpn # Client for Proton VPN
    purs-tidy # Purescript formatter
    psmisc
    awww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    usbutils # Tools for working with USB devices, such as lsusb
    vlc # Video palyer
    xrandr # Command line interface to X11 Resize, Rotate, and Reflect (RandR) extension
  ];
}
