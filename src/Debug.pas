unit Debug;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Math;

Procedure DebugImage(const Img:TBitMap);

type
  TForm2 = class(TForm)
    Image1: TImage;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
{$R *.DFM}

Procedure DebugImage(const Img:TBitMap);
var h,w:Integer;
begin;
Form2.Image1.Canvas.Brush.Color:=clBtnFace;
Form2.Image1.Canvas.FillRect(Rect(0,0,Form2.Image1.Width,Form2.Image1.Height));
h:=min(Img.Height,Round(Img.Height*min(Form2.Image1.Height/Img.Height, Form2.Image1.Width/Img.Width)));
w:=min(Img.Width, Round(Img.Width* min(Form2.Image1.Height/Img.Height, Form2.Image1.Width/Img.Width)));
Form2.Image1.Canvas.StretchDraw(Rect((Form2.Image1.Width-w)div 2, (Form2.Image1.Height-h)div 2, (Form2.Image1.Width-w)div 2+w, (Form2.Image1.Height-h)div 2+h),Img);
Form2.ShowModal;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Form2.Visible:=False;
end;

Initialization

end.
