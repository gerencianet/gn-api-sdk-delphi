object MainEmissions: TMainEmissions
  Left = 0
  Top = 0
  Caption = 'API de Emiss'#245'es'
  ClientHeight = 638
  ClientWidth = 1089
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
    Left = 3
    Top = 1
    Width = 245
    Height = 471
    Caption = 'Credentials'
    Color = 6001140
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 21
      Width = 37
      Height = 13
      Caption = 'ClientId'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 64
      Width = 58
      Height = 13
      Caption = 'ClientSecret'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 133
      Width = 108
      Height = 13
      Caption = 'Identificador da Conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object txtClientId: TEdit
      Left = 6
      Top = 37
      Width = 237
      Height = 21
      TabOrder = 0
    end
    object txtClientSecret: TEdit
      Left = 6
      Top = 83
      Width = 237
      Height = 21
      TabOrder = 1
    end
    object PostAuthorization: TButton
      Left = 6
      Top = 206
      Width = 237
      Height = 26
      Caption = 'Post /Oauth/Token'
      TabOrder = 2
      OnClick = PostAuthorizationClick
    end
    object MOAuth: TPanel
      Left = 6
      Top = 179
      Width = 237
      Height = 26
      Caption = 'Autentica'#231#227'o'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object CheckBoxSandbox: TCheckBox
      Left = 6
      Top = 110
      Width = 70
      Height = 17
      Caption = 'Sandbox'
      Checked = True
      Color = 6001140
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object txtIdentifier: TEdit
      Left = 6
      Top = 152
      Width = 237
      Height = 21
      TabOrder = 5
    end
  end
  object MemoResponse: TMemo
    Left = 3
    Top = 473
    Width = 1081
    Height = 163
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object MCharges: TPanel
    Left = 249
    Top = 3
    Width = 195
    Height = 34
    Caption = 'Cobran'#231'as'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = MChargesClick
  end
  object SCharges: TPanel
    Left = 249
    Top = 38
    Width = 195
    Height = 434
    BevelKind = bkFlat
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    Visible = False
    OnMouseLeave = SChargesMouseLeave
    object createCharge: TButton
      Left = 2
      Top = 0
      Width = 187
      Height = 33
      Caption = 'Post /v1/charge'
      TabOrder = 0
      OnClick = createChargeClick
    end
    object detailCharge: TButton
      Left = 2
      Top = 99
      Width = 187
      Height = 33
      Caption = 'Get /v1/charge/:id'
      TabOrder = 1
      OnClick = detailChargeClick
    end
    object cancelCharge: TButton
      Left = 2
      Top = 165
      Width = 187
      Height = 33
      Caption = 'Put /v1/charge/:id/cancel'
      TabOrder = 2
      OnClick = cancelChargeClick
    end
    object payChargeBillet: TButton
      Left = 2
      Top = 198
      Width = 187
      Height = 33
      Caption = 'Post /v1/charge/:id/pay Billet'
      TabOrder = 3
      OnClick = payChargeBilletClick
    end
    object payChargeCreditCard: TButton
      Left = 2
      Top = 231
      Width = 187
      Height = 33
      Caption = 'Post /v1/charge/:id/pay Card'
      TabOrder = 4
      OnClick = payChargeCreditCardClick
    end
    object resendBillet: TButton
      Left = 2
      Top = 264
      Width = 187
      Height = 33
      Caption = 'POST /v1/charge/:id/billet/resend'
      TabOrder = 5
      OnClick = resendBilletClick
    end
    object createChargeHistory: TButton
      Left = 2
      Top = 297
      Width = 187
      Height = 33
      Caption = 'POST /v1/charge/:id/history'
      TabOrder = 6
      OnClick = createChargeHistoryClick
    end
    object linkCharge: TButton
      Left = 2
      Top = 330
      Width = 187
      Height = 33
      Caption = 'POST /v1/charge/:id/link'
      TabOrder = 7
      OnClick = linkChargeClick
    end
    object updateChargeLink: TButton
      Left = 2
      Top = 363
      Width = 187
      Height = 33
      Caption = 'PUT /v1/charge/:id/link'
      TabOrder = 8
      OnClick = updateChargeLinkClick
    end
    object settleCharge: TButton
      Left = 2
      Top = 396
      Width = 187
      Height = 33
      Caption = 'PUT /v1/charge/:id/settle'
      TabOrder = 9
      OnClick = settleChargeClick
    end
    object updateChargeMetadata: TButton
      Left = 2
      Top = 132
      Width = 187
      Height = 33
      Caption = 'Put /v1/charge/:id/metadata'
      TabOrder = 10
      OnClick = updateChargeMetadataClick
    end
    object createChargeOneStepBillet: TButton
      Left = 2
      Top = 33
      Width = 187
      Height = 33
      Caption = 'Post /v1/charge/one-step Billet'
      TabOrder = 11
      OnClick = createChargeOneStepBilletClick
    end
    object createChargeOneStepCreditCard: TButton
      Left = 2
      Top = 66
      Width = 187
      Height = 33
      Caption = 'Post /v1/charge/one-step CreditCard'
      TabOrder = 12
      OnClick = createChargeOneStepCreditCardClick
    end
  end
  object MCarnet: TPanel
    Left = 445
    Top = 3
    Width = 242
    Height = 34
    Caption = 'Carn'#234's'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    OnClick = MCarnetClick
  end
  object SCarnet: TPanel
    Left = 445
    Top = 38
    Width = 242
    Height = 434
    BevelKind = bkFlat
    Color = clWhite
    ParentBackground = False
    TabOrder = 5
    Visible = False
    OnMouseLeave = SCarnetMouseLeave
    object createCarnet: TButton
      Left = 2
      Top = 0
      Width = 233
      Height = 33
      Caption = 'Post /v1/carnet'
      TabOrder = 0
      OnClick = createCarnetClick
    end
    object detailCarnet: TButton
      Left = 2
      Top = 33
      Width = 233
      Height = 33
      Caption = 'Get /v1/carnet/:id'
      TabOrder = 1
      OnClick = detailCarnetClick
    end
    object cancelCarnet: TButton
      Left = 2
      Top = 132
      Width = 233
      Height = 33
      Caption = 'Put /v1/carnet/:id/cancel'
      TabOrder = 2
      OnClick = cancelCarnetClick
    end
    object updateParcel: TButton
      Left = 2
      Top = 99
      Width = 233
      Height = 33
      Caption = 'Put /v1/carnet/:id/parcel/:parcel'
      TabOrder = 3
      OnClick = updateParcelClick
    end
    object updateCarnetMetadata: TButton
      Left = 2
      Top = 66
      Width = 233
      Height = 33
      Caption = 'Put /v1/carnet/:id/metadata'
      TabOrder = 4
      OnClick = updateCarnetMetadataClick
    end
    object settleCarnet: TButton
      Left = 2
      Top = 297
      Width = 233
      Height = 33
      Caption = 'PUT /v1/carnet/:id/settle'
      TabOrder = 5
      OnClick = settleCarnetClick
    end
    object createCarnetHistory: TButton
      Left = 2
      Top = 264
      Width = 233
      Height = 33
      Caption = 'POST /v1/carnet/:id/history'
      TabOrder = 6
      OnClick = createCarnetHistoryClick
    end
    object cancelParcel: TButton
      Left = 2
      Top = 165
      Width = 233
      Height = 33
      Caption = 'PUT /v1/carnet/:id/parcel/:parcel/cancel'
      TabOrder = 7
      OnClick = cancelParcelClick
    end
    object ResendParcel: TButton
      Left = 2
      Top = 231
      Width = 233
      Height = 33
      Caption = 'POST /v1/carnet/:id/parcel/:parcel/resend'
      TabOrder = 8
      OnClick = ResendParcelClick
    end
    object ResendCarnet: TButton
      Left = 2
      Top = 198
      Width = 233
      Height = 33
      Caption = 'POST /v1/carnet/:id/resend'
      TabOrder = 9
      OnClick = ResendCarnetClick
    end
  end
  object MPlans: TPanel
    Left = 688
    Top = 3
    Width = 242
    Height = 34
    Caption = 'Assinaturas'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    OnClick = MPlansClick
  end
  object SPlans: TPanel
    Left = 688
    Top = 38
    Width = 242
    Height = 434
    BevelKind = bkFlat
    Color = clWhite
    ParentBackground = False
    TabOrder = 7
    Visible = False
    OnMouseLeave = SPlansMouseLeave
    object createSubscription: TButton
      Left = 0
      Top = 132
      Width = 236
      Height = 33
      Caption = 'Post /v1/plan/:id/subscription'
      TabOrder = 0
      OnClick = createSubscriptionClick
    end
    object detailSubscription: TButton
      Left = 0
      Top = 165
      Width = 236
      Height = 33
      Caption = 'Get /v1/subscription/:id'
      TabOrder = 1
      OnClick = detailSubscriptionClick
    end
    object cancelSubscription: TButton
      Left = 0
      Top = 198
      Width = 236
      Height = 33
      Caption = 'Put /v1/subscription/:id/cancel'
      TabOrder = 2
      OnClick = cancelSubscriptionClick
    end
    object updateSubscriptionMetadata: TButton
      Left = 0
      Top = 231
      Width = 236
      Height = 33
      Caption = 'Put /v1/subscription/:id/metadata'
      TabOrder = 3
      OnClick = updateSubscriptionMetadataClick
    end
    object createSubscriptionHistory: TButton
      Left = 0
      Top = 330
      Width = 236
      Height = 33
      Caption = 'Post /v1/subscription/:id/history'
      TabOrder = 4
      OnClick = createSubscriptionHistoryClick
    end
    object createPlan: TButton
      Left = 0
      Top = 0
      Width = 236
      Height = 33
      Caption = 'Post /v1/plan'
      TabOrder = 5
      OnClick = createPlanClick
    end
    object getPlans: TButton
      Left = 0
      Top = 33
      Width = 236
      Height = 33
      Caption = 'Get /v1/plans'
      TabOrder = 6
      OnClick = getPlansClick
    end
    object updatePlan: TButton
      Left = 0
      Top = 66
      Width = 236
      Height = 33
      Caption = 'Put /v1/plan/:id'
      TabOrder = 7
      OnClick = updatePlanClick
    end
    object deletePlan: TButton
      Left = 0
      Top = 99
      Width = 236
      Height = 33
      Caption = 'Delete /v1/plan/:id'
      TabOrder = 8
      OnClick = deletePlanClick
    end
    object paySubscriptionBillet: TButton
      Left = 0
      Top = 264
      Width = 236
      Height = 33
      Caption = 'Post /v1/subscription/:id/pay Billet'
      TabOrder = 9
      OnClick = paySubscriptionBilletClick
    end
    object paySubscriptionCreditCard: TButton
      Left = 0
      Top = 297
      Width = 236
      Height = 33
      Caption = 'Post /v1/subscription/:id/pay Card'
      TabOrder = 10
      OnClick = paySubscriptionCreditCardClick
    end
  end
  object MOthers: TPanel
    Left = 931
    Top = 3
    Width = 156
    Height = 34
    Caption = 'Outros'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 8
    OnClick = MOthersClick
  end
  object SOthers: TPanel
    Left = 931
    Top = 38
    Width = 156
    Height = 434
    BevelKind = bkFlat
    Color = clWhite
    ParentBackground = False
    TabOrder = 9
    Visible = False
    OnMouseLeave = SOthersMouseLeave
    object Button4: TButton
      Left = 0
      Top = 0
      Width = 151
      Height = 33
      Caption = 'Get /v1/notification/:token'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
end
