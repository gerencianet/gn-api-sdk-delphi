object ViewPixDevolution: TViewPixDevolution
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
    Caption = '*Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 164
      Height = 13
      Caption = '*Identificador :e2eid da Cobran'#231'a'
    end
    object Label2: TLabel
      Left = 8
      Top = 68
      Width = 146
      Height = 13
      Caption = '*Identificador :id da Cobran'#231'a'
    end
    object txtE2eid: TEdit
      Left = 8
      Top = 41
      Width = 569
      Height = 21
      TabOrder = 0
    end
    object txtId: TEdit
      Left = 8
      Top = 83
      Width = 569
      Height = 21
      TabOrder = 1
    end
    object btnConfirmRequest: TButton
      Left = 284
      Top = 159
      Width = 291
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 2
      OnClick = btnConfirmRequestClick
    end
    object btnCancelRequest: TButton
      Left = 6
      Top = 159
      Width = 277
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 3
      OnClick = btnCancelRequestClick
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 107
      Width = 573
      Height = 49
      Caption = 'Body da Requisi'#231#227'o'
      TabOrder = 4
      object Label3: TLabel
        Left = 7
        Top = 20
        Width = 81
        Height = 13
        Caption = '*Valor - Ex. 5.00'
      end
      object txtValue: TEdit
        Left = 94
        Top = 17
        Width = 475
        Height = 21
        TabOrder = 0
      end
    end
  end
end
