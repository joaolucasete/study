{ pkgs, ... }:

let
  inherit (pkgs)
    dotnetCorePackages
    fetchzip
    stdenv
    writeScript;

  dotnet = dotnetCorePackages.sdk_7_0;
  arch = "net7.0";

  binScript = src: arch: pname:
    writeScript pname
      "DOTNET_ROOT=${dotnet} ${dotnet}/dotnet ${src}/tools/${arch}/any/${pname}.dll";
in
stdenv.mkDerivation rec {
  pname = "fsautocomplete";
  version = "0.58.4";

  src = fetchzip {
    url = "https://www.nuget.org/api/v2/package/${pname}/${version}";
    sha256 = "sha256-PLO24n2zcRPWR6/ihAnCT2Y8kBH9WCHhlkOqc7xEujg=";
    extension = "zip";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstallPhase

    mkdir -p $out/bin

    cp -r ${binScript src arch pname} $out/bin/${pname}

    runHook postInstallPhase
  '';
}
