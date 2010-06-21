unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, FileCtrl, ComCtrls, Spin, Gauges, ExtCtrls,
  Support, Options, CoolTrayIcon, TextTrayIcon, Globals, Utils, DBase, Math,
  FileUtil, ImgList, OptionsControl;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Gauge1: TGauge;
    Gauge2: TGauge;
    Gauge3: TGauge;
    Gauge4: TGauge;
    Memo1: TMemo;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TabSheet4: TTabSheet;
    GroupBox5: TGroupBox;
    Image1: TImage;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    BitBtn5: TBitBtn;
    GroupBox6: TGroupBox;
    Image2: TImage;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    BitBtn6: TBitBtn;
    GroupBox7: TGroupBox;
    ListBox1: TListBox;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    TextTrayIcon1: TTextTrayIcon;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox12: TGroupBox;
    BitBtn11: TBitBtn;
    Label42: TLabel;
    Label43: TLabel;
    ImageList1: TImageList;
    TabSheet5: TTabSheet;
    Panel1: TPanel;
    Image3: TImage;
    Label44: TLabel;
    Label45: TLabel;
    TabSheet6: TTabSheet;
    PageControl2: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    ListBox2: TListBox;
    Panel2: TPanel;
    BitBtn12: TBitBtn;
    CheckBox3: TCheckBox;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    CheckBox4: TCheckBox;
    Label49: TLabel;
    SpinEdit4: TSpinEdit;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    BitBtn13: TBitBtn;
    Label53: TLabel;
    Gauge6: TGauge;
    Label54: TLabel;
    Label55: TLabel;
    SpinEdit5: TSpinEdit;
    Label56: TLabel;
    Label57: TLabel;
    SpinEdit6: TSpinEdit;
    Label58: TLabel;
    GroupBox13: TGroupBox;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    TrackBar2: TTrackBar;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Label7: TLabel;
    Label26: TLabel;
    ComboBox1: TComboBox;
    Label27: TLabel;
    BitBtn4: TBitBtn;
    Label28: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckListBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckListBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn12Click(Sender: TObject);
    procedure SpinEdit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit2Exit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinEdit3Exit(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TextTrayIcon1DblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure ListBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
procedure ChangeOptions(Index: Integer); forward;

{$R *.DFM}

//============================================================================\\
// ProcessPriority
//============================================================================\\
Procedure ChangePriority(const NewPriority:Integer);
const Priorities:array[0..2]of String=('IDLE','NORMAL','HIGH');
begin;
case NewPriority of
  0:SetPriorityClass(GetCurrentProcess,IDLE_PRIORITY_CLASS);
  1:SetPriorityClass(GetCurrentProcess,NORMAL_PRIORITY_CLASS);
  2:SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS);
end;
Form1.ComboBox1.ItemIndex:=NewPriority;
Form1.Label27.Caption:='Current Priority: '+Priorities[NewPriority];
end;


//============================================================================\\
// DBSize
//============================================================================\\
Procedure UpdateDBSize;
var DBSize,Size1:Int64;
begin;
DBSize:=0;
Size1:=GetFileSize(ExtractFilePath(Application.ExeName)+'Data\DBase.nmb');
if Size1>-1 then DBSize:=DBSize+Size1;
Size1:=GetFileSize(ExtractFilePath(Application.ExeName)+'Data\DBase.idb');
if Size1>-1 then DBSize:=DBSize+Size1;
Size1:=GetFileSize(ExtractFilePath(Application.ExeName)+'Data\DBase.lst');
if Size1>-1 then DBSize:=DBSize+Size1;
Form1.Label54.Caption:='DataBase Size: '+FileSizeToStr(DBSize);
end;


//============================================================================\\
// Folder Management
//============================================================================\\
// Add Old Folder
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
AddFolder(Form1.CheckListBox1,TWinControl(Form1.DirectoryListBox1),Form1.DirectoryListBox1.GetItemPath(Form1.DirectoryListBox1.ItemIndex));
end;

// Add New Folder
procedure TForm1.BitBtn2Click(Sender: TObject);
begin
AddFolder(Form1.CheckListBox2,TWinControl(Form1.DirectoryListBox1),Form1.DirectoryListBox1.GetItemPath(Form1.DirectoryListBox1.ItemIndex));
end;

// Add Excluded Folder
procedure TForm1.BitBtn3Click(Sender: TObject);
begin
AddFolder(Form1.CheckListBox3,TWinControl(Form1.DirectoryListBox1),Form1.DirectoryListBox1.GetItemPath(Form1.DirectoryListBox1.ItemIndex));
end;

// Change Old Folder's IncludeSubFolders Status
procedure TForm1.CheckListBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Pos:TPoint;
begin
Pos.x:=X;
Pos.y:=Y;
ChangeIncludeSubFoldersStatus(Form1.CheckListBox1,Form1.CheckListBox1.ItemAtPos(Pos,True));
end;

