unit DBase;

interface
uses
  Classes, ComCtrls, StdCtrls, Controls, Forms, CoolTrayIcon, Globals;


procedure DBaseLoadImages;
function AddImageToBase(const Str:String; const ResizedImage:TResizedImage):PResizedImage;
Procedure OptimizeDataBase;

implementation
uses Windows,SysUtils,FileUtil,options,Graphics,Utils;

type
  TDBasePair=record
    FileName:String;
    N:Integer;
  end;
  PDBasePair=^TDBasePair;

var DBaseList:TList{of PDBasePair};
    Base:TList{of PResizedImage};
    DBRecords:Integer;

//============================================================================\\
// Sort Base
//============================================================================\\
var x:String;
    y:PDBasePair;
procedure QSortDBaseList(l,r: integer);
var
  i,j: integer;
begin
  i:=l; j:=r; x:=PDBasePair(DBaseList[(l+r) DIV 2]).FileName;
  repeat
    while PDBasePair(DBaseList[i]).FileName<x do i:=i+1;
    while x<PDBasePair(DBaseList[j]).FileName do j:=j-1;
    if i<=j then
    begin
      y:=DBaseList[i]; DBaseList[i]:=DBaseList[j]; DBaseList[j]:=y;
      i:=i+1; j:=j-1;
    end;
  until i>j;
  if l<j then QSortDBaseList(l,j);
  if i<r then QSortDBaseList(i,r);
end;

//============================================================================\\
// Save Base
//============================================================================\\
procedure SaveDBase;
var i:Integer;
    f:Text;
    Numbers:File of Integer;
    BaseFile:File of TResizedImage;
begin;
AssignFile(Numbers,ExtractFilePath(Application.ExeName)+'Data\DBase.nmb');
ReWrite(Numbers);
Write(Numbers,DBRecords);
for i:=0 to DBRecords do
  Write(Numbers,PDBasePair(DBaseList[i]).N);
CloseFile(Numbers);

AssignFile(f,ExtractFilePath(Application.ExeName)+'Data\DBase.lst');
ReWrite(f);
for i:=0 to DBRecords do
  Writeln(f,PDBasePair(DBaseList[i]).FileName);
CloseFile(f);

AssignFile(BaseFile,ExtractFilePath(Application.ExeName)+'Data\DBase.idb');
ReWrite(BaseFile);
For i:=0 to DBRecords do
  Write(BaseFile,PResizedImage(Base[i])^);
Close(BaseFile);
end;

procedure AutoSaveDBase;
begin;
GlobalLabel.Caption:='AutoSaving DataBase...';
Application.ProcessMessages;
QSortDBaseList(0,DBaseList.Count-1);
DBRecords:=DBaseList.Count-1;
SaveDBase;
end;

//============================================================================\\
// Find Image in Base
//============================================================================\\
function FindString(const Str:String):Integer;
var min,max:Integer;
begin;
Result:=-1;
min:=0;
max:=DBRecords;
While min<=max do
  if Str<PDBasePair(DBaseList[(min+max)div 2]).FileName then max:=(min+max)div 2-1
  else if Str>PDBasePair(DBaseList[(min+max)div 2]).FileName then min:=(min+max)div 2+1
  else
    begin;
    Result:=(min+max)div 2;
    Exit;
    end;
end;

function AddImageToBase(const Str:String; const ResizedImage:TResizedImage):PResizedImage;
var n:Integer;
    RI:PResizedImage;
    DBP:PDBasePair;
begin;
n:=FindString(Str);
if n<>-1 then AddImageToBase:=PResizedImage(Base[PDBasePair(DBaseList[n]).N])
else
  begin;
  new(RI);
  RI^:=ResizedImage;
  Base.Add(RI);
  AddImageToBase:=RI;
  new(DBP);
  DBP.FileName:=Str;
  DBP.N:=Base.Count-1;
  DBaseList.Add(DBP);
  end;
end;

