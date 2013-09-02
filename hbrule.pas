unit hbrule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

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
 THBRuleList=Array of THBRule;


Var
  HBRuleList:THBRuleList;
  SectionName:UTF8String;
  ThisRule:Integer;

implementation

uses
  hbconfig;

Initialization
  SetLength(HBRuleList,1);
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

