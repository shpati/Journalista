object Form2: TForm2
  Left = 1251
  Top = 663
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 128
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
    Left = 10
    Top = 10
    Width = 124
    Height = 13
    Caption = 'Path of Journalista entries:'
  end
  object Label2: TLabel
    Left = 10
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
    Left = 98
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
    Left = 286
    Top = 66
    Width = 44
    Height = 13
    Caption = 'Font Size'
  end
  object Label5: TLabel
    Left = 180
    Top = 10
    Width = 116
    Height = 13
    Caption = 'Start Program Maximized'
  end
  object Label6: TLabel
    Left = 340
    Top = 10
    Width = 118
    Height = 13
    Caption = 'Minimize Program to Tray'
  end
  object Label7: TLabel
    Left = 26
    Top = 98
    Width = 120
    Height = 13
    Caption = 'Set reminder at (HH:MM):'
  end
  object Edit1: TEdit
    Left = 10
    Top = 28
    Width = 377
    Height = 21
    AutoSelect = False
    ReadOnly = True
    TabOrder = 0
    OnKeyDown = browse
  end
  object ComboBox1: TComboBox
    Left = 338
    Top = 62
    Width = 49
    Height = 21
    ItemHeight = 13
    TabOrder = 1
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
    Left = 162
    Top = 8
    Width = 17
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 2
    OnClick = maxchange
  end
  object Button1: TButton
    Left = 392
    Top = 28
    Width = 67
    Height = 21
    Caption = 'Browse...'
    TabOrder = 3
    OnClick = Button1click
  end
  object CheckBox2: TCheckBox
    Left = 320
    Top = 8
    Width = 17
    Height = 17
    Caption = 'CheckBox2'
    TabOrder = 4
    OnClick = minchange
  end
  object CheckBox3: TCheckBox
    Left = 8
    Top = 96
    Width = 17
    Height = 17
    Caption = 'CheckBox3'
    TabOrder = 5
    OnClick = reminderchange
  end
  object ComboBox2: TComboBox
    Left = 152
    Top = 94
    Width = 41
    Height = 21
    Hint = 'Hour'
    Enabled = False
    ItemHeight = 13
    TabOrder = 6
    Text = '12'
    OnClick = reminderchange
    Items.Strings = (
      '00'
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
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
      '21'
      '22'
      '23')
  end
  object ComboBox3: TComboBox
    Left = 200
    Top = 94
    Width = 41
    Height = 21
    Hint = 'Minute'
    Enabled = False
    ItemHeight = 13
    TabOrder = 7
    Text = '00'
    OnClick = reminderchange
    Items.Strings = (
      '00'
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
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
      '21'
      '22'
      '23'
      '24'
      '25'
      '26'
      '27'
      '28'
      '29'
      '30'
      '31'
      '32'
      '33'
      '34'
      '35'
      '36'
      '37'
      '38'
      '39'
      '40'
      '41'
      '42'
      '43'
      '44'
      '45'
      '46'
      '47'
      '48'
      '49'
      '50'
      '51'
      '52'
      '53'
      '54'
      '55'
      '56'
      '57'
      '58'
      '59')
  end
  object ColorDialog1: TColorDialog
    Left = 416
    Top = 64
  end
end