// Change New Folder's IncludeSubFolders Status
procedure TForm1.CheckListBox2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Pos:TPoint;
begin
Pos.x:=X;
Pos.y:=Y;
ChangeIncludeSubFoldersStatus(Form1.CheckListBox2,Form1.CheckListBox2.ItemAtPos(Pos,True));
end;

// Change Excluded Folder's IncludeSubFolders Status
procedure TForm1.CheckListBox3MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Pos:TPoint;
begin
Pos.x:=X;
Pos.y:=Y;
ChangeIncludeSubFoldersStatus(Form1.CheckListBox3,Form1.CheckListBox3.ItemAtPos(Pos,True));
end;

// Delete Old Folder
procedure TForm1.CheckListBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if Key=VK_DELETE then DeleteFolders(Form1.CheckListBox1);
end;

// Delete New Folder
procedure TForm1.CheckListBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if Key=VK_DELETE then DeleteFolders(Form1.CheckListBox2);
end;

// Delete Excluded Folder
procedure TForm1.CheckListBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if Key=VK_DELETE then DeleteFolders(Form1.CheckListBox3);
end;


//============================================================================\\
// Tray Icon Routines
//============================================================================\\
procedure SetCaption(const s,IconStr:String);
begin;
Form1.Caption:=s+' - '+DefaultCaption;
Form1.TextTrayIcon1.Hint:=Form1.Caption;
Application.Title:=Form1.Caption;
if IconStr='' then
  begin;
  Form1.TextTrayIcon1.Border:=False;
  Form1.TextTrayIcon1.Icon:=Application.Icon;
  end
else
  begin;
  Form1.TextTrayIcon1.Border:=True;
  Form1.TextTrayIcon1.Text:=IconStr;
  end;
end;

procedure TForm1.TextTrayIcon1DblClick(Sender: TObject);
begin
Form1.TextTrayIcon1.ShowMainForm;
end;



//============================================================================\\
// Form Initialization/Finalization
//============================================================================\\
procedure TForm1.FormCreate(Sender: TObject);
begin
LoadDirList(CheckListBox1,'Scanned Folders');
LoadDirList(CheckListBox2,'New Folders');
LoadDirList(CheckListBox3,'Exclude Folders');
ChangePriority(ProcessPriority);
Form1.PageControl1.ActivePageIndex:=0;
Form1.Label47.Caption:=Garbage;
Form1.Label47.Hint:=Form1.Label47.Caption;
Form1.CheckBox3.Checked:=AllowGarbage;
Form1.SpinEdit5.Value:=Difference;
Form1.SpinEdit6.Value:=Round((HWMlp-1)*100);
Form1.DirectoryListBox1.Directory:=DefDir;
Form1.CheckBox4.Checked:=AllowAutoSaving;
Form1.SpinEdit4.Value:=AutoSaveInterval;
Form1.CheckBox1.Checked:=CutFields;
//Form1.ListBox2.Selected[OptionsListPosition]:=True;
ChangeOptions(OptionsListPosition);
GlobalMemo:=Form1.Memo1;
GlobalLabel:=Form1.Label9;
GlobalSetCaption:=@SetCaption;
Form1.TextTrayIcon1.Icon:=Application.Icon;
Form1.OpenDialog1.Filter:='Results files (*'+ResultsExt+')|*'+ResultsExt;
Form1.SaveDialog1.Filter:='Results files (*'+ResultsExt+')|*'+ResultsExt;
Form1.SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
Form1.OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
if FileSizeIsGood then
  Form1.RadioGroup4.ItemIndex:=0
else
  Form1.RadioGroup4.ItemIndex:=1;
if ResolutionIsGood then
  Form1.RadioGroup3.ItemIndex:=0
else
  Form1.RadioGroup3.ItemIndex:=1;
Form1.TrackBar2.Position:=ResolutionEffectOnRating;
UpdateDBSize;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
Garbage:=Form1.Label47.Caption;
AllowGarbage:=Form1.CheckBox3.Checked;
Difference:=Form1.SpinEdit5.Value;
HWMlp:=Form1.SpinEdit6.Value/100+1;
DefDir:=Form1.DirectoryListBox1.Directory;
AllowAutoSaving:=Form1.CheckBox4.Checked;
AutoSaveInterval:=Form1.SpinEdit4.Value;
SaveDirList(CheckListBox1,'Scanned Folders');
SaveDirList(CheckListBox2,'New Folders');
SaveDirList(CheckListBox3,'Exclude Folders');
end;


//============================================================================\\
// Options
//============================================================================\\
procedure TForm1.BitBtn12Click(Sender: TObject);
var Dir:String;
begin
if SelectDirectory('Garbage...','',Dir) then
  begin;
  Form1.Label47.Hint:=Dir;
  Form1.Label47.Caption:=Dir;
  Garbage:=Form1.Label47.Caption;
  end;
end;

procedure TForm1.SpinEdit1Exit(Sender: TObject);
begin
if Form1.SpinEdit5.Text='' then Form1.SpinEdit5.Text:='0';
end;

procedure TForm1.SpinEdit2Exit(Sender: TObject);
begin
if Form1.SpinEdit6.Text='' then Form1.SpinEdit6.Text:='0';
end;

