{ config, ... }:

{
  home.file.".xprofile".text = ''
    # Add here different display resolutions using xrandr
    xrandr --output "virtual1" --mode 1920x1200 #Virual Machine resolution

    # Services
    systemctl --user start udiskie.service

    # Workaround from here: https://github.com/NixOS/nixpkgs/issues/119513#issuecomment-873506384
    if [ -z $_XPROFILE_SOURCED ]; then
      export _XPROFILE_SOURCED=1

      # Create known directory if doesn't exists
      mkdir -p ${config.home.homeDirectory}/.local/share/applications ${config.home.homeDirectory}/workspace ${config.home.homeDirectory}/temp ${config.home.homeDirectory}/docs

    fi
  '';
}
