# generated by zon2nix (https://github.com/nix-community/zon2nix)

{ linkFarm, fetchzip }:

linkFarm "zig-packages" [
  {
    name = "12209e0b868be4707dbf0e43bc730d7b0fa82a0d84ec089b1fe0222f4848022f40b2";
    path = fetchzip {
      url = "https://github.com/karlseguin/http.zig/archive/b731097ccb8f801e6c8711fa36000ed86c577bcc.tar.gz";
      hash = "sha256-+Sqp5WX6VlgviTP9KSINFtM0SJtvBy+AzybYmAIyb+A=";
    };
  }
]