//============================================================================\\
// Create Resized Image
//============================================================================\\
procedure CreateResizedImage(n:Integer);
var Img:TBitMap;
    k:Integer;
    RI:PResizedImage;
    DBP:PDBasePair;
begin;
  k:=FindString(Files[n]);
  if (k=-1) then
    begin;
    LoadImage(Img,Files[n]);
    if ResizeToBase(Img,RI) then
      begin;
      Img.Destroy;
      RI.FileSize:=GetFileSize(Files[n]);
      Base.Add(RI);
      Images.Add(RI);

      new(DBP);
      DBP.FileName:=Files[n];
      DBP.N:=Base.Count-1;
      DBaseList.Add(DBP);
      end
    else
      begin;
      Img.Free;
      raise Exception.Create('BUG!');
      end;
    end
  else if (k>-1)and( (PResizedImage(Base[PDBasePair(DBaseList[k]).N]).FileSize<>GetFileSize(Files[n]))or
                     (PResizedImage(Base[PDBasePair(DBaseList[k]).N]).CropValue<>CropValue)or
                     ((PResizedImage(Base[PDBasePair(DBaseList[k]).N]).CropValue>0)and(CutFields=False)) ) then
    begin;
    LoadImage(Img,Files[n]);
    ResizeToBase(Img,RI);
    Img.Destroy;
    RI.FileSize:=GetFileSize(Files[n]);
    Dispose(PResizedImage(Base[PDBasePair(DBaseList[k]).N]));
    Base[PDBasePair(DBaseList[k]).N]:=RI;
    Images.Add(RI);
    end
  else
    begin;
    Images.Add(Base[PDBasePair(DBaseList[k]).N]);
    end;
end;

//============================================================================\\
// Load Images
//============================================================================\\
procedure DBaseLoadImages;
var i,n,MaxN,TickCount:Integer;
begin;
MaxN:=Files.Count;
n:=0;
i:=0;
GlobalGauge.MaxValue:=MaxN;
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Loading Files Started'#13#10;
While i<=Files.Count-1 do
  begin;
  Inc(n);
  if ((n mod 100)=0)or(GetTickCount-TickCount>500) then
    begin;
    TickCount:=GetTickCount;
    GlobalGauge.Progress:=n;
    GlobalLabel.Caption:=IntToStr(n)+' of '+IntToStr(MaxN)+' Loading...  '+Files[i];
    GlobalSetCaption(IntToStr(GlobalGauge.PercentDone)+'% Loading',IntToStr(GlobalGauge.PercentDone)+'%');
    Application.ProcessMessages;
    end;
  try
    CreateResizedImage(i);
    Inc(i);
  except
    on E:Exception do
      begin;
      Files.Delete(i);
      end;
  end;
  if (DBaseList.Count-DBRecords)>=AutoSaveInterval then
    AutoSaveDBase;
  end;
AutoSaveDBase;
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Loading Files Completed'#13#10;
GlobalGauge.MaxValue:=100;
GlobalGauge.Progress:=GlobalGauge.MaxValue;
end;

//============================================================================\\
// Optimize
//============================================================================\\
Procedure OptimizeDataBase;
var i:Integer;
    Base1:TList{of PResizedImage};
    TickCount:Integer;
begin;
If Base.Count<=0 then Exit;
Base1:=TList.Create;
GlobalGauge.Progress:=0;
GlobalGauge.MaxValue:=DBRecords*2;
TickCount:=GetTickCount;
For i:=DBRecords downto 0 do
  begin;
  if ((i mod 100)=0)or(GetTickCount-TickCount>500) then
    begin;
    TickCount:=GetTickCount;
    GlobalGauge.Progress:=DBRecords-i;
    Application.ProcessMessages;
    end;
  if not(FileExists(PDBasePair(DBaseList[i]).FileName)) then
    begin;
    Dispose(PResizedImage(Base[PDBasePair(DBaseList[i]).N]));
    Dispose(PDBasePair(DBaseList[i]));
    DBaseList.Delete(i);
    end;
  end;
