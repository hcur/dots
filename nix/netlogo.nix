# NetLogo 7.0.4 packaged
# based on default.nix for v6.4.0, hacked together by myself and claude

{
  lib,
  stdenv,
  fetchurl,
  jre,
  makeBinaryWrapper,
  copyDesktopItems,
  wrapGAppsHook3,
  makeDesktopItem,
  gtk3,
  glib,
  libXxf86vm,
  libXtst,
  libXrender,
  libXi,
  libXext,
  libGL,
  alsa-lib,
}:

let
  desktopicon = fetchurl {
    name = "netlogo.png";
    url = "https://netlogoweb.org/assets/images/desktopicon.png";
    hash = "sha256-KCsXt1dnBNUEBKvusp5JpKOSH7u9gSwaUvvTMDKkg8Q=";
  };

  nativeLibs = [
    gtk3
    glib
    libXxf86vm
    libXtst
    libXrender
    libXi
    libXext
    libGL
    alsa-lib
  ];
in
stdenv.mkDerivation (finalAttrs: {
  pname = "netlogo";
  version = "7.0.4";

  src = fetchurl {
    url = "https://downloads.netlogo.org/7.0.4/NetLogo-7.0.4-64.tgz";
    hash = "sha256-dWNrhGnqSZXsBRz7yR5SXxcb6EuPlZuGvAgPv/cC37w=";
  };

  nativeBuildInputs = [
    makeBinaryWrapper
    copyDesktopItems
    wrapGAppsHook3
  ];

  buildInputs = nativeLibs;

  desktopItems = [
    (makeDesktopItem {
      name = "netlogo";
      exec = "netlogo";
      icon = "netlogo";
      comment = "A multi-agent programmable modeling environment";
      desktopName = "NetLogo";
      categories = [ "Science" ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/netlogo
    cp -r ./ $out/opt/netlogo

    # launcher with `cd` is required b/c otherwise the model library isn't usable
    makeWrapper ${jre}/bin/java $out/bin/netlogo \
      --chdir $out/opt/netlogo/lib/app \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath nativeLibs} \
      --add-flags "-Dnetlogo.extensions.dir=$out/opt/netlogo/extensions" \
      --add-flags "-Dnetlogo.models.dir=$out/opt/netlogo/models" \
      --add-flags "-Dnetlogo.docs.dir=$out/opt/netlogo/docs" \
      --add-flags "-Djava.library.path=$out/opt/netlogo/natives/linux-amd64" \
      --add-flags "-jar netlogo-${finalAttrs.version}.jar"

    install -Dm644 ${desktopicon} $out/share/icons/hicolor/256x256/apps/netlogo.png

    runHook postInstall
  '';

  meta = {
    description = "Multi-agent programmable modeling environment";
    mainProgram = "netlogo";
    longDescription = ''
      NetLogo is a multi-agent programmable modeling environment. It is used by
      many tens of thousands of students, teachers and researchers worldwide.
    '';
    homepage = "https://www.netlogo.org/";
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.dpaetzel ];
    platforms = lib.platforms.linux;
  };
})