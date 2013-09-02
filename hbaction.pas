unit hbaction;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

// Source = Absolute directory including file name
// Dest = Absolute destination path only. (No file name)
Procedure MoveFile(Const SourceFullPath:UTF8String; DestDir:UTF8String);


implementation


Procedure MoveFile(Const SourceFullPath:UTF8String; DestDir:UTF8String);
  var
    DestFullPath:UTF8String;
  begin
    DestFullPath := IncludeTrailingPathDelimiter(DestDir) + ExtractFileName(SourceFullPath);
    RenameFile(SourceFullPath, DestFullPath)
  end;

end.