Base1.Count:=DBaseList.Count;
GlobalGauge.MaxValue:=DBaseList.Count*2+1;
GlobalGauge.Progress:=DBaseList.Count;
For i:=0 to DBaseList.Count-1 do
  begin;
  if ((i mod 100)=0)or(GetTickCount-TickCount>500) then
    begin;
    TickCount:=GetTickCount;
    GlobalGauge.Progress:=DBaseList.Count+i+1;
    Application.ProcessMessages;
    end;
  Base1[i]:=Base[PDBasePair(DBaseList[i]).N];
  PDBasePair(DBaseList[i]).N:=i;
  end;
Base.Free;
Base:=Base1;
DBRecords:=Base.Count-1;
SaveDBase;
GlobalGauge.MaxValue:=100;
GlobalGauge.Progress:=100;
end;


var i:Integer;
    f:Text;
    Numbers:File of Integer;
    RI:PResizedImage;
    DBP:PDBasePair;
    BaseFile:File of TResizedImage;

Procedure NullDBFiles;
begin;
AssignFile(f,ExtractFilePath(Application.ExeName)+'Data\DBase.lst');
Rewrite(f);
CloseFile(f);
AssignFile(Numbers,ExtractFilePath(Application.ExeName)+'Data\DBase.nmb');
Rewrite(Numbers);
i:=-1;
Write(Numbers,i);
CloseFile(Numbers);
AssignFile(BaseFile,ExtractFilePath(Application.ExeName)+'Data\DBase.idb');
Rewrite(BaseFile);
CloseFile(BaseFile);
end;

Procedure LoadDBase;
begin;
  AssignFile(Numbers,ExtractFilePath(Application.ExeName)+'Data\DBase.nmb');
  Reset(Numbers);
  Read(Numbers,DBRecords);
  for i:=0 to DBRecords do
    begin;
    new(DBP);
    Read(Numbers,DBP.N);
    DBaseList.Add(DBP);
    end;
  CloseFile(Numbers);

  AssignFile(f,ExtractFilePath(Application.ExeName)+'Data\DBase.lst');
  Reset(f);
  for i:=0 to DBRecords do
    begin;
    Readln(f,PDBasePair(DBaseList[i]).FileName);
    end;
  CloseFile(f);

  AssignFile(BaseFile,ExtractFilePath(Application.ExeName)+'Data\DBase.idb');
  Reset(BaseFile);
  For i:=0 to DBRecords do
    begin;
    New(RI);
    Read(BaseFile,RI^);
    Base.Add(RI);
    end;
  Close(BaseFile);
end;
//============================================================================\\
// Initialization
//============================================================================\\
initialization
DBaseList:=TList.Create;
Base:=TList.Create;

if (not(FileExists(ExtractFilePath(Application.ExeName)+'Data\DBase.lst')))or
   (not(FileExists(ExtractFilePath(Application.ExeName)+'Data\DBase.nmb')))or
   (not(FileExists(ExtractFilePath(Application.ExeName)+'Data\DBase.idb'))) then
  NullDBFiles;

try
  LoadDBase;
except
  on E:Exception do
    begin;
    NullDBFiles;
    DBRecords:=-1;
    for i:=0 to DBaseList.Count-1 do
      if DBaseList[i]<>nil then
        try
          Dispose(PDBasePair(DBaseList[i]));
        except
          on E:Exception do begin;end;
        end;
    for i:=0 to Base.Count-1 do
      if Base[i]<>nil then
        try
          Dispose(PResizedImage(Base[i]));
        except
          on E:Exception do begin;end;
        end;
    DBaseList.Clear;
    Base.Clear;
    end;
end;

//============================================================================\\
// Finalization
//============================================================================\\
finalization
SaveDBase;
for i:=0 to DBRecords do
  begin;
  Dispose(PDBasePair(DBaseList[i]));
  Dispose(PResizedImage(Base[i]));
  end;
Base.Free;
DbaseList.Free;
end.
