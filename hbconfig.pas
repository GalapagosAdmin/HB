unit hbconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Const
  Global=False;

  Function GetConfig(Const Section:UTF8String; Const key:UTF8String; Const DefaultValue:UTF8String):UTF8string;
  Procedure SetConfig(Const Section:UTF8String; Const Key:UTF8String; Const Value:UTF8String);

  Function GetConfigC(Const Section:UTF8String; Const key:UTF8String; Const DefaultValue:UTF8String):Char;

implementation

uses fileutil, INIFiles;

Var
  ConfigFilePath:UTF8String;
  ConfigFileDir:UTF8String;
  INI:TINIFile;


Function GetConfig(Const Section:UTF8String; Const key:UTF8String; Const DefaultValue:UTF8String):UTF8string;
  begin
    Result := INI.ReadString(Section,Key,DefaultValue);
  end;

Procedure SetConfig(Const Section:UTF8String; Const Key:UTF8String; Const Value:UTF8String);
  begin
    Ini.WriteString(Section, Key, Value);
  end;

Function GetConfigC(Const Section:UTF8String; Const key:UTF8String; Const DefaultValue:UTF8String):Char;
  begin
    Result := Copy(INI.ReadString(Section,Key,DefaultValue),1,1)[1];
  end;

initialization

 //function GetAppConfigDirUTF8(Global: Boolean): string;

  ConfigFileDir := GetAppConfigDirUTF8(Global);//GetAppConfigFileUTF8(Global); + '.conf';
  if not ForceDirectoriesUTF8(ConfigFileDir) then raise exception.Create('Error Creating Configuration directory.');
  ConfigFilePath := GetAppConfigFileUTF8(Global);
  Ini := TINIFile.Create(ConfigFilePath);

finalization
  Ini.UpdateFile;
  Ini.Free;

end.

