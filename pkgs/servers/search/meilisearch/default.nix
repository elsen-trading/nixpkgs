{ stdenv
, lib
, rustPlatform
, fetchFromGitHub
, Security
, DiskArbitration
, Foundation
}:

let version = "0.25.2";
in
rustPlatform.buildRustPackage {
  pname = "meilisearch";
  inherit version;
  src = fetchFromGitHub {
    owner = "meilisearch";
    repo = "MeiliSearch";
    rev = "v${version}";
    sha256 = "sha256-KRJ9GWIfafAGS6JVBcTzpC9QR/eZwQDDlOs8fTkv9Kc=";
  };
  doCheck = false;
  cargoPatches = [
    # feature mini-dashboard tries to download a file from the internet
    # feature analitycs should be opt-in
    ./remove-default-feature.patch
  ];
  cargoSha256 = "sha256-wfklYT2ddVjuEve82A8Z1P/l2qetLroA56L2VbjEk2Q=";
  buildInputs = lib.optionals stdenv.isDarwin [ Security DiskArbitration Foundation ];
  meta = with lib; {
    description = "Powerful, fast, and an easy to use search engine ";
    homepage = "https://docs.meilisearch.com/";
    license = licenses.mit;
    maintainers = with maintainers; [ happysalada ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
