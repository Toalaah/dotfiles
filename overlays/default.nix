{...}: (
  final: prev: let
    customPkgs = import ../pkgs {pkgs = final;};
  in
    # custom package declarations
    customPkgs
    # any other overlays go here
    // {
      mpv = prev.mpv.override {
        scripts = with prev.mpvScripts; [
          # sponsorblock
          quality-menu
        ];
      };
    }
)
