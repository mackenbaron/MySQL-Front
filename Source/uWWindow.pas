unit uWWindow;

interface {********************************************************************}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Types,
  Dialogs, ActnList, ComCtrls, DBActns, ExtCtrls, ImgList, Menus, StdActns,
  ActnCtrls, StdCtrls, ToolWin,
  {$IFDEF EurekaLog}
  ExceptionLog,
  {$ENDIF}
  SynEditHighlighter, SynHighlighterSQL,
  ExtCtrls_Ext, Forms_Ext, StdCtrls_Ext, ComCtrls_Ext, Dialogs_Ext, StdActns_Ext,
  MySQLDB,
  uSession, uPreferences, uDeveloper,
  uFSession, uBase;

const
  cWindowClassName = 'MySQL-Front.Application';

const
  UM_ACTIVATETAB = WM_USER + 600;
  UM_MYSQLCLIENT_SYNCHRONIZE = WM_USER + 601;
  UM_ONLINE_UPDATE_FOUND = WM_USER + 602;

type
  TWWindow = class (TForm_Ext)
    ActionList: TActionList;
    aDCancel: TAction;
    aDCancelRecord: TDataSetCancel;
    aDCreateDatabase: TAction;
    aDCreateEvent: TAction;
    aDCreateField: TAction;
    aDCreateForeignKey: TAction;
    aDCreateFunction: TAction;
    aDCreateFunction1: TMenuItem;
    aDCreateKey: TAction;
    aDCreateProcedure: TAction;
    aDCreateTable: TAction;
    aDCreateTrigger: TAction;
    aDCreateUser: TAction;
    aDCreateView: TAction;
    aDDeleteDatabase: TAction;
    aDDeleteEvent: TAction;
    aDDeleteField: TAction;
    aDDeleteForeignKey: TAction;
    aDDeleteKey: TAction;
    aDDeleteProcess: TAction;
    aDDeleteRecord: TAction;
    aDDeleteRoutine: TAction;
    aDDeleteTable: TAction;
    aDDeleteTrigger: TAction;
    aDDeleteUser: TAction;
    aDDeleteView: TAction;
    aDEditDatabase: TAction;
    aDEditEvent: TAction;
    aDEditField: TAction;
    aDEditForeignKey: TAction;
    aDEditKey: TAction;
    aDEditProcess: TAction;
    aDEditRecord: TAction;
    aDEditRoutine: TAction;
    aDEditServer: TAction;
    aDEditTable: TAction;
    aDEditTrigger: TAction;
    aDEditUser: TAction;
    aDEditVariable: TAction;
    aDEditView: TAction;
    aDEmpty: TAction;
    aDInsertRecord: TAction;
    aDPostObject: TAction;
    aDPostRecord: TDataSetPost;
    aDRun: TAction;
    aDRunSelection: TAction;
    aECopy: TEditCopy;
    aECopyToFile: TAction;
    aECut: TEditCut;
    aEDelete: TEditDelete;
    aEFind: TAction;
    aEFormatSQL: TAction;
    aEJobAddExport: TAction;
    aEJobAddImport: TAction;
    aEJobDelete: TAction;
    aEJobEdit: TAction;
    aEJobExecute: TAction;
    aEPaste: TEditPaste;
    aEPasteFrom1: TMenuItem;
    aEPasteFromFile: TAction;
    aERedo: TAction;
    aERename: TAction;
    aEReplace: TAction;
    aESelectAll: TEditSelectAll;
    aETransfer: TAction;
    aEUndo: TEditUndo;
    aFClose: TAction;
    aFCloseAll: TAction;
    aFExit: TAction;
    aFExportAccess: TAction;
    aFExportBitmap: TAction;
    aFExportExcel: TAction;
    aFExportHTML: TAction;
    aFExportODBC: TAction;
    aFExportODBC1: TMenuItem;
    aFExportPDF: TAction;
    aFExportSQL: TAction;
    aFExportText: TAction;
    aFExportXML: TAction;
    aFImportAccess: TAction;
    aFImportExcel: TAction;
    aFImportODBC: TAction;
    aFImportSQL: TAction;
    aFImportText: TAction;
    aFOpen: TAction;
    aFOpenAccount: TAction;
    aFSave: TAction;
    aFSaveAs: TAction;
    aHIndex: TAction;
    aHInfo: TAction;
    aHManual: TAction;
    aHSQL: TAction;
    aHUpdate: TAction;
    aOAccounts: TAction;
    aOGlobals: TAction;
    aOExport: TAction;
    aOImport: TAction;
    aSSearchFind: TSearchFind_Ext;
    aSSearchNext: TSearchFindNext;
    aSSearchReplace: TSearchReplace_Ext;
    aVDataBrowser: TAction;
    aVDiagram: TAction;
    aVExplorer: TAction;
    aVJobs: TAction;
    aVNavigator: TAction;
    aVObjectBrowser: TAction;
    aVObjectIDE: TAction;
    aVQueryBuilder: TAction;
    aVRefresh: TAction;
    aVRefreshAll: TAction;
    aVSQLEditor: TAction;
    aVSQLEditor2: TAction;
    aVSQLEditor3: TAction;
    aVSQLHistory: TAction;
    aVSQLLog: TAction;
    CToolBar: TCoolBar;
    Highlighter: TSynSQLSyn;
    MainMenu: TMainMenu;
    miDatabase: TMenuItem;
    miDCancelRecord: TMenuItem;
    miDCreate: TMenuItem;
    miDCreateDatabase: TMenuItem;
    miDCreateEvent: TMenuItem;
    miDCreateField: TMenuItem;
    miDCreateForeignKey: TMenuItem;
    miDCreateIndex: TMenuItem;
    miDCreateRoutine: TMenuItem;
    miDCreateTable: TMenuItem;
    miDCreateTrigger: TMenuItem;
    miDCreateUser: TMenuItem;
    miDCreateView: TMenuItem;
    miDDelete: TMenuItem;
    miDDeleteDatabase: TMenuItem;
    miDDeleteEvent: TMenuItem;
    miDDeleteField: TMenuItem;
    miDDeleteForeignKey: TMenuItem;
    miDDeleteIndex: TMenuItem;
    miDDeleteProcess: TMenuItem;
    miDDeleteRecord: TMenuItem;
    miDDeleteRoutine: TMenuItem;
    miDDeleteTable: TMenuItem;
    miDDeleteTrigger: TMenuItem;
    miDDeleteUser: TMenuItem;
    miDDeleteView: TMenuItem;
    miDEditDatabase: TMenuItem;
    miDEditEvent: TMenuItem;
    miDEditField: TMenuItem;
    miDEditForeignKey: TMenuItem;
    miDEditIndex: TMenuItem;
    miDEditProcess: TMenuItem;
    miDEditRecord: TMenuItem;
    miDEditRoutine: TMenuItem;
    miDEditServer: TMenuItem;
    miDEditTable: TMenuItem;
    miDEditTrigger: TMenuItem;
    miDEditUser: TMenuItem;
    miDEditVariable: TMenuItem;
    miDEditView: TMenuItem;
    miDEmpty: TMenuItem;
    miDInsertRecord: TMenuItem;
    miDPostObject: TMenuItem;
    miDPostRecord: TMenuItem;
    miDProperties: TMenuItem;
    miDRun: TMenuItem;
    miDRunSelection: TMenuItem;
    miECopy: TMenuItem;
    miECopyToFile: TMenuItem;
    miECut: TMenuItem;
    miEDelete: TMenuItem;
    miEdit: TMenuItem;
    miEFind: TMenuItem;
    miEFormatSQL: TMenuItem;
    miEPaste: TMenuItem;
    miERedo: TMenuItem;
    miERename: TMenuItem;
    miEReplace: TMenuItem;
    miESelectAll: TMenuItem;
    miETransfer: TMenuItem;
    miEUndo: TMenuItem;
    miExtras: TMenuItem;
    miFClose: TMenuItem;
    miFConnect: TMenuItem;
    miFExit: TMenuItem;
    miFExport: TMenuItem;
    miFExportAccess: TMenuItem;
    miFExportBitmap: TMenuItem;
    miFExportExcel: TMenuItem;
    miFExportHTML: TMenuItem;
    miFExportPDF: TMenuItem;
    miFExportSQL: TMenuItem;
    miFExportText: TMenuItem;
    miFExportXML: TMenuItem;
    miFile: TMenuItem;
    miFImport: TMenuItem;
    miFImportAccess: TMenuItem;
    miFImportExcel: TMenuItem;
    miFImportODBC: TMenuItem;
    miFImportSQL: TMenuItem;
    miFImportText: TMenuItem;
    miFOpen: TMenuItem;
    miFReopen: TMenuItem;
    miFSave: TMenuItem;
    miFSaveAs: TMenuItem;
    miHelp: TMenuItem;
    miHIndex: TMenuItem;
    miHInfo: TMenuItem;
    miHManual: TMenuItem;
    miHSQL: TMenuItem;
    miHUpdate: TMenuItem;
    miEJobAdd: TMenuItem;
    miEJobAddExport: TMenuItem;
    miEJobAddImport: TMenuItem;
    miEJobDelete: TMenuItem;
    miEJobEdit: TMenuItem;
    miEJobs: TMenuItem;
    miOAccounts: TMenuItem;
    miOGlobals: TMenuItem;
    miOptions: TMenuItem;
    miOExport: TMenuItem;
    miOImport: TMenuItem;
    miSearch: TMenuItem;
    miSSearchFind: TMenuItem;
    miSSearchNext: TMenuItem;
    miSSearchReplace: TMenuItem;
    miVBrowser: TMenuItem;
    miVDiagram: TMenuItem;
    miVExplorer: TMenuItem;
    miView: TMenuItem;
    miVJobs: TMenuItem;
    miVNavigator: TMenuItem;
    miVObjectBrowser: TMenuItem;
    miVObjectIDE: TMenuItem;
    miVQueryBuilder: TMenuItem;
    miVRefresh: TMenuItem;
    miVRefreshAll: TMenuItem;
    miVSidebar: TMenuItem;
    miVSQLEditor: TMenuItem;
    miVSQLHistory: TMenuItem;
    miVSQLLog: TMenuItem;
    MTabControl: TPopupMenu;
    mtFClose: TMenuItem;
    mtFOpenAccount: TMenuItem;
    mtTabs: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N2: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    N3: TMenuItem;
    N30: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    OpenDialog: TOpenDialog_Ext;
    PWorkSpace: TPanel_Ext;
    SaveDialog: TSaveDialog_Ext;
    StatusBar: TStatusBar;
    TabControl: TTabControl;
    tbCancelRecord: TToolButton;
    tbCreateDatabase: TToolButton;
    tbCreateField: TToolButton;
    tbCreateForeignKey: TToolButton;
    tbCreateIndex: TToolButton;
    tbCreateTable: TToolButton;
    tbDBFirst: TToolButton;
    tbDBLast: TToolButton;
    tbDBNext: TToolButton;
    tbDBPrev: TToolButton;
    tbDCancel: TToolButton;
    tbDDeleteRecord: TToolButton;
    tbDeleteDatabase: TToolButton;
    tbDeleteField: TToolButton;
    tbDeleteForeignKey: TToolButton;
    tbDeleteIndex: TToolButton;
    tbDeleteTable: TToolButton;
    tbDInsertRecord: TToolButton;
    tbECopy: TToolButton;
    tbECut: TToolButton;
    tbEDelete: TToolButton;
    tbEPaste: TToolButton;
    tbFormatSQL: TToolButton;
    tbOpen: TToolButton;
    tbPostObject: TToolButton;
    tbPostRecord: TToolButton;
    tbProperties: TToolButton;
    tbRedo: TToolButton;
    tbRun: TToolButton;
    tbRunSelection: TToolButton;
    tbSave: TToolButton;
    tbSearchFind: TToolButton;
    tbSearchReplace: TToolButton;
    TBTabControl: TToolBar;
    tbUndo: TToolButton;
    tbVRefresh: TToolButton;
    tcOpenAccount: TToolButton;
    ToolBar: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton2: TToolButton;
    ToolButton23: TToolButton;
    ToolButton30: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton1: TToolButton;
    procedure aDCreateParentExecute(Sender: TObject);
    procedure aEFindExecute(Sender: TObject);
    procedure aEReplaceExecute(Sender: TObject);
    procedure aETransferExecute(Sender: TObject);
    procedure aFCloseAllExecute(Sender: TObject);
    procedure aFCloseExecute(Sender: TObject);
    procedure aFExitExecute(Sender: TObject);
    procedure aFOpenAccountExecute(Sender: TObject);
    procedure aHIndexExecute(Sender: TObject);
    procedure aHInfoExecute(Sender: TObject);
    procedure aHUpdateExecute(Sender: TObject);
    procedure aOGlobalsExecute(Sender: TObject);
    procedure aOAccountsExecute(Sender: TObject);
    procedure aSSearchFindNotFound(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HandleParam(const AParam: string);
    procedure TabControlChange(Sender: TObject);
    procedure TabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure TabControlContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabControlDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TabControlDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TabControlEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TabControlGetImageIndex(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
    procedure TabControlResize(Sender: TObject);
    procedure TabControlStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tbPropertiesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabControlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aOExportExecute(Sender: TObject);
    procedure aOImportExecute(Sender: TObject);
  const
    tiDeactivate = 1;
  type
    PTabControlRepaint = ^TTabControlRepaint;
    TTabControlRepaint = record
      Active: Boolean;
      Rect: TRect;
    end;
  private
    CheckOnlineVersionThread: TCheckOnlineVersionThread;
    {$IFDEF EurekaLog}
    EurekaLog: TEurekaLog;
    {$ENDIF}
    FSessions: TList;
    MouseDownPoint: TPoint;
    Param: string; // needed for PostMessage
    PreviousForm: TForm;
    QuitAfterShow: Boolean;
    TabControlDragMarkedTabIndex: Integer;
    TabControlDragStartTabIndex: Integer;
    TabControlRepaint: TList;
    UniqueTabNameCounter: Integer;
    OnlineRecommendedUpdateFound: Boolean;
    procedure ApplicationActivate(Sender: TObject);
    procedure ApplicationDeactivate(Sender: TObject);
    procedure ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
    procedure ApplicationModalBegin(Sender: TObject);
    procedure ApplicationModalEnd(Sender: TObject);
    function CloseAll(): Boolean;
    procedure CloseTab(const Tab: TFSession);
    procedure CMSysFontChanged(var Message: TMessage); message CM_SYSFONTCHANGED;
    procedure EmptyWorkingMem();
    {$IFDEF EurekaLog}
    procedure EurekaLogCustomButtonClickNotify(
      EurekaExceptionRecord: TEurekaExceptionRecord; var CloseDialog: Boolean);
    procedure EurekaLogCustomDataRequest(
      EurekaExceptionRecord: TEurekaExceptionRecord; DataFields: TStrings);
    procedure EurekaLogExceptionNotify(
      EurekaExceptionRecord: TEurekaExceptionRecord; var Handle: Boolean);
    {$ENDIF}
    function GetActiveTab(): TFSession;
    function GetNewTabIndex(Sender: TObject; X, Y: Integer): Integer;
    procedure InformOnlineUpdateFound();
    procedure miFReopenClick(Sender: TObject);
    procedure mtTabsClick(Sender: TObject);
    procedure MySQLConnectionSynchronize(const Data: Pointer); inline;
    procedure OnlineVersionChecked(Sender: TObject);
    procedure SetActiveTab(const FSession: TFSession);
    procedure SQLError(const Connection: TMySQLConnection; const ErrorCode: Integer; const ErrorMessage: string);
    procedure UMActivateTab(var Message: TMessage); message UM_ACTIVATETAB;
    procedure UMAddTab(var Message: TMessage); message UM_ADDTAB;
    procedure UMChangePreferences(var Message: TMessage); message UM_CHANGEPREFERENCES;
    procedure UMMySQLClientSynchronize(var Message: TMessage); message UM_MYSQLCLIENT_SYNCHRONIZE;
    procedure UMDeactivateTab(var Message: TMessage); message UM_DEACTIVATETAB;
    procedure UMPostShow(var Message: TMessage); message UM_POST_SHOW;
    procedure UMOnlineUpdateFound(var Message: TMessage); message UM_ONLINE_UPDATE_FOUND;
    procedure UMTerminate(var Message: TMessage); message UM_TERMINATE;
    procedure UMUpdateToolbar(var Message: TMessage); message UM_UPDATETOOLBAR;
    procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    procedure WMHelp(var Message: TWMHelp); message WM_HELP;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    property ActiveTab: TFSession read GetActiveTab write SetActiveTab;
  protected
    procedure ApplicationException(Sender: TObject; E: Exception);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    function DBLogin(const Account: Pointer): Boolean;
  end;

var
  WWindow: TWWindow;

implementation {***************************************************************}

{$R *.dfm}

uses
  ShellApi, ShlObj, DBConsts, CommCtrl, StrUtils, ShLwApi, IniFiles, Themes,
  Variants, WinINet, SysConst, Math, Zip,
  ODBCAPI,
  acQBLocalizer,
  MySQLConsts, HTTPTunnel,
  uTools, uURI,
  uDAccounts, uDAccount, uDOptions, uDLogin, uDStatement, uDTransfer, uDSearch,
  uDConnecting, uDInfo, uDUpdate;

function IsConnectedToInternet(): Boolean;
//var
//  ConnectionTypes: DWORD;
begin
//  ConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(nil, 0);
end;

{ TWWindow ********************************************************************}

procedure TWWindow.aDCreateParentExecute(Sender: TObject);
begin
  ; // Dummy, damit MenuItem enabled
end;

procedure TWWindow.aEFindExecute(Sender: TObject);
begin
  if (Assigned(ActiveTab) and (ActiveTab is TFSession)) then
    TFSession(ActiveTab).aEFindExecute(Sender)
  else
  begin
    DSearch.Session := nil;
    DSearch.SearchOnly := True;
    DSearch.Tab := nil;
    DSearch.Execute();
  end;
end;

procedure TWWindow.aEReplaceExecute(Sender: TObject);
begin
  if (Assigned(ActiveTab) and (ActiveTab is TFSession)) then
    TFSession(ActiveTab).aEReplaceExecute(Sender)
  else
  begin
    DSearch.Session := nil;
    DSearch.SearchOnly := False;
    DSearch.Tab := nil;
    DSearch.Execute();
  end;
end;

procedure TWWindow.aETransferExecute(Sender: TObject);
begin
  if (Assigned(ActiveTab) and (ActiveTab is TFSession)) then
    TFSession(ActiveTab).aETransferExecute(Sender)
  else
  begin
    DTransfer.SourceSession := nil;
    DTransfer.Execute();
  end;
end;

procedure TWWindow.aFCloseAllExecute(Sender: TObject);
begin
  CloseAll();
end;

procedure TWWindow.aFCloseExecute(Sender: TObject);
begin
  if (Assigned(ActiveTab) and Boolean(SendMessage(ActiveTab.Handle, UM_CLOSE_TAB_QUERY, 0, 0))) then
    CloseTab(ActiveTab);
end;

procedure TWWindow.aFExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TWWindow.aFOpenAccountExecute(Sender: TObject);
begin
  Perform(UM_ADDTAB, 0, 0);
end;

procedure TWWindow.aHIndexExecute(Sender: TObject);
var
  Control: TWinControl;
begin
  Control := ActiveControl;
  while (Assigned(Control) and (Control.HelpContext = 0)) do
    // Needed for TacQueryBuilder
    Control := Control.Parent;

  if (not Assigned(ActiveControl) or (Control.HelpContext < 0)) then
    Application.HelpCommand(HELP_FINDER, 0)
  else
    Application.HelpCommand(HELP_CONTEXT, Control.HelpContext);
end;

procedure TWWindow.aHInfoExecute(Sender: TObject);
begin
  DInfo.ShowModal();
end;

procedure TWWindow.aHUpdateExecute(Sender: TObject);
begin
  if (CloseAll()) then
  begin
    Preferences.SetupProgramExecute := DUpdate.Execute();
    if (Preferences.SetupProgramExecute) then
      Close()
    else if (Preferences.ObsoleteVersion < Preferences.Version) then
      Preferences.ObsoleteVersion := Preferences.Version;
  end;
end;

procedure TWWindow.aOAccountsExecute(Sender: TObject);
begin
  DAccounts.Account := nil;
  DAccounts.Open := False;
  DAccounts.Execute();
end;

procedure TWWindow.aOGlobalsExecute(Sender: TObject);
var
  I: Integer;
begin
  if (DOptions.Execute()) then
  begin
    Preferences.Save();
    TabControl.Visible := Preferences.TabsVisible or not Preferences.TabsVisible and (FSessions.Count >= 2);
    TBTabControl.Visible := Preferences.TabsVisible;
    for I := 0 to Screen.FormCount - 1 do
      PostMessage(Screen.Forms[I].Handle, UM_CHANGEPREFERENCES, 0, 0);
  end;
end;

procedure TWWindow.aOExportExecute(Sender: TObject);
var
  ZipFile: TZipFile;
begin
  SaveDialog.Title := Preferences.LoadStr(200);
  SaveDialog.FileName := SysUtils.LoadStr(1000) + '_Settings.zip';
  SaveDialog.Filter := FilterDescription('zip') + ' (*.zip)|*.zip';
  SaveDialog.DefaultExt := '.zip';
  if (SaveDialog.Execute()) then
  begin
    Preferences.Save();
    Accounts.Save();

    ZipFile := TZipFile.Create();
    ZipFile.Open(SaveDialog.FileName, zmWrite);
    ZipFile.Add(Preferences.Filename);
    ZipFile.Add(Accounts.Filename);
    ZipFile.Close();
    ZipFile.Free();
  end;
end;

procedure TWWindow.aOImportExecute(Sender: TObject);
var
  I: Integer;
  ZipFile: TZipFile;
begin
  OpenDialog.Title := Preferences.LoadStr(371);
  OpenDialog.FileName := SysUtils.LoadStr(1000) + '_Settings.zip';
  OpenDialog.Filter := FilterDescription('zip') + ' (*.zip)|*.zip';
  OpenDialog.DefaultExt := '.zip';
  if (CloseAll() and OpenDialog.Execute()) then
  begin
    ZipFile := TZipFile.Create();
    ZipFile.Open(OpenDialog.FileName, zmRead);
    ZipFile.ExtractAll(Preferences.UserPath);
    ZipFile.Close();
    ZipFile.Free();

    Preferences.Open();
    Preferences.Save();
    Accounts.Open();

    TabControl.Visible := Preferences.TabsVisible or not Preferences.TabsVisible and (FSessions.Count >= 2);
    TBTabControl.Visible := Preferences.TabsVisible;
    for I := 0 to Screen.FormCount - 1 do
      PostMessage(Screen.Forms[I].Handle, UM_CHANGEPREFERENCES, 0, 0);
  end;
end;

procedure TWWindow.ApplicationActivate(Sender: TObject);
begin
  KillTimer(Handle, tiDeactivate);
end;

procedure TWWindow.ApplicationDeactivate(Sender: TObject);
begin
  SetTimer(Handle, tiDeactivate, 60000, nil);
end;

procedure TWWindow.ApplicationException(Sender: TObject; E: Exception);
begin
  if (E.Message <> SRecordChanged) then
  begin
    DisableApplicationActivate := True;

    {$IFNDEF EurekaLog}
    if ((OnlineProgramVersion < 0) and IsConnectedToInternet()) then
      if (Assigned(CheckOnlineVersionThread)) then
        CheckOnlineVersionThread.WaitFor()
      else
      begin
        CheckOnlineVersionThread := TCheckOnlineVersionThread.Create();
        CheckOnlineVersionThread.Execute();
        FreeAndNil(CheckOnlineVersionThread);
      end;
    {$ENDIF}

    MsgBox('Internal Program Bug:' + #13#10 + E.Message, Preferences.LoadStr(45), MB_OK + MB_ICONERROR);

    if (OnlineProgramVersion > Preferences.Version) then
      InformOnlineUpdateFound()
    else if (Preferences.ObsoleteVersion < Preferences.Version) then
      Preferences.ObsoleteVersion := Preferences.Version;

    DisableApplicationActivate := False;
  end;
end;

procedure TWWindow.ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
var
  NewTabIndex: Integer;
begin
  if ((Screen.ActiveForm = Self) and (WM_KEYFIRST <= Msg.Message) and (Msg.Message <= WM_KEYLAST)
    and ((TWMKey(Pointer(@Msg.message)^).CharCode = VK_TAB) or (TWMKey(Pointer(@Msg.message)^).CharCode = VK_PRIOR) or (TWMKey(Pointer(@Msg.message)^).CharCode = VK_NEXT) or (TWMKey(Pointer(@Msg.message)^).CharCode in [Ord('1') .. Ord('9')])) and (GetKeyState(VK_CONTROL) < 0)) then
  begin
    if (Msg.Message = WM_KEYDOWN) then
    begin
      if ((TWMKey(Pointer(@Msg.message)^).CharCode = VK_TAB) and (GetKeyState(VK_SHIFT) < 0) or (TWMKey(Pointer(@Msg.message)^).CharCode =  VK_PRIOR)) then
      begin
        NewTabIndex := TabControl.TabIndex - 1;
        if (NewTabIndex < 0) then
          NewTabIndex := FSessions.Count - 1;
        Handled := True;
      end
      else if ((TWMKey(Pointer(@Msg.message)^).CharCode = VK_TAB) and (GetKeyState(VK_SHIFT) >= 0) or (TWMKey(Pointer(@Msg.message)^).CharCode =  VK_NEXT)) then
      begin
        NewTabIndex := TabControl.TabIndex + 1;
        if (NewTabIndex >= FSessions.Count) then
          NewTabIndex := 0;
        Handled := True;
      end
      else if ((Ord('1') <= TWMKey(Pointer(@Msg.message)^).CharCode) and (TWMKey(Pointer(@Msg.message)^).CharCode < Ord('1') + FSessions.Count)) then
      begin
        NewTabIndex := TWMKey(Pointer(@Msg.message)^).CharCode - Ord('1');
        Handled := True;
      end
      else
        NewTabIndex := TabControl.TabIndex;

      if (NewTabIndex <> TabControl.TabIndex) then
      begin
        Perform(UM_DEACTIVATETAB, 0, 0);
        Perform(UM_ACTIVATETAB, 0, LPARAM(FSessions[NewTabIndex]));
      end;
    end;
  end;
end;

procedure TWWindow.ApplicationModalBegin(Sender: TObject);
begin
  if (Assigned(Screen.ActiveForm) and Screen.ActiveForm.Active and (Screen.ActiveForm is TForm_Ext)) then
  begin
    PreviousForm := Screen.ActiveForm;

    if ((Screen.ActiveForm = Self) and Assigned(ActiveTab)) then
      SendMessage(ActiveTab.Handle, UM_DEACTIVATEFRAME, 0, 0);
  end
  else
    PreviousForm := nil;
end;

procedure TWWindow.ApplicationModalEnd(Sender: TObject);
begin
  if (Assigned(PreviousForm) and (PreviousForm is TForm_Ext)) then
  begin
    PreviousForm := nil;

    if (Screen.ActiveForm = Self) then
    begin
      if (OnlineRecommendedUpdateFound) then
      begin
        OnlineRecommendedUpdateFound := False;
        InformOnlineUpdateFound();
      end;

      if (Assigned(ActiveTab)) then
        PostMessage(ActiveTab.Handle, UM_ACTIVATEFRAME, 0, 0);
    end;
  end;
end;

procedure TWWindow.aSSearchFindNotFound(Sender: TObject);
var
  FindText: string;
begin
  if (Sender is TSearchFind) then
    FindText := TSearchFind(Sender).Dialog.FindText
  else if (Sender is TSearchReplace) then
    FindText := TSearchReplace(Sender).Dialog.FindText
  else
    FindText := '';
  MsgBox(Preferences.LoadStr(533, FindText), Preferences.LoadStr(43), MB_OK + MB_ICONINFORMATION);
end;

function TWWindow.CloseAll(): Boolean;
var
  I: Integer;
begin
  Result := Assigned(FSessions); // Prevent a new call, while closing
  if (Result) then
    for I := FSessions.Count - 1 downto 0 do
    begin
      Result := Result and (SendMessage(TFSession(FSessions[I]).Handle, UM_CLOSE_TAB_QUERY, 0, 0) = 1);
      if (Result) then
        CloseTab(TFSession(FSessions[I]));
    end;
end;

procedure TWWindow.CloseTab(const Tab: TFSession);
var
  Session: TSSession;
  NewTabIndex: Integer;
begin
  Perform(UM_DEACTIVATETAB, 0, 0);

  NewTabIndex := FSessions.IndexOf(Tab);

  if (0 <= NewTabIndex) and (NewTabIndex < TabControl.Tabs.Count) then
  begin
    TabControl.Tabs.Delete(NewTabIndex);
    FSessions.Delete(FSessions.IndexOf(Tab));
    if (TabControl.TabIndex < 0) then
      TabControl.TabIndex := FSessions.Count - 1;

    Dec(NewTabIndex, 1);
    if ((NewTabIndex < 0) and (FSessions.Count > 0)) then
      NewTabIndex := 0;
    if (NewTabIndex >= 0) then
      Perform(UM_ACTIVATETAB, 0, LPARAM(FSessions[NewTabIndex]));

    Session := Tab.Session;

    Tab.Visible := False;
    Tab.Free();

    Session.Free();

    TBTabControl.Visible := Preferences.TabsVisible or not Preferences.TabsVisible and (FSessions.Count >= 2);
    TabControl.Visible := TBTabControl.Visible;
    TabControlResize(nil);

    aFCloseAll.Enabled := FSessions.Count > 0;
  end;

  Perform(UM_UPDATETOOLBAR, 0, 0);
end;

procedure TWWindow.CMSysFontChanged(var Message: TMessage);
begin
  inherited;

  if (StyleServices.Enabled or not CheckWin32Version(6)) then
    ToolBar.BorderWidth := 0
  else
    ToolBar.BorderWidth := 2;

  if (Assigned(ToolBar.Images)) then
  begin
    // Recalculate height of Toolbar:
    CToolBar.AutoSize := False;
    ToolBar.AutoSize := False;
    ToolBar.ButtonHeight := 0;
    ToolBar.ButtonHeight := ToolBar.Images.Height + 6;
    ToolBar.ButtonWidth := ToolBar.Images.Width + 7;
    ToolBar.AutoSize := True;
    CToolBar.AutoSize := True;
  end;
end;

constructor TWWindow.Create(AOwner: TComponent);
var
  WindowPlacement: TWindowPlacement;
  Wnd: HWND;
begin
  Wnd := FindWindow(PChar(cWindowClassName), nil);

  inherited;

  WindowPlacement.length := SizeOf(WindowPlacement);
  if ((Wnd > 0) and GetWindowPlacement(Wnd, @WindowPlacement)) then
  begin
    Inc(WindowPlacement.rcNormalPosition.Left, 2 * GetSystemMetrics(SM_CXBORDER) + GetSystemMetrics(SM_CYCAPTION));
    Inc(WindowPlacement.rcNormalPosition.Top, 2 * GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYCAPTION));
    Inc(WindowPlacement.rcNormalPosition.Right, 2 * GetSystemMetrics(SM_CXBORDER) + GetSystemMetrics(SM_CYCAPTION));
    Inc(WindowPlacement.rcNormalPosition.Bottom, 2 * GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYCAPTION));

    if (WindowPlacement.rcNormalPosition.Right > Screen.WorkAreaRect.Right) then
    begin
      Dec(WindowPlacement.rcNormalPosition.Right, WindowPlacement.rcNormalPosition.Left);
      WindowPlacement.rcNormalPosition.Left := 0;
      Dec(WindowPlacement.rcNormalPosition.Bottom, WindowPlacement.rcNormalPosition.Top);
      WindowPlacement.rcNormalPosition.Top := 0;
    end
    else if (WindowPlacement.rcNormalPosition.Bottom > Screen.WorkAreaRect.Bottom) then
    begin
      Dec(WindowPlacement.rcNormalPosition.Bottom, WindowPlacement.rcNormalPosition.Top);
      WindowPlacement.rcNormalPosition.Top := 0;
    end;

    Left := WindowPlacement.rcNormalPosition.Left;
    Top := WindowPlacement.rcNormalPosition.Top;
    Width := WindowPlacement.rcNormalPosition.Right - WindowPlacement.rcNormalPosition.Left;
    Height := WindowPlacement.rcNormalPosition.Bottom - WindowPlacement.rcNormalPosition.Top;
  end
  else if (((Preferences.Height > 0) and (Preferences.Width > 0))) then
  begin
    Left := Preferences.Left;
    Top := Preferences.Top;
    Width := Preferences.Width;
    Height := Preferences.Height;
    WindowState := Preferences.WindowState;

    if (WindowState = wsNormal) then
    begin
      if (Width > Screen.WorkAreaRect.Right - Screen.WorkAreaRect.Left) then
        Left := 0
      else if (Left + Width > Screen.WorkAreaRect.Right) then
        Left := Screen.WorkAreaRect.Right - Width;

      if (Height > Screen.WorkAreaRect.Bottom - Screen.WorkAreaRect.Top) then
        Top := 0
      else if (Top + Height > Screen.WorkAreaRect.Bottom) then
        Top := Screen.WorkAreaRect.Bottom - Height;
    end;
  end;
end;

function TWWindow.DBLogin(const Account: Pointer): Boolean;
begin
  DLogin.Username := TPAccount(Account).Connection.Username;
  DLogin.Password := TPAccount(Account).Connection.Password;
  Result := DLogin.Execute();
  if (Result) then
  begin
    TPAccount(Account).Connection.Username := DLogin.Username;
    TPAccount(Account).Connection.Password := DLogin.Password;
  end;
end;

destructor TWWindow.Destroy();
begin
  FreeAndNil(FSessions);
  FreeAndNil(Accounts);

  {$IFDEF EurekaLog}
    EurekaLog.Free();
  {$ENDIF}

  inherited;
end;

procedure TWWindow.EmptyWorkingMem();
var
  Process: THandle;
begin
  Process := OpenProcess(PROCESS_ALL_ACCESS, FALSE, GetCurrentProcessId());
  if (Process <> 0) then
  begin
    SetProcessWorkingSetSize(Process, Size_T(-1), Size_T(-1));
    CloseHandle(Process);
  end;
end;

{$IFDEF EurekaLog}
procedure TWWindow.EurekaLogCustomButtonClickNotify(
  EurekaExceptionRecord: TEurekaExceptionRecord; var CloseDialog: Boolean);
var
  ClipboardData: HGLOBAL;
  S: string;
begin
  if (not OpenClipboard(Handle)) then
    MessageBox(0, PChar(SysErrorMessage(GetLastError())), 'Error', MB_OK)
  else
  begin
    S := string(EurekaExceptionRecord.LogText);

    EmptyClipboard();
    ClipboardData := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, (Length(S) + 1) * SizeOf(S[1]));
    StrPCopy(GlobalLock(ClipboardData), S);
    SetClipboardData(CF_UNICODETEXT, ClipboardData);
    GlobalUnlock(ClipboardData);
    CloseClipboard();

    CloseDialog := False  ;
  end;
