object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'API - Usando Horse'
  ClientHeight = 353
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 20
  object PanelCentral: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 353
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 490
    ExplicitHeight = 352
    object PanelPaddingBottom: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 296
      Width = 454
      Height = 37
      Margins.Left = 20
      Margins.Right = 20
      Margins.Bottom = 20
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      ExplicitTop = 295
      ExplicitWidth = 450
      object PanelButtonAtivar: TPanel
        Left = 0
        Top = 0
        Width = 113
        Height = 37
        Margins.Left = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Ativar'
        Color = 10747718
        ParentBackground = False
        TabOrder = 0
        OnClick = PanelButtonAtivarClick
        OnMouseEnter = PanelButtonAtivarMouseEnter
        OnMouseLeave = PanelButtonAtivarMouseLeave
      end
    end
  end
end
