unit UTables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Contnrs, System.Types;

type
  TFormTables = class(TForm)
    ButtonAddTable: TButton;
    CheckBoxEdit: TCheckBox;
    PopupMenu1: TPopupMenu;
    Rectangular1: TMenuItem;
    Circular1: TMenuItem;
    procedure ButtonAddTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MoveControl(AControl: TControl; const X, Y: Integer);
    procedure ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    TableList:TObjectList;
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
  with Table do
  begin
    Parent := Self;
    Shape := stCircle;
    Width := 65;
    Height := 65;
    OnMouseMove := ShapeToMoveMouseMove;
  end;
  //TableList.Add(Table);
end;

procedure TFormTables.MoveControl(AControl: TControl; const X, Y: Integer);
var
  lPoint: TPoint;
begin
  lPoint := AControl.Parent.ScreenToClient(AControl.ClientToScreen(Point(X, Y)));
  AControl.Left := lPoint.X - AControl.Width div 2;
  AControl.Top := lPoint.Y - AControl.Height div 2;
end;

procedure TFormTables.ShapeToMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and CheckBoxEdit.Checked then // only move it when Left-click is down
    MoveControl(Sender as TControl, X, Y);
end;

procedure TFormTables.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TableList.Free;
end;

procedure TFormTables.FormCreate(Sender: TObject);
begin
TableList := TObjectList.Create;
end;

end.