end;

procedure TWWindow.EurekaLogCustomDataRequest(
  EurekaExceptionRecord: TEurekaExceptionRecord; DataFields: TStrings);
var
  I: Integer;
  Log: TStringList;
  Start: Integer;
begin
  for I := 0 to Sessions.Count - 1 do
    if (Sessions[I].Connection.Connected) then
      if (Assigned(ActiveTab) and (Sessions[I] = ActiveTab.Session)) then
        DataFields.Add(IntToStr(I) + '=MySQL Version ' + Sessions[I].Connection.ServerVersionStr + ' (Id*: ' + IntToStr(Sessions[I].Connection.ThreadId) + ')')
      else
        DataFields.Add(IntToStr(I) + '=MySQL Version ' + Sessions[I].Connection.ServerVersionStr + ' (Id: ' + IntToStr(Sessions[I].Connection.ThreadId) + ')');

  if (Assigned(ActiveTab)) then
  begin
    Log := TStringList.Create();
    Log.Text := ActiveTab.Session.Connection.BugMonitor.CacheText;
    if (Log.Count < 10) then Start := 0 else Start := Log.Count - 10;
    for I := Start to Log.Count - 1 do
      DataFields.Add(IntToStr(DataFields.Count) + '=' + Log[I]);
    Log.Free();
  end;

  EurekaExceptionRecord.CurrentModuleOptions.EMailSubject
    := AnsiString(SysUtils.LoadStr(1000) + ' ' + IntToStr(Preferences.VerMajor) + '.' + IntToStr(Preferences.VerMinor)
    + ' (Build: ' + IntToStr(Preferences.VerPatch) + '.' + IntToStr(Preferences.VerBuild) + ')')
    + ' - Bug Report';
