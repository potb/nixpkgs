{ stdenv, fetchurl, cmake, qt4, libgadu, libXScrnSaver, libsndfile, libX11,
  alsaLib, aspell, libidn, qca2, phonon }:

stdenv.mkDerivation {

  name = "kadu-0.10.0";

  src = fetchurl {
    url = http://www.kadu.net/download/stable/kadu-0.10.0.tar.bz2;
    sha256 = "039dx8y6vzqmv86prk1srmi7fvxlrbisyd6rcfs0gv497bfi1995";
  };

  buildInputs = [ cmake qt4 libgadu libXScrnSaver libsndfile libX11 alsaLib aspell libidn qca2 phonon
  ];

  configureFlags = "CPPFLAGS=-DQT_NO_DEBUG";

  cmakeFlags = "-DENABLE_AUTODOWNLOAD=OFF -DBUILD_DESCRIPTION='NixOS' -DCMAKE_BUILD_TYPE=Release";

  prePatch = ''
    patchShebangs .
  '';

  # because I was not able to get those working
  patches = [ ./disable_encryption_plugins.patch ];

  NIX_LDFLAGS="-lX11";

  meta = {
    description = "An instant-messenger client for the gadu-gadu network (most popular polish IM network)";
    homepage = http://www.kadu.net/w/English:Main_Page;
    license = "GPLv2";
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.piotr ];
  };
}
