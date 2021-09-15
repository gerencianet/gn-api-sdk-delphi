object ViewPixSend: TViewPixSend
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
    object btnConfirmRequest: TButton
      Left = 286
      Top = 226
      Width = 291
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 1
      OnClick = btnConfirmRequestClick
    end
    object btnCancelRequest: TButton
      Left = 8
      Top = 226
      Width = 275
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 2
      OnClick = btnCancelRequestClick
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 16
      Width = 569
      Height = 208
      Caption = 'Body da Requisi'#231#227'o'
      TabOrder = 0
      object Label3: TLabel
        Left = 8
        Top = 22
        Width = 81
        Height = 13
        Caption = '*Valor - Ex. 5.00'
      end
      object txtValue: TEdit
        Left = 95
        Top = 19
        Width = 468
        Height = 21
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 6
        Top = 142
        Width = 560
        Height = 51
        Caption = 'Favorecido'
        TabOrder = 2
        object Label4: TLabel
          Left = 5
          Top = 24
          Width = 181
          Height = 13
          Caption = '*Chave Pix - Ex. jo'#227'o@meuemail.com'
        end
        object txtKeyFav: TEdit
          Left = 192
          Top = 21
          Width = 365
          Height = 21
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 6
        Top = 51
        Width = 560
        Height = 83
        Caption = '*Pagador'
        TabOrder = 1
        object Label5: TLabel
          Left = 6
          Top = 24
          Width = 284
          Height = 13
          Caption = '*Chave Pix - Ex. a1f4102e-a446-4a57-bcce-6fa48899c1d1'
        end
        object Label6: TLabel
          Left = 6
          Top = 55
          Width = 283
          Height = 13
          Caption = 'Informa'#231#227'o do Pagador - Ex. Segue o pagamento da conta'
        end
        object txtKeyPag: TEdit
          Left = 296
          Top = 21
          Width = 261
          Height = 21
          TabOrder = 0
        end
        object txtPayerInfo: TEdit
          Left = 296
          Top = 52
          Width = 261
          Height = 21
          TabOrder = 1
        end
      end
    end
  end
end