procedure TForm1.SpinEdit3Exit(Sender: TObject);
begin
if Form1.SpinEdit4.Text='' then Form1.SpinEdit4.Text:='0';
end;

procedure UpdateOptions;
begin;
Garbage:=Form1.Label47.Caption;
AllowGarbage:=Form1.CheckBox3.Checked;
Difference:=Form1.SpinEdit5.Value;
HWMlp:=Form1.SpinEdit6.Value/100+1;
DefDir:=Form1.DirectoryListBox1.Directory;
AllowAutoSaving:=Form1.CheckBox4.Checked;
AutoSaveInterval:=Form1.SpinEdit4.Value;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
AllowGarbage:=Form1.CheckBox3.Checked;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
Difference:=Form1.SpinEdit5.Value;
if Difference>MaxDifference then
  begin;
  Form1.SpinEdit5.Value:=MaxDifference;
  Difference:=MaxDifference;
  end;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
HWMlp:=Form1.SpinEdit6.Value/100+1;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
AllowAutoSaving:=Form1.CheckBox4.Checked;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
AutoSaveInterval:=Form1.SpinEdit4.Value;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
if Form1.RadioGroup4.ItemIndex=0 then FileSizeIsGood:=True
else FileSizeIsGood:=False;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
if Form1.RadioGroup3.ItemIndex=0 then ResolutionIsGood:=True
else ResolutionIsGood:=False;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
ResolutionEffectOnRating:=Form1.TrackBar2.Position;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
CutFields:=CheckBox1.Checked;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
ProcessPriority:=Form1.ComboBox1.ItemIndex;
ChangePriority(ProcessPriority);
end;


//============================================================================\\
// Results
//============================================================================\\
procedure DisplayResults(n:Integer);
var Bmp:TBitMap;
    h,w:Integer;
begin;
if n<0 then
  begin;
  Form1.Image1.Canvas.Brush.Color:=clBtnFace;
  Form1.Image1.Canvas.FillRect(Rect(0,0,Form1.Image1.Width,Form1.Image1.Height));
  Form1.GroupBox5.Caption:='Best File: File1';
  Form1.Label17.Caption:='';
  Form1.Label17.Hint:='';
  Form1.Label18.Caption:='';
  Form1.Label19.Caption:='';

  Form1.Image2.Canvas.Brush.Color:=clBtnFace;
  Form1.Image2.Canvas.FillRect(Rect(0,0,Form1.Image2.Width,Form1.Image2.Height));
  Form1.GroupBox6.Caption:='File2';
  Form1.Label23.Caption:='';
  Form1.Label23.Hint:='';
  Form1.Label24.Caption:='';
  Form1.Label25.Caption:='';
  end
