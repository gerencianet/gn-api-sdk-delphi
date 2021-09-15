unit MainCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, System.SysUtils,
  Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, XSuperObject, Vcl.Dialogs,
  MainPix, MainEmissions, Vcl.Graphics, Vcl.Imaging.pngimage;

type
  TMainCode = class(TForm)
    mainFrmApiBoletos: TPanel;
    mainFrmApiPix: TPanel;
    Image1: TImage;
    Image2: TImage;
    procedure mainFrmApiBoletosClick(Sender: TObject);
    procedure mainFrmApiPixClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

  var
    frmCode : TMainCode;

implementation

{$R *.dfm}

procedure TMainCode.FormCreate(Sender: TObject);
begin
  frmCode.Position := poScreenCenter;
end;

procedure TMainCode.mainFrmApiBoletosClick(Sender: TObject);
begin
  Application.CreateForm(TMainEmissions, frmBoletos);
  frmBoletos.Visible := False;
  frmBoletos.ShowModal;
end;

procedure TMainCode.mainFrmApiPixClick(Sender: TObject);
begin
  Application.CreateForm(TMainPix, frmPix);
  frmPix.Visible := False;
  frmPix.ShowModal;
end;

end.
