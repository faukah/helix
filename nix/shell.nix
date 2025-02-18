{
  mkShell,
  lld_13,
  cargo-flamegraph,
  rust-analyzer,
  cargo-tarpaulin,
  lldb,
  CoreFoundation,
  checks,
  lib,
  stdenv,
  rustFlagsEnv,
}:
mkShell {
  inputsFrom = builtins.attrValues checks;
  packages =
    [lld_13 cargo-flamegraph rust-analyzer]
    ++ (lib.optional (stdenv.isx86_64 && stdenv.isLinux) cargo-tarpaulin)
    ++ (lib.optional stdenv.isLinux lldb)
    ++ (lib.optional stdenv.isDarwin CoreFoundation);
  shellHook = ''
    export HELIX_RUNTIME="$PWD/runtime"
    export RUST_BACKTRACE="1"
    export RUSTFLAGS="''${RUSTFLAGS:-""} ${rustFlagsEnv}"
  '';
}
