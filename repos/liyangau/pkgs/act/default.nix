{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "act";
  version = "0.2.43";

  src = fetchFromGitHub {
    owner = "nektos";
    repo = "act";
    rev = "v${version}";
    sha256 = "sha256-Le5jw1ezGNx4lurHucbJ+q9arXldnHjDlAO61w4p61U=";
  };

  vendorSha256 = "sha256-yQA84lBe85/NyG6GUa9gueLKw7Ei+3Hc3U9PmqGG8YA=";

  doCheck = false;

  ldflags = [ "-s" "-w" "-X main.version=${version}" ];

  meta = with lib; {
    description = "Run your GitHub Actions locally";
    homepage = "https://github.com/nektos/act";
    changelog = "https://github.com/nektos/act/releases/tag/v${version}";
    license = licenses.mit;
  };
}
