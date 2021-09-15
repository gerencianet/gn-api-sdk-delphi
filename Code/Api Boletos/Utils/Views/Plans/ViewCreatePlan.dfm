object ViewCreatePlan: TViewCreatePlan
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
    Caption = 'Dados do Body - *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 17
      Width = 239
      Height = 13
      Caption = '*Nome - Ex. Plano de Internet - Velocidade 10 Mb'
    end
    object Label3: TLabel
      Left = 7
      Top = 97
      Width = 94
      Height = 13
      Caption = 'Repeti'#231#245'es - Ex. 12'
    end
    object Label5: TLabel
      Left = 7
      Top = 58
      Width = 85
      Height = 13
      Caption = '*Intervalo - Ex. 1'
    end
    object txtName: TEdit
      Left = 7
      Top = 29
      Width = 559
      Height = 21
      TabOrder = 0
    end
    object txtRepeats: TEdit
      Left = 7
      Top = 110
      Width = 559
      Height = 21
      TabOrder = 2
    end
    object txtInterval: TEdit
      Left = 7
      Top = 70
      Width = 559
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
