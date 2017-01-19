unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure MoveControl(AControl: TControl; const X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
with TShape.Create(nil) do
  begin
    Name := Format('ShapeToMove%d',[Self.ControlCount + 1]);
    Parent := Self; // Parent will free it
    Shape := stCircle;
    Width := 65;
    Height := 65;
    OnMouseMove := ShapeToMoveMouseMove;
  end;
end;


procedure TForm2.MoveControl(AControl: TControl; const X, Y: Integer);
var
  lPoint: TPoint;
begin
  lPoint := AControl.Parent.ScreenToClient(AControl.ClientToScreen(Point(X, Y)));
  AControl.Left := lPoint.X - AControl.Width div 2;
  AControl.Top := lPoint.Y - AControl.Height div 2;
end;

procedure TForm2.ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if ssLeft in Shift then // only move it when Left-click is down
    MoveControl(Sender as TControl, X, Y);
end;

end.
