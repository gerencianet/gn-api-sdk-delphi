object ViewUpdateParcel: TViewUpdateParcel
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
    object Parcela: TLabel
      Left = 6
      Top = 63
      Width = 76
      Height = 13
      Caption = '*Parcela - Ex. 5'
    end
    object Label2: TLabel
      Left = 6
      Top = 20
      Width = 122
      Height = 13
      Caption = '*Identificador - carnet_id'
    end
    object txtId: TEdit
      Left = 6
      Top = 34
      Width = 571
      Height = 21
      TabOrder = 0
    end
    object btnConfirmRequest: TButton
      Left = 284
      Top = 159
      Width = 291
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 3
      OnClick = btnConfirmRequestClick
    end
    object btnCancelRequest: TButton
      Left = 6
      Top = 159
      Width = 277
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 4
      OnClick = btnCancelRequestClick
    end
    object txtParcel: TEdit
      Left = 6
      Top = 78
      Width = 571
      Height = 21
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 107
      Width = 573
      Height = 49
      Caption = 'Dados do Body '
      TabOrder = 2
      object Label3: TLabel
        Left = 7
        Top = 20
        Width = 146
        Height = 13
        Caption = '*Vencimento - Ex. 2025-12-30'
      end
      object txtValue: TEdit
        Left = 159
        Top = 17
        Width = 410
        Height = 21
        TabOrder = 0
      end
    end
  end
end
