{ stdenv, desktop ? false, libX11, alsaLib }:

stdenv.mkDerivation {
  name = "slstatus-HEAD";

  src = builtins.filterSource
    (path: type: (toString path) != (toString ./.git)) ./.;

  buildInputs = [ libX11 alsaLib ];

  prePatch = ''
    substituteInPlace config.mk --replace '/usr/local' $out
  '';

  patch = if desktop then [ ./desktop.patch ] else [];

  meta = with stdenv.lib; {
    description = "Suckless statusbar for window managers using WM_NAME or stdin";
    homepage = https://git.drkhsh.at/slstatus/;
    license = licenses.isc;
    platforms = platforms.all;
  };
}
