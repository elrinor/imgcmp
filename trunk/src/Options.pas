unit options;

interface
const MaxDifference=200;

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

implementation
uses IniFiles,SysUtils,Forms,FileCtrl;

var Opt:TIniFile;

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

if not(DirectoryExists(DefDir)) then DefDir:=ExtractFilePath(Application.ExeName);
if not(DirectoryExists(Garbage)) then Garbage:=ExtractFilePath(Application.ExeName)+'Garbage';
if not(DirectoryExists(Garbage)) then MkDir(Garbage);
if Difference<0 then Difference:=0;
if Difference>MaxDifference then Difference:=MaxDifference;
if AutoSaveInterval<10 then AutoSaveInterval:=10;
if ResolutionEffectOnRating<0 then ResolutionEffectOnRating:=0;
if ResolutionEffectOnRating>10 then ResolutionEffectOnRating:=10; 
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
Opt.Free;
end;


initialization
ReadOptions;

finalization
WriteOptions;

end.