else
  begin;
  Form1.Image1.Canvas.Brush.Color:=clBtnFace;
  Form1.Image1.Canvas.FillRect(Rect(0,0,Form1.Image1.Width,Form1.Image1.Height));
  Form1.GroupBox5.Caption:='Best File: '+ExtractFileName(Files[PEqualPair(Equals[n])[1]]);
  Form1.Label17.Caption:=Files[PEqualPair(Equals[n])[1]];
  Form1.Label17.Hint:=Form1.Label17.Caption;
  Form1.Label18.Caption:=FileSizeToStr(PResizedImage(Images[PEqualPair(Equals[n])[1]]).FileSize);
  Form1.Label19.Caption:=IntToStr(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Width)+'x'+IntToStr(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Height);
  try
    LoadImage(Bmp,Files[PEqualPair(Equals[n])[1]]);
    h:=min(Bmp.Height,Round(Bmp.Height*min(Form1.Image1.Height/Bmp.Height, Form1.Image1.Width/Bmp.Width)));
    w:=min(Bmp.Width,Round(Bmp.Width*min(Form1.Image1.Height/Bmp.Height, Form1.Image1.Width/Bmp.Width)));
    Form1.Image1.Canvas.StretchDraw(Rect((Form1.Image1.Width-w)div 2, (Form1.Image1.Height-h)div 2, (Form1.Image1.Width-w)div 2+w, (Form1.Image1.Height-h)div 2+h),Bmp);
    Bmp.Free;
    If CutFields then
      begin;
      If PResizedImage(Images[PEqualPair(Equals[n])[1]]).MidColor[1]+
         PResizedImage(Images[PEqualPair(Equals[n])[1]]).MidColor[2]+
         PResizedImage(Images[PEqualPair(Equals[n])[1]]).MidColor[3]<384 then
        Form1.Image1.Canvas.Brush.Color:=clWhite
      else
        Form1.Image1.Canvas.Brush.Color:=clBlack;
      Form1.Image1.Canvas.FrameRect(Rect(
      (Form1.Image1.Width -w)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Crop[2]*w),
      (Form1.Image1.Height-h)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Crop[0]*h),
      (Form1.Image1.Width -w)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Crop[3]*w),
      (Form1.Image1.Height-h)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[1]]).Crop[1]*h)));
      end;
  except
    on E:Exception do
      begin;
      Form1.Image1.Canvas.Brush.Color:=clBtnFace;      
      w:=Form1.Image1.Canvas.TextExtent('Preview not available').cx;
      h:=Form1.Image1.Canvas.TextExtent('Preview not available').cy;
      Form1.Image1.Canvas.TextOut(Form1.Image1.Width div 2-w div 2,Form1.Image1.Height div 2-h div 2,'Preview not available');
      end;
  end;

  Form1.Image2.Canvas.Brush.Color:=clBtnFace;
  Form1.Image2.Canvas.FillRect(Rect(0,0,Form1.Image2.Width,Form1.Image2.Height));
  Form1.GroupBox6.Caption:=ExtractFileName(Files[PEqualPair(Equals[n])[2]]);
  Form1.Label23.Caption:=Files[PEqualPair(Equals[n])[2]];
  Form1.Label23.Hint:=Form1.Label23.Caption;
  Form1.Label24.Caption:=FileSizeToStr(PResizedImage(Images[PEqualPair(Equals[n])[2]]).FileSize);
  Form1.Label25.Caption:=IntToStr(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Width)+'x'+IntToStr(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Height);
  try
    LoadImage(Bmp,Files[PEqualPair(Equals[n])[2]]);
    h:=min(Bmp.Height,Round(Bmp.Height*min(Form1.Image2.Height/Bmp.Height, Form1.Image2.Width/Bmp.Width)));
    w:=min(Bmp.Width,Round(Bmp.Width*min(Form1.Image2.Height/Bmp.Height, Form1.Image2.Width/Bmp.Width)));
    Form1.Image2.Canvas.StretchDraw(Rect((Form1.Image2.Width-w)div 2, (Form1.Image2.Height-h)div 2, (Form1.Image2.Width-w)div 2+w, (Form1.Image2.Height-h)div 2+h),Bmp);
    Bmp.Free;
    If CutFields then
      begin;
      If PResizedImage(Images[PEqualPair(Equals[n])[2]]).MidColor[1]+
         PResizedImage(Images[PEqualPair(Equals[n])[2]]).MidColor[2]+
         PResizedImage(Images[PEqualPair(Equals[n])[2]]).MidColor[3]<384 then
        Form1.Image2.Canvas.Brush.Color:=clWhite
      else
        Form1.Image2.Canvas.Brush.Color:=clBlack;
      Form1.Image2.Canvas.FrameRect(Rect(
      (Form1.Image2.Width -w)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Crop[2]*w),
      (Form1.Image2.Height-h)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Crop[0]*h),
      (Form1.Image2.Width -w)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Crop[3]*w),
      (Form1.Image2.Height-h)div 2+Round(PResizedImage(Images[PEqualPair(Equals[n])[2]]).Crop[1]*h)));
      end;
  except
    on E:Exception do
      begin;
      Form1.Image2.Canvas.Brush.Color:=clBtnFace;
      w:=Form1.Image2.Canvas.TextExtent('Preview not available').cx;
      h:=Form1.Image2.Canvas.TextExtent('Preview not available').cy;
      Form1.Image2.Canvas.TextOut(Form1.Image2.Width div 2-w div 2,Form1.Image2.Height div 2-h div 2,'Preview not available');
      end;
  end;

  end;
end;

procedure PrepareResults;
var i,j,h:Integer;
    k:Single;
begin;
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Preparing Results Started'#13#10;
if Equals.Count<>0 then
  begin;
  SetCaption('Preparing Results','');
  GlobalLabel.Caption:='Preparing Results...';
  GlobalGauge.MaxValue:=ResultsSteps;
  Form1.ListBox1.Clear;
  For i:=0 to Files.Count-1 do
    begin;
    if UpperCase(ExtractFileExt(Files[i]))='.BMP' then
      K:=1/10
    else
      K:=1;
    if ResolutionIsGood then
      k:=k*Power(PResizedImage(Images[i]).Height*PResizedImage(Images[i]).Width,0.5+(ResolutionEffectOnRating)/10)
    else
      k:=k*1000000/(Power(PResizedImage(Images[i]).Height*PResizedImage(Images[i]).Width,0.5+(ResolutionEffectOnRating)/10));
    if FileSizeIsGood then
      k:=k*Power(PResizedImage(Images[i]).FileSize,0.5+(10-ResolutionEffectOnRating)/10)
    else
      k:=k*1000000/(Power(PResizedImage(Images[i]).FileSize,0.5+(10-ResolutionEffectOnRating)/10));
    if Integer(Files.Objects[i])=1 then k:=k*1.0001;
    Files.Objects[i]:=TObject(k);
    end;

  For j:=0 to ResultsSteps do
    begin;
    For i:=(((Equals.Count)*j) div (ResultsSteps+1)) to (((Equals.Count)*(j+1)) div (ResultsSteps+1)-1) do
      begin;
      If Single(Files.Objects[PEqualPair(Equals[i])[1]])<Single(Files.Objects[PEqualPair(Equals[i])[2]]) then
        begin;
        h:=PEqualPair(Equals[i])[1];
        PEqualPair(Equals[i])[1]:=PEqualPair(Equals[i])[2];
        PEqualPair(Equals[i])[2]:=h;
        end;
      Form1.ListBox1.Items.Add(ExtractFileName(Files[PEqualPair(Equals[i])[1]])+' and '+ExtractFileName(Files[PEqualPair(Equals[i])[2]]));
      end;
    GlobalGauge.AddProgress(1);
    Application.ProcessMessages;
    end;
  Form1.ListBox1.ItemIndex:=0;
  DisplayResults(0);
  Form1.TextTrayIcon1.ShowBalloonHint('Comparing completed',IntToStr(Equals.Count)+' duplicates found',bitInfo,10);
  end
