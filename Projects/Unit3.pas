unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Data.DB, ZAbstractRODataset, ZDataset,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, ZAbstractDataset, Vcl.Buttons, Clipbrd;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SpinEdit1: TSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    SpinEdit2: TSpinEdit;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    GroupBox7: TGroupBox;
    Memo1: TMemo;
    GroupBox8: TGroupBox;
    Memo2: TMemo;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    ComboBox1: TComboBox;
    ZQuery1: TZQuery;
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1RowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  showcreate : String;
  createtable : String;
  LastRow : Integer;

  LastEdit : String;
  LastComboBox : String;
  LastSpinEdit : String;
  LastCheckBox : Boolean;

  LastNum : Integer;

implementation

{$R *.dfm}

uses Unit2, Unit1, Unit4;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.FormCreate(Sender: TObject);
begin
//StringGrid1.Options := [goFixedVertLine, goThumbTracking, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goDrawFocusSelected, goColSizing, goRowSelect];
StringGrid1.RowCount := StrToInt(SpinEdit1.Text)+1;
StringGrid1.Cells[1,0] := '��� ����';
StringGrid1.Cells[2,0] := '��� ����';
StringGrid1.Cells[3,0] := '�����/��������';
StringGrid1.Cells[4,0] := '��������� NULL';
StringGrid1.Cells[0,1] := '1';
StringGrid1.ColWidths[0] := 25;
StringGrid1.Font.Name := 'Sitka Text';
StringGrid1.Font.Size := 9;

StringGrid1.Cells[1, 1] := '';
StringGrid1.Cells[2, 1] := '';
StringGrid1.Cells[3, 1] := '';
StringGrid1.Cells[4, 1] := 'NULL';

Combobox1.Items.Add('TEXT');
Combobox1.Items.Add('INT');
Combobox1.Items.Add('DATE');
Combobox1.Items.Add('FLOAT');

LastRow := 1;
LastNum := 1;

Edit1.Clear;
ComboBox1.Text := '';
SpinEdit2.Clear;
CheckBox1.Checked := True;

DataSource1.DataSet := ZQuery1;
ZQuery1.Active := False;
ZQuery1.SQL.Clear;
ZQuery1.Connection := Form1.ZConnection1;
end;

procedure TForm3.Memo2Change(Sender: TObject);
begin
Form3.Caption := '������� �������: "' + Memo2.Text + '"';
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.SpinEdit1Change(Sender: TObject);
begin
StringGrid1.RowCount := StrToInt(SpinEdit1.Text)+1;
StringGrid1.Cells[0, StrToInt(SpinEdit1.Text)] := IntToStr(StrToInt(SpinEdit1.Text));

if LastNum>StrToInt(SpinEdit1.Text) then
  begin
  LastNum := StrToInt(SpinEdit1.Text);
  StringGrid1.Cells[1, StrToInt(SpinEdit1.Text)+1] := '';
  StringGrid1.Cells[2, StrToInt(SpinEdit1.Text)+1] := '';
  StringGrid1.Cells[3, StrToInt(SpinEdit1.Text)+1] := '';
  StringGrid1.Cells[4, StrToInt(SpinEdit1.Text)+1] := '';
  end
else
  begin
  LastNum := StrToInt(SpinEdit1.Text);
  StringGrid1.Cells[4, StrToInt(SpinEdit1.Text)] := 'NULL';
  end;

end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.StringGrid1RowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
i : Integer;
begin
for i := 1 to StrToInt(SpinEdit1.Text) do StringGrid1.Cells[0, i] := InttoStr(i);
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
Row2 : Integer;
begin
Row2 := StringGrid1.Row;

if not(LastRow=ARow) then
  begin
  LastRow := ARow;

//--------------------------------------------//
  LastEdit := Edit1.Text;
  LastComboBox := ComboBox1.Text;
  LastSpinEdit := SpinEdit2.Text;
  LastCheckBox := CheckBox1.Checked;
//--------------------------------------------//
  Edit1.Text := StringGrid1.Cells[1, ARow];


  if StringGrid1.Cells[2, ARow]='TEXT' then ComboBox1.ItemIndex := 0
  else if StringGrid1.Cells[2, ARow]='INT' then ComboBox1.ItemIndex := 1
  else if StringGrid1.Cells[2, ARow]='DATE' then ComboBox1.ItemIndex := 2
  else if StringGrid1.Cells[2, ARow]='FLOAT' then ComboBox1.ItemIndex := 3
  else ComboBox1.ItemIndex := -1;


  SpinEdit2.Text := StringGrid1.Cells[3, ARow];


  if StringGrid1.Cells[4, ARow] = 'NULL' then
    begin
    CheckBox1.Checked := True;
    end
  else
    begin
    CheckBox1.Checked := False;
    end;
