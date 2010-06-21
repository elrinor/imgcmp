unit Globals;

interface
uses SysUtils, Windows, ShellAPI, Forms, Graphics, Classes, RxGif, jpeg,
     FileUtil, StdCtrls, Gauges;

const Base=10;
      FileTypeN=5;
      FileTypes:Array[1..FileTypeN] of String=('bmp','gif','jpg','jpeg','ico');
      DefaultCaption='ImgCmp';
      CmpSteps=100;
      ResultsSteps=100;
      ResultsExt='.RSL';
type
  TSetCaptionProc=procedure(const s,IconStr:String);
  TColorPair=record
    Exists:Boolean;
    List:TList;
  end;  
  THWPair=record
    N:Integer;
    HW:Real;
  end;
  TCheck=record
    D:Integer;
    Passed:Byte;
  end;
  TChecksArray=array[0..100000000] of TCheck;
  PChecksArray=^TChecksArray;
  THWPairArray=array[0..100000000] of THWPair;
  PHWPairArray=^THWPairArray;
  TEqualPair=array[1..2]of Integer;
  PEqualPair=^TEqualPair;
  TResizedImage = Record
    Height,Width:Integer;
    Img:array[0..Base-1,0..Base-1,1..3]of Integer;
    MidColor:array[1..3]of Integer;
    FileSize:LongInt;
  end;
  PResizedImage = ^TResizedImage;
  TBigByteArray=Array[0..100000000]of byte;
  PBigByteArray=^TBigByteArray;

var
  Images: TList{of PResizedImage};
  Files:TStringList;
  Equals:TList{of PEqualPair};
  HWPairArray:PHWPairArray;
  ChecksArray:PChecksArray;
  ColorPairArray:array[1..3,0..255] of TColorPair;
  GlobalGauge:TGauge;
  GlobalLabel:TLabel;
  GlobalMemo:TMemo;
  GlobalSetCaption:TSetCaptionProc;

implementation
end.
