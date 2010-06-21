unit Utils;

interface
uses Globals, Windows, ShellAPI, Forms, SysUtils, Graphics, CheckLst, Controls,
     Classes, Math, Debug;

procedure LoadImage(var Img:TBitmap; FileName:String);
function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
procedure QSortHWPairArray(l,r: integer);
function ResizeToBase(var Img:TBitMap; var ResizedImage:PResizedImage):Boolean;
Procedure AddFolder(var CheckListBox:TCheckListBox; var ControlToFocus:TWinControl; const Dir:String);
Procedure ChangeIncludeSubFoldersStatus(var CheckListBox:TCheckListBox; const n:Integer);
Procedure DeleteFolders(var CheckListBox:TCheckListBox);
procedure MakeFileList(var Old,New,Excluded:TCheckListBox);
function FileSizeToStr(n:Int64):String;
procedure MoveFileToGarbage(const FileName:String);

implementation
uses RxGIF, Jpeg, Options;

//============================================================================\\
// Move File To Garbage
//============================================================================\\
procedure MoveFileToGarbage(const FileName:String);
var Name,Ext:String;
    i,LastError,TickCount:Integer;
    Msg:PChar;
    StrMsg:String;
begin;
Ext:=ExtractFileExt(FileName);
Name:=ExtractFileName(FileName);
Name:=Copy(Name,1,Length(Name)-Length(Ext));
Name:=Garbage+'\'+Name;
if not(MoveFile(PChar(FileName),PChar(Name+Ext))) then
  begin;
  FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER + FORMAT_MESSAGE_FROM_SYSTEM, nil, GetLastError, LANG_SYSTEM_DEFAULT, @Msg, 0, nil);
  StrMsg:=string(Msg);
  LastError:=GetLastError;
  if not((LastError=2)or(Pos('cannot find',StrMsg)<>0)) then
    begin;
    i:=0;
    TickCount:=GetTickCount;
    While (not(MoveFile(PChar(FileName),PChar(Name+'_'+IntToStr(i)+Ext))))and(GetTickCount-TickCount<500) do Inc(i);
    end;
  end;
end;

//============================================================================\\
// File Size to String
//============================================================================\\
function FileSizeToStr(n:Int64):String;
begin;
if n<1024 then Result:=IntToStr(n)+' bytes'
else if n<1024*1024 then Result:=IntToStr(n div 1024)+','+IntToStr(Round((n mod 1024)/1024*10))+' KB'+' ('+IntToStr(n)+' bytes)'
else Result:=IntToStr(n div (1024*1024))+','+IntToStr(Round((n mod 1024*1024)/(1024*1024)*10))+' MB'+' ('+IntToStr(n)+' bytes)';
end;


