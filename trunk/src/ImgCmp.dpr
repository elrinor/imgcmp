program ImgCmp;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  DBase in 'DBase.pas',
  Utils in 'Utils.pas',
  Options in 'Options.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ImgCmp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
