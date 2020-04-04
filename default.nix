pkgs: attrs:
  with pkgs;
  let
    defaultAttrs = {
      args = [ ./builder.sh ];
      baseInputs = [ coreutils findutils ];
      buildInputs = [ ];
      builder = "${bash}/bin/bash";
      dotfiles = { };
      setup = ./setup.sh;
      system = builtins.currentSystem;
    };

    combinedAttrs = (defaultAttrs // attrs);

    finalAttrs = (combinedAttrs // {
      dotfiles = lib.attrsets.mapAttrsToList
        (name: value: name + "=" + builtins.path {
          path = value;
          name = lib.strings.sanitizeDerivationName "mgmt_${name}";
        })
        combinedAttrs.dotfiles;
    });
  in
    derivation finalAttrs
