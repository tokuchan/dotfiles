{
  description = "Cross-compilation environment for lnav using external toolchain (arm-linux-gnueabihf-g++-14)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Runtime dependencies (headers/libs for cross target)
        buildInputs = with pkgs; [
          ncurses
          readline
          zlib
          sqlite
          curl
          pcre
          bzip2
          libarchive
          openssl
        ];

        # Build-time dependencies (on host)
        nativeBuildInputs = with pkgs; [
          pkg-config
          autoconf
          automake
          libtool
          cmake
          file
        ];

        # Path to your external cross toolchain
        toolchainPrefix = "/usr/bin/arm-linux-gnueabihf";
      in {
        devShell = pkgs.mkShell {
          packages = buildInputs;
          nativeBuildInputs = nativeBuildInputs;

          shellHook = ''
            echo "Using external toolchain at ${toolchainPrefix}"

            export CC=${toolchainPrefix}-gcc-14
            export CXX=${toolchainPrefix}-g++-14
            export AR=${toolchainPrefix}-ar
            export RANLIB=${toolchainPrefix}-ranlib
            export STRIP=${toolchainPrefix}-strip

            # These variables help pkg-config use the right library and header paths
            export PKG_CONFIG_PATH=${pkgs.ncurses.dev}/lib/pkgconfig:${pkgs.readline.dev}/lib/pkgconfig:${pkgs.sqlite.dev}/lib/pkgconfig
            export PKG_CONFIG_LIBDIR=$PKG_CONFIG_PATH

            export CONFIGURE_FLAGS="--host=arm-linux-gnueabihf"

            echo "Ready to cross-compile with: ./autogen.sh && ./configure $CONFIGURE_FLAGS && make"
          '';
        };
      });
}

