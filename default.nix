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

    combinedAttrs = (defaultAttrs // attrs // (with pkgs.stdenv.lib; {
      #version = "0.1.0.0";
      #description = "⚙️  Use nix to manage your CLI tools, configuration dotfiles, and more";
      #homepage = "https://github.com/rpearce/mgmt";
      #license = licenses.bsd3.fullName;
      #maintainers = with maintainers; [ rpearce ];
      #platforms = platforms.unix;
    }));

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