else
  begin;
  GlobalGauge.MaxValue:=1;
  GlobalGauge.Progress:=1;
  Form1.TextTrayIcon1.ShowBalloonHint('Comparing completed','No duplicates found',bitInfo,10);
  end;
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Preparing Results Completed'#13#10;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
try
if FileExists(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[1]]) then
  ExecuteFile(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[1]],'',ExtractFilePath(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[1]]),SW_MAXIMIZE);
except
  on E:Exception do begin;end;
end;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
try
if FileExists(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[2]]) then
  ExecuteFile(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[2]],'',ExtractFilePath(Files[PEqualPair(Equals[Form1.ListBox1.ItemIndex])[2]]),SW_MAXIMIZE);
except
  on E:Exception do begin;end;
end;
end;

Procedure RemoveFile(const k:Integer; DoDisplayResults:Boolean);
var i:Integer;
    Selection:Integer;
    Index:Integer;
begin
if Form1.ListBox1.ItemIndex<0 then Exit;
Selection:=Form1.ListBox1.ItemIndex;
If not(AllowGarbage) then
  DeleteFile(Files[PEqualPair(Equals[selection])[k]])
else
  MoveFileToGarbage(Files[PEqualPair(Equals[selection])[k]]);
Index:=PEqualPair(Equals[selection])[k];
For i:=Form1.ListBox1.Items.Count-1 downto 0 do
  if (Index=PEqualPair(Equals[i])[1])or(Index=PEqualPair(Equals[i])[2]) then
    begin;
    Equals.Delete(i);
    Form1.ListBox1.Items.Delete(i);
    if I<Selection then Dec(Selection);
    end;
if Form1.ListBox1.Items.Count<>0 then
  begin;
  if Selection>Form1.ListBox1.Items.Count-1 then Selection:=Form1.ListBox1.Items.Count-1;
  Form1.ListBox1.ItemIndex:=Selection;
  if DoDisplayResults then DisplayResults(Selection);
  end
else
  if DoDisplayResults then DisplayResults(-1);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin;
RemoveFile(1,True);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin;
RemoveFile(2,True);
end;

procedure TForm1.ListBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  APoint: TPoint;
  Index: integer;
begin
if Button = mbLeft then
  begin
  APoint.X := X;
  APoint.Y := Y;
  Index:=ListBox1.ItemAtPos(APoint, True);
  if (Index>=0)and(Index<=Form1.ListBox1.Items.Count-1) then DisplayResults(Index);
  end;
end;

procedure TForm1.ListBox1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if Key in [VK_UP,VK_DOWN,VK_PRIOR,VK_NEXT,VK_LEFT,VK_RIGHT,VK_HOME,VK_END] then
  DisplayResults(Form1.ListBox1.ItemIndex);
end;


//============================================================================\\
// Compare
//============================================================================\\
function Compare(i,j:Integer):Boolean;
var d,x,y:Integer;
begin;
  Application.ProcessMessages;
  if (Byte(Files.Objects[i])=1)and(Byte(Files.Objects[j])=1) then
    begin;
    Result:=False;
    Exit;
    end;

  if (PResizedImage(Images[i]).FileSize=PResizedImage(Images[j]).FileSize)
     and (PResizedImage(Images[i]).Height=PResizedImage(Images[j]).Height)
     and (PResizedImage(Images[i]).Width=PResizedImage(Images[j]).Width)
     and (abs(PResizedImage(Images[i]).MidColor[1]-PResizedImage(Images[j]).MidColor[1])+
          abs(PResizedImage(Images[i]).MidColor[2]-PResizedImage(Images[j]).MidColor[2])+
          abs(PResizedImage(Images[i]).MidColor[3]-PResizedImage(Images[j]).MidColor[3])<=Difference) then
    begin;
    Result:=True;
    end
  else if abs(PResizedImage(Images[i]).Width*PResizedImage(Images[j]).Height/PResizedImage(Images[i]).Height-
              PResizedImage(Images[j]).Width)/min(PResizedImage(Images[j]).Width,PResizedImage(Images[i]).Width)>0.1 then
    begin;
    Result:=False;
    end
  else if (abs(PResizedImage(Images[i]).MidColor[1]-PResizedImage(Images[j]).MidColor[1])+
           abs(PResizedImage(Images[i]).MidColor[2]-PResizedImage(Images[j]).MidColor[2])+
           abs(PResizedImage(Images[i]).MidColor[3]-PResizedImage(Images[j]).MidColor[3])>Difference) then
    begin;
    Result:=False;
    end
  else
    begin;
    d:=0;
    for x:=0 to Base-1 do for y:=0 to Base-1 do
      d:=d+abs(PResizedImage(Images[i]).Img[x,y,1]-PResizedImage(Images[j]).Img[x,y,1])+
           abs(PResizedImage(Images[i]).Img[x,y,2]-PResizedImage(Images[j]).Img[x,y,2])+
           abs(PResizedImage(Images[i]).Img[x,y,3]-PResizedImage(Images[j]).Img[x,y,3]);
    if d<=Base*Base*Difference then
      Result:=True
    else
      Result:=False;
    end;
