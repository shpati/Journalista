object Form2: TForm2
  Left = 826
  Top = 546
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 98
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = load
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 124
    Height = 13
    Caption = 'Path of Journalista entries:'
  end
  object Label2: TLabel
    Left = 8
    Top = 66
    Width = 81
    Height = 13
    Caption = 'Foreground Color'
  end
  object Label3: TLabel
    Left = 144
    Top = 66
    Width = 85
    Height = 13
    Caption = 'Background Color'
  end
  object Shape1: TShape
    Left = 96
    Top = 62
    Width = 25
    Height = 21
    OnMouseDown = forecolor
  end
  object Shape2: TShape
    Left = 237
    Top = 62
    Width = 25
    Height = 21
    OnMouseDown = backcolor
  end
  object Label4: TLabel
    Left = 284
    Top = 66
    Width = 44
    Height = 13
    Caption = 'Font Size'
  end
  object Label5: TLabel
    Left = 266
    Top = 10
    Width = 116
    Height = 13
    Caption = 'Start Program Maximized'
  end
  object Edit1: TEdit
    Left = 8
    Top = 28
    Width = 377
    Height = 21
    AutoSelect = False
    ReadOnly = True
    TabOrder = 0
    OnKeyDown = browse
  end
  object BitBtn1: TBitBtn
    Left = 390
    Top = 28
    Width = 67
    Height = 23
    Caption = 'Browse'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object ComboBox1: TComboBox
    Left = 336
    Top = 62
    Width = 49
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = fontsizechange
    Items.Strings = (
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '22'
      '24'
      '26'
      '28'
      '36'
      '48')
  end
  object CheckBox1: TCheckBox
    Left = 248
    Top = 8
    Width = 17
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 3
    OnClick = maxchange
  end
  object ColorDialog1: TColorDialog
    Left = 416
    Top = 64
  end
end