end;

procedure TWWindow.EurekaLogExceptionNotify(
  EurekaExceptionRecord: TEurekaExceptionRecord; var Handle: Boolean);
var
  I: Integer;
  Report: string;
  SQL: PChar;
  StringList: TStringList;
begin
  for I := 0 to FSessions.Count - 1 do
    try TFSession(FSessions[I]).CrashRescue(); except end;
  try Accounts.Save(); except end;
  try Preferences.Save(); except end;

  if ((OnlineProgramVersion < 0) and IsConnectedToInternet()) then
    if (Assigned(CheckOnlineVersionThread)) then
      CheckOnlineVersionThread.WaitFor()
    else
    begin
      CheckOnlineVersionThread := TCheckOnlineVersionThread.Create();
      CheckOnlineVersionThread.Execute();
      FreeAndNil(CheckOnlineVersionThread);
    end;

  Handle := Preferences.Version >= OnlineProgramVersion;

  if (Handle) then
  begin
    if (Preferences.ObsoleteVersion < Preferences.Version) then
      Preferences.ObsoleteVersion := Preferences.Version;


    Report := LoadStr(1000) + ' ' + Preferences.VersionStr + #13#10;
    Report := Report + #13#10;
    Report := Report + EurekaExceptionRecord.ExceptionObject.ClassName + ':' + #13#10;
    if (EurekaExceptionRecord.ExceptionObject is Exception) then
      Report := Report + Exception(EurekaExceptionRecord.ExceptionObject).Message + #13#10;
    Report := Report + #13#10;

    StringList := TStringList.Create();
    CallStackToStrings(EurekaExceptionRecord.CallStack, StringList);
    Report := Report + Trim(StringList.Text) + #13#10;
    StringList.Free();

    if (Assigned(ActiveTab)) then
    begin
      Report := Report + #13#10;
      Report := Report + 'MySQL:' + #13#10;
      Report := Report + StringOfChar('-', Length('Version: ' + ActiveTab.Session.Connection.ServerVersionStr)) + #13#10;
      Report := Report + 'Version: ' + ActiveTab.Session.Connection.ServerVersionStr + #13#10;
      Report := Report + 'LibraryType: ' + IntToStr(Ord(ActiveTab.Session.Connection.LibraryType)) + #13#10;
      Report := Report + #13#10;
      Report := Report + 'SQL Log:' + #13#10;
      Report := Report + StringOfChar('-', 72) + #13#10;
      if (Length(ActiveTab.Session.Connection.BugMonitor.CacheText) < 500) then
        SQL := PChar(ActiveTab.Session.Connection.BugMonitor.CacheText)
      else
      begin
        SQL := PChar(@ActiveTab.Session.Connection.BugMonitor.CacheText[Length(ActiveTab.Session.Connection.BugMonitor.CacheText) - 500]);
        while ((StrLen(SQL) > 0) and not CharInSet(SQL[0], [#10, #13])) do SQL := PChar(@SQL[1]);
        while ((StrLen(SQL) > 0) and CharInSet(SQL[0], [#10, #13])) do SQL := PChar(@SQL[1]);
      end;
      Report := Report + StrPas(SQL);
    end;

    SendBugToDeveloper(Report);
  end;
end;
{$ENDIF}

procedure TWWindow.FormActivate(Sender: TObject);
begin
  if (Assigned(ActiveTab)) then
    ActiveTab.Perform(UM_ACTIVATEFRAME, 0, 0);
end;

procedure TWWindow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CloseAll();
end;

procedure TWWindow.FormCreate(Sender: TObject);
var
  I: Integer;
  Foldername: array [0..MAX_PATH] of Char;
begin
  DisableApplicationActivate := False;
  MouseDownPoint := Point(-1, -1);
  OnlineRecommendedUpdateFound := False;
  QuitAfterShow := False;
  UniqueTabNameCounter := 0;

  MySQLDB.MySQLConnectionOnSynchronize := MySQLConnectionSynchronize;

  Application.HelpFile := ExtractFilePath(Application.ExeName) + Copy(ExtractFileName(Application.ExeName), 1, Length(ExtractFileName(Application.ExeName)) - 4) + '.chm';
  Application.OnException := ApplicationException;
  Application.OnMessage := ApplicationMessage;
  Application.OnModalBegin := ApplicationModalBegin;
  Application.OnModalEnd := ApplicationModalEnd;
  Application.OnActivate := ApplicationActivate;
  Application.OnDeactivate := ApplicationDeactivate;

  {$IFDEF EurekaLog}
    EurekaLog := TEurekaLog.Create(Self);
    EurekaLog.OnExceptionNotify := EurekaLogExceptionNotify;
    EurekaLog.OnCustomButtonClickNotify := EurekaLogCustomButtonClickNotify;
    EurekaLog.OnCustomDataRequest := EurekaLogCustomDataRequest;
  {$ENDIF}

  Accounts := TPAccounts.Create(DBLogin);

  Sessions.OnSQLError := SQLError;

  MainActionList := ActionList;
  MainHighlighter := Highlighter;


  TabControl.Images := Preferences.Images;
  TBTabControl.Images := Preferences.Images;

  if (not CheckWin32Version(6)) then
    CToolBar.EdgeBorders := [ebTop,ebBottom]
  else
    CToolBar.EdgeBorders := [];

  FSessions := TList.Create();
  TBTabControl.Visible := Preferences.TabsVisible;
  TabControlRepaint := TList.Create();

  aFImportAccess.Visible := (odAccess in ODBCDrivers) or (odAccess2003 in ODBCDrivers);
  aFImportExcel.Visible := (odExcel in ODBCDrivers) or (odExcel2003 in ODBCDrivers);
  aFImportODBC.Visible := ODBCEnv <> SQL_NULL_HANDLE;
  aFExportAccess.Visible := (odAccess in ODBCDrivers) or (odAccess2003 in ODBCDrivers);
  aFExportExcel.Visible := (odExcel in ODBCDrivers) or (odExcel2003 in ODBCDrivers);
  aFExportODBC.Visible := ODBCEnv <> SQL_NULL_HANDLE;
  aVJobs.Visible := False; // CheckWin32Version(6);
  miEJobs.Visible := False; // CheckWin32Version(6);
  aHIndex.Enabled := FileExists(Application.HelpFile);
  aHUpdate.Enabled := IsConnectedToInternet() and (Preferences.SetupProgram = '');

  Perform(UM_UPDATETOOLBAR, 0, 0);

  if (SHGetFolderPath(0, CSIDL_DESKTOP, 0, 0, @Foldername) <> S_OK) then
    OpenDialog.InitialDir := 'C:\'
  else
    OpenDialog.InitialDir := StrPas(PChar(@Foldername[0]));
  if (SHGetFolderPath(0, CSIDL_DESKTOP, 0, 0, @Foldername) <> S_OK) then
    SaveDialog.InitialDir := 'C:\'
  else
    SaveDialog.InitialDir := StrPas(PChar(@Foldername[0]));

  for I := 0 to StatusBar.Panels.Count - 1 do
    StatusBar.Panels[I].Text := '';
end;

procedure TWWindow.FormDeactivate(Sender: TObject);
begin
  if (Assigned(ActiveTab)) then
    ActiveTab.Perform(UM_DEACTIVATEFRAME, 0, 0);
end;

procedure TWWindow.FormDestroy(Sender: TObject);
begin
  while (TabControlRepaint.Count > 0) do
  begin
    FreeMem(TabControlRepaint[0]);
    TabControlRepaint.Delete(0);
  end;
  TabControlRepaint.Free();

  if (Assigned(CheckOnlineVersionThread)) then
    TerminateThread(CheckOnlineVersionThread.Handle, 0);
end;

procedure TWWindow.FormHide(Sender: TObject);
begin
  Preferences.WindowState := WindowState;
  if (WindowState = wsNormal) then
    begin Preferences.Top := Top; Preferences.Left := Left; Preferences.Height := Height; Preferences.Width := Width; end;
end;

procedure TWWindow.FormResize(Sender: TObject);
var
  I: Integer;
  PanelWidth: Integer;
begin
  if (Assigned(Preferences)) then
  begin
    StatusBar.Panels[sbNavigation].Width := StatusBar.Canvas.TextWidth('9999 (999999999)') + StatusBar.BorderWidth + 15;
    StatusBar.Panels[sbSummarize].Width := StatusBar.Canvas.TextWidth(Preferences.LoadStr(889, '9999', '999999999')) + StatusBar.BorderWidth + 15;

    PanelWidth := StatusBar.Width;
    for I := 1 to StatusBar.Panels.Count - 2 do
      Dec(PanelWidth, StatusBar.Panels[I].Width);
    if (WindowState = wsNormal) then
      Dec(PanelWidth, StatusBar.Height);
    StatusBar.Panels[sbMessage].Width := PanelWidth;
  end;

  if (not TabControl.Visible and Assigned(TabControl.OnResize)) then
    TabControl.OnResize(Sender);
end;

procedure TWWindow.FormShow(Sender: TObject);
begin
  if ((((Preferences.UpdateCheck = utDaily) and (Trunc(Preferences.UpdateChecked) < Date())) or (Preferences.ObsoleteVersion >= Preferences.Version)) and IsConnectedToInternet()) then
  begin
    CheckOnlineVersionThread := TCheckOnlineVersionThread.Create();
    CheckOnlineVersionThread.OnTerminate := OnlineVersionChecked;
    CheckOnlineVersionThread.Start();
  end;

  PostMessage(Handle, UM_POST_SHOW, 0, 0);
end;

function TWWindow.GetActiveTab(): TFSession;
begin
  if (not Assigned(FSessions) or (TabControl.TabIndex < 0) or (FSessions.Count <= TabControl.TabIndex)) then
    Result := nil
  else
    Result := TFSession(FSessions[TabControl.TabIndex]);
end;

function TWWindow.GetNewTabIndex(Sender: TObject; X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := TabControlDragStartTabIndex;
  for I := TabControlDragStartTabIndex - 1 downto 0 do
    if (X < TabControl.TabRect(I).Left + 3 * ((TabControl.TabRect(I).Right - TabControl.TabRect(I).Left) div 4)) then
      Result := I;
  for I := TabControlDragStartTabIndex + 1 to TabControl.Tabs.Count - 1 do
    if (X > TabControl.TabRect(I).Left + ((TabControl.TabRect(I).Right - TabControl.TabRect(I).Left) div 4)) then
      Result := I;
end;

procedure TWWindow.HandleParam(const AParam: string);
begin
  if (Copy(AParam, 1, 1) <> '/') then
  begin
    Param := AParam;
    Perform(UM_ADDTAB, 0, WPARAM(PChar(Param)));
  end;
end;

procedure TWWindow.InformOnlineUpdateFound();
begin
  Preferences.ObsoleteVersion := 0;
  if (MsgBox(Preferences.LoadStr(506) + #10#10 + Preferences.LoadStr(845), Preferences.LoadStr(43), MB_ICONQUESTION + MB_YESNOCANCEL) = ID_YES) then
    aHUpdate.Execute();
end;

procedure TWWindow.miFReopenClick(Sender: TObject);
begin
  ActiveTab.OpenSQLFile(ActiveTab.Session.Account.Desktop.Files[TMenuItem(Sender).Tag].Filename, ActiveTab.Session.Account.Desktop.Files[TMenuItem(Sender).Tag].CodePage);
end;

procedure TWWindow.mtTabsClick(Sender: TObject);
begin
  if (Sender is TMenuItem) then
  begin
    if (Assigned(ActiveTab)) then
      Perform(UM_DEACTIVATETAB, 0, 0);
    Perform(UM_ACTIVATETAB, 0, LPARAM(TFSession(FSessions[TMenuItem(Sender).Parent.IndexOf(TMenuItem(Sender))])));
  end;
end;

procedure TWWindow.MySQLConnectionSynchronize(const Data: Pointer);
begin
  PostMessage(Handle, UM_MYSQLCLIENT_SYNCHRONIZE, 0, LPARAM(Data));
end;

procedure TWWindow.OnlineVersionChecked(Sender: TObject);
begin
  PostMessage(Handle, UM_TERMINATE, 0, 0);
  if ((OnlineRecommendedVersion > Preferences.Version)
    or (OnlineProgramVersion > Preferences.ObsoleteVersion)) then
    PostMessage(Handle, UM_ONLINE_UPDATE_FOUND, 0, 0);
end;

procedure TWWindow.SetActiveTab(const FSession: TFSession);
begin
  TabControl.TabIndex := FSessions.IndexOf(FSession);

  TFSession(FSessions[FSessions.IndexOf(FSession)]).BringToFront();
end;

procedure TWWindow.SQLError(const Connection: TMySQLConnection; const ErrorCode: Integer; const ErrorMessage: string);
var
  Flags: Longint;
  Msg: string;
begin
  case (ErrorCode) of
    EE_READ: Msg := ErrorMessage;
    ER_DBACCESS_DENIED_ERROR: Msg := Preferences.LoadStr(165, IntToStr(ErrorCode), ErrorMessage);
    ER_ACCESS_DENIED_ERROR: Msg := Preferences.LoadStr(165, IntToStr(ErrorCode), ErrorMessage);
    ER_CANT_OPEN_LIBRARY: Msg := Preferences.LoadStr(570, Connection.LibraryName, ExtractFilePath(Application.ExeName));
    CR_COMMANDS_OUT_OF_SYNC: Msg := 'Internal Program Bug #' + IntToStr(ErrorCode) + ': ' + ErrorMessage;
    CR_CONN_HOST_ERROR: if (Connection.Port = MYSQL_PORT) then Msg := Preferences.LoadStr(495, Connection.Host) else Msg := Preferences.LoadStr(495, Connection.Host + ':' + IntToStr(Connection.Port));
    CR_SERVER_GONE_ERROR: if (Connection.Port = MYSQL_PORT) then Msg := Preferences.LoadStr(881, Connection.Host) else Msg := Preferences.LoadStr(881, Connection.Host + ':' + IntToStr(Connection.Port));
    CR_UNKNOWN_HOST: if (ErrorMessage <> '') then Msg := ErrorMessage else if (Connection.Host <> '') then Msg := Preferences.LoadStr(706, Connection.Host) else Msg := Preferences.LoadStr(706);
    CR_OUT_OF_MEMORY: Msg := Preferences.LoadStr(733);
    CR_SERVER_LOST: Msg := Preferences.LoadStr(806, TSConnection(Connection).Session.Caption);
    CR_HTTPTUNNEL_UNKNOWN_ERROR: Msg := ErrorMessage + #10#10 + Preferences.LoadStr(652) + ': ' + Connection.LibraryName;
    CR_HTTPTUNNEL_OLD: Msg := Preferences.LoadStr(659, Connection.LibraryName);
    CR_HTTPTUNNEL_CONN_ERROR: Msg := ErrorMessage;
    CR_HTTPTUNNEL_ACCESS_DENIED_ERROR: Msg := Preferences.LoadStr(860, Preferences.LoadStr(859), Copy(ErrorMessage, 1, Pos(' ', ErrorMessage) - 1)) + ':' + #10#10 + ErrorMessage  + #10#10 + ' (' + Connection.LibraryName + ')';
    CR_HTTPTUNNEL_NOT_FOUND: Msg := Preferences.LoadStr(523, Connection.LibraryName);
    CR_HTTPTUNNEL_INVALID_CONTENT_TYPE_ERROR: Msg := ErrorMessage;
    CR_HTTPTUNNEL_SERVER_ERROR: Msg := Preferences.LoadStr(860, Preferences.LoadStr(859), Copy(ErrorMessage, 1, Pos(' ', ErrorMessage) - 1)) + ':' + #10#10 + ErrorMessage  + #10#10 + ' (' + Connection.LibraryName + ')';
    CR_HTTPTUNNEL_INVALID_SERVER_RESPONSE,
    CR_IPSOCK_ERROR: Msg := ErrorMessage;
    DS_SET_NAMES: Msg := Preferences.LoadStr(878, ErrorMessage);
    DS_SERVER_OLD: Msg := Preferences.LoadStr(696, '3.23.20');
    DS_OUT_OF_MEMORY: Msg := Preferences.LoadStr(733);
    else
      if ((CR_MIN_ERROR <= ErrorCode) and (ErrorCode <= CR_MAX_ERROR)) then
        Msg := ErrorMessage
      else
        Msg := Preferences.LoadStr(165, IntToStr(ErrorCode), ErrorMessage);
  end;

  if (Msg <> '') then
  begin
    case (ErrorCode) of
      ER_DBACCESS_DENIED_ERROR,
      ER_ACCESS_DENIED_ERROR: MsgBoxHelpContext := 1145;
      CR_CONN_HOST_ERROR: MsgBoxHelpContext := 1146;
      CR_UNKNOWN_HOST: MsgBoxHelpContext := 1144;
      else MsgBoxHelpContext := 0;
    end;
    Flags := MB_OK + MB_ICONERROR;
    if (MsgBoxHelpContext <> 0) then
      Flags := Flags or MB_HELP;

    DisableApplicationActivate := True;
    MsgBox(Msg, Preferences.LoadStr(45), Flags);
    DisableApplicationActivate := False;
  end;
end;

procedure TWWindow.TabControlChange(Sender: TObject);
var
  Tab: TFSession;
begin
  if ((0 <= TabControl.TabIndex) and (TabControl.TabIndex < FSessions.Count)) then
  begin
    Tab := TFSession(FSessions[TabControl.TabIndex]);

    Perform(UM_ACTIVATETAB, 0, LPARAM(Tab));
  end;
end;

procedure TWWindow.TabControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (Assigned(ActiveTab)) then
    Perform(UM_DEACTIVATETAB, 0, 0);
end;

procedure TWWindow.TabControlContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  I: Integer;
  MenuItem: TMenuItem;
begin
  mtTabs.Clear();
  if (TabControl.Tabs.Count > 1) then
    for I := 0 to FSessions.Count - 1 do
    begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := TFSession(FSessions[I]).ToolBarData.Caption;
      MenuItem.RadioItem := True;
      MenuItem.Checked := I = TabControl.TabIndex;
      MenuItem.OnClick := mtTabsClick;
      mtTabs.Add(MenuItem);
    end;

  ShowEnabledItems(MTabControl.Items);
end;

procedure TWWindow.TabControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I: Integer;
  NewTabIndex: Integer;
begin
  NewTabIndex := GetNewTabIndex(Sender, X, Y);

  FSessions.Move(TabControlDragStartTabIndex, NewTabIndex);

  TabControl.Tabs.Clear();
  for I := 0 to FSessions.Count - 1 do
    TabControl.Tabs.Add(TFSession(FSessions[I]).Session.Account.Name);

  TabControl.TabIndex := NewTabIndex;
end;

procedure TWWindow.TabControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  NewTabIndex: Integer;
begin
  NewTabIndex := GetNewTabIndex(Sender, X, Y);
  Accept := (Source = TabControl) and (NewTabIndex <> TabControlDragStartTabIndex);

  if ((TabControlDragStartTabIndex >= 0) and (NewTabIndex <> TabControlDragMarkedTabIndex)) then
    TabControl.Repaint();
  if (Accept) then
  begin
    TabControl.Canvas.Brush.Color := clBtnText;
    if (NewTabIndex < TabControlDragStartTabIndex) then
      TabControl.Canvas.FillRect(Rect(TabControl.TabRect(NewTabIndex).Left - 2, 0, TabControl.TabRect(NewTabIndex).Left + 2, TabControl.Height))
    else
      TabControl.Canvas.FillRect(Rect(TabControl.TabRect(NewTabIndex).Right - 2, 0, TabControl.TabRect(NewTabIndex).Right + 2, TabControl.Height));
    TabControlDragMarkedTabIndex := NewTabIndex;
  end;
end;

procedure TWWindow.TabControlEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  TabControl.Repaint();
end;

procedure TWWindow.TabControlGetImageIndex(Sender: TObject;
  TabIndex: Integer; var ImageIndex: Integer);
begin
  ImageIndex := iiServer;

  if (ImageIndex < 0) then
    ImageIndex := iiServer;
end;

procedure TWWindow.TabControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AllowChange: Boolean;
  I: Integer;
begin
  if (Button = mbRight) then
    for I := 0 to TabControl.Tabs.Count - 1 do
      if ((TabControl.TabRect(I).Left <= X) and (X <= TabControl.TabRect(I).Right)) then
      begin
        AllowChange := True;
        TabControlChanging(Sender, AllowChange);
        if (AllowChange) then
        begin
          TabControl.TabIndex := I;
          TabControlChange(Sender);
        end;
      end;
end;

procedure TWWindow.TabControlMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Index: Integer;
  S: string;
  Tab: TFSession;
begin
  Index := TabControl.IndexOfTabAt(X, Y);
  if ((Index < 0) or (FSessions.Count <= Index)) then
    TabControl.Hint := ''
  else
  begin
    Tab := TFSession(FSessions[Index]);

    S := Tab.Session.Account.Connection.Host;
    if (Tab.Session.Account.Connection.Port <> MYSQL_PORT) then
      S := S + ':' + IntToStr(Tab.Session.Account.Connection.Port);
    if (Tab.ToolBarData.Caption <> '') then
      S := S + ' - ' + Tab.ToolBarData.Caption;
    TabControl.Hint := S;
  end;
end;

procedure TWWindow.TabControlResize(Sender: TObject);
begin
  if (TabControl.Tabs.Count > 0) then
  begin
    TBTabControl.Left := TabControl.TabRect(TabControl.Tabs.Count - 1).Right + 5;
    TBTabControl.Top := TabControl.Top + 1;
    TBTabControl.Width := TabControl.Width - TBTabControl.Left;
    TBTabControl.Height := TabControl.Height - 3;
  end
  else
  begin
    TBTabControl.Left := CToolBar.Left;
    TBTabControl.Top := CToolBar.Top + CToolBar.Height;
    TBTabControl.Width := CToolBar.Width;
    TBTabControl.Height := TabControl.Height - 3;
  end
end;

procedure TWWindow.TabControlStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  TabControlDragStartTabIndex := TabControl.TabIndex;
  TabControlDragMarkedTabIndex := -1;
end;

procedure TWWindow.tbPropertiesClick(Sender: TObject);
begin
  ActiveTab.ToolBarData.tbPropertiesAction.Execute();
end;

procedure TWWindow.UMActivateTab(var Message: TMessage);
begin
  ActiveTab := TFSession(Message.LParam);

  Color := clBtnFace;

  if (ActiveTab.Visible) then
    SendMessage(ActiveTab.Handle, UM_ACTIVATEFRAME, 0, 0);

  tbDBPrev.Action := ActiveTab.aDPrev;
  tbDBFirst.Action := ActiveTab.DataSetFirst;
  tbDBLast.Action := ActiveTab.DataSetLast;
  tbDBNext.Action := ActiveTab.aDNext;
  tbPostRecord.Action := ActiveTab.DataSetPost;
  tbCancelRecord.Action := ActiveTab.DataSetCancel;

  tbDBPrev.Hint := ActiveTab.aDPrev.Caption + ' (' + ShortCutToText(VK_PRIOR) + ')';
  tbDBFirst.Hint := ActiveTab.DataSetFirst.Caption + ' (' + ShortCutToText(scCtrl + VK_HOME) + ')';
  tbDBLast.Hint := ActiveTab.DataSetLast.Caption + ' (' + ShortCutToText(scCtrl + VK_END) + ')';
  tbDBNext.Hint := ActiveTab.aDNext.Caption + ' (' + ShortCutToText(VK_NEXT) + ')';

  aFClose.Enabled := True;

  Perform(UM_UPDATETOOLBAR, 0, Message.LParam);

  Message.Result := 1;
end;

procedure TWWindow.UMAddTab(var Message: TMessage);
var
  FSession: TFSession;
begin
  DAccounts.Open := True;
  DAccounts.Account := nil;
  DAccounts.Session := nil;
  if (Copy(StrPas(PChar(Message.LParam)), 1, 8) = 'mysql://') then
  begin
    DAccounts.Account := Accounts.AccountByURI(PChar(Message.LParam));
    if (Assigned(DAccounts.Account)) then
    begin
      DConnecting.Session := TSSession.Create(Sessions, DAccounts.Account);
      if (not DConnecting.Execute()) then
        DConnecting.Session.Free()
      else
        DAccounts.Session := DConnecting.Session;
    end;
  end;
  if (not Assigned(DAccounts.Session) and not DAccounts.Execute()) then
    FSession := nil
  else
  begin
    Perform(UM_DEACTIVATETAB, 0, 0);

    if (FSessions.Count = 0) then
    begin
      TabControl.Tabs.Add(DAccounts.Session.Account.Name);
      TabControl.Visible := Preferences.TabsVisible;
      if (TabControl.Visible) then
        TabControlResize(nil);
    end
    else
    begin
      TabControl.Tabs.Add(DAccounts.Session.Account.Name);
      if (TabControl.Tabs.Count < 0) then
        raise ERangeError.Create(SRangeError);
      TabControl.TabIndex := TabControl.Tabs.Count - 1;
      if (not TabControl.Visible) then
      begin
        TabControl.Visible := True;
        TabControlResize(nil);
      end;
    end;

    FSession := TFSession.Create(Self, PWorkSpace, DAccounts.Session, PChar(Message.LParam));
    FSession.Visible := True;

    Inc(UniqueTabNameCounter);
    FSession.Name := FSession.ClassName + '_' + IntToStr(UniqueTabNameCounter);

    FSession.StatusBar := StatusBar;

    aFCloseAll.Enabled := True;

    FSessions.Add(FSession);

    Perform(UM_ACTIVATETAB, 0, LPARAM(FSession));

    TBTabControl.Visible := TabControl.Visible;
  end;

  Message.Result := LRESULT(Assigned(FSession));
end;

procedure TWWindow.UMChangePreferences(var Message: TMessage);
var
  I: Integer;
begin
  ToolBar.Images := Preferences.Images;
  TabControl.Images := Preferences.Images;
  TBTabControl.Images := Preferences.Images;

  Perform(CM_SYSFONTCHANGED, 0, 0);

  if (not CheckWin32Version(6)) then
    ToolBar.BorderWidth := 0
  else
    ToolBar.BorderWidth := 2;

  TabControl.Canvas.Font := Font;

  Caption := LoadStr(1000);

  miFile.Caption := Preferences.LoadStr(3);
  aFOpenAccount.Caption := Preferences.LoadStr(1) + '...';
  aFOpen.Caption := Preferences.LoadStr(581) + '...';
  aFSave.Caption := Preferences.LoadStr(582);
  aFSaveAs.Caption := Preferences.LoadStr(583) + '...';
  miFReopen.Caption := Preferences.LoadStr(885);
  miFImport.Caption := Preferences.LoadStr(371);
  aFImportSQL.Caption := Preferences.LoadStr(409) + '...';
  aFImportText.Caption := Preferences.LoadStr(410) + '...';
  aFImportExcel.Caption := Preferences.LoadStr(801) + '...';
  aFImportAccess.Caption := Preferences.LoadStr(695) + '...';
  aFImportODBC.Caption := Preferences.LoadStr(607) + '...';
  miFExport.Caption := Preferences.LoadStr(200);
  aFExportSQL.Caption := Preferences.LoadStr(409) + '...';
  aFExportText.Caption := Preferences.LoadStr(410) + '...';
  aFExportExcel.Caption := Preferences.LoadStr(801) + '...';
  aFExportAccess.Caption := Preferences.LoadStr(695) + '...';
  aFExportODBC.Caption := Preferences.LoadStr(607) + '...';
  aFExportHTML.Caption := Preferences.LoadStr(453) + '...';
  aFExportXML.Caption := Preferences.LoadStr(454) + '...';
  aFExportPDF.Caption := Preferences.LoadStr(890) + '...';
  aFExportBitmap.Caption := Preferences.LoadStr(868) + '...';
  aFClose.Caption := Preferences.LoadStr(7);
  aFExit.Caption := Preferences.LoadStr(8);

  miEdit.Caption := Preferences.LoadStr(62);
  aEUndo.Caption := Preferences.LoadStr(425);
  aERedo.Caption := Preferences.LoadStr(705);
  aECut.Caption := Preferences.LoadStr(63);
  aECopy.Caption := Preferences.LoadStr(64);
  aEPaste.Caption := Preferences.LoadStr(65);
  aEDelete.Caption := Preferences.LoadStr(28);
  aESelectAll.Caption := Preferences.LoadStr(572);
  aECopyToFile.Caption := Preferences.LoadStr(182) + '...';
  aEPasteFromFile.Caption := Preferences.LoadStr(183) + '...';
  aERename.Caption := Preferences.LoadStr(98);

  miSearch.Caption := Preferences.LoadStr(424);
  aSSearchFind.Caption := Preferences.LoadStr(187) + '...';
  aSSearchReplace.Caption := Preferences.LoadStr(416) + '...';
  aSSearchNext.Caption := Preferences.LoadStr(188);

  miView.Caption := Preferences.LoadStr(9);
  aVObjectBrowser.Caption := Preferences.LoadStr(4);
  aVDataBrowser.Caption := Preferences.LoadStr(5);
  aVObjectIDE.Caption := Preferences.LoadStr(865);
  aVQueryBuilder.Caption := Preferences.LoadStr(852);
  aVDiagram.Caption := Preferences.LoadStr(800);
  aVSQLEditor.Caption := Preferences.LoadStr(6);
  aVSQLEditor2.Caption := Preferences.LoadStr(6) + ' #2';
  aVSQLEditor3.Caption := Preferences.LoadStr(6) + ' #3';
  miVSidebar.Caption := Preferences.LoadStr(736);
  aVNavigator.Caption := Preferences.LoadStr(10);
  aVExplorer.Caption := Preferences.LoadStr(435);
  aVJobs.Caption := Preferences.LoadStr(896);
  aVSQLHistory.Caption := Preferences.LoadStr(807);
  aVSQLLog.Caption := Preferences.LoadStr(11);
  aVRefresh.Caption := Preferences.LoadStr(41);
  aVRefreshAll.Caption := Preferences.LoadStr(623);

  miDatabase.Caption := Preferences.LoadStr(38);
  miDCreate.Caption := Preferences.LoadStr(26);
  aDCreateDatabase.Caption := Preferences.LoadStr(38) + '...';
  aDCreateTable.Caption := Preferences.LoadStr(302) + '...';
  aDCreateView.Caption := Preferences.LoadStr(738) + '...';
  aDCreateProcedure.Caption := Preferences.LoadStr(768) + '...';
  aDCreateFunction.Caption := Preferences.LoadStr(769) + '...';
  aDCreateTrigger.Caption := Preferences.LoadStr(788) + '...';
  aDCreateEvent.Caption := Preferences.LoadStr(812) + '...';
  aDCreateKey.Caption := Preferences.LoadStr(163) + '...';
  aDCreateField.Caption := Preferences.LoadStr(164) + '...';
  aDCreateForeignKey.Caption := Preferences.LoadStr(248) + '...';
  aDCreateUser.Caption := Preferences.LoadStr(561) + '...';
  miDDelete.Caption := Preferences.LoadStr(28);
  aDDeleteDatabase.Caption := Preferences.LoadStr(38);
  aDDeleteTable.Caption := Preferences.LoadStr(302);
  aDDeleteView.Caption := Preferences.LoadStr(738);
  aDDeleteRoutine.Caption := Preferences.LoadStr(774);
  aDDeleteKey.Caption := Preferences.LoadStr(163);
  aDDeleteField.Caption := Preferences.LoadStr(164);
  aDDeleteForeignKey.Caption := Preferences.LoadStr(248);
  aDDeleteTrigger.Caption := Preferences.LoadStr(788);
  aDDeleteEvent.Caption := Preferences.LoadStr(812);
  aDDeleteUser.Caption := Preferences.LoadStr(561);
  aDDeleteProcess.Caption := Preferences.LoadStr(562);
  miDProperties.Caption := Preferences.LoadStr(97);
  aDEditServer.Caption := Preferences.LoadStr(37) + '...';
  aDEditDatabase.Caption := Preferences.LoadStr(38) + '...';
  aDEditTable.Caption := Preferences.LoadStr(302) + '...';
  aDEditView.Caption := Preferences.LoadStr(738) + '...';
  aDEditRoutine.Caption := Preferences.LoadStr(774) + '...';
  aDEditKey.Caption := Preferences.LoadStr(163) + '...';
  aDEditField.Caption := Preferences.LoadStr(164) + '...';
  aDEditForeignKey.Caption := Preferences.LoadStr(248) + '...';
  aDEditTrigger.Caption := Preferences.LoadStr(788) + '...';
  aDEditEvent.Caption := Preferences.LoadStr(812) + '...';
  aDEditProcess.Caption := Preferences.LoadStr(562) + '...';
  aDEditUser.Caption := Preferences.LoadStr(561) + '...';
  aDEditVariable.Caption := Preferences.LoadStr(267) + '...';
  aDInsertRecord.Caption := Preferences.LoadStr(179);
  aDDeleteRecord.Caption := Preferences.LoadStr(178);
  aDEditRecord.Caption := Preferences.LoadStr(500);
  aDPostRecord.Caption := Preferences.LoadStr(516);
  aDCancelRecord.Caption := Preferences.LoadStr(517);
  aDCancel.Caption := Preferences.LoadStr(517);
  aDRun.Caption := Preferences.LoadStr(174);
  aDRunSelection.Caption := Preferences.LoadStr(175);
  aDPostObject.Caption := Preferences.LoadStr(582);
  aDEmpty.Caption := Preferences.LoadStr(181);

  miOptions.Caption := Preferences.LoadStr(13);
  aOGlobals.Caption := Preferences.LoadStr(52) + '...';
  aOAccounts.Caption := Preferences.LoadStr(25) + '...';
  aOImport.Caption := Preferences.LoadStr(371) + '...';
  aOExport.Caption := Preferences.LoadStr(200) + '...';

  miExtras.Caption := Preferences.LoadStr(707);
  aEFind.Caption := Preferences.LoadStr(187) + '...';
  aEReplace.Caption := Preferences.LoadStr(416) + '...';
  aETransfer.Caption := Preferences.LoadStr(753) + '...';
  miEJobs.Caption := Preferences.LoadStr(896);
  miEJobAdd.Caption := Preferences.LoadStr(26);
  aEJobAddImport.Caption := Preferences.LoadStr(371) + '...';
  aEJobAddExport.Caption := Preferences.LoadStr(200) + '...';
  aEJobDelete.Caption := Preferences.LoadStr(28);
  aEJobEdit.Caption := Preferences.LoadStr(97) + '...';
  aEFormatSQL.Caption := Preferences.LoadStr(921);

  miHelp.Caption := Preferences.LoadStr(167);
  aHIndex.Caption := Preferences.LoadStr(653) + '...';
  aHSQL.Caption := Preferences.LoadStr(883) + '...';
  aHManual.Caption := Preferences.LoadStr(573);
  aHUpdate.Caption := Preferences.LoadStr(666) + '...';
  aHInfo.Caption := Preferences.LoadStr(168) + '...';

  for I := 0 to ActionList.ActionCount - 1 do
    if (ActionList.Actions[I] is TCustomAction) and (TCustomAction(ActionList.Actions[I]).Hint = '') then
      TCustomAction(ActionList.Actions[I]).Hint := TCustomAction(ActionList.Actions[I]).Caption;

  mtTabs.Caption := Preferences.LoadStr(851);

  SetToolBarHints(ToolBar);
  tbCreateDatabase.Hint := Preferences.LoadStr(147) + '...';
  tbDeleteDatabase.Hint := Preferences.LoadStr(28);
  tbCreateTable.Hint := Preferences.LoadStr(383) + '...';
  tbDeleteTable.Hint := Preferences.LoadStr(28);
  tbCreateIndex.Hint := Preferences.LoadStr(160) + '...';
  tbDeleteIndex.Hint := Preferences.LoadStr(28);
  tbCreateField.Hint := Preferences.LoadStr(87) + '...';
  tbDeleteField.Hint := Preferences.LoadStr(28);
  tbCreateForeignKey.Hint := Preferences.LoadStr(249) + '...';
  tbDeleteForeignKey.Hint := Preferences.LoadStr(28);
  tbProperties.Hint := Preferences.LoadStr(97) + '...';
  tbPostRecord.Hint := Preferences.LoadStr(516);
  tbCancelRecord.Hint := Preferences.LoadStr(517);


  SetToolBarHints(TBTabControl);


  Highlighter.CommentAttri.Foreground := Preferences.Editor.CommentForeground;
  Highlighter.CommentAttri.Background := Preferences.Editor.CommentBackground;
  Highlighter.CommentAttri.Style := Preferences.Editor.CommentStyle;
  Highlighter.ConditionalCommentAttri.Foreground := Preferences.Editor.ConditionalCommentForeground;
  Highlighter.ConditionalCommentAttri.Background := Preferences.Editor.ConditionalCommentBackground;
  Highlighter.ConditionalCommentAttri.Style := Preferences.Editor.ConditionalCommentStyle;
  Highlighter.DataTypeAttri.Foreground := Preferences.Editor.DataTypeForeground;
  Highlighter.DataTypeAttri.Background := Preferences.Editor.DataTypeBackground;
  Highlighter.DataTypeAttri.Style := Preferences.Editor.DataTypeStyle;
  Highlighter.DelimitedIdentifierAttri.Foreground := Preferences.Editor.IdentifierForeground;
  Highlighter.DelimitedIdentifierAttri.Background := Preferences.Editor.IdentifierBackground;
  Highlighter.DelimitedIdentifierAttri.Style := Preferences.Editor.IdentifierStyle;
  Highlighter.FunctionAttri.Foreground := Preferences.Editor.FunctionForeground;
  Highlighter.FunctionAttri.Background := Preferences.Editor.FunctionBackground;
  Highlighter.FunctionAttri.Style := Preferences.Editor.FunctionStyle;
  Highlighter.IdentifierAttri.Foreground := Preferences.Editor.IdentifierForeground;
  Highlighter.IdentifierAttri.Background := Preferences.Editor.IdentifierBackground;
  Highlighter.IdentifierAttri.Style := Preferences.Editor.IdentifierStyle;
  Highlighter.KeyAttri.Foreground := Preferences.Editor.KeywordForeground;
  Highlighter.KeyAttri.Background := Preferences.Editor.KeywordBackground;
  Highlighter.KeyAttri.Style := Preferences.Editor.KeywordStyle;
  Highlighter.NumberAttri.Foreground := Preferences.Editor.NumberForeground;
  Highlighter.NumberAttri.Background := Preferences.Editor.NumberBackground;
  Highlighter.NumberAttri.Style := Preferences.Editor.NumberStyle;
  Highlighter.PLSQLAttri.Foreground := Preferences.Editor.KeywordForeground;
  Highlighter.PLSQLAttri.Background := Preferences.Editor.KeywordBackground;
  Highlighter.PLSQLAttri.Style := Preferences.Editor.KeywordStyle;
  Highlighter.StringAttri.Foreground := Preferences.Editor.StringForeground;
  Highlighter.StringAttri.Background := Preferences.Editor.StringBackground;
  Highlighter.StringAttri.Style := Preferences.Editor.StringStyle;
  Highlighter.VariableAttri.Foreground := Preferences.Editor.VariableForeground;
  Highlighter.VariableAttri.Background := Preferences.Editor.VariableBackground;
  Highlighter.VariableAttri.Style := Preferences.Editor.VariableStyle;

  try
    acQBLanguageManager.CurrentLanguageIndex := -1;
    for I := 0 to acQBLanguageManager.LanguagesCount - 1 do
      if (lstrcmpi(PChar(acQBLanguageManager.Language[i].LanguageName), PChar(Preferences.Language.ActiveQueryBuilderLanguageName)) = 0) then
        acQBLanguageManager.CurrentLanguageIndex := I;
  except
    // There is a bug inside acQBLocalizer.pas ver. 1.18 - but it's not interested to get informed
  end;

  if (Assigned(FSessions)) then
    for I := 0 to FSessions.Count - 1 do
      SendMessage(TFSession(FSessions[0]).Handle, Message.Msg, Message.WParam, Message.LParam);
end;

procedure TWWindow.UMDeactivateTab(var Message: TMessage);
var
  I: Integer;
begin
  if (Assigned(ActiveTab)) then
  begin
    SendMessage(ActiveTab.Handle, UM_DEACTIVATEFRAME, 0, 0);

    TabControl.TabIndex := -1;

    Caption := LoadStr(1000);

    aFClose.Enabled := False;


    aVObjectBrowser.Checked := False;
    aVDataBrowser.Checked := False;
    aVObjectIDE.Checked := False;
    aVQueryBuilder.Checked := False;
    aVSQLEditor.Checked := False;
    aVSQLEditor2.Checked := False;
    aVSQLEditor3.Checked := False;
    aVNavigator.Checked := False;
    aVExplorer.Checked := False;
    aVJobs.Checked := False;
    aVSQLHistory.Checked := False;
    aVSQLLog.Checked := False;
    tbVRefresh.Enabled := False;

    aFOpen.Enabled := False;
    aFSave.Enabled := False;
    aFSaveAs.Enabled := False;
    aECopy.Enabled := False;
    aEPaste.Enabled := False;
    aVObjectBrowser.Enabled := False;
    aVDataBrowser.Enabled := False;
    aVObjectIDE.Enabled := False;
    aVQueryBuilder.Enabled := False;
    aVDiagram.Enabled := False;
    aVSQLEditor.Enabled := False;
    aVSQLEditor2.Enabled := False;
    aVSQLEditor3.Enabled := False;
    aVNavigator.Enabled := False;
    aVExplorer.Enabled := False;
    aVJobs.Enabled := False;
    aVSQLHistory.Enabled := False;
    aVSQLLog.Enabled := False;
    aDCancel.Enabled := False;
    aDInsertRecord.Enabled := False;
    aDDeleteRecord.Enabled := False;
    aDRun.Enabled := False;
    aDRunSelection.Enabled := False;
    aHManual.Enabled := False;

    miVRefresh.Enabled := False;
    miVRefreshAll.Enabled := False;
  end;

  Perform(UM_UPDATETOOLBAR, 0, 0);
  for I := 0 to StatusBar.Panels.Count - 1 do
    StatusBar.Panels[I].Text := '';
end;

procedure TWWindow.UMOnlineUpdateFound(var Message: TMessage);
begin
  if (Screen.ActiveForm <> Self) then
    OnlineRecommendedUpdateFound := True
  else
    InformOnlineUpdateFound();
end;

procedure TWWindow.UMPostShow(var Message: TMessage);
var
  ExecutePostShow: Boolean;
  I: Integer;
begin
  ExecutePostShow := False;

  if (ParamCount() = 0) then
    Perform(UM_ADDTAB, 0, 0)
  else
    for I := 1 to ParamCount() do
      HandleParam(ParamStr(I));

  if (ExecutePostShow and (FSessions.Count = 1)) then
    PostMessage(TFSession(FSessions[0]).Handle, UM_EXECUTE, 0, 0);
end;

procedure TWWindow.UMMySQLClientSynchronize(var Message: TMessage);
begin
  MySQLDB.MySQLConnectionSynchronize(Pointer(Message.LParam));
end;

procedure TWWindow.UMTerminate(var Message: TMessage);
begin
  CheckOnlineVersionThread.WaitFor();
  FreeAndNil(CheckOnlineVersionThread);
end;

procedure TWWindow.UMUpdateToolbar(var Message: TMessage);
var
  Found: Boolean;
  I: Integer;
  MenuItem: TMenuItem;
  S: string;
  Tab: TFSession;
begin
  Tab := TFSession(Message.LParam);

  for I := ToolBar.ButtonCount - 1 downto ToolButton11.Index do
    ToolBar.Buttons[I].Visible := False;

  if (not Assigned(Tab)) then
  begin
    Caption := LoadStr(1000);
    Application.Title := Caption;
  end
  else if (Tab = ActiveTab) then
  begin
    S := Tab.Session.Caption;
    if (Tab.ToolBarData.Caption <> '') then
      S := S + ' - ' + Tab.ToolBarData.Caption;
    Caption := S + ' - ' + LoadStr(1000);
    Application.Title := Caption;

    tbProperties.Action := Tab.ToolBarData.tbPropertiesAction;
    tbProperties.Caption := Preferences.LoadStr(97) + '...';
    tbProperties.ImageIndex := 11;
  end;

  tbCreateDatabase.Visible   := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbDeleteDatabase.Visible   := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbCreateTable.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects, vDiagram]);
  tbDeleteTable.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects, vDiagram]);
  tbCreateIndex.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbDeleteIndex.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbCreateField.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbDeleteField.Visible      := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects]);
  tbCreateForeignKey.Visible := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects, vDiagram]);
  tbDeleteForeignKey.Visible := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects, vDiagram]);
  tbProperties.Visible       := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vObjects, vDiagram]);

  tbOpen.Visible             := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbSave.Visible             := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbUndo.Visible             := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbRedo.Visible             := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbSearchFind.Visible       := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbSearchReplace.Visible    := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbRun.Visible              := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vBuilder, vEditor, vEditor2, vEditor3]);
  tbRunSelection.Visible     := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vEditor, vEditor2, vEditor3]);
  tbPostObject.Visible       := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE]);
  tbFormatSQL.Visible        := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vIDE, vEditor, vEditor2, vEditor3]);

  tbDBFirst.Visible          := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser, vBuilder, vEditor, vEditor2, vEditor3]);
  tbDBPrev.Visible           := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser]);
  tbDBNext.Visible           := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser]);
  tbDBLast.Visible           := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser, vBuilder, vEditor, vEditor2, vEditor3]);
  tbDInsertRecord.Visible    := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser, vBuilder, vEditor, vEditor2, vEditor3]);
  tbDDeleteRecord.Visible    := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser, vBuilder, vEditor, vEditor2, vEditor3]);
  tbPostRecord.Visible       := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser]);
  tbCancelRecord.Visible     := Assigned(Tab) and Tab.Visible and (Tab.ToolBarData.View in [vBrowser]);

  // Auto hide unneeded separator buttons
  Found := False;
  for I := ToolBar.ButtonCount - 1 downto ToolButton11.Index do
    if (ToolBar.Buttons[I].ImageIndex >= 0) then
      Found := Found or ToolBar.Buttons[I].Visible
    else
    begin
      ToolBar.Buttons[I].Visible := Found;
      Found := False;
    end;

  Found := False;
  for I := ToolBar.ButtonCount - 1 downto ToolButton11.Index do
    Found := Found or ToolBar.Buttons[I].Visible and (ToolBar.Buttons[I].ImageIndex >= 0) and (ToolBar.Buttons[I].Width <> ToolBar.ButtonWidth);
  if (Found) then
    Toolbar.ButtonWidth := 0; // Without this, the Buttons are too small. Why??? A Delphi bug?

  while (miFReopen.Count > 1) do
    miFReopen.Delete(0);
  miFReopen.Enabled := Assigned(Tab) and (Tab.ToolBarData.View in [vEditor, vEditor2, vEditor3]) and (Tab.Session.Account.Desktop.Files.Count > 0);
  if (miFReopen.Enabled) then
  begin
    for I := 0 to Tab.Session.Account.Desktop.Files.Count - 1 do
    begin
      MenuItem := TMenuItem.Create(Owner);
      MenuItem.Caption := '&' + IntToStr(miFReopen.Count) + ' ' + Tab.Session.Account.Desktop.Files[I].Filename;
      MenuItem.OnClick := miFReopenClick;
      MenuItem.Tag := I;
      miFReopen.Add(MenuItem);
    end;
    miFReopen.Delete(0);
  end;
