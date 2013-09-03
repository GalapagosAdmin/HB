program HBGUI;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, frmhbsettings_unit, hbrule, hbaction, hbconfig, frmhbmain_unit;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFrmHBSettings, FrmHBSettings);
  Application.CreateForm(TFrmHBMain, FrmHBMain);
  Application.Run;
end.