end;

//============================================================================\\
// Main
//============================================================================\\
procedure TForm1.BitBtn9Click(Sender: TObject);
var i,j,k,l,n,q:Integer;
    Pair:PEqualPair;
    MaxHW:Real;
begin
  Files.Free;
  if Equals<>nil then
    for i:=0 to Equals.Count-1 do Dispose(PEqualPair(Equals[i]));
  Equals.Free;
  Images.Free;

  {UpdateOptions;}

  DisplayResults(-1);
  Form1.ListBox1.Clear;
  Form1.BitBtn9.Enabled:=False;
  Form1.Gauge1.Progress:=0;
  Form1.Gauge2.Progress:=0;
  Form1.Gauge3.Progress:=0;
  Form1.Gauge4.Progress:=0;
  Form1.TabSheet1.Enabled:=False;
  Form1.TabSheet6.Enabled:=False;
  Form1.TabSheet4.Enabled:=False;

  Equals:=TList.Create;
  Images:=TList.Create;
  Files:=TStringList.Create;

  // Создание списка картинок
  GlobalGauge:=Form1.Gauge1;
  MakeFileList(Form1.CheckListBox1,Form1.CheckListBox2,Form1.CheckListBox3);

  // Загрузка картинок
  GlobalGauge:=Form1.Gauge2;
  DBaseLoadImages;
  n:=Files.Count-1;

  // Создание вспомогательных структур для оптимиза
  GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Comparing Started'#13#10;
  GlobalGauge:=Form1.Gauge3;
  GlobalGauge.MaxValue:=CmpSteps;
  if n>=1 then
    begin;
    GetMem(HWPairArray,(n+1)*sizeof(THWPair));
    GetMem(ChecksArray,(n+1)*sizeof(TCheck));
    for i:=0 to n do
      begin;
      HWPairArray[i].N:=i;
      HWPairArray[i].HW:=(PResizedImage(Images[i]).Width)/(PResizedImage(Images[i]).Height);
      for j:=1 to 3 do
        begin;
        If ColorPairArray[j][PResizedImage(Images[i]).MidColor[j]].Exists then
          begin;
          ColorPairArray[j][PResizedImage(Images[i]).MidColor[j]].List.Add(Pointer(i));
          end
        else
          begin;
          ColorPairArray[j][PResizedImage(Images[i]).MidColor[j]].List:=TList.Create;
          ColorPairArray[j][PResizedImage(Images[i]).MidColor[j]].List.Add(Pointer(i));
          ColorPairArray[j][PResizedImage(Images[i]).MidColor[j]].Exists:=True;
          end;
        end;
      end;
    QsortHWPairArray(0,n);

    // Сравнение
    Form1.Label9.Caption:='Comparing...';
    For l:=0 to CmpSteps do
      begin;
      GlobalGauge.AddProgress(1);
      GlobalSetCaption(IntToStr(GlobalGauge.PercentDone)+'% Comparing',IntToStr(GlobalGauge.PercentDone)+'%');
      For i:=((n+1)*l div (CmpSteps+1)) to (((n+1)*(l+1))div(CmpSteps+1)-1) do
        begin;
        try
          FillChar(ChecksArray^,(n+1)*sizeof(TCheck),0);
          j:=i+1;
          MaxHW:=max(HWPairArray[i].HW*HWMlp,HWPairArray[i].HW+HWMlp-1);
          q:=0;
          while (j<=n)and(HWPairArray[j].HW<MaxHW) do
            begin;
            Inc(ChecksArray[HWPairArray[j].N].Passed);
            Inc(j);
            Inc(q);
            end;

          if q>0 then
            begin;
            q:=0;
            For j:=max(0,  PResizedImage(Images[HWPairArray[i].N]).MidColor[1]-Difference) to
                   min(255,PResizedImage(Images[HWPairArray[i].N]).MidColor[1]+Difference) do
              if ColorPairArray[1][j].Exists then
                for k:=0 to ColorPairArray[1][j].List.Count-1 do
                  begin;
                  Inc(ChecksArray[Integer(ColorPairArray[1][j].List[k])].Passed);
                  Inc(ChecksArray[Integer(ColorPairArray[1][j].List[k])].D,Abs(PResizedImage(Images[HWPairArray[i].N]).MidColor[1]-j));
                  if ChecksArray[Integer(ColorPairArray[1][j].List[k])].Passed=2 then Inc(q);
                  end;
            end;

          if q>0 then
            begin;
            q:=0;
            For j:=max(0,  PResizedImage(Images[HWPairArray[i].N]).MidColor[2]-Difference) to
                   min(255,PResizedImage(Images[HWPairArray[i].N]).MidColor[2]+Difference) do
              if ColorPairArray[2][j].Exists then
                for k:=0 to ColorPairArray[2][j].List.Count-1 do
                  begin;
                  Inc(ChecksArray[Integer(ColorPairArray[2][j].List[k])].Passed);
                  Inc(ChecksArray[Integer(ColorPairArray[2][j].List[k])].D,Abs(PResizedImage(Images[HWPairArray[i].N]).MidColor[2]-j));
                  if ChecksArray[Integer(ColorPairArray[2][j].List[k])].Passed=3 then Inc(q);
                  end;
            end;

          if q>0 then
            For j:=max(0,  PResizedImage(Images[HWPairArray[i].N]).MidColor[3]-Difference) to
                   min(255,PResizedImage(Images[HWPairArray[i].N]).MidColor[3]+Difference) do
              if ColorPairArray[3][j].Exists then
                for k:=0 to ColorPairArray[3][j].List.Count-1 do
                  if ChecksArray[Integer(ColorPairArray[3][j].List[k])].Passed=3 then
                    if (ChecksArray[Integer(ColorPairArray[3][j].List[k])].D+
                        Abs(PResizedImage(Images[HWPairArray[i].N]).MidColor[3]-j))<=Difference then
                      begin;
                      try
                      if Compare(HWPairArray[i].N,Integer(ColorPairArray[3][j].List[k])) then
                        begin;
                        New(Pair);
                        Pair^[1]:=HWPairArray[i].N;
                        Pair^[2]:=Integer(ColorPairArray[3][j].List[k]);
                        Equals.Add(Pair);
                        end;
                      except
                        on E:Exception do begin;end;
                      end;
                      end;
        except
          on E:Exception do begin;end;
        end;
        end;
      end;  

    // Уничтожение промежуточных переменных.
    FreeMem(HWPairArray,(n+1)*sizeof(THWPair));
    FreeMem(ChecksArray,(n+1)*sizeof(TCheck));
    for i:=0 to 255 do for j:=1 to 3 do if ColorPairArray[j][i].Exists then
      begin;
      ColorPairArray[j][i].Exists:=False;
      ColorPairArray[j][i].List.Free;
      end;
    end;
  GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Comparing Completed'#13#10;
  GlobalGauge.Progress:=GlobalGauge.MaxValue;

  // вывод результатов
  GlobalGauge:=Form1.Gauge4;
  PrepareResults;
  SetCaption('Done','');
  GlobalLabel.Caption:='No operations in progress.';
  Form1.TextTrayIcon1.ShowMainForm;
  Application.Restore;

  UpdateDBSize;
  Form1.TabSheet1.Enabled:=True;
  Form1.TabSheet6.Enabled:=True;
  Form1.TabSheet4.Enabled:=True;
  Form1.BitBtn9.Enabled:=True;
  Form1.PageControl1.ActivePageIndex:=3;
