object ViewUpdateLinkCharge: TViewUpdateLinkCharge
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
    Caption = 'Playground: Transa'#231#245'es - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 21
      Width = 124
      Height = 13
      Caption = '*Identificador - charge_id'
    end
    object Label2: TLabel
      Left = 6
      Top = 139
      Width = 133
      Height = 13
      Caption = 'Desconto no Boletos - Ex. 5'
    end
    object Label3: TLabel
      Left = 6
      Top = 181
      Width = 136
      Height = 13
      Caption = 'Descontos no Cart'#227'o - Ex. 5'
    end
    object Label4: TLabel
      Left = 6
      Top = 101
      Width = 146
      Height = 13
      Caption = '*Vencimento - Ex. 2025-12-30'
    end
    object Label5: TLabel
      Left = 300
      Top = 101
      Width = 176
      Height = 13
      Caption = 'Mensagem - Ex. Mensagem de Teste'
    end
    object Label6: TLabel
      Left = 6
      Top = 61
      Width = 148
      Height = 13
      Caption = 'M'#233'todo de Pagamento - Ex. All'
    end
    object txtIdent: TEdit
      Left = 6
      Top = 36
      Width = 572
      Height = 21
      TabOrder = 0
    end
    object btnCancelRequest: TButton
      Left = 6
      Top = 222
      Width = 283
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 8
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 300
      Top = 222
      Width = 278
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 7
      OnClick = btnConfirmRequestClick
    end
    object txtBilletDiscount: TEdit
      Left = 6
      Top = 152
      Width = 283
      Height = 21
      TabOrder = 4
    end
    object txtCardDiscount: TEdit
      Left = 6
      Top = 193
      Width = 283
      Height = 21
      TabOrder = 5
    end
    object txtExpireAt: TEdit
      Left = 6
      Top = 114
      Width = 283
      Height = 21
      TabOrder = 3
    end
    object txtRequestDeliveryAddress: TCheckBox
      Left = 300
      Top = 75
      Width = 165
      Height = 17
      Caption = 'Solicitar Endere'#231'o de Entrega'
      TabOrder = 2
    end
    object txtPaymentMethod: TEdit
      Left = 6
      Top = 73
      Width = 283
      Height = 21
      TabOrder = 1
    end
    object txtMessage: TMemo
      Left = 300
      Top = 114
      Width = 278
      Height = 107
      Lines.Strings = (
        'Memo1')
      TabOrder = 6
    end
  end
end
