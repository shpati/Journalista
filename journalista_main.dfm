object Form1: TForm1
  Left = 1229
  Top = 142
  AutoScroll = False
  Caption = 'Journalista'
  ClientHeight = 426
  ClientWidth = 638
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = positioning
  OnCloseQuery = onformclose
  OnCreate = formCreate
  OnPaint = checkboxclick
  OnResize = positioning
  DesignSize = (
    638
    426)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 445
    Top = 176
    Width = 154
    Height = 13
    Caption = 'Filter entries from selected month'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 445
    Top = 192
    Width = 171
    Height = 13
    Caption = 'Filter shown entries containing text...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ListView1: TListView
    Left = 430
    Top = 240
    Width = 201
    Height = 167
    Anchors = [akTop, akRight, akBottom]
    BorderStyle = bsNone
    Columns = <
      item
        AutoSize = True
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    SortType = stData
    TabOrder = 2
    ViewStyle = vsReport
    OnResize = ListViewWndProc
    OnSelectItem = select
  end
  object MonthCalendar1: TMonthCalendar
    Left = 424
    Top = 0
    Width = 201
    Height = 161
    Date = 44255.379210347220000000
    TabOrder = 0
    WeekNumbers = True
    OnClick = checkboxclick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 406
    Width = 638
    Height = 20
    Panels = <>
    SimplePanel = True
  end
  object CheckBox1: TCheckBox
    Left = 424
    Top = 176
    Width = 17
    Height = 17
    TabStop = False
    Caption = 'CheckBox1'
    TabOrder = 4
    OnClick = checkboxclick
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 417
    Height = 407
    Anchors = [akLeft, akTop, akBottom]
    BevelInner = bvSpace
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    HideSelection = False
    HideScrollBars = False
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    PlainText = True
    ScrollBars = ssVertical
    TabOrder = 1
    WantTabs = True
    OnChange = countw
    OnContextPopup = contextmenu
    OnKeyUp = changes
  end
  object CheckBox2: TCheckBox
    Left = 424
    Top = 192
    Width = 17
    Height = 17
    TabStop = False
    Caption = 'CheckBox1'
    TabOrder = 5
    OnClick = checkbox2click
  end
  object Edit2: TEdit
    Left = 424
    Top = 208
    Width = 209
    Height = 21
    TabStop = False
    TabOrder = 6
    Visible = False
    OnKeyPress = readfilter
  end
  object StaticText1: TStaticText
    Left = 440
    Top = 320
    Width = 185
    Height = 73
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'A very large number of entries was found in the entries folder, ' +
      'slowing down the program. Please consider moving the older or le' +
      'ss used entries to a subfolder within the entries folder.'
    TabOrder = 7
    Visible = False
    OnClick = hidewarning
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 112
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New'
        ShortCut = 16462
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = '&Open...'
        ShortCut = 16463
        OnClick = opendialog
      end
      object Close1: TMenuItem
        Caption = '&Close'
        OnClick = closefile
      end
      object Save1: TMenuItem
        Caption = '&Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
        ShortCut = 49235
        OnClick = saveasdialog
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Encrypt1: TMenuItem
        Caption = '&Encrypt / Decrypt'
        ShortCut = 16453
        OnClick = Encrypt1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Delete1: TMenuItem
        Caption = '&Delete File'
        OnClick = Delete1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object sendtoprinter: TMenuItem
        Caption = '&Print...'
        ShortCut = 16464
        OnClick = print
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = exit
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Caption = 'Undo'
        ShortCut = 16474
        OnClick = Undo1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object cut1: TMenuItem
        Caption = 'Cut'
        ShortCut = 16472
        OnClick = cut1Click
      end
      object Copy1: TMenuItem
        Caption = 'Copy'
        ShortCut = 16451
        OnClick = Copy1Click
      end
      object Paste1: TMenuItem
        Caption = 'Paste'
        ShortCut = 16470
        OnClick = Paste1Click
      end
      object Delete2: TMenuItem
        Caption = 'Delete Selection'
        OnClick = Delete2Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object SelectAll1: TMenuItem
        Caption = 'Select All'
        ShortCut = 16449
        OnClick = SelectAll1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = 'Find...'
        ShortCut = 16454
        OnClick = FindDialog1Find
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object ConvertfromUTF81: TMenuItem
        Caption = 'Convert from UTF-8'
        ShortCut = 16469
        OnClick = ConvertfromUTF81Click
      end
    end
    object About1: TMenuItem
      Caption = 'Favorites'
      object Addfiletofavorites1: TMenuItem
        Caption = '&Add file to favorites'
        OnClick = Addfiletofavorites1Click
      end
      object Removefilefromfavorites1: TMenuItem
        Caption = '&Remove file from favorites'
        OnClick = Removefilefromfavorites1Click
      end
    end
    object Settings1: TMenuItem
      Caption = '&Settings'
      OnClick = Settings
    end
    object About2: TMenuItem
      Caption = '&About'
      OnClick = About
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 144
  end
  object SaveDialog1: TSaveDialog
    Left = 176
  end
  object PrintDialog1: TPrintDialog
    Left = 304
  end
  object FindDialog1: TFindDialog
    OnFind = Findit
    Left = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    object Undo3: TMenuItem
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = Undo1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Cut3: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = cut1Click
    end
    object Copy3: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = Copy1Click
    end
    object Paste3: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = Paste1Click
    end
    object DeleteSelection3: TMenuItem
      Caption = 'Delete Selection'
      OnClick = Delete2Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object SelectAll3: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = SelectAll1Click
    end
  end
end
