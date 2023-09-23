{pkgs, ...}: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = true;
  };
}
