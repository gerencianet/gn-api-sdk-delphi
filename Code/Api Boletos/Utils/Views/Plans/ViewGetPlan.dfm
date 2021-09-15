object ViewGetPlan: TViewGetPlan
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
  object gbDevedor: TGroupBox
    Left = 0
    Top = 0
    Width = 584
    Height = 261
    Align = alClient
    Caption = 'Playground Planos - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 18
      Width = 117
      Height = 13
      Caption = 'Nome - Ex. Meu Produto'
    end
    object Label3: TLabel
      Left = 7
      Top = 101
      Width = 67
      Height = 13
      Caption = 'OffSet - Ex. 5'
    end
    object Label5: TLabel
      Left = 7
      Top = 59
      Width = 62
      Height = 13
      Caption = 'Limite - Ex. 5'
    end
    object txtName: TEdit
      Left = 7
      Top = 31
      Width = 574
      Height = 21
      TabOrder = 0
    end
    object txtOffset: TEdit
      Left = 7
      Top = 113
      Width = 574
      Height = 21
      TabOrder = 2
    end
    object txtLimit: TEdit
      Left = 7
      Top = 71
      Width = 574
      Height = 21
      TabOrder = 1
    end
    object btnCancelRequest: TButton
      Left = 7
      Top = 226
      Width = 280
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 4
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 290
      Top = 226
      Width = 291
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 3
      OnClick = btnConfirmRequestClick
    end
  end
end
