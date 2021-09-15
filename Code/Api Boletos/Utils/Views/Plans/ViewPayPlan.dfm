object ViewPayPlan: TViewPayPlan
  Left = 0
  Top = 0
  Caption = 'Modal de Pagamento'
  ClientHeight = 371
  ClientWidth = 634
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 634
    Height = 371
    Align = alClient
    Caption = 'Pagamento de Planos - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label12: TLabel
      Left = 320
      Top = 159
      Width = 146
      Height = 13
      Caption = '*Vencimento - Ex. 2025-12-30'
    end
    object Label15: TLabel
      Left = 8
      Top = 22
      Width = 148
      Height = 13
      Caption = '*Identificador - subscription_id'
    end
    object btnCancelRequest: TButton
      Left = 4
      Top = 335
      Width = 307
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 7
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 314
      Top = 335
      Width = 316
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 6
      OnClick = btnConfirmRequestClick
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 42
      Width = 300
      Height = 134
      Caption = '*Cliente'
      TabOrder = 1
      object Label4: TLabel
        Left = 4
        Top = 86
        Width = 118
        Height = 13
        Caption = '*Telefone - 5144916523'
      end
      object Label3: TLabel
        Left = 4
        Top = 63
        Width = 134
        Height = 13
        Caption = 'E-mail - email@servidor.com'
      end
      object Label2: TLabel
        Left = 4
        Top = 39
        Width = 149
        Height = 13
        Caption = '*CPF/CNPJ - Ex. 94271564656'
      end
      object Label1: TLabel
        Left = 4
        Top = 15
        Width = 152
        Height = 13
        Caption = '*Nome - Ex. Gorbadoc Oldbuck '
      end
      object Label18: TLabel
        Left = 4
        Top = 110
        Width = 118
        Height = 13
        Caption = 'Nascimento -1990-08-29'
      end
      object txtName: TEdit
        Left = 156
        Top = 12
        Width = 141
        Height = 21
        TabOrder = 0
      end
      object txtCPF: TEdit
        Left = 156
        Top = 36
        Width = 141
        Height = 21
        TabOrder = 1
      end
      object txtEmail: TEdit
        Left = 145
        Top = 60
        Width = 152
        Height = 21
        TabOrder = 2
      end
      object txtPhone: TEdit
        Left = 124
        Top = 83
        Width = 173
        Height = 21
        TabOrder = 3
      end
      object txtBirth: TEdit
        Left = 124
        Top = 107
        Width = 173
        Height = 21
        TabOrder = 4
      end
    end
    object txtExpire: TEdit
      Left = 467
      Top = 156
      Width = 163
      Height = 21
      TabOrder = 3
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 177
      Width = 300
      Height = 72
      Caption = 'Configura'#231#245'es - Juros ap'#243's vencimento'
      TabOrder = 4
      object Label13: TLabel
        Left = 9
        Top = 26
        Width = 99
        Height = 13
        Caption = 'Valor - Ex. 200 (2%)'
      end
      object Label14: TLabel
        Left = 9
        Top = 48
        Width = 184
        Height = 13
        Caption = 'Valor do Juros / Dia - Ex. 33 (0,033%)'
      end
      object txtFine: TEdit
        Left = 117
        Top = 21
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object txtInterest: TEdit
        Left = 199
        Top = 45
        Width = 98
        Height = 21
        TabOrder = 1
      end
    end
    object GroupBox5: TGroupBox
      Left = 314
      Top = 177
      Width = 316
      Height = 72
      Caption = 'Mensagem'
      TabOrder = 5
      object txtMessage: TMemo
        Left = 6
        Top = 13
        Width = 309
        Height = 53
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
    object txtIdent: TEdit
      Left = 162
      Top = 19
      Width = 146
      Height = 21
      TabOrder = 0
    end
    object GroupBox2: TGroupBox
      Left = 314
      Top = 14
      Width = 316
      Height = 141
      Caption = 'Endere'#231'o'
      TabOrder = 2
      object Label5: TLabel
        Left = 4
        Top = 19
        Width = 133
        Height = 13
        Caption = 'Rua - Ex. Avenida Juscelino'
      end
      object Label6: TLabel
        Left = 4
        Top = 43
        Width = 84
        Height = 13
        Caption = 'Numero - Ex. 909'
      end
      object Label7: TLabel
        Left = 4
        Top = 67
        Width = 93
        Height = 13
        Caption = 'Bairro - Ex. Bauxita'
      end
      object Label8: TLabel
        Left = 4
        Top = 91
        Width = 96
        Height = 13
        Caption = 'CEP - Ex. 35400000'
      end
      object Label9: TLabel
        Left = 142
        Top = 43
        Width = 112
        Height = 13
        Caption = 'Cidade- Ex. Ouro Preto'
      end
      object Label10: TLabel
        Left = 4
        Top = 115
        Width = 118
        Height = 13
        Caption = 'Complemento - Ex. Casa'
      end
      object Label11: TLabel
        Left = 177
        Top = 91
        Width = 77
        Height = 13
        Caption = 'Estado - Ex. MG'
      end
      object txtNumber: TEdit
        Left = 89
        Top = 40
        Width = 50
        Height = 21
        TabOrder = 1
      end
      object txtZipCode: TEdit
        Left = 102
        Top = 88
        Width = 73
        Height = 21
        TabOrder = 4
      end
      object txtNeighborhood: TEdit
        Left = 102
        Top = 64
        Width = 213
        Height = 21
        TabOrder = 3
      end
      object txtState: TEdit
        Left = 254
        Top = 88
        Width = 61
        Height = 21
        TabOrder = 5
      end
      object txtComplement: TEdit
        Left = 125
        Top = 112
        Width = 190
        Height = 21
        TabOrder = 6
      end
      object txtCity: TEdit
        Left = 254
        Top = 40
        Width = 61
        Height = 21
        TabOrder = 2
      end
      object txtStreet: TEdit
        Left = 138
        Top = 16
        Width = 177
        Height = 21
        TabOrder = 0
      end
    end
  end
end
