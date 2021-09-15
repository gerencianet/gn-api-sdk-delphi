object ViewResendParcel: TViewResendParcel
  Left = 0
  Top = 0
  Caption = 'Modal da Requisi'#231#227'o'
  ClientHeight = 261
  ClientWidth = 584
  Color = 6001140
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 584
    Height = 261
    Align = alClient
    Caption = 'Playground: Carnet - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 26
      Width = 122
      Height = 13
      Caption = '*Identificador - carnet_id'
    end
    object Label2: TLabel
      Left = 7
      Top = 106
      Width = 224
      Height = 13
      Caption = '*Email - Ex. email_do_cliente@servidor.com.br'
    end
    object Label3: TLabel
      Left = 6
      Top = 65
      Width = 76
      Height = 13
      Caption = '*Parcela - Ex. 5'
    end
    object txtIdent: TEdit
      Left = 6
      Top = 39
      Width = 569
      Height = 21
      TabOrder = 0
    end
    object btnCancelRequest: TButton
      Left = 6
      Top = 144
      Width = 280
      Height = 33
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 4
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 290
      Top = 144
      Width = 285
      Height = 33
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 3
      OnClick = btnConfirmRequestClick
    end
    object txtEmail: TEdit
      Left = 7
      Top = 120
      Width = 569
      Height = 21
      TabOrder = 2
    end
    object txtParcel: TEdit
      Left = 6
      Top = 77
      Width = 569
      Height = 21
      TabOrder = 1
    end
  end
end