end;


//============================================================================\\
// Save/Load Results
//============================================================================\\
procedure TForm1.BitBtn7Click(Sender: TObject);
var f:TextFile;
    i,j,k,l:Integer;
    s:String;
begin
if Form1.ListBox1.Items.Count>0 then
if Form1.SaveDialog1.Execute then
  begin;
  s:=Form1.SaveDialog1.FileName;
  s:=Copy(s,1,Length(s)-Length(ExtractFileExt(s)))+ResultsExt;

  AssignFile(f,s);
  ReWrite(f);
  Writeln(f,Files.Count,' ',Equals.Count);
  For i:=0 to Files.Count-1 do
    Writeln(f,Files[i]);
  For i:=0 to Images.Count-1 do
    begin;
    Write(f,PResizedImage(Images[i]).Height,' ',PResizedImage(Images[i]).Width,' ',PResizedImage(Images[i]).FileSize,' ');
    for j:=1 to 3 do Write(f,PResizedImage(Images[i]).MidColor[j],' ');
    for j:=0 to Base-1 do for k:=0 to Base-1 do for l:=1 to 3 do Write(f,PResizedImage(Images[i]).Img[j,k,l],' ');
    end;
  For i:=0 to Equals.Count-1 do
    Writeln(f,PEqualPair(Equals[i])[1],' ',PEqualPair(Equals[i])[2]);
  CloseFile(f);
  end;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
var f:TextFile;
    i,FilesN,EqualsN,j,k,l:Integer;
    s:String;
    Img:TResizedImage;
    PEP:PEqualPair;
