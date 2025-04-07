{
  description = "Cross-compilation environment for lnav targeting armv7l (cortex-a9)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        targetTriple = "armv7l-unknown-linux-gnueabihf";

        pkgs = import nixpkgs {
          inherit system;
          crossSystem = {
            config = targetTriple;
            gcc = {
              cpu = "cortex-a9";
              fpu = "neon";
              float-abi = "hard";
            };
          };
        };

        nativePkgs = import nixpkgs { inherit system; };
        lib = nixpkgs.lib;

        buildInputs = with pkgs; [
          ncurses
          readline
          zlib
          sqlite
          curl
          pcre2
          bzip2
          libarchive
          openssl
        ];

        nativeBuildInputs = with nativePkgs; [
          pkg-config
          autoconf
          automake
          libtool
          cmake
          file
        ];

        cppFlags = lib.concatStringsSep " " (map (pkg: "-I${pkg}/include") [
          pkgs.zlib.dev
          pkgs.ncurses.dev
          pkgs.pcre2.dev
          pkgs.readline.dev
        ]) + " -DPCRE2_CODE_UNIT_WIDTH=8";

        ldFlags = lib.concatStringsSep " " (map (pkg: "-L${pkg}/lib") [
          pkgs.zlib
          pkgs.ncurses.out
          pkgs.pcre2
          pkgs.readline.out
          pkgs.bzip2
          pkgs.openssl
        ]) + " -lreadline -ltinfo";

        pkgConfigPaths = lib.concatStringsSep ":" (map (pkg: "${pkg}/lib/pkgconfig") [
          pkgs.zlib.dev
          pkgs.ncurses.dev
          pkgs.pcre2.dev
          pkgs.readline.dev
          pkgs.sqlite.dev
        ]);

      in {
        devShell = pkgs.mkShell {
          packages = buildInputs;
          nativeBuildInputs = nativeBuildInputs;

          shellHook = ''
            echo "🔧 Cross-compiling lnav for ARM..."

            export CC=${pkgs.stdenv.cc.targetPrefix}gcc
            export CXX=${pkgs.stdenv.cc.targetPrefix}g++
            export AR=${pkgs.stdenv.cc.targetPrefix}ar
            export RANLIB=${pkgs.stdenv.cc.targetPrefix}ranlib
            export STRIP=${pkgs.stdenv.cc.targetPrefix}strip

            export PKG_CONFIG=${pkgs.pkg-config}/bin/pkg-config
            export PKG_CONFIG_PATH="${pkgConfigPaths}"
            export PKG_CONFIG_LIBDIR="$PKG_CONFIG_PATH"

            export CPPFLAGS="${cppFlags}"
            export LDFLAGS="${ldFlags}"

            echo "🛠 Generating build.sh..."
            echo "#!/usr/bin/env bash" > build.sh
            echo "set -e" >> build.sh
            echo >> build.sh
            echo "export CC=\"$CC\"" >> build.sh
            echo "export CXX=\"$CXX\"" >> build.sh
            echo "export AR=\"$AR\"" >> build.sh
            echo "export RANLIB=\"$RANLIB\"" >> build.sh
            echo "export STRIP=\"$STRIP\"" >> build.sh
            echo "export CPPFLAGS=\"$CPPFLAGS\"" >> build.sh
            echo "export LDFLAGS=\"$LDFLAGS\"" >> build.sh
            echo "export PKG_CONFIG_PATH=\"$PKG_CONFIG_PATH\"" >> build.sh
            echo "export PKG_CONFIG_LIBDIR=\"$PKG_CONFIG_LIBDIR\"" >> build.sh
            echo >> build.sh
            echo "export ac_cv_header_pcre2_h=yes" >> build.sh
            echo "export ac_cv_lib_pcre2_8_pcre2_compile_8=yes" >> build.sh
            echo "export ac_cv_lib_readline_readline=yes" >> build.sh
            echo "export ac_cv_header_readline_readline_h=yes" >> build.sh
            echo "export ac_cv_header_readline_h=yes" >> build.sh
            echo >> build.sh
            echo "$CC $CPPFLAGS -x c - -o /dev/null $LDFLAGS -lreadline <<< '#include <readline/readline.h>' \
  && echo '✅ Readline headers and libs detected' \
  || echo '❌ Readline detection failed'" >> build.sh
            echo >> build.sh
            echo "./autogen.sh" >> build.sh
            echo "./configure --host=${targetTriple} --build=${system}" >> build.sh
            echo "make -j\$(nproc)" >> build.sh

            chmod +x build.sh
            echo "✅ build.sh created. Run it with: ./build.sh"
          '';
        };
      });
}
