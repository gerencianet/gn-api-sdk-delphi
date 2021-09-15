object ViewPayCreditCardOneStep: TViewPayCreditCardOneStep
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
    Caption = 'Pagamento de Cobran'#231'as '
    TabOrder = 0
    object btnCancelRequest: TButton
      Left = 4
      Top = 335
      Width = 301
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 5
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 311
      Top = 335
      Width = 321
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 4
      OnClick = btnConfirmRequestClick
    end
    object GroupBox3: TGroupBox
      Left = 4
      Top = 161
      Width = 301
      Height = 147
      Caption = '*Cliente'
      TabOrder = 1
      object Label4: TLabel
        Left = 9
        Top = 91
        Width = 118
        Height = 13
        Caption = '*Telefone - 5144916523'
      end
      object Label3: TLabel
        Left = 9
        Top = 67
        Width = 140
        Height = 13
        Caption = '*E-mail - email@servidor.com'
      end
      object Label2: TLabel
        Left = 9
        Top = 43
        Width = 120
        Height = 13
        Caption = '*CPF - Ex. 94271564656'
      end
      object Label1: TLabel
        Left = 9
        Top = 19
        Width = 152
        Height = 13
        Caption = '*Nome - Ex. Gorbadoc Oldbuck '
      end
      object Label18: TLabel
        Left = 9
        Top = 116
        Width = 124
        Height = 13
        Caption = '*Nascimento -1990-08-29'
      end
      object txtName: TEdit
        Left = 163
        Top = 16
        Width = 133
        Height = 21
        TabOrder = 0
      end
      object txtCPF: TEdit
        Left = 134
        Top = 40
        Width = 162
        Height = 21
        TabOrder = 1
      end
      object txtEmail: TEdit
        Left = 155
        Top = 64
        Width = 141
        Height = 21
        TabOrder = 2
      end
      object txtPhone: TEdit
        Left = 134
        Top = 88
        Width = 162
        Height = 21
        TabOrder = 3
      end
      object txtBirth: TEdit
        Left = 134
        Top = 113
        Width = 163
        Height = 21
        TabOrder = 4
      end
    end
    object GroupBox2: TGroupBox
      Left = 311
      Top = 14
      Width = 320
      Height = 141
      Caption = 'Endere'#231'o'
      TabOrder = 2
      object Label5: TLabel
        Left = 3
        Top = 19
        Width = 139
        Height = 13
        Caption = '*Rua - Ex. Avenida Juscelino'
      end
      object Label6: TLabel
        Left = 3
        Top = 43
        Width = 90
        Height = 13
        Caption = '*Numero - Ex. 909'
      end
      object Label7: TLabel
        Left = 3
        Top = 67
        Width = 99
        Height = 13
        Caption = '*Bairro - Ex. Bauxita'
      end
      object Label8: TLabel
        Left = 3
        Top = 91
        Width = 102
        Height = 13
        Caption = '*CEP - Ex. 35400000'
      end
      object Label9: TLabel
        Left = 139
        Top = 43
        Width = 118
        Height = 13
        Caption = '*Cidade- Ex. Ouro Preto'
      end
      object Label10: TLabel
        Left = 5
        Top = 115
        Width = 118
        Height = 13
        Caption = 'Complemento - Ex. Casa'
      end
      object Label11: TLabel
        Left = 175
        Top = 91
        Width = 83
        Height = 13
        Caption = '*Estado - Ex. MG'
      end
      object txtNumber: TEdit
        Left = 95
        Top = 40
        Width = 43
        Height = 21
        TabOrder = 1
      end
      object txtZipCode: TEdit
        Left = 106
        Top = 88
        Width = 68
        Height = 21
        TabOrder = 4
      end
      object txtNeighborhood: TEdit
        Left = 106
        Top = 64
        Width = 211
        Height = 21
        TabOrder = 3
      end
      object txtState: TEdit
        Left = 259
        Top = 88
        Width = 58
        Height = 21
        TabOrder = 5
      end
      object txtComplement: TEdit
        Left = 127
        Top = 112
        Width = 190
        Height = 21
        TabOrder = 6
      end
      object txtCity: TEdit
        Left = 259
        Top = 40
        Width = 58
        Height = 21
        TabOrder = 2
      end
      object txtStreet: TEdit
        Left = 145
        Top = 16
        Width = 172
        Height = 21
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 311
      Top = 161
      Width = 320
      Height = 147
      Caption = 'Dados do Cart'#227'o'
      TabOrder = 3
      object Label12: TLabel
        Left = 5
        Top = 19
        Width = 96
        Height = 13
        Caption = '*Bandeira - Ex. visa'
      end
      object Label13: TLabel
        Left = 5
        Top = 41
        Width = 177
        Height = 13
        Caption = '*Numero - Ex. 4012 0010 3844 3335'
      end
      object Label14: TLabel
        Left = 174
        Top = 86
        Width = 72
        Height = 13
        Caption = '*CVV - Ex. 123'
      end
      object Label16: TLabel
        Left = 5
        Top = 112
        Width = 143
        Height = 13
        Caption = '*Venc. M'#234's/Ano- Ex. 05 2021'
      end
      object Label17: TLabel
        Left = 5
        Top = 86
        Width = 81
        Height = 13
        Caption = '*Parcelas - Ex. 1'
      end
      object txtCard1: TEdit
        Left = 5
        Top = 56
        Width = 76
        Height = 21
        TabOrder = 1
      end
      object txtMonth: TEdit
        Left = 149
        Top = 109
        Width = 70
        Height = 21
        TabOrder = 7
      end
      object txtCVV: TEdit
        Left = 247
        Top = 83
        Width = 70
        Height = 21
        TabOrder = 6
      end
      object txtBrand: TEdit
        Left = 105
        Top = 16
        Width = 212
        Height = 21
        TabOrder = 0
      end
      object txtCard2: TEdit
        Left = 83
        Top = 56
        Width = 76
        Height = 21
        TabOrder = 2
      end
      object txtCard3: TEdit
        Left = 161
        Top = 56
        Width = 77
        Height = 21
        TabOrder = 3
      end
      object txtCard4: TEdit
        Left = 240
        Top = 56
        Width = 77
        Height = 21
        TabOrder = 4
      end
      object txtYear: TEdit
        Left = 222
        Top = 109
        Width = 95
        Height = 21
        TabOrder = 8
      end
      object txtInstallments: TEdit
        Left = 89
        Top = 81
        Width = 58
        Height = 21
        TabOrder = 5
      end
    end
    object GroupBox6: TGroupBox
      Left = 3
      Top = 14
      Width = 305
      Height = 143
      Caption = 'Items'
      TabOrder = 0
      object Label19: TLabel
        Left = 3
        Top = 13
        Width = 123
        Height = 13
        Caption = '*Nome - Ex. Meu Produto'
      end
      object Label20: TLabel
        Left = 3
        Top = 52
        Width = 83
        Height = 13
        Caption = '*Valor - Ex. 8900'
      end
      object Label21: TLabel
        Left = 3
        Top = 94
        Width = 97
        Height = 13
        Caption = '*Quantidade - Ex. 2'
      end
      object txtItem: TEdit
        Left = 3
        Top = 26
        Width = 299
        Height = 21
        TabOrder = 0
      end
      object txtValue: TEdit
        Left = 3
        Top = 65
        Width = 299
        Height = 21
        TabOrder = 1
      end
      object txtAmount: TEdit
        Left = 3
        Top = 107
        Width = 299
        Height = 21
        TabOrder = 2
      end
    end
  end
end
