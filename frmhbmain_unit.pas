unit frmhbmain_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ActnList;

type

  { TFrmHBMain }

  TFrmHBMain = class(TForm)
    acRefreshDir: TAction;
    ActionList1: TActionList;
    lbDir: TListBox;
    sbRuleAdd: TSpeedButton;
    sbRuleDelete: TSpeedButton;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure acRefreshDirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbRuleAddClick(Sender: TObject);
    procedure sbRuleDeleteClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmHBMain: TFrmHBMain;

implementation

uses hbrule;

{$R *.lfm}

{ TFrmHBMain }

procedure TFrmHBMain.sbRuleAddClick(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
    begin
      DirectoryAdd(SelectDirectoryDialog1.FileName);
      acRefreshDir.Execute;
    end;
end;

procedure TFrmHBMain.sbRuleDeleteClick(Sender: TObject);
begin
  acRefreshDir.Execute;
end;

procedure TFrmHBMain.acRefreshDirExecute(Sender: TObject);
begin
  lbDir.Clear;
  ImportDirList(lbDir.Items);
end;

procedure TFrmHBMain.FormShow(Sender: TObject);
begin
  acRefreshDir.Execute;
end;

end.

