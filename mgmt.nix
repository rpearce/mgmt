{ stdenv }:

stdenv.mkDerivation rec {
  pname = "mgmt";
  version = "0.1.0.0";

  builder = ./builder.sh;

  meta = with stdenv.lib; {
    description = "todo...";
    #maintainers = [];
    platforms = platforms.unix;
    license = licenses.bsd3;
  };
}