begin
if Form1.OpenDialog1.Execute then
  begin;
  s:=Form1.OpenDialog1.FileName;
  s:=Copy(s,1,Length(s)-Length(ExtractFileExt(s)))+ResultsExt;
  If FileExists(s) then
    begin;
    Files.Free;
    if Equals<>nil then
      for i:=0 to Equals.Count-1 do Dispose(PEqualPair(Equals[i]));
    Equals.Free;
    Images.Free;

    DisplayResults(-1);
    Form1.ListBox1.Clear;
    Form1.BitBtn9.Enabled:=False;
    Form1.Gauge1.Progress:=0;
    Form1.Gauge2.Progress:=0;
    Form1.Gauge3.Progress:=0;
    Form1.Gauge4.Progress:=0;
    Form1.TabSheet1.Enabled:=False;
    Form1.TabSheet6.Enabled:=False;
    Form1.TabSheet4.Enabled:=False;
    Form1.PageControl1.ActivePageIndex:=2;

    Files:=TStringList.Create;
    Equals:=TList.Create;
    Images:=TList.Create;

    // Loading FileList
    AssignFile(f,s);
    Reset(f);
    Readln(f,FilesN,EqualsN);
    For i:=0 to FilesN-1 do
      begin;
      Readln(f,s);
      Files.Add(s);
      end;
    Form1.Gauge1.MaxValue:=100;
    Form1.Gauge1.Progress:=100;
    For i:=0 to FilesN-1 do
      begin;
      Read(f,Img.Height,Img.Width,Img.FileSize);
      for j:=1 to 3 do Read(f,Img.MidColor[j]);
      for j:=0 to Base-1 do for k:=0 to Base-1 do for l:=1 to 3 do Read(f,Img.Img[j,k,l]);
      Images.Add(AddImageToBase(Files[i],img));
      end;

    Form1.Gauge2.MaxValue:=100;
    For i:=0 to EqualsN-1 do
      begin;
      new(PEP);
      Readln(f,PEP[1],PEP[2]);
      Equals.Add(PEP);
      end;
    Form1.Gauge2.Progress:=100;
    CloseFile(f);
    Form1.Gauge3.MaxValue:=100;
    Form1.Gauge3.Progress:=100;

    GlobalGauge:=Form1.Gauge4;
    PrepareResults;

    UpdateDBSize;
    Form1.TabSheet1.Enabled:=True;
    Form1.TabSheet6.Enabled:=True;
    Form1.TabSheet4.Enabled:=True;
    Form1.BitBtn9.Enabled:=True;
    Form1.PageControl1.ActivePageIndex:=3;
    end;
  end;
end;


//============================================================================\\
// Optimize DataBase
//============================================================================\\
procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  Form1.TabSheet1.Enabled:=False;
  Form1.TabSheet3.Enabled:=False;
  Form1.TabSheet4.Enabled:=False;
  Form1.BitBtn13.Enabled:=False;
  Form1.Gauge6.Progress:=0;
  GlobalGauge:=Form1.Gauge6;
  OptimizeDataBase;
  UpdateDBSize;
  Form1.Gauge6.Progress:=0;
  Form1.TabSheet1.Enabled:=True;
  Form1.TabSheet3.Enabled:=True;
  Form1.TabSheet4.Enabled:=True;
  Form1.BitBtn13.Enabled:=True;
  Form1.PageControl1.ActivePageIndex:=1;
end;

//============================================================================\\
// AutoDelete
//============================================================================\\
procedure TForm1.BitBtn11Click(Sender: TObject);
var i:Integer;
begin
If MessageDlg('Are you sure want to automatically process the list of similar images?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
  begin;
  DisplayResults(-1);
  Form1.TabSheet1.Enabled:=False;
  Form1.TabSheet6.Enabled:=False;
  Form1.TabSheet3.Enabled:=False;
  Form1.TabSheet4.Enabled:=False;
  for i:=Form1.ListBox1.Items.Count-1 downto 0 do
    begin;
    Form1.ListBox1.ItemIndex:=0;
    RemoveFile(2,False);
    Application.ProcessMessages;
    end;
  Form1.TabSheet1.Enabled:=True;
  Form1.TabSheet6.Enabled:=True;
  Form1.TabSheet3.Enabled:=True;
  Form1.TabSheet4.Enabled:=True;
  Form1.PageControl1.ActivePageIndex:=3;
  end;
end;


//============================================================================\\
// New Options
//============================================================================\\
procedure ChangeOptions(Index: Integer);
begin;
OptionsListPosition:=Index;
Form1.Label5.Caption:=Form1.ListBox2.Items[Index];
Form1.PageControl2.ActivePageIndex:=Index;
end;

procedure TForm1.ListBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  APoint: TPoint;
  Index: integer;
begin
if Button = mbLeft then
  begin
  APoint.X := X;
  APoint.Y := Y;
  Index:=ListBox2.ItemAtPos(APoint, True);
  if (Index>=0)and(Index<=Form1.ListBox2.Items.Count-1) then ChangeOptions(Index);
  end;
end;

procedure TForm1.ListBox2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key in [VK_UP,VK_DOWN,VK_PRIOR,VK_NEXT,VK_LEFT,VK_RIGHT,VK_HOME,VK_END] then
  ChangeOptions(Form1.ListBox1.ItemIndex);
end;


end.




