object ViewCreateCarnet: TViewCreateCarnet
  Left = 314
  Top = 0
  Caption = 'Modal da Requisi'#231#227'o'
  ClientHeight = 331
  ClientWidth = 634
  Color = 6001140
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbDevedor: TGroupBox
    Left = 0
    Top = 0
    Width = 634
    Height = 331
    Align = alClient
    Caption = 'Dados do Body - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label12: TLabel
      Left = 10
      Top = 199
      Width = 146
      Height = 13
      Caption = '*Vencimento - Ex. 2025-12-30'
    end
    object Label4: TLabel
      Left = 127
      Top = 176
      Width = 81
      Height = 13
      Caption = '*Parcelas - Ex. 6'
    end
    object btnCancelRequest: TButton
      Left = 3
      Top = 296
      Width = 305
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 9
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 314
      Top = 296
      Width = 316
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 8
      OnClick = btnConfirmRequestClick
    end
    object GroupBox3: TGroupBox
      Left = 314
      Top = 11
      Width = 316
      Height = 139
      Caption = '*Cliente'
      TabOrder = 1
      object Label1: TLabel
        Left = 9
        Top = 67
        Width = 134
        Height = 13
        Caption = 'E-mail - email@servidor.com'
      end
      object Label6: TLabel
        Left = 9
        Top = 43
        Width = 120
        Height = 13
        Caption = '*CPF - Ex. 94271564656'
      end
      object Label7: TLabel
        Left = 3
        Top = 17
        Width = 152
        Height = 13
        Caption = '*Nome - Ex. Gorbadoc Oldbuck '
      end
      object Label8: TLabel
        Left = 9
        Top = 91
        Width = 118
        Height = 13
        Caption = '*Telefone - 5144916523'
      end
      object Label18: TLabel
        Left = 9
        Top = 116
        Width = 118
        Height = 13
        Caption = 'Nascimento -1990-08-29'
      end
      object txtNameCli: TEdit
        Left = 161
        Top = 14
        Width = 152
        Height = 21
        TabOrder = 0
      end
      object txtCPF: TEdit
        Left = 135
        Top = 40
        Width = 178
        Height = 21
        TabOrder = 1
      end
      object txtEmail: TEdit
        Left = 144
        Top = 64
        Width = 170
        Height = 21
        TabOrder = 2
      end
      object txtPhone: TEdit
        Left = 133
        Top = 88
        Width = 180
        Height = 21
        TabOrder = 3
      end
      object txtBirth: TEdit
        Left = 133
        Top = 113
        Width = 180
        Height = 21
        TabOrder = 4
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 11
      Width = 303
      Height = 96
      Caption = '*Items'
      TabOrder = 0
      object Label2: TLabel
        Left = 7
        Top = 17
        Width = 123
        Height = 13
        Caption = '*Nome - Ex. Meu Produto'
      end
      object Label5: TLabel
        Left = 7
        Top = 41
        Width = 83
        Height = 13
        Caption = '*Valor - Ex. 8900'
      end
      object Label3: TLabel
        Left = 7
        Top = 65
        Width = 97
        Height = 13
        Caption = '*Quantidade - Ex. 2'
      end
      object txtAmount: TEdit
        Left = 110
        Top = 62
        Width = 189
        Height = 21
        TabOrder = 2
      end
      object txtValue: TEdit
        Left = 96
        Top = 38
        Width = 203
        Height = 21
        TabOrder = 1
      end
      object txtName: TEdit
        Left = 136
        Top = 14
        Width = 163
        Height = 21
        TabOrder = 0
      end
    end
    object txtExpire: TEdit
      Left = 163
      Top = 196
      Width = 145
      Height = 21
      TabOrder = 4
    end
    object GroupBox4: TGroupBox
      Left = 5
      Top = 107
      Width = 303
      Height = 63
      Caption = 'Configura'#231#245'es'
      TabOrder = 2
      object Label13: TLabel
        Left = 9
        Top = 18
        Width = 99
        Height = 13
        Caption = 'Valor - Ex. 200 (2%)'
      end
      object Label14: TLabel
        Left = 9
        Top = 41
        Width = 184
        Height = 13
        Caption = 'Valor do Juros / Dia - Ex. 33 (0,033%)'
      end
      object txtFine: TEdit
        Left = 113
        Top = 15
        Width = 187
        Height = 21
        TabOrder = 0
      end
      object txtInterest: TEdit
        Left = 198
        Top = 38
        Width = 102
        Height = 21
        TabOrder = 1
      end
    end
    object GroupBox5: TGroupBox
      Left = 3
      Top = 219
      Width = 305
      Height = 72
      Caption = 'Mensagem'
      TabOrder = 6
      object txtMessage: TMemo
        Left = 8
        Top = 15
        Width = 293
        Height = 51
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
    object txtRepeats: TEdit
      Left = 214
      Top = 173
      Width = 94
      Height = 21
      TabOrder = 5
    end
    object txtSplitItems: TCheckBox
      Left = 12
      Top = 175
      Width = 101
      Height = 17
      Caption = 'Itens Divididos ?'
      TabOrder = 3
    end
    object GroupBox2: TGroupBox
      Left = 314
      Top = 150
      Width = 316
      Height = 141
      Caption = 'Endere'#231'o'
      TabOrder = 7
      object Label9: TLabel
        Left = 4
        Top = 19
        Width = 133
        Height = 13
        Caption = 'Rua - Ex. Avenida Juscelino'
      end
      object Label20: TLabel
        Left = 139
        Top = 42
        Width = 112
        Height = 13
        Caption = 'Cidade- Ex. Ouro Preto'
      end
      object Label21: TLabel
        Left = 4
        Top = 41
        Width = 84
        Height = 13
        Caption = 'Numero - Ex. 909'
      end
      object Label22: TLabel
        Left = 4
        Top = 67
        Width = 93
        Height = 13
        Caption = 'Bairro - Ex. Bauxita'
      end
      object Label23: TLabel
        Left = 4
        Top = 91
        Width = 96
        Height = 13
        Caption = 'CEP - Ex. 35400000'
      end
      object Label24: TLabel
        Left = 186
        Top = 91
        Width = 77
        Height = 13
        Caption = 'Estado - Ex. MG'
      end
      object Label25: TLabel
        Left = 4
        Top = 115
        Width = 118
        Height = 13
        Caption = 'Complemento - Ex. Casa'
      end
      object txtNumber: TEdit
        Left = 88
        Top = 38
        Width = 48
        Height = 21
        TabOrder = 1
      end
      object txtZipCode: TEdit
        Left = 102
        Top = 88
        Width = 75
        Height = 21
        TabOrder = 4
      end
      object txtNeighborhood: TEdit
        Left = 101
        Top = 64
        Width = 212
        Height = 21
        TabOrder = 3
      end
      object txtState: TEdit
        Left = 265
        Top = 88
        Width = 48
        Height = 21
        TabOrder = 5
      end
      object txtComplement: TEdit
        Left = 129
        Top = 112
        Width = 184
        Height = 21
        TabOrder = 6
      end
      object txtCity: TEdit
        Left = 254
        Top = 39
        Width = 59
        Height = 21
        TabOrder = 2
      end
      object txtStreet: TEdit
        Left = 141
        Top = 16
        Width = 172
        Height = 21
        TabOrder = 0
      end
    end
  end
end