//--------------------------------------------//

  StringGrid1.Cells[1, Row2] := LastEdit;
  StringGrid1.Cells[2, Row2] := LastComboBox;
  StringGrid1.Cells[3, Row2] := LastSpinEdit;

  if LastCheckBox then
    begin
    StringGrid1.Cells[4, Row2] := 'NULL';
    end
  else
    begin
    StringGrid1.Cells[4, Row2] := 'noNULL';
    end;

//--------------------------------------------//

  if ComboBox1.Text = 'DATE' then
    begin
    SpinEdit2.Text := '';
    SpinEdit2.Enabled := False;
    end
  else
    begin
    SpinEdit2.Enabled := True;
    end;

  end;
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.BitBtn1Click(Sender: TObject);
var
I : Integer;
TypeField : String;
begin
createtable := 'CREATE TABLE `' + Trim(Memo2.Text) + '` (';

for I := 1 to StrtoInt(SpinEdit1.Text) do
  begin
            //------------Name------------//
  createtable := createtable + '`' + StringGrid1.Cells[1, I] + '` ';

      //------------Type and Length------------//
  if StringGrid1.Cells[2, I] = 'TEXT' then
    begin
    createtable := createtable + 'VARCHAR(' + StringGrid1.Cells[3, I] + ') ';
    end;

  if StringGrid1.Cells[2, I] = 'INT' then
    begin
    createtable := createtable + 'INT(' + StringGrid1.Cells[3, I] + ') ';
    end;

  if StringGrid1.Cells[2, I] = 'FLOAT' then
    begin
    createtable := createtable + 'FLOAT(' + StringGrid1.Cells[3, I] + ') ';
    end;

  if StringGrid1.Cells[2, I] = 'DATE' then
    begin
    createtable := createtable + 'DATE ';
    end;

            //------------Null------------//
  if StringGrid1.Cells[4, I] = 'NULL' then
    begin
      if I = StrtoInt(SpinEdit1.Text) then
        begin
        createtable := createtable + 'NULL) ';
        end
      else
        begin
        createtable := createtable + 'NULL, ';
        end;
    end
  else
    begin
       if I = StrtoInt(SpinEdit1.Text) then
        begin
        createtable := createtable + 'NULL) ';
        end
      else
        begin
        createtable := createtable + 'NOT NULL, ';
        end;
    end;
  end;

          //------------Comment------------//
  if Memo1.Text = '' then
    begin
    createtable := createtable + 'COLLATE=''utf8_general_ci'';';
    end
  else
    begin
    createtable := createtable + 'COMMENT=''' + Memo1.Text + ''' COLLATE=''utf8_general_ci'';';
    end;

try
ZQuery1.SQL.Clear;
ZQuery1.SQL.Text := createtable;
ZQuery1.ExecSQL;

if Form2.TreeView1.Selected.Level = 1 then
  begin
  Form2.TreeView1.Items.Add(Form2.TreeView1.Selected, Memo2.Text)
  end
else
  begin
  Form2.TreeView1.Items.AddChild(Form2.TreeView1.Selected, Memo2.Text);
  end;

except
 On E : Exception do
 begin
 ShowMessage('������: '+ E.Message);
 end;
end;
end;


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.Edit1Change(Sender: TObject);
begin
StringGrid1.Cells[1, StringGrid1.Row] := Edit1.Text;
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
StringGrid1.Cells[2 , StringGrid1.Row] := ComboBox1.Text;

if ComboBox1.Text = 'DATE' then
  begin
  SpinEdit2.Text := '';
  SpinEdit2.Enabled := False;
  end
else
  begin
  SpinEdit2.Enabled := True;
  end;

end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.SpinEdit2Change(Sender: TObject);
begin
StringGrid1.Cells[3 , StringGrid1.Row] := SpinEdit2.Text;
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.CheckBox1Click(Sender: TObject);
begin

if CheckBox1.Checked then
  begin
  StringGrid1.Cells[4 , StringGrid1.Row] := 'NULL';
  end
else
  begin
  StringGrid1.Cells[4 , StringGrid1.Row] := 'noNULL';
  end;

end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form3 := nil;
end;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

end.
