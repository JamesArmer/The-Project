unit UTables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Contnrs;

type
  TFormTables = class(TForm)
    ButtonAddTable: TButton;
    CheckBoxEdit: TCheckBox;
    Shape1: TShape;
    PopupMenu1: TPopupMenu;
    Rectangular1: TMenuItem;
    Circular1: TMenuItem;
    Button1: TButton;
    procedure ButtonAddTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    //procedure MoveControl(AControl: TControl; const X, Y: Integer);
    //procedure TForm1.ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    //procedure TForm1.Button1Click(Sender: TObject);
  private
    { Private declarations }
    TableList:TObjectList;
    inReposition : boolean;
    oldPos, newPos: TPoint;
  public
    { Public declarations }
  end;

var
  FormTables: TFormTables;

implementation

{$R *.dfm}

procedure TFormTables.ButtonAddTableClick(Sender: TObject);
var
  Table:TShape;
begin
  Table := TShape.Create(Self);
  with Table do begin
    Parent := Self;
    Left := 64;
    Top := 200;
    Width := 75;
    Height := 75;
    Visible := true;
  end;
  TableList.Add(Table);
end;



{procedure TFormTables.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (CheckBoxEdit.Checked) AND (Sender is TWinControl) then
  begin
    inReposition:=True;
    SetCapture(TWinControl(Sender).Handle);
    GetCursorPos(oldPos);
  end;
end;

procedure TFormTables.ControlMouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
var
  newPos: TPoint;
begin
 if inReposition then
  begin
    with TWinControl(Sender) do
     begin
       GetCursorPos(newPos);
       Screen.Cursor := crSize;
       Left := Left - oldPos.X + newPos.X;
       Top := Top - oldPos.Y + newPos.Y;
       oldPos := newPos;
     end;
  end;
end;

procedure TFormTables.ControlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if inReposition then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    inReposition := False;
  end;
end; }

procedure MoveControl(AControl: TControl; const X, Y: Integer);
var
  lPoint: TPoint;
begin
  lPoint := AControl.Parent.ScreenToClient(AControl.ClientToScreen(Point(X, Y)));
  AControl.Left := lPoint.X - AControl.Width div 2;
  AControl.Top := lPoint.Y - AControl.Height div 2;
end;

procedure TFormTables.ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then // only move it when Left-click is down
    MoveControl(Sender as TControl, X, Y);
end;

procedure TForm1.Button1Click(Sender: TObject);
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

procedure TFormTables.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TableList.Free;
end;

procedure TFormTables.FormCreate(Sender: TObject);
begin
TableList := TObjectList.Create;

Button1.OnMouseDown := ControlMouseDown;
Button1.OnMouseMove := ControlMouseMove;
Button1.OnMouseUp := ControlMouseUp;
end;

end.
