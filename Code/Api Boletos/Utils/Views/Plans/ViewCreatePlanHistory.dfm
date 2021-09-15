object ViewCreatePlanHistory: TViewCreatePlanHistory
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
    Caption = 'Playground: Planos- *Campos Obrigat'#243'rios'
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 26
      Width = 148
      Height = 13
      Caption = '*Identificador - subscription_id'
    end
    object txtIdent: TEdit
      Left = 6
      Top = 41
      Width = 569
      Height = 21
      TabOrder = 0
    end
    object btnCancelRequest: TButton
      Left = 6
      Top = 128
      Width = 280
      Height = 32
      Caption = 'Cancelar a Requisi'#231#227'o'
      TabOrder = 3
      OnClick = btnCancelRequestClick
    end
    object btnConfirmRequest: TButton
      Left = 290
      Top = 128
      Width = 285
      Height = 32
      Caption = 'Confirmar a Requisi'#231#227'o'
      TabOrder = 2
      OnClick = btnConfirmRequestClick
    end
    object gbDevedor: TGroupBox
      Left = 6
      Top = 68
      Width = 569
      Height = 59
      Caption = 'Dados do Body'
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 19
        Width = 244
        Height = 13
        Caption = '*Descri'#231#227'o - Ex. Minha mensagem do hist'#243'rico aqui'
      end
      object Button1: TButton
        Left = 7
        Top = 226
        Width = 280
        Height = 32
        Caption = 'Cancelar a Requisi'#231#227'o'
        TabOrder = 2
        OnClick = btnCancelRequestClick
      end
      object Button2: TButton
        Left = 290
        Top = 226
        Width = 291
        Height = 32
        Caption = 'Confirmar a Requisi'#231#227'o'
        TabOrder = 1
        OnClick = btnConfirmRequestClick
      end
      object txtDescription: TEdit
        Left = 4
        Top = 33
        Width = 560
        Height = 21
        TabOrder = 0
      end
    end
  end
end