end;

procedure TWWindow.WMCopyData(var Message: TWMCopyData);
begin
  SetForegroundWindow(Application.Handle);
  if IsIconic(Application.Handle) then
  begin
    WindowState := wsNormal;
    Application.Restore();
  end;

  if (Assigned(Screen.ActiveForm) and (fsModal in Screen.ActiveForm.FormState)) then
  begin
    Application.BringToFront();
    MessageBeep(MB_ICONERROR);
  end
  else
    HandleParam(PChar(Message.CopyDataStruct^.lpData));
end;

procedure TWWindow.WMDrawItem(var Message: TWMDrawItem);
var
  Control: TControl;
begin
  Control := FindControl(Message.DrawItemStruct^.hwndItem);

  if ((Control is TTabControl) and TTabControl(Control).OwnerDraw) then
    Control.Perform(Message.Msg + CN_BASE, TMessage(Message).WParam, TMessage(Message).LParam)
  else
    inherited;
end;

procedure TWWindow.WMHelp(var Message: TWMHelp);
begin
  if (Message.HelpInfo.iContextType = HELPINFO_MENUITEM) then
    inherited
  else if (MsgBoxHelpContext <> 0) then
    Application.HelpCommand(HELP_CONTEXT, MsgBoxHelpContext);
end;

procedure TWWindow.WMTimer(var Message: TWMTimer);
begin
  case (Message.TimerID) of
    tiDeactivate:
      EmptyWorkingMem();
  end;
end;

end.
