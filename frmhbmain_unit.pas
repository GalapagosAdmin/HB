unit frmhbmain_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  StdCtrls, ExtCtrls, PopupNotifier, Menus;

type

  { TfrmHBMain }

  TfrmHBMain = class(TForm)
    acSearchRun: TAction;
    acExitApplication: TAction;
    ActionList1: TActionList;
    cbEnabled: TCheckBox;
    IdleTimer1: TIdleTimer;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupNotifier1: TPopupNotifier;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    TrayIcon1: TTrayIcon;
    procedure acExitApplicationExecute(Sender: TObject);
    procedure acSearchRunExecute(Sender: TObject);
    procedure cbEnabledChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    Procedure ShowBaloon(Const MessageText:UTF8String);
    procedure TrayIcon1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHBMain: TfrmHBMain;

implementation

{$R *.lfm}

{ TfrmHBMain }

(*
  var
  sl: TStringList;
  i: Integer;
begin
  sl := FindAllFiles('C:\Lazarus\Projects\search_test_dir', '*.pas', True);
*)


Procedure TfrmHBMain.ShowBaloon(Const MessageText:UTF8String);
  begin
    {$IFDEF WINDOWS}
      TrayIcon1.BalloonTitle:='HB';
      TrayIcon1.BalloonHint:=MessageText;
      TrayIcon1.Show;
      TrayIcon1.ShowBalloonHint;
    {$ELSE}
      PopupNotifier1.Title:='HB';
      PopupNotifier1.Text:= MessageText;
      PopupNotifier1.Show;
    {$ENDIF}
  end;

procedure TfrmHBMain.TrayIcon1Click(Sender: TObject);
begin
  frmHBMain.Show;
end;

procedure TfrmHBMain.acSearchRunExecute(Sender: TObject);
var
sl: TStringList;
i:longint;
//  FS:TFileSearcher;
Const
  TheDirectory='C:\Users\nsilva\Downloads'; // Should be read from config file
  TheNewDirectory='C:\Users\nsilva\Documents\AeroFS\Drop\';
  FileMask='*.msi';
var
  NewFullPath:UTF8String;
begin
  //  FS := TFileSearcher.Create;
  //  FS.OnFileFound := @SomeProcedure;    // Do a load of stuff with each file whenever the next line find a file
  //  FS.Search(TheDirectory, '*.*', True);
  //  FS.Free;

  sl := FindAllFiles(IncludeTrailingPathDelimiter(TheDirectory), filemask, True);
    try
     If sl.count > 0 then
       begin
 //        PopupNotifier1.Text := 'There are ' + IntToStr(sl.Count) + ' Matching file(s)';
         for i:=0 to sl.Count-1 do
           // Perform Action
           begin
           NewFullPath := IncludeTrailingPathDelimiter(TheNewDirectory) + ExtractFileName(sl.Strings[i]);
           RenameFile(sl.Strings[i], NewFullPath)
         //  ShowMessage('File'+IntToStr(i)+': ' + sl.Strings[i]);
           end;
         if sl.Count = 1 then
           ShowBaloon( ExtractFileName(sl.Strings[i]) + ' was moved to ' + TheNewDirectory  )
         else
         ShowBaloon( IntToStr(sl.Count) + ' files were moved to ' + TheNewDirectory );


       end;
  finally
    sl.Free;
  end;

end;

procedure TfrmHBMain.acExitApplicationExecute(Sender: TObject);
begin
  application.Terminate;
  self.close;
end;

procedure TfrmHBMain.cbEnabledChange(Sender: TObject);
begin
  IdleTimer1.Enabled :=  cbEnabled.Checked;
end;

procedure TfrmHBMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TfrmHBMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := False;
  self.Hide;
end;

procedure TfrmHBMain.FormCreate(Sender: TObject);
begin

end;

procedure TfrmHBMain.IdleTimer1Timer(Sender: TObject);
begin
  acSearchRun.Execute;
end;

procedure TfrmHBMain.MenuItem1Click(Sender: TObject);
begin
  acExitApplication.Execute;
end;

end.

