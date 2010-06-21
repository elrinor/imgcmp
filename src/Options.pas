unit options;

interface
uses CheckLst;
procedure SaveDirList(var CheckListBox:TCheckListBox; const BoxName:String);
procedure LoadDirList(var CheckListBox:TCheckListBox; const BoxName:String);

const MaxDifference=200;
      CropValue=50;
      
var Difference:Integer;
    HWMlp:Real;
    DefDir:String;
    AllowAutoSaving:Boolean;
    AutoSaveInterval:Integer;
    AllowGarbage:Boolean;
    Garbage:String;
    FileSizeIsGood:Boolean;
    ResolutionIsGood:Boolean;
    ResolutionEffectOnRating:Integer;
    ProcessPriority:Integer;
    CutFields:Boolean;
    OptionsListPosition:Integer;

implementation
uses IniFiles,SysUtils,Forms,FileCtrl;

var Opt:TIniFile;

procedure SaveDirList(var CheckListBox:TCheckListBox; const BoxName:String);
var i:Integer;
begin;
Opt:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Data\Options.ini');
Opt.UpdateFile;
Opt.EraseSection(BoxName);
Opt.WriteInteger(BoxName,'Count',CheckListBox.Items.Count);
For i:=0 to CheckListBox.Items.Count-1 do
  begin;
  Opt.WriteString(BoxName,'Dir'+IntToStr(i+1),CheckListBox.Items[i]);
  Opt.WriteBool(BoxName,'Checked'+IntToStr(i+1),CheckListBox.Checked[i]);
  end;
Opt.Free;
end;

procedure LoadDirList(var CheckListBox:TCheckListBox; const BoxName:String);
var i,Count:Integer;
    s:String;
    Checked:Boolean;
begin;
Opt:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Data\Options.ini');
Opt.UpdateFile;
Count:=Opt.ReadInteger(BoxName,'Count',0);
For i:=1 to Count do
  begin;
  s:=Opt.ReadString(BoxName,'Dir'+IntToStr(i),'C:\');
  Checked:=Opt.ReadBool(BoxName,'Checked'+IntToStr(i),False);
  CheckListBox.Items.Add(S);
  CheckListBox.Checked[i-1]:=Checked;
  end;
Opt.Free;
end;

procedure ReadOptions;
begin;
If not(DirectoryExists(ExtractFilePath(Application.ExeName)+'Data')) then
  MkDir(ExtractFilePath(Application.ExeName)+'Data');
Opt:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Data\Options.ini');
Opt.UpdateFile;

Difference:=Opt.ReadInteger('ImgCmp','Difference',13);
HWMlp:=Opt.ReadFloat('ImgCmp','HWMlp',1.1);
DefDir:=Opt.ReadString('ImgCmp','DefDir',ExtractFilePath(Application.ExeName));
AllowAutoSaving:=Opt.ReadBool('ImgCmp','AllowAutoSaving',True);
AutoSaveInterval:=Opt.ReadInteger('ImgCmp','AutoSaveInterval',500);
AllowGarbage:=Opt.ReadBool('ImgCmp','AllowGarbage',True);
Garbage:=Opt.ReadString('ImgCmp','Garbage',ExtractFilePath(Application.ExeName)+'Garbage');
FileSizeIsGood:=Opt.ReadBool('ImgCmp','FileSizeIsGood',True);
ResolutionIsGood:=Opt.ReadBool('ImgCmp','ResolutionIsGood',True);
ResolutionEffectOnRating:=Opt.ReadInteger('ImgCmp','ResolutionEffectOnRating',5);
ProcessPriority:=Opt.ReadInteger('ImgCmp','ProcessPriority',0);
CutFields:=Opt.ReadBool('ImgCmp','CutFields',False);
OptionsListPosition:=Opt.ReadInteger('ImgCmp','OptionsListPosition',0);

if not(DirectoryExists(DefDir)) then DefDir:=ExtractFilePath(Application.ExeName);
if not(DirectoryExists(Garbage)) then Garbage:=ExtractFilePath(Application.ExeName)+'Garbage';
if not(DirectoryExists(Garbage)) then MkDir(Garbage);
if Difference<0 then Difference:=0;
if Difference>MaxDifference then Difference:=MaxDifference;
if AutoSaveInterval<10 then AutoSaveInterval:=10;
if ResolutionEffectOnRating<0 then ResolutionEffectOnRating:=0;
if ResolutionEffectOnRating>10 then ResolutionEffectOnRating:=10;
if ProcessPriority<0 then ProcessPriority:=0;
if ProcessPriority>2 then ProcessPriority:=2;
Opt.Free;
end;

procedure WriteOptions;
begin;
Opt:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Data\Options.ini');
Opt.UpdateFile;
Opt.WriteInteger('ImgCmp','Difference',Difference);
Opt.WriteInteger('ImgCmp','AutoSaveInterval',AutoSaveInterval);
Opt.WriteFloat('ImgCmp','HWMlp',HWMlp);
Opt.WriteString('ImgCmp','DefDir',DefDir);
Opt.WriteBool('ImgCmp','AllowAutoSaving',AllowAutoSaving);
Opt.WriteBool('ImgCmp','AllowGarbage',AllowGarbage);
Opt.WriteString('ImgCmp','Garbage',Garbage);
Opt.WriteBool('ImgCmp','FileSizeIsGood',FileSizeIsGood);
Opt.WriteBool('ImgCmp','ResolutionIsGood',ResolutionIsGood);
Opt.WriteInteger('ImgCmp','ResolutionEffectOnRating',ResolutionEffectOnRating);
Opt.WriteInteger('ImgCmp','ProcessPriority',ProcessPriority);
Opt.WriteBool('ImgCmp','CutFields',CutFields);
Opt.WriteInteger('ImgCmp','OptionsListPosition',OptionsListPosition);
Opt.Free;
end;


initialization
ReadOptions;

finalization
WriteOptions;

end.
