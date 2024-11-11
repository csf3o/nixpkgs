{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "fansly-downloader";
  version = "0.9.7";
  format = "other";

  src = fetchFromGitHub {
    owner = "prof79";
    repo = "fansly-downloader-ng";
    rev = "refs/tags/v${version}";
    hash = "sha256-e+iRC5OAlnA9ec9F7M4zd6iBIHrfo0ljXP+8P7dlhZo=";
  };

  propagatedBuildInputs = with python3Packages; [
    imagehash
    loguru
    m3u8
    memory-profiler
    pillow
    ffmpeg-python
    plyvel
    psutil
    python-dateutil
    requests
    rich
    strenum
    websockets
    setuptools
  ];

  doCheck = false;

  installPhase = ''
    mkdir -p $out/${python3Packages.python.sitePackages}
    mv {api,config,download,errors,fileio,media,pathio,textio,updater,utils} $out/${python3Packages.python.sitePackages}

    mkdir -p $out/bin
    install -m0755 fansly_downloader_ng.py $out/bin/fansly_downloader_ng
  '';

  meta = with lib; {
    description = "fansly scraper";
    license = licenses.gpl3Only;
    homepage = "https://github.com/prof79/fansly-downloader-ng";
    maintainers = with maintainers; [ dandellion ];
  };
}

