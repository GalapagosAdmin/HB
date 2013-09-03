unit hbrule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl;

type
 THBRule=record
   Name:UTF8String;
   Enabled:Boolean;   // Rule is Active
   SourceDirectory:UTF8String;
   ScopeType:Char;    // F=FilePattern, D=Modification Date,E=File Extension
   ScopeCondition:UTF8String; // File Pattern, etc.
   ActionType:Char;   // M=Move, D=Delete, R=Rename
   DestDirectory:UTF8String;  // Destination Directory in case of Move
 end;
 THBDirectory=record
   DisplayName:UTF8String;
   PhysicalName:UTF8String;
 end;

(*
operator := (r : THBDirectory) z : THBDirectory;
begin
  z.DisplayName:=r.DisplayName;
  z.PhysicalName:=r.PhysicalName;
end;
  *)

 //TLexemList = specialize TFPGList<THBDirectory>;


 THBRuleList=Array of THBRule;
 THBDirectoryList=Array of THBDirectory;

 Procedure DirectoryAdd(const Directory:UTF8String);
 // Populates an external stringlist with the list of directories
 Procedure ImportDirList(TheList:TStrings);

Var
  HBRuleList:THBRuleList;
  HBDirectoryList:THBDirectoryList;
  RuleCount:Integer;
//  DirectoryCount:Integer;
  SectionName:UTF8String;
  ThisRule:Integer;

implementation

uses
  hbconfig, fileutil;

Function DirectoryCount:Integer;
  begin
    DirectoryCount :=  Length(HBDirectoryList);
  end;

Procedure ImportDirList(TheList:TStrings);
  var
    ThisDir:Integer;
  begin
    TheList.Clear;
    for ThisDir := Low(HBDirectoryList) to High(HBDirectoryList) do
      begin
       TheList.Append(HBDirectoryList[ThisDir].DisplayName);
 //      TheList.ValueFromIndex[ThisDir] := IntToStr(ThisDir);
      end;
  end;

Procedure DirectoryAdd(const Directory:UTF8String);
  var
    CurrLen:Integer;
  begin
    CurrLen := DirectoryCount;
    SetLength(HBDirectoryList,CurrLen+1);
    // Using CurrLen below is not a bug, because the array is zero based
    HBDirectoryList[CurrLen].DisplayName:= ExtractFileNameOnly(Directory);
    HBDirectoryList[CurrLen].PhysicalName:=Directory;

  end;


Initialization
  RuleCount := 1;
  SetLength(HBRuleList,RuleCount);
  ThisRule := 0;
  SectionName := 'Rule' + IntToStr(ThisRule);
  HBRuleList[ThisRule].Name := GetConfig(SectionName, 'Name', 'Move MSI files from dowload to Drop.');
  HBRuleList[ThisRule].Enabled := True;
  HBRuleList[ThisRule].SourceDirectory := GetConfig(SectionName, 'SourceDirectory', 'C:\Users\nsilva\Downloads');
  HBRuleList[ThisRule].ScopeType := GetConfigC(SectionName, 'ScopeType', 'F');
  HBRuleList[ThisRule].ScopeCondition := GetConfig(SectionName, 'ScopeCondition', '*.msi');
  HBRuleList[ThisRule].ActionType := GetConfigC(SectionName, 'ActionType', 'M');
  HBRuleList[ThisRule].DestDirectory := GetConfig(SectionNAme, 'DestDirectory', 'C:\Users\nsilva\Documents\AeroFS\Drop\');

Finalization
 SetConfig(SectionName, 'Name', HBRuleList[ThisRule].Name);
 SetConfig(SectionName, 'SourceDirectory', HBRuleList[ThisRule].SourceDirectory);
 SetConfig(SectionName, 'ScopeType', HBRuleList[ThisRule].ScopeType);
 SetConfig(SectionName, 'ScopeCondition', HBRuleList[ThisRule].ScopeCondition);
 SetConfig(SectionName, 'ActionType', HBRuleList[ThisRule].ActionType);
 SetConfig(SectionName, 'DestDirectory', HBRuleList[ThisRule].DestDirectory);

end.