//============================================================================\\
// Folder Management
//============================================================================\\
// Add Folder
Procedure AddFolder(var CheckListBox:TCheckListBox; var ControlToFocus:TWinControl; const Dir:String);
var i:Integer;
begin;
ControlToFocus.SetFocus;
for i:=0 to CheckListBox.Items.Count-1 do
  begin;
  if CheckListBox.Checked[i] then
    begin;
    if ((Dir[Length(CheckListBox.Items[i])+1]='\')or(Dir[Length(CheckListBox.Items[i])]='\'))and
       (CheckListBox.Items[i]=Copy(Dir,1,Length(CheckListBox.Items[i]))) then
      exit;
    end
  else
    begin;
    if CheckListBox.Items[i]=Dir then
      exit;
    end;
  end;
CheckListBox.Items.Add(Dir);
end;

// Change IncluseSubFolders Status
Procedure ChangeIncludeSubFoldersStatus(var CheckListBox:TCheckListBox; const n:Integer);
var i:Integer;
    Dir:String;
begin;
if n<>-1 then
  begin;
  If CheckListBox.Checked[n] then
    begin;
    Dir:=CheckListBox.Items[n];
    for i:=CheckListBox.Items.Count-1 downto 0 do
      begin;
      If (i<>n)and((CheckListBox.Items[i][Length(Dir)+1]='\')or(CheckListBox.Items[i][Length(Dir)]='\'))and(Dir=Copy(CheckListBox.Items[i],1,Length(Dir))) then
        CheckListBox.Items.Delete(i);
      end;
    end;
  end;
end;

// Delete Folders
Procedure DeleteFolders(var CheckListBox:TCheckListBox);
var n:Integer;
begin;
if CheckListBox.ItemIndex>-1 then
  begin;
  n:=CheckListBox.ItemIndex;
  CheckListBox.Items.Delete(n);
  if CheckListBox.Items.Count-1<n then n:=CheckListBox.Items.Count-1;
  CheckListBox.ItemIndex:=n;
  end;
end;


//============================================================================\\
// QSort HWP array
//============================================================================\\
var x:Real;
    y:THWPair;
procedure QSortHWPairArray(l,r: integer);
var
  i,j: integer;
begin
  i:=l; j:=r; x:=HWPairArray[(l+r) DIV 2].HW;
  repeat
    while HWPairArray[i].HW<x do i:=i+1;
    while x<HWPairArray[j].HW do j:=j-1;
    if i<=j then
    begin
      y:=HWPairArray[i]; HWPairArray[i]:=HWPairArray[j]; HWPairArray[j]:=y;
      i:=i+1; j:=j-1;
    end;
  until i>j;
  if l<j then QSortHWPairArray(l,j);
  if i<r then QSortHWPairArray(i,r);
end;


//============================================================================\\
// Execute File
//============================================================================\\
function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
//var zFileName, zParams, zDir: array[0..500] of Char;
begin
//Result := ShellExecute(Application.MainForm.Handle, nil, StrPCopy(zFileName, FileName), StrPCopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
Result := ShellExecute(Application.MainForm.Handle, nil, PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
end;


//============================================================================\\
// Load Image
//============================================================================\\
procedure LoadImage(var Img:TBitmap; FileName:String);
var ext:String;
    GifImage:TGIFImage;
    JpgImage:TJPEGImage;
    IcoImage:TIcon;
begin;
{Img.Free;}
Img:=TBitmap.Create;
ext:=ExtractFileExt(FileName);
ext:=UpperCase(Copy(ext,2,Length(ext)-1));
if (ext='BMP') then
  begin;
  Img.LoadFromFile(FileName);
  end;
if (ext='GIF') then
  begin;
  GifImage:=TGifImage.Create;
  GifImage.LoadFromFile(FileName);
  Img.Height:=GifImage.Frames[0].Bitmap.Height;
  Img.Width:=GifImage.Frames[0].Bitmap.Width;
  Img.Canvas.Draw(0,0,GifImage.Frames[0].Bitmap);
  GifImage.Free;
  end;
if (ext='JPG')or(ext='JPEG') then
  begin;
  JpgImage:=TJPEGImage.Create;
  JpgImage.LoadFromFile(FileName);
  Img.Height:=JpgImage.Height;
  Img.Width:=JpgImage.Width;
  Img.Canvas.Draw(0,0,JpgImage);
  JpgImage.Free;
  end;
if (ext='ICO') then
  begin;
  IcoImage:=TIcon.Create;
  IcoImage.LoadFromFile(FileName);
  Img.Height:=IcoImage.Height;
  Img.Width:=IcoImage.Width;
  Img.Canvas.Draw(0,0,IcoImage);
  IcoImage.Free;
  end;
end;

//============================================================================\\
// Cut Fields
//============================================================================\\
procedure DoCutFields(var Img:TBitmap; var ResizedImage:PResizedImage);
const ww=200;
      hh=200;
      minh=32;
      minw=32;
      d=3;
var Rec:TRect;
    P:PBigByteArray;
    w,h,x,y,s:Integer;
    a:array[1..8,1..2]of integer;   {1..l8 of min,max}
    color:array[0..2]of byte;
    Top,Bottom,Left,Right:Integer;

Procedure GetS;
var i:Integer;
begin;
  s:=0;
  for i:=1 to 8 do
    if a[i,2]-a[i,1]>s then s:=a[i,2]-a[i,1];
end;

Procedure InitA;
var i:Integer;
begin;
  for i:=1 to 8 do
    begin;
    a[i,1]:=1000;
    a[i,2]:=-1000;
    end;
end;

Procedure ChangeA;
begin;
    s:=color[0]+color[1]+color[2];
    if s<a[1,1] then a[1,1]:=s;
    if s>a[1,2] then a[1,2]:=s;

    s:=color[0]+color[1]-color[2];
    if s<a[2,1] then a[2,1]:=s;
    if s>a[2,2] then a[2,2]:=s;

    s:=color[0]-color[1]+color[2];
    if s<a[3,1] then a[3,1]:=s;
    if s>a[3,2] then a[3,2]:=s;

    s:=color[0]-color[1]-color[2];
    if s<a[4,1] then a[4,1]:=s;
    if s>a[4,2] then a[4,2]:=s;

    s:=color[0]+color[1]+color[2];
    if s<a[5,1] then a[5,1]:=s;
    if s>a[5,2] then a[5,2]:=s;

    s:=-color[0]+color[1]-color[2];
    if s<a[6,1] then a[6,1]:=s;
    if s>a[6,2] then a[6,2]:=s;

    s:=-color[0]-color[1]+color[2];
    if s<a[7,1] then a[7,1]:=s;
    if s>a[7,2] then a[7,2]:=s;

    s:=-color[0]-color[1]-color[2];
    if s<a[8,1] then a[8,1]:=s;
    if s>a[8,2] then a[8,2]:=s;
end;

begin;
if (Img.Height<=minh)and(Img.Width<=minw) then
  begin;
  ResizedImage.Crop[0]:=0;
  ResizedImage.Crop[1]:=1;
  ResizedImage.Crop[2]:=0;
  ResizedImage.Crop[3]:=1;
  ResizedImage.CropValue:=CropValue;
  Exit;
  end;
If (Img.Height>hh)and(Img.Width>ww) then
  begin;
  Rec.Top:=0;
  Rec.Left:=0;
  Rec.Bottom:=hh-1;
  Rec.Right:=ww-1;
  Img.Canvas.StretchDraw(Rec,Img);
  Img.Height:=hh;
  Img.Width:=ww;
  end;
FillChar(Rec,SizeOf(Rec),0);
w:=Img.Width*d; w:=w+(4-w mod 4)mod 4;
h:=Img.Height-1;
P:=Img.ScanLine[Img.Height-1];
//P^[(h-y1)*w+x1*d+0]

//top
InitA;
For Top:=0 to Img.Height-Base do
  begin;
  For x:=0 to Img.Width-1 do
    begin;
    color[0]:=P^[(h-Top)*w+x*d+0];
    color[1]:=P^[(h-Top)*w+x*d+1];
    color[2]:=P^[(h-Top)*w+x*d+2];
    ChangeA;
    end;
  GetS;
  if s>CropValue then Break
  end;

//Down
InitA;
For Bottom:=Img.Height-1 downto Base+Top-1 do
  begin;
  For x:=0 to Img.Width-1 do
    begin;
    color[0]:=P^[(h-Bottom)*w+x*d+0];
    color[1]:=P^[(h-Bottom)*w+x*d+1];
    color[2]:=P^[(h-Bottom)*w+x*d+2];
    ChangeA;
    end;
  GetS;
  if s>CropValue then Break
  end;

//Left
InitA;
For Left:=0 to Img.Width-Base do
  begin;
  For y:=0 to Img.Height-1 do
    begin;
    color[0]:=P^[(h-y)*w+Left*d+0];
    color[1]:=P^[(h-y)*w+Left*d+1];
    color[2]:=P^[(h-y)*w+Left*d+2];
    ChangeA;
    end;
  GetS;
  if s>CropValue then Break
  end;

//Right
InitA;
For Right:=Img.Width-1 downto Left+Base-1 do
  begin;
  For y:=0 to Img.Height-1 do
    begin;
    color[0]:=P^[(h-y)*w+Right*d+0];
    color[1]:=P^[(h-y)*w+Right*d+1];
    color[2]:=P^[(h-y)*w+Right*d+2];
    ChangeA;
    end;
  GetS;
  if s>CropValue then Break
  end;

//DebugImage(Img);
If ((Bottom-Top)>Base+2)and((Right-Left)>Base+2) then
  begin;
  ResizedImage.Crop[0]:=Top/min(hh-1,Img.Height-1);
  ResizedImage.Crop[1]:=Bottom/min(hh-1,Img.Height-1);
  ResizedImage.Crop[2]:=Left/min(ww-1,Img.Width-1);
  ResizedImage.Crop[3]:=Right/min(ww-1,Img.Width-1);
  ResizedImage.CropValue:=CropValue;

  Rec.Top:=Top;
  Rec.Bottom:=Bottom;
  Rec.Left:=Left;
  Rec.Right:=Right;
  Img.Canvas.CopyRect(Rect(0,0,Right-Left+1,Bottom-Top+1),Img.Canvas,Rec);
  Img.Height:=Bottom-Top+1;
  Img.Width:=Right-Left+1;
  //DebugImage(Img);
  end
else
  begin;
  ResizedImage.Crop[0]:=0;
  ResizedImage.Crop[1]:=1;
  ResizedImage.Crop[2]:=0;
  ResizedImage.Crop[3]:=1;
  ResizedImage.CropValue:=CropValue;
  end;
end;

//============================================================================\\
// Resize
//============================================================================\\
function ResizeToBase(var Img:TBitMap; var ResizedImage:PResizedImage):Boolean;
const d=3;
var x,y,x1,y1,k,i,w,h:Integer;
    color:array[1..3]of integer;
    P:PBigByteArray;
begin;
Result:=True;
if (Img.Height>=10)and(Img.Width>=10) then
  begin;
  New(ResizedImage);

  ResizedImage.Height:=Img.Height;
  ResizedImage.Width:=Img.Width;

  Img.PixelFormat:=pf24bit;

  If CutFields then
    try
      DoCutFields(Img,ResizedImage);
    except
      on E:Exception do
        begin;
        ResizedImage.Crop[0]:=0;
        ResizedImage.Crop[1]:=1;
        ResizedImage.Crop[2]:=0;
        ResizedImage.Crop[3]:=1;
        ResizedImage.CropValue:=CropValue;
        end;
    end;

  w:=Img.Width*d; w:=w+(4-w mod 4)mod 4;
  h:=Img.Height-1;
  P:=Img.ScanLine[Img.Height-1];

  For x:=0 to Base-1 do for y:=0 to Base-1 do
    begin;
    Application.ProcessMessages;
    Fillchar(color,sizeof(color),0);
    for y1:=(Round(Img.Height/Base*y)) to (Round(Img.Height/Base*(y+1))-1) do
      begin;
      for x1:=(Round(Img.Width/Base*x)) to (Round(Img.Width/Base*(x+1))-1) do
        begin;
        color[1]:=color[1]+P^[(h-y1)*w+x1*d+0];
        color[2]:=color[2]+P^[(h-y1)*w+x1*d+1];
        color[3]:=color[3]+P^[(h-y1)*w+x1*d+2];
        end;
      end;
    k:=((Round(Img.Width/Base*(x+1))-1) - (Round(Img.Width/Base*x)) +1)*( (Round(Img.Height/Base*(y+1))-1) - (Round(Img.Height/Base*y)) +1);
    ResizedImage.Img[x,y,1]:=Round(color[1]/k);
    ResizedImage.Img[x,y,2]:=Round(color[2]/k);
    ResizedImage.Img[x,y,3]:=Round(color[3]/k);
    end;

  Fillchar(ResizedImage.MidColor,sizeof(ResizedImage.MidColor),0);
  For x:=0 to Base-1 do for y:=0 to Base-1 do
    for i:=1 to 3 do ResizedImage.MidColor[i]:=ResizedImage.MidColor[i]+ResizedImage.Img[x,y,i];
  for i:=1 to 3 do ResizedImage.MidColor[i]:=Round(ResizedImage.MidColor[i]/(Base*Base));

  {ResizedImage.FileSize:=GetFileSize(Files[n]);}
  end
else
  begin;
  Result:=False;
  end;
end;

//============================================================================\\
// Make FileList
//============================================================================\\
// Add to FileList
procedure AddToFileList(Dir:String; const SubDirs:Boolean; FolderType:Integer);
var SearchRec:TSearchRec;
    i:Integer;
begin;
Application.ProcessMessages;
if Dir[Length(Dir)]<>'\' then Dir:=Dir+'\';

for i:=1 to FileTypeN do
if FindFirst(Dir+'*.'+FileTypes[i],faAnyFile,SearchRec)=0 then
  begin;
  Files.Add(Dir+SearchRec.Name);
  Files.Objects[Files.Count-1]:=TObject(FolderType);
  while FindNext(SearchRec) = 0 do
    begin;
    Files.Add(Dir+SearchRec.Name);
    Files.Objects[Files.Count-1]:=TObject(FolderType);
    end;
  FindClose(SearchRec);
  end;

if SubDirs then
  begin;
  if FindFirst(Dir+'*',faDirectory,SearchRec)=0 then
    begin;
    if (SearchRec.Attr and faDirectory = faDirectory)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then AddToFileList(Dir+SearchRec.Name,SubDirs,FolderType);
    while FindNext(SearchRec) = 0 do
      if  (SearchRec.Attr and faDirectory = faDirectory)and(SearchRec.Name<>'.')and(SearchRec.Name<>'..') then AddToFileList(Dir+SearchRec.Name,SubDirs,FolderType);
    FindClose(SearchRec);
    end;
  end;
end;

// Make FileList
procedure MakeFileList(var Old,New,Excluded:TCheckListBox);
var i,a,b:Integer;
    s:Byte;
begin;
GlobalLabel.Caption:='Making File List...';
GlobalSetCaption('Making File List','');
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Making FileList Started'#13#10;
if New.Items.Count<>0 then
  begin;
  GlobalGauge.MaxValue:=(New.Items.Count+Old.Items.Count+Excluded.Items.Count)*2;

  for i:=0 to New.Items.Count-1 do
    begin;
    AddToFileList(New.Items[i],New.Checked[i],10);
    GlobalGauge.AddProgress(1);
    Application.ProcessMessages;
    end;
  for i:=0 to Old.Items.Count-1 do
    begin;
    AddToFileList(Old.Items[i],Old.Checked[i],1);
    GlobalGauge.AddProgress(1);
    Application.ProcessMessages;
    end;
  for i:=0 to Excluded.Items.Count-1 do
    begin;
    AddToFileList(Excluded.Items[i],Excluded.Checked[i],100);
    GlobalGauge.AddProgress(1);
    Application.ProcessMessages;
    end;

  if Files.Count>0 then
    begin;
    Files.Sort;
    b:=Files.Count-1;
    repeat
      a:=b;
      repeat
        Dec(a);
      until (a<0)or(Files[a]<>Files[b]);
      Inc(a);
      if b-a<>0 then
        begin;
        s:=0;
        for i:=a to b do s:=max(s,Integer(Files.Objects[i]));
        if s=100 then
          for i:=b downto a do Files.Delete(i)
        else
          begin;
          for i:=b downto a+1 do Files.Delete(i);
          Files.Objects[a]:=TObject(s);
          end;
        end
      else
        if Byte(Files.Objects[a])=100 then
          Files.Delete(a);
      b:=a-1;
    until b<0;
    end;
  end
else
  GlobalGauge.MaxValue:=100;
GlobalGauge.Progress:=GlobalGauge.MaxValue;
GlobalMemo.Text:=GlobalMemo.Text+DateTimeToStr(Now)+': Making FileList Completed'#13#10;
end;


end.
