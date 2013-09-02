unit frmhbmain_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  StdCtrls, ExtCtrls, PopupNotifier, Menus, Buttons;

type

  { TfrmHBMain }

  TfrmHBMain = class(TForm)
    acSearchRun: TAction;
    acExitApplication: TAction;
    Action1: TAction;
    acPopupTimerHide: TAction;
    ActionList1: TActionList;
    bbNotificationTest: TBitBtn;
    cbEnabled: TCheckBox;
    ScanTimer: TIdleTimer;
    pnTimer: TIdleTimer;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupNotifier1: TPopupNotifier;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    TrayIcon1: TTrayIcon;
    procedure acExitApplicationExecute(Sender: TObject);
    procedure acPopupTimerHideExecute(Sender: TObject);
    procedure acSearchRunExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure bbNotificationTestClick(Sender: TObject);
    procedure cbEnabledChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure ScanTimerTimer(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure pnTimerTimer(Sender: TObject);
    Procedure ShowBalloon(Const MessageText:UTF8String);
    procedure TrayIcon1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHBMain: TfrmHBMain;

implementation

uses hbrule, hbaction;

{$R *.lfm}

{ TfrmHBMain }

(*
  var
  sl: TStringList;
  i: Integer;
begin
  sl := FindAllFiles('C:\Lazarus\Projects\search_test_dir', '*.pas', True);
*)


Procedure TfrmHBMain.ShowBalloon(Const MessageText:UTF8String);
  begin
    {$IFDEF XWINDOWS}
      TrayIcon1.BalloonTitle:='HB';
      TrayIcon1.Hint:='HB';
      TrayIcon1.BalloonHint:=MessageText;
 //     TrayIcon1.Show;
      TrayIcon1.ShowBalloonHint;
    {$ELSE}
      PopupNotifier1.Title:='HB';
      PopupNotifier1.Text:= MessageText;
      PNTimer.Enabled:=True;
      PopupNotifier1.Show;
    {$ENDIF}
  end;

procedure TfrmHBMain.TrayIcon1Click(Sender: TObject);
begin
  frmHBMain.Show;
end;

procedure TfrmHBMain.acSearchRunExecute(Sender: TObject);
Const
  RuleNumber=0;
var
sl: TStringList;
i:longint;
//  FS:TFileSearcher;
//Const
//  TheSourceDirectory='C:\Users\nsilva\Downloads'; // Should be read from config file
//  TheNewDirectory='C:\Users\nsilva\Documents\AeroFS\Drop\';
//  FileMask='*.msi';
var
  NewFullPath:UTF8String;
  FileMast:UTF8String;
  TheSourceDirectory:UTF8String;
  TheDestDirectory:UTF8String;
  FileMask:UTF8String;
begin
  //  FS := TFileSearcher.Create;
  //  FS.OnFileFound := @SomeProcedure;    // Do a load of stuff with each file whenever the next line find a file
  //  FS.Search(TheDirectory, '*.*', True);
  //  FS.Free;

  TheSourceDirectory := HBRuleList[RuleNumber].SourceDirectory;
  TheDestDirectory := HBRuleList[RuleNumber].DestDirectory;
  FileMask := HBRuleList[RuleNumber].ScopeCondition;
  sl := FindAllFiles(IncludeTrailingPathDelimiter(TheSourceDirectory), FileMask, True);
    try
     If sl.count > 0 then
       begin
 //        PopupNotifier1.Text := 'There are ' + IntToStr(sl.Count) + ' Matching file(s)';
         for i:=0 to sl.Count-1 do
           // Perform Action
           begin
   //        NewFullPath := IncludeTrailingPathDelimiter(TheDestDirectory) + ExtractFileName(sl.Strings[i]);
   //        RenameFile(sl.Strings[i], NewFullPath)
         //  ShowMessage('File'+IntToStr(i)+': ' + sl.Strings[i]);
               case HBRuleList[RuleNumber].ActionType of

                 'M':MoveFile(sl.Strings[i],  TheDestDirectory);
               end; // of CASE
             end; // of process match
         if sl.Count = 1 then
           ShowBalloon( ExtractFileName(sl.Strings[i]) + ' was moved to ' + TheDestDirectory  )
         else
           ShowBalloon( IntToStr(sl.Count) + ' files were moved to ' + TheDestDirectory );


       end; // of matching files found
  finally
    sl.Free;
  end;

end;

procedure TfrmHBMain.Action1Execute(Sender: TObject);
begin

end;

procedure TfrmHBMain.bbNotificationTestClick(Sender: TObject);
begin
  ShowBalloon('Test Notification');
end;

procedure TfrmHBMain.acExitApplicationExecute(Sender: TObject);
begin
  application.Terminate;
  self.close;
end;

procedure TfrmHBMain.acPopupTimerHideExecute(Sender: TObject);
begin
  PNTimer.Enabled:=False;
  PopupNotifier1.Hide;
end;

procedure TfrmHBMain.cbEnabledChange(Sender: TObject);
begin
  ScanTimer.Enabled :=  cbEnabled.Checked;
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

procedure TfrmHBMain.ScanTimerTimer(Sender: TObject);
begin
  acSearchRun.Execute;
end;

procedure TfrmHBMain.MenuItem1Click(Sender: TObject);
begin
  acExitApplication.Execute;
end;

procedure TfrmHBMain.pnTimerTimer(Sender: TObject);
begin
  acPopupTimerHide.Execute;
end;

end.

