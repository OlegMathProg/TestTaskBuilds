unit main;

{$mode objfpc}{$H+}

interface

uses

  {rtl}
  Classes, Controls, SysUtils, LResources, Forms, Graphics, Dialogs, ExtCtrls,
  StdCtrls,

  {3d party units}
  BGRABitmap, BGRABitmapTypes,
  fphttpclient, fpjson, jsonparser, opensslsockets,

  {own units}
  rounded_panel;



const

  DPI  =96.0;

  D_W  =390;
  D_H  =844;

  MRG00=005;
  MRG01=024;
  MRG02=299;
  MRG03=053;
  MRG04=374;
  MRG05=484;
  MRG06=021;
  MRG07=007;
  MRG08=057;
  MRG09=043;
  MRG10=200;
  MRG11=063;
  MRG12=282;
  MRG13=023;
  MRG14=040;
  MRG15=120;
  MRG16=212;
  MRG17=100;
  MRG18=032;
  MRG19=016;
  MRG20=029;
  MRG21=103;
  MRG22=213;
  MRG23=389;
  MRG24=274;
  MRG25=220;

  COL0 =$00873D3F;
  COL1 =$00FFFAF9;
  COL2 =$004D48F7;
  COL3 =$00A79B96;
  COL4 =$00B05E62; COL4_=$00C28386; COL4__=$00C56370;
  COL5 =$00923F47;
  COL6 =$009B444D;
  COL7 =$00C98992;
  COL8 =$000BD5A3; COL8_=$000AAF86;
  COL9 =$00CAADAC;
  COL10=$00BA9594;
  COL11=$008D615F;
  COL12=$00DAD1CF;
  COL13=$001AB9FD;
  COL14=$00CF9293;
  COL15=$00BD9791;

  RAD0 =030;
  RAD1 =014;
  RAD2 =005;
  RAD3 =020;
  RAD4 =029;
  RAD5 =140;
  RAD6 =100;
  RAD7 =070;
  RAD8 =066;

  {$ifdef Windows}
  PIC0='Pics\Star.png';
  {$endif}



type

  TFlags       =(torrent,favorite,vip);

  TServerObj   =record
    Id        : Integer;
    Name      : String;
    CountryIso: String;
    Flags     : TFlags;
  end;

  {TF_AstrillVPN}
  TF_AstrillVPN=class(TForm)

    {Pictures}
    IL_0               : TImageList;
    IL_1               : TImageList;
    I_Star             : TImage;
    I_Username         : TImage;
    I_Password         : TImage;
    I_Settings         : TImage;
    I_USA              : TImage;
    I_ArrowUp          : TImage;
    I_ArrowDown        : TImage;

    {Labels}
    E_Username         : TEdit;
    E_Password         : TEdit;
    E_Search_Locations : TEdit;

    L_Astrill          : TLabel;
    L_VPN              : TLabel;
    L_Login            : TLabel;
    L_Username         : TLabel;
    L_Password         : TLabel;
    L_Register         : TLabel;
    L_Forgot_Password  : TLabel;
    L_Remember_Password: TLabel;
    L_Login2           : TLabel;
    L_AstrillVPN       : TLabel;
    L_United_States    : TLabel;
    L_IP               : TLabel;
    L_Connect_Status   : TLabel;
    L_Session_Time     : TLabel;
    L_VPN_Protocol     : TLabel;
    L_Expires          : TLabel;
    L_Upload           : TLabel;
    L_Download         : TLabel;
    L_Upload_Speed     : TLabel;
    L_Download_Speed   : TLabel;
    L_Invite_Friends   : TLabel;
    L_Select_Server    : TLabel;
    L_Optimal_Locations: TLabel;
    L_Other_Locations  : TLabel;
    L_Error_Ok         : TLabel;
    L_Error_Header     : TLabel;
    L_Error_Content    : TLabel;

    {Debug}
    Memo1              : TMemo;
    T_Session_Time     : TTimer;

    procedure FormActivate                (Sender:TObject);
    procedure FormCreate                  (Sender:TObject);
    procedure FormResize                  (Sender:TObject);
    procedure L_Remember_PasswordMouseDown(Sender:TObject;
                                           Button:TMouseButton;
                                           Shift :TShiftState;
                                           X,Y   :Integer);
    procedure E_UsernameMouseDown         (Sender:TObject;
                                           Button:TMouseButton;
                                           Shift :TShiftState;
                                           X,Y   :Integer);
    procedure E_PasswordMouseDown         (Sender:TObject;
                                           Button:TMouseButton;
                                           Shift :TShiftState;
                                           X,Y   :Integer);
    procedure E_Search_LocationsMouseDown (Sender:TObject;
                                           Button:TMouseButton;
                                           Shift :TShiftState;
                                           X,Y   :Integer);
    procedure T_Session_TimeTimer         (Sender:TObject);
    public
      FScale        : double;

      {Server list}
      server_obj_arr: array of TServerObj;

      {Panels}
      r_pnl_arr     : array of TBGRARoundedPanel;

      {Panel labels}
      p_lbl_arr     : array of TLabel;

      procedure SetParamsDynamic0;
      procedure SetParamsStatic0;
      procedure SetParamsDynamic1;
      procedure SetParamsStatic1;
      procedure HighLightBounds       (Sender   :TObject);
      procedure HighLightBounds2      (Sender   :TObject);
      procedure HighLightBounds3      (Sender   :TObject);
      procedure DarkenBounds          (Sender   :TObject);
      procedure DarkenBounds2         (Sender   :TObject);
      procedure DarkenBounds3         (Sender   :TObject);
      procedure RoundedPanelMouseEnter(Sender   :TObject);
      procedure RoundedPanelMouseLeave(Sender   :TObject);
      procedure RoundedPanelMouseMove (Sender   :TObject;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure RoundedPanelMouseDown (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure ArrowBackMouseDown    (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure ArrowBackMouseUp      (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure ArrowBack2MouseUp     (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure SettingsMouseDown     (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure SettingsMouseUp       (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure UnitedStatesMouseDown (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure UnitedStatesMouseDown2(Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure UnitedStatesMouseUp   (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure UnitedStatesMouseUp2  (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure ConnectMouseDown      (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure ConnectMouseUp        (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure LabelsMouseDown       (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure LabelsMouseUp         (Sender   :TObject;
                                       Button   :TMouseButton;
                                       Shift    :TShiftState;
                                       X,Y      :Integer);
      procedure AddPanel              (Parent_  :TWinControl;
                                       W,H      :Integer;
                                       AddLabel_:Boolean=False;
                                       Visible_ :Boolean=True);

      {}
      procedure ShowPage              (PageInd_ :Integer);
      procedure HandleLoginSuccess    (RespJSON :TJSONObject);
      procedure HandleLoginError      (RespJSON :TJSONObject);
      procedure LoginClick            (Sender   :TObject);
      procedure ErrorOkClick          (Sender   :TObject);

  end;



var

  F_AstrillVPN     : TF_AstrillVPN;
  ImgListBmpArr    : array of TBGRABitmap;
  PageInd          : Integer=0;
  TimeBeforeConnect: Integer=0;
  LoginSuccess     : Boolean=False;
  IsConnected      : Boolean=False;



implementation

uses

  Unit1;

{TF_AstrillVPN}

{UI drawing}
procedure TF_AstrillVPN.SetParamsStatic0;
begin

  with r_pnl_arr[0] do
    begin
      BkgndColor          :=F_AstrillVPN.Color;
      geom_2D_arr[0].Color:=COL0;
    end;

  with r_pnl_arr[1] do
    begin
      BkgndColor               :=COL0;
      geom_2D_arr[0].Color     :=COL1;
      geom_2D_arr[1].Color     :=COL0;
      geom_2D_arr[2].BGRABmpPtr:=@ImgListBmpArr[0];
    end;

  with r_pnl_arr[2] do
    begin
      BkgndColor               :=COL0;
      geom_2D_arr[0].Color     :=COL1;
      geom_2D_arr[1].Color     :=COL0;
      geom_2D_arr[2].BGRABmpPtr:=@ImgListBmpArr[1];
    end;

  with r_pnl_arr[3] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=COL1;
      geom_2D_arr[1].Color:=COL0;
      with geom_2D_arr[2] do
        begin
          Alpha    :=255;
          IsChecked:=False;
          Color    :=COL1;
        end;
    end;

  with r_pnl_arr[4] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=COL2;
      geom_2D_arr[1].Color:=COL2;
    end;

  with r_pnl_arr[5] do
    begin
      BkgndColor          :=F_AstrillVPN.Color;
      geom_2D_arr[0].Color:=COL0;
    end;

  with r_pnl_arr[6] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=COL4;
      geom_2D_arr[1].Color:=clWhite;
      with geom_2D_arr[2] do
        begin
          Alpha:=0;
          Color:=COL4;
        end;
    end;

  with r_pnl_arr[7] do
    begin
      BkgndColor               :=COL0;
      geom_2D_arr[0].Color     :=COL4;
      geom_2D_arr[1].BGRABmpPtr:=@ImgListBmpArr[2];
      with geom_2D_arr[2] do
        begin
          Alpha:=0;
          Color:=COL4;
        end;
    end;

  with r_pnl_arr[8] do
    begin
      BkgndColor               :=COL0;
      geom_2D_arr[0].Color     :=COL4;
      geom_2D_arr[1].Color     :=COL0;
      geom_2D_arr[3].Color     :=COL4;
      geom_2D_arr[2].BGRABmpPtr:=@ImgListBmpArr[7];
      geom_2D_arr[4].Color     :=clWhite;
    end;

  with r_pnl_arr[9] do
    begin
      BkgndColor:=COL0;
      with geom_2D_arr[0] do
        begin
          Alpha:=255;
          Color:=COL5;
        end;
      with geom_2D_arr[1] do
        begin
          Alpha:=255;
          Color:=COL6;
        end;
      with geom_2D_arr[2] do
        begin
          Alpha:=255;
          Color:=COL0;
        end;
      with geom_2D_arr[3] do
        begin
          Alpha:=255;
          Color:=clWhite;
        end;
      with geom_2D_arr[4] do
        begin
          Color :=COL0;
          Angle1:=-Pi/3.4;
          Angle2:= Pi-Angle1;
        end;
      with geom_2D_arr[5] do
        begin
          Alpha:=65535;
          Color:=COL0;
        end;
    end;

  with r_pnl_arr[10] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=COL4;
      with geom_2D_arr[1] do
        begin
          Alpha:=65535;
          Color:=COL7;
        end;
      with geom_2D_arr[2] do
        begin
          Alpha:=255;
          Color:=COL2;
        end;
      with geom_2D_arr[3] do
        begin
          Alpha:=255;
          Color:=COL8;
        end;
      geom_2D_arr[4].BGRABmpPtr:=@ImgListBmpArr[5];
      geom_2D_arr[5].BGRABmpPtr:=@ImgListBmpArr[6];
    end;

  with r_pnl_arr[11] do
    begin
      BkgndColor          :=F_AstrillVPN.Color;
      geom_2D_arr[0].Color:=COL0;
    end;

  with r_pnl_arr[12] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=COL4;
      geom_2D_arr[1].Color:=clWhite;
      with geom_2D_arr[2] do
        begin
          Alpha:=0;
          Color:=COL4;
        end;
    end;

  with r_pnl_arr[13] do
    begin
      BkgndColor               :=COL0;
      geom_2D_arr[0].Color     :=COL1;
      geom_2D_arr[1].Color     :=COL0;
      geom_2D_arr[2].BGRABmpPtr:=@ImgListBmpArr[4];
    end;

  with r_pnl_arr[21] do
    begin
      BkgndColor          :=COL0;
      geom_2D_arr[0].Color:=clWhite;
    end;

  with r_pnl_arr[22] do
    begin
      BkgndColor          :=clWhite;
      geom_2D_arr[0].Color:=COL8{COL2};
      geom_2D_arr[1].Color:=COL8{COL2};
    end;

end;
procedure TF_AstrillVPN.SetParamsDynamic0;
begin

  with r_pnl_arr[0] do
    begin
      Width :=F_AstrillVPN.Width -2*MRG00;
      Height:=F_AstrillVPN.Height-2*MRG00;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD0;
          Radius2:=Radius1;
        end;
    end;

  with r_pnl_arr[1] do
    begin
      Width :=r_pnl_arr[00].Width-2*MRG01;
      Height:=MRG03;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=2;
          Radius1      :=RAD1;
          Radius2      :=Radius1;
          RctDst.Left  :=1;       //2;
          RctDst.Top   :=1;       //2;
          RctDst.Width :=Width -2;//Width -4;
          RctDst.Height:=Height-2;//Height-4;
        end;
      with geom_2D_arr[2] do
        begin
          RctDst.Left:=12+BGRABmpPtr^.Width>>1;
          RctDst.Top :=RctDst.Left;
        end;
    end;

  with r_pnl_arr[2] do
    begin
      Width :=r_pnl_arr[1].Width;
      Height:=r_pnl_arr[1].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=r_pnl_arr[1].geom_2D_arr[0].Radius1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=r_pnl_arr[1].geom_2D_arr[1].Thikness;
          Radius1      :=r_pnl_arr[1].geom_2D_arr[1].Radius1;
          Radius2      :=Radius1;
          RctDst.Left  :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Left;
          RctDst.Top   :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Top;
          RctDst.Width :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Width;
          RctDst.Height:=r_pnl_arr[1].geom_2D_arr[1].RctDst.Height;
        end;
      with geom_2D_arr[2] do
        begin
          RctDst.Left:=12+BGRABmpPtr^.Width>>1;
          RctDst.Top :=RctDst.Left;
        end;
    end;

  with r_pnl_arr[3] do
    begin
      Width :=MRG06;
      Height:=Width;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD2;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=2;
          Radius1      :=RAD2;
          Radius2      :=Radius1;
          RctDst.Left  :=1;       //2;
          RctDst.Top   :=1;       //2;
          RctDst.Width :=Height-2;//Height-4;
          RctDst.Height:=Height-2;//Height-4;
        end;
      with geom_2D_arr[2] do
        begin
          Radius1    :=RAD2;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
    end;

  with r_pnl_arr[4] do
    begin
      Width :=r_pnl_arr[1].Width;
      Height:=r_pnl_arr[1].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=r_pnl_arr[1].geom_2D_arr[0].Radius1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=r_pnl_arr[1].geom_2D_arr[1].Thikness;
          Radius1      :=r_pnl_arr[1].geom_2D_arr[1].Radius1;
          Radius2      :=Radius1;
          RctDst.Left  :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Left;
          RctDst.Top   :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Top;
          RctDst.Width :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Width;
          RctDst.Height:=r_pnl_arr[1].geom_2D_arr[1].RctDst.Height;
        end;
    end;

  with r_pnl_arr[5] do
    begin
      Width :=r_pnl_arr[0].Width;
      Height:=r_pnl_arr[0].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=r_pnl_arr[0].geom_2D_arr[0].Radius1;
          Radius2:=Radius1;
        end;
    end;

  with r_pnl_arr[6] do
    begin
      Width :=MRG09;
      Height:=Width;
      with geom_2D_arr[0] do
        begin
          Thikness   :=1;
          Radius1    :=RAD3;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=Height>>1;
        end;
      with geom_2D_arr[1] do
        begin
          Pt3[0].X:=16;
          Pt3[0].Y:=geom_2D_arr[0].Radius1;
          Pt3[1].X:=Pt3[0].X+7;
          Pt3[1].Y:=Pt3[0].Y-7;
          Thikness:=1;
        end;
      with geom_2D_arr[2] do
        begin
          Radius1    :=RAD3+geom_2D_arr[0].Thikness;
          Radius2    :=RAD3+geom_2D_arr[0].Thikness;
          RctDst.Left:=Height>>1;
          RctDst.Top :=Height>>1;
        end;
    end;

  with r_pnl_arr[7] do
    begin
      Width :=r_pnl_arr[6].Width;
      Height:=Width;
      with geom_2D_arr[0] do
        begin
          Thikness   :=r_pnl_arr[6].geom_2D_arr[0].Thikness;
          Radius1    :=r_pnl_arr[6].geom_2D_arr[0].Radius1;
          Radius2    :=Radius1;
          RctDst.Left:=r_pnl_arr[6].geom_2D_arr[0].RctDst.Left;
          RctDst.Top :=r_pnl_arr[6].geom_2D_arr[0].RctDst.Top;
        end;
      with geom_2D_arr[1] do
        begin
          RctDst.Left:=Height>>1+1;
          RctDst.Top :=RctDst.Left-1;
        end;
      with geom_2D_arr[2] do
        begin
          Radius1    :=r_pnl_arr[6].geom_2D_arr[2].Radius1;
          Radius2    :=Radius1;
          RctDst.Left:=r_pnl_arr[6].geom_2D_arr[2].RctDst.Left;
          RctDst.Top :=r_pnl_arr[6].geom_2D_arr[2].RctDst.Top;
        end;
    end;

  with r_pnl_arr[8] do
    begin
      Width :=MRG10;
      Height:=MRG11;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD4;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=2;
          Radius1      :=RAD4;
          Radius2      :=Radius1;
          RctDst.Left  :=2;
          RctDst.Top   :=2;
          RctDst.Width :=Width -4;
          RctDst.Height:=Height-4;
        end;
      with geom_2D_arr[3] do
        begin
          Radius1    :=RAD3+1;
          Radius2    :=Radius1;
          Thikness   :=4;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[2] do
        begin
          Scale      :=0.98;
          RctDst.Left:=geom_2D_arr[3].RctDst.Left+1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[4] do
        begin
          Thikness:=1;
          Pt3[0].X:=181;
          Pt3[0].Y:=r_pnl_arr[8].Height>>1;
          Pt3[1].X:=Pt3[0].X-5;
          Pt3[1].Y:=Pt3[0].Y-5;
        end;
    end;

  with r_pnl_arr[9] do
    begin
      Width :=MRG12;
      Height:=Width;
      with geom_2D_arr[0] do
        begin
          Radius1    :=RAD5;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[1] do
        begin
          Radius1    :=RAD6;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[2] do
        begin
          Radius1    :=RAD7;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[3] do
        begin
          Radius1    :=RAD8;
          Radius2    :=Radius1;
          RctDst.Left:=Height>>1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[4] do
        begin
          Radius1    :=RAD3-1;
          Radius2    :=Radius1;
          Thikness   :=6;
          RctDst.Left:=geom_2D_arr[0].Radius1;
          RctDst.Top :=RctDst.Left;
        end;
      with geom_2D_arr[5] do
        begin
          Thikness:=7;
          Pt3[0].X:=geom_2D_arr[0].Radius1;
          Pt3[0].Y:=Pt3[0].X-3;
          Pt3[1].Y:=Pt3[0].X-22;
        end;
    end;

  with r_pnl_arr[10] do
    begin
      Width :=r_pnl_arr[5].Width-2*MRG01;
      Height:=MRG17;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness:=1;
          Pt3[0].X:=r_pnl_arr[10].Width>>1;
          Pt3[0].Y:=32;
          Pt3[1].Y:=r_pnl_arr[10].Height-MRG18;
        end;
      with geom_2D_arr[2] do
        begin
          Radius1    :=RAD3;
          Radius2    :=Radius1;
          RctDst.Left:=MRG19+RAD3;
          RctDst.Top :=MRG20+RAD3;
        end;
      with geom_2D_arr[3] do
        begin
          Radius1    :=RAD3;
          Radius2    :=Radius1;
          RctDst.Left:=geom_2D_arr[1].Pt3[0].X+geom_2D_arr[2].RctDst.Left;
          RctDst.Top :=geom_2D_arr[2].RctDst.Top;
        end;
      with geom_2D_arr[4] do
        begin
          RctDst.Left:=geom_2D_arr[2].RctDst.Left;
          RctDst.Top :=geom_2D_arr[2].RctDst.Top;
        end;
      with geom_2D_arr[5] do
        begin
          RctDst.Left:=geom_2D_arr[3].RctDst.Left;
          RctDst.Top :=geom_2D_arr[2].RctDst.Top;
        end;
    end;

  with r_pnl_arr[11] do
    begin
      Width :=r_pnl_arr[0].Width;
      Height:=r_pnl_arr[0].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD0;
          Radius2:=Radius1;
        end;
    end;

  with r_pnl_arr[12] do
    begin
      Width :=r_pnl_arr[6].Width;
      Height:=Width;
      geom_2D_arr[0]:=r_pnl_arr[6].geom_2D_arr[0];
      geom_2D_arr[1]:=r_pnl_arr[6].geom_2D_arr[1];
      geom_2D_arr[2]:=r_pnl_arr[6].geom_2D_arr[2];
    end;

  with r_pnl_arr[13] do
    begin
      Width :=r_pnl_arr[1].Width;
      Height:=r_pnl_arr[1].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=r_pnl_arr[1].geom_2D_arr[0].Radius1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=r_pnl_arr[1].geom_2D_arr[1].Thikness;
          Radius1      :=r_pnl_arr[1].geom_2D_arr[1].Radius1;
          Radius2      :=Radius1;
          RctDst.Left  :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Left;
          RctDst.Top   :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Top;
          RctDst.Width :=r_pnl_arr[1].geom_2D_arr[1].RctDst.Width;
          RctDst.Height:=r_pnl_arr[1].geom_2D_arr[1].RctDst.Height;
        end;
      with geom_2D_arr[2] do
        begin
          RctDst.Left:=12+BGRABmpPtr^.Width>>1;
          RctDst.Top :=RctDst.Left;
        end;
    end;

  with r_pnl_arr[21] do
    begin
      Width :=MRG24;
      Height:=MRG25;
      with geom_2D_arr[0] do
        begin
          Radius1:=RAD3;
          Radius2:=Radius1;
        end;
    end;

  with r_pnl_arr[22] do
    begin
      Width :=r_pnl_arr[21].Width-40;
      Height:=r_pnl_arr[4].Height;
      with geom_2D_arr[0] do
        begin
          Radius1:=r_pnl_arr[1].geom_2D_arr[0].Radius1;
          Radius2:=Radius1;
        end;
      with geom_2D_arr[1] do
        begin
          Thikness     :=r_pnl_arr[1].geom_2D_arr[1].Thikness;
          Radius1      :=r_pnl_arr[1].geom_2D_arr[1].Radius1;
          Radius2      :=Radius1;
          RctDst.Left  :=1;       //2;
          RctDst.Top   :=1;       //2;
          RctDst.Width :=Width -2;//Width -4;
          RctDst.Height:=Height-2;//Height-4;
        end;
    end;

end;
procedure TF_AstrillVPN.SetParamsStatic1;
var
  I:Integer;
begin
  for I:=14 to 20 do
    with r_pnl_arr[I] do
      begin
        BkgndColor          :=COL0;
        geom_2D_arr[0].Color:=COL0;
        geom_2D_arr[1].Color:=COL4__;
        with geom_2D_arr[2] do
          if (I in [14,15]) then
            BGRABmpPtr:=@ImgListBmpArr[7]
          else
            BGRABmpPtr:=@ImgListBmpArr[7+(I-16)];
        geom_2D_arr[3].Color:=COL0;
        geom_2D_arr[4].BGRABmpPtr:=@ImgListBmpArr[3];
        with geom_2D_arr[5] do
          if (I in [14,15]) then
            Color:=COL13
          else
            Color:=COL14;
      end;
end;
procedure TF_AstrillVPN.SetParamsDynamic1;
var
  I:Integer;
begin
  for I:=14 to 20 do
    with r_pnl_arr[I] do
      begin
        Width :=r_pnl_arr[11].Width-2*MRG01;
        Height:=MRG03-4;
        with geom_2D_arr[0] do
          begin
            Radius1:=RAD1;
            Radius2:=Radius1;
          end;
        with geom_2D_arr[1] do
          begin
            Thikness     :=2;
            Radius1      :=RAD1;
            Radius2      :=Radius1;
            RctDst.Left  :=2;
            RctDst.Top   :=2;
            RctDst.Width :=Width -4;
            RctDst.Height:=Height-4;
          end;
        with geom_2D_arr[2] do
          begin
            Scale      :=0.8;
            RctDst.Left:=(Height+1)>>1;
            RctDst.Top :=RctDst.Left;
          end;
        with geom_2D_arr[3] do
          begin
            Radius1    :=RAD3-4;
            Radius2    :=Radius1;
            Thikness   :=4;
            RctDst.Left:=Height>>1;
            RctDst.Top :=RctDst.Left;
          end;
        with geom_2D_arr[4] do
          begin
            RctDst.Left:=Width-55;
            RctDst.Top :=geom_2D_arr[2].RctDst.Top;
          end;
        with geom_2D_arr[5] do
          begin
            Radius1    :=4;
            Radius2    :=8;
            RctDst.Left:=Width-21;
            RctDst.Top :=geom_2D_arr[2].RctDst.Top;
          end;
      end;
end;
procedure TF_AstrillVPN.FormCreate  (Sender :TObject);
var
  Bmp: TBitmap;
  I  : Integer;
begin
  Position   :={poDesigned; //}poDesktopCenter;
  BorderStyle:=bsSizeable; //}bsNone;
  Scaled     :=True;
  FScale     :=Screen.PixelsPerInch/DPI; //ClientWidth/D_W;
  Width      :=Round(D_W*FScale);
  Height     :=Round(D_H*FScale);

  {Server list--} {$region -fold}
  SetLength(server_obj_arr,7);
  with server_obj_arr[0] do
    begin
      Id        :=Random(10);
      Name      :='USA-Phoenix 2 (Private)';
      CountryIso:='US';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[1] do
    begin
      Id        :=Random(10)+server_obj_arr[0].Id+10;
      Name      :='USA-Los Angeles 10G';
      CountryIso:='US';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[2] do
    begin
      Id        :=Random(10)+server_obj_arr[1].Id+10;
      Name      :='USA-Los Angeles';
      CountryIso:='US';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[3] do
    begin
      Id        :=Random(10)+server_obj_arr[2].Id+10;
      Name      :='Netherlands-Amsterdam';
      CountryIso:='NL';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[4] do
    begin
      Id        :=Random(10)+server_obj_arr[3].Id+10;
      Name      :='United Kingdom-London';
      CountryIso:='GB';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[5] do
    begin
      Id        :=Random(10)+server_obj_arr[4].Id+10;
      Name      :='France-Paris';
      CountryIso:='FR';
      Flags     :=TFlags(Random(3));
    end;
  with server_obj_arr[6] do
    begin
      Id        :=Random(10)+server_obj_arr[5].Id+10;
      Name      :='Switzerland-Zurich';
      CountryIso:='CH';
      Flags     :=TFlags(Random(3));
    end;
  {$endregion}

  {ImgList init.} {$region -fold}
  SetLength(ImgListBmpArr,12);
  bmp:=TBitmap.Create;

  bmp.SetSize(IL_0.Width,IL_0.Height);
  bmp.PixelFormat:=pf32bit;
  IL_0.GetBitmap(1,bmp);
  ImgListBmpArr[0]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_0.Width,IL_0.Height);
  bmp.PixelFormat:=pf32bit;
  IL_0.GetBitmap(2,bmp);
  ImgListBmpArr[1]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(0,bmp);
  ImgListBmpArr[2]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_0.Width,IL_0.Height);
  bmp.PixelFormat:=pf32bit;
  IL_0.GetBitmap(4,bmp);
  ImgListBmpArr[3]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_0.Width,IL_0.Height);
  bmp.PixelFormat:=pf32bit;
  IL_0.GetBitmap(3,bmp);
  ImgListBmpArr[4]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(1,bmp);
  ImgListBmpArr[5]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(2,bmp);
  ImgListBmpArr[6]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(3,bmp);
  ImgListBmpArr[7]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(4,bmp);
  ImgListBmpArr[8]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(5,bmp);
  ImgListBmpArr[9]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(6,bmp);
  ImgListBmpArr[10]:=TBGRABitmap.Create(bmp);

  bmp.SetSize(IL_1.Width,IL_1.Height);
  bmp.PixelFormat:=pf32bit;
  IL_1.GetBitmap(7,bmp);
  ImgListBmpArr[11]:=TBGRABitmap.Create(bmp);

  bmp.Free;
  {$endregion}

  {Panels}
  // r_pnl_arr[00] - login       panel; r_pnl_arr[01..04] - child panels;
  // r_pnl_arr[05] - connect     panel; r_pnl_arr[06..10] - child panels;
  // r_pnl_arr[11] - server list panel; r_pnl_arr[12....] - child panels;

  {Login        panels} {$region -fold}
  AddPanel(Self         ,F_AstrillVPN .Width-2*MRG00,F_AstrillVPN.Height-2*MRG00);
  AddPanel(r_pnl_arr[00],r_pnl_arr[00].Width-2*MRG01,MRG03                      );
  AddPanel(r_pnl_arr[00],r_pnl_arr[00].Width-2*MRG01,MRG03                      );
  AddPanel(r_pnl_arr[00],MRG06                      ,MRG06                      );
  AddPanel(r_pnl_arr[00],r_pnl_arr[00].Width-2*MRG01,MRG08                      );
  //r_pnl_arr[0].Visible:=False;
  {$endregion}

  {Connect      panels} {$region -fold}
  AddPanel(Self         ,F_AstrillVPN .Width-2*MRG00,F_AstrillVPN.Height-2*MRG00);
  AddPanel(r_pnl_arr[05],MRG09                      ,MRG09                      );
  AddPanel(r_pnl_arr[05],MRG09                      ,MRG09                      );
  AddPanel(r_pnl_arr[05],MRG10                      ,MRG11                      );
  AddPanel(r_pnl_arr[05],MRG12                      ,MRG12                      );
  AddPanel(r_pnl_arr[05],r_pnl_arr[05].Width-2*MRG01,MRG17                      );
  r_pnl_arr[5].Visible:=False;
  {$endregion}

  {Server list  panels} {$region -fold}
  AddPanel(Self         ,F_AstrillVPN .Width-2*MRG00,F_AstrillVPN.Height-2*MRG00);
  AddPanel(r_pnl_arr[11],MRG09                      ,MRG09                      );
  AddPanel(r_pnl_arr[11],r_pnl_arr[11].Width-2*MRG01,MRG03                      );
  for I:=0 to 6 do
    AddPanel(r_pnl_arr[11],r_pnl_arr[11].Width-2*MRG01,MRG03,True);
  r_pnl_arr[11].Visible:=False;
  {$endregion}

  {Error screen panels} {$region -fold}
  AddPanel(r_pnl_arr[00],MRG24,MRG25);
  AddPanel(r_pnl_arr[21],r_pnl_arr[21].Width-40,r_pnl_arr[4].Height);
  r_pnl_arr[21].Visible:=False;
  {$endregion}

  {Panels geom. init.-} {$region -fold}
  r_pnl_arr[0].Geom2DAdd(g2DtFilledRectangle);
  with r_pnl_arr[1] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
      Geom2DAdd(g2DtImage);
    end;
  with r_pnl_arr[2] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
      Geom2DAdd(g2DtImage);
    end;
  with r_pnl_arr[3] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
      Geom2DAdd(g2DtFilledCircle);
    end;
  with r_pnl_arr[4] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
    end;
  r_pnl_arr[5].Geom2DAdd(g2DtFilledRectangle);
  with r_pnl_arr[6] do
    begin
      Geom2DAdd(g2DtCircle);
      Geom2DAdd(g2DtArrowLeftRight);
      Geom2DAdd(g2DtFilledCircle);
    end;
  with r_pnl_arr[7] do
    begin
      Geom2DAdd(g2DtCircle);
      Geom2DAdd(g2DtImage);
      Geom2DAdd(g2DtFilledCircle);
    end;
  with r_pnl_arr[8] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
      Geom2DAdd(g2DtImage);
      Geom2DAdd(g2DtCircle);
      Geom2DAdd(g2DtArrowLeftRight);
    end;
  with r_pnl_arr[9] do
    begin
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtCapArc);
      Geom2DAdd(g2DtVertLine);
    end;
  with r_pnl_arr[10] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtVertLine);
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtFilledCircle);
      Geom2DAdd(g2DtImage);
      Geom2DAdd(g2DtImage);
    end;
  r_pnl_arr[11].Geom2DAdd(g2DtFilledRectangle);
  with r_pnl_arr[12] do
    begin
      Geom2DAdd(g2DtCircle);
      Geom2DAdd(g2DtArrowLeftRight);
      Geom2DAdd(g2DtFilledCircle);
    end;
  with r_pnl_arr[13] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
      Geom2DAdd(g2DtImage);
    end;
  for I:=14 to 20 do
    with r_pnl_arr[I] do
      begin
        Geom2DAdd(g2DtFilledRectangle);
        Geom2DAdd(g2DtRectangle);
        Geom2DAdd(g2DtImage);
        Geom2DAdd(g2DtCircle);
        Geom2DAdd(g2DtImage);
        Geom2DAdd(g2DtStar);
      end;
  r_pnl_arr[21].Geom2DAdd(g2DtFilledRectangle);
  with r_pnl_arr[22] do
    begin
      Geom2DAdd(g2DtFilledRectangle);
      Geom2DAdd(g2DtRectangle);
    end;
  {$endregion}

  {Set static params.-} {$region -fold}
  SetParamsStatic0;
  SetParamsStatic1;
  {$endregion}

  {Set dynamic params.} {$region -fold}
  SetParamsDynamic0;
  SetParamsDynamic1;
  {$endregion}

  {Procs init.--------} {$region -fold}
  r_pnl_arr[1]       .OnMouseEnter:=@HighLightBounds;
  r_pnl_arr[2]       .OnMouseEnter:=@HighLightBounds;
  r_pnl_arr[3]       .OnMouseEnter:=@HighLightBounds;
  r_pnl_arr[4]       .OnMouseEnter:=@HighLightBounds;
  r_pnl_arr[13]      .OnMouseEnter:=@HighLightBounds;
  for I:=14 to 20 do
    r_pnl_arr[I]     .OnMouseEnter:=@HighLightBounds2;
  for I:=0 to Length(p_lbl_arr)-1 do
    p_lbl_arr[I]     .OnMouseEnter:=@HighLightBounds2;
  r_pnl_arr[22]      .OnMouseEnter:=@HighLightBounds3;
  L_Error_Ok         .OnMouseEnter:=@HighLightBounds3;

  E_Username         .OnMouseEnter:=@HighLightBounds;
  E_Password         .OnMouseEnter:=@HighLightBounds;
  E_Search_Locations .OnMouseEnter:=@HighLightBounds;
  L_Login2           .OnMouseEnter:=@HighLightBounds;

  r_pnl_arr[1]       .OnMouseLeave:=@DarkenBounds;
  r_pnl_arr[2]       .OnMouseLeave:=@DarkenBounds;
  r_pnl_arr[3]       .OnMouseLeave:=@DarkenBounds;
  r_pnl_arr[4]       .OnMouseLeave:=@DarkenBounds;
  r_pnl_arr[13]      .OnMouseLeave:=@DarkenBounds;
  for I:=14 to 20 do
    r_pnl_arr[I]     .OnMouseLeave:=@DarkenBounds2;
  for I:=0 to Length(p_lbl_arr)-1 do
    p_lbl_arr[I]     .OnMouseLeave:=@DarkenBounds2;
  r_pnl_arr[22]      .OnMouseLeave:=@DarkenBounds3;
  L_Error_Ok         .OnMouseLeave:=@DarkenBounds3;

  E_Username         .OnMouseLeave:=@DarkenBounds;
  E_Password         .OnMouseLeave:=@DarkenBounds;
  E_Search_Locations .OnMouseLeave:=@DarkenBounds;
  L_Login2           .OnMouseLeave:=@DarkenBounds;

  r_pnl_arr[6]       .OnMouseEnter:=@RoundedPanelMouseEnter;
  r_pnl_arr[7]       .OnMouseEnter:=@RoundedPanelMouseEnter;
  r_pnl_arr[8]       .OnMouseEnter:=@RoundedPanelMouseEnter;
  r_pnl_arr[12]      .OnMouseEnter:=@RoundedPanelMouseEnter;
  L_Register         .OnMouseEnter:=@RoundedPanelMouseEnter;
  L_Forgot_Password  .OnMouseEnter:=@RoundedPanelMouseEnter;
  L_Remember_Password.OnMouseEnter:=@RoundedPanelMouseEnter;
  L_United_States    .OnMouseEnter:=@RoundedPanelMouseEnter;
  L_IP               .OnMouseEnter:=@RoundedPanelMouseEnter;
  L_Invite_Friends   .OnMouseEnter:=@RoundedPanelMouseEnter;

  r_pnl_arr[6]       .OnMouseLeave:=@RoundedPanelMouseLeave;
  r_pnl_arr[7]       .OnMouseLeave:=@RoundedPanelMouseLeave;
  r_pnl_arr[8]       .OnMouseLeave:=@RoundedPanelMouseLeave;
  r_pnl_arr[9]       .OnMouseLeave:=@RoundedPanelMouseLeave;
  r_pnl_arr[12]      .OnMouseLeave:=@RoundedPanelMouseLeave;
  L_Register         .OnMouseLeave:=@RoundedPanelMouseLeave;
  L_Forgot_Password  .OnMouseLeave:=@RoundedPanelMouseLeave;
  L_Remember_Password.OnMouseLeave:=@RoundedPanelMouseLeave;
  L_United_States    .OnMouseLeave:=@RoundedPanelMouseLeave;
  L_IP               .OnMouseLeave:=@RoundedPanelMouseLeave;
  L_Invite_Friends   .OnMouseLeave:=@RoundedPanelMouseLeave;

  r_pnl_arr[9]       .OnMouseMove :=@RoundedPanelMouseMove;

  r_pnl_arr[1]       .OnMouseDown :=@E_UsernameMouseDown;
  r_pnl_arr[2]       .OnMouseDown :=@E_PasswordMouseDown;
  r_pnl_arr[3]       .OnMouseDown :=@RoundedPanelMouseDown;
  r_pnl_arr[6]       .OnMouseDown :=@ArrowBackMouseDown;
  r_pnl_arr[7]       .OnMouseDown :=@SettingsMouseDown;
  r_pnl_arr[8]       .OnMouseDown :=@UnitedStatesMouseDown;
  r_pnl_arr[9]       .OnMouseDown :=@ConnectMouseDown;
  r_pnl_arr[12]      .OnMouseDown :=@ArrowBackMouseDown;
  for I:=14 to 20 do
    r_pnl_arr[I]     .OnMouseDown :=@UnitedStatesMouseDown2;

  L_Register         .OnMouseDown :=@LabelsMouseDown;
  L_Forgot_Password  .OnMouseDown :=@LabelsMouseDown;
  L_Invite_Friends   .OnMouseDown :=@LabelsMouseDown;

  r_pnl_arr[6]       .OnMouseUp   :=@ArrowBackMouseUp;
  r_pnl_arr[7]       .OnMouseUp   :=@SettingsMouseUp;
  r_pnl_arr[8]       .OnMouseUp   :=@UnitedStatesMouseUp;
  r_pnl_arr[9]       .OnMouseUp   :=@ConnectMouseUp;
  r_pnl_arr[12]      .OnMouseUp   :=@ArrowBack2MouseUp;
  for I:=14 to 20 do
    r_pnl_arr[I]     .OnMouseUp   :=@UnitedStatesMouseUp2;

  L_Register         .OnMouseUp   :=@LabelsMouseUp;
  L_Forgot_Password  .OnMouseUp   :=@LabelsMouseUp;
  L_Invite_Friends   .OnMouseUp   :=@LabelsMouseUp;

  r_pnl_arr[4]       .OnClick     :=@LoginClick;
  L_Login2           .OnClick     :=@LoginClick;
  r_pnl_arr[22]      .OnClick     :=@ErrorOkClick;
  L_Error_Ok         .OnClick     :=@ErrorOkClick;
  {$endregion}

  {Pictures-----------} {$region -fold}
  IL_0.GetBitmap(0,I_Star.Picture.Bitmap);
  I_Star             .Parent:=r_pnl_arr[00];
  {$endregion}

  {Labels-------------} {$region -fold}
  L_Astrill          .Parent:=r_pnl_arr[00];
  L_VPN              .Parent:=r_pnl_arr[00];
  L_Login            .Parent:=r_pnl_arr[00];
  L_Register         .Parent:=r_pnl_arr[00];
  L_Forgot_Password  .Parent:=r_pnl_arr[00];
  L_Remember_Password.Parent:=r_pnl_arr[00];
  L_Login2           .Parent:=r_pnl_arr[04];
  L_AstrillVPN       .Parent:=r_pnl_arr[05];
  L_United_States    .Parent:=r_pnl_arr[08];
  L_IP               .Parent:=r_pnl_arr[08];
  L_Connect_Status   .Parent:=r_pnl_arr[05];
  L_Session_Time     .Parent:=r_pnl_arr[05];
  L_VPN_Protocol     .Parent:=r_pnl_arr[05];
  L_Expires          .Parent:=r_pnl_arr[05];
  L_Upload           .Parent:=r_pnl_arr[10];
  L_Download         .Parent:=r_pnl_arr[10];
  L_Upload_Speed     .Parent:=r_pnl_arr[10];
  L_Download_Speed   .Parent:=r_pnl_arr[10];
  L_Invite_Friends   .Parent:=r_pnl_arr[05];
  L_Select_Server    .Parent:=r_pnl_arr[11];
  L_Optimal_Locations.Parent:=r_pnl_arr[11];
  L_Other_Locations  .Parent:=r_pnl_arr[11];
  for I:=0 to Length(p_lbl_arr)-1 do
    with p_lbl_arr[I] do
      Caption:=server_obj_arr[I].Name;
  L_Error_Ok         .Parent:=r_pnl_arr[22];
  L_Error_Header     .Parent:=r_pnl_arr[21];
  L_Error_Content    .Parent:=r_pnl_arr[21];
  {$endregion}

  {Text fields--------} {$region -fold}
  E_Username         .Parent:=r_pnl_arr[01];
  E_Password         .Parent:=r_pnl_arr[02];
  E_Search_Locations .Parent:=r_pnl_arr[13];

  E_Username         .Left  :=45;
  E_Password         .Left  :=45;
  E_Search_Locations .Left  :=45;

  E_Username         .Top   :=(E_Username        .Parent.Height-E_Username        .Height)>>1-1;
  E_Password         .Top   :=(E_Password        .Parent.Height-E_Password        .Height)>>1-1;
  E_Search_Locations .Top   :=(E_Search_Locations.Parent.Height-E_Search_Locations.Height)>>1-1;
  {$endregion}

end;
procedure TF_AstrillVPN.FormActivate(Sender :TObject);
begin
  F_AstrillVPN.FormResize(Self);
  F_Switch_Pages.Visible:=True;
  F_Switch_Pages.Left   :=F_AstrillVPN.Left-8*Byte(BorderStyle=bsNone);
  F_Switch_Pages.Top    :=F_AstrillVPN.Top-2*F_Switch_Pages.Height+20;
end;
procedure TF_AstrillVPN.FormResize  (Sender :TObject);
var
  I: Integer;
begin
  FScale:=Screen.PixelsPerInch/DPI; //ClientWidth/D_W;
  Width :=Round(D_W*FScale);
  Height:=Round(D_H*FScale);

  with r_pnl_arr[0] do
    SetBounds(MRG00,MRG00,F_AstrillVPN.Width-2*MRG00,F_AstrillVPN.Height-2*MRG00);
  with r_pnl_arr[1] do
    SetBounds(MRG01,L_Login.Top+60{MRG02},r_pnl_arr[0].Width-2*MRG01,MRG03);
  with r_pnl_arr[2] do
    SetBounds(r_pnl_arr[1].Left,r_pnl_arr[1].Top+r_pnl_arr[1].Height+MRG01{MRG04},r_pnl_arr[1].Width,r_pnl_arr[1].Height);
  with r_pnl_arr[3] do
    SetBounds(r_pnl_arr[1].Left,r_pnl_arr[2].Top+Round(2.5*r_pnl_arr[2].Height){MRG05},MRG06,MRG06);
  with r_pnl_arr[4] do
    SetBounds(r_pnl_arr[1].Left,r_pnl_arr[0].Height-2*r_pnl_arr[1].Height-MRG07,r_pnl_arr[1].Width,r_pnl_arr[1].Height);
  with r_pnl_arr[5] do
    SetBounds(r_pnl_arr[0].Left,r_pnl_arr[0].Left,F_AstrillVPN.Width-2*r_pnl_arr[0].Left,F_AstrillVPN.Height-2*r_pnl_arr[0].Left);
  with r_pnl_arr[6] do
    SetBounds(MRG13,MRG14,MRG09,MRG09);
  with r_pnl_arr[7] do
    SetBounds(r_pnl_arr[5].Width-r_pnl_arr[6].Left-r_pnl_arr[7].Width,MRG14,r_pnl_arr[6].Height,r_pnl_arr[6].Height);
  with r_pnl_arr[8] do
    SetBounds((r_pnl_arr[5].Width-r_pnl_arr[8].Width)>>1,MRG15,MRG10,MRG11);
  with r_pnl_arr[9] do
    SetBounds((r_pnl_arr[5].Width-r_pnl_arr[9].Width)>>1,MRG16,MRG12,MRG12);
  with r_pnl_arr[10] do
    SetBounds(r_pnl_arr[1].Left,r_pnl_arr[4].Top+r_pnl_arr[4].Height-r_pnl_arr[10].Height,r_pnl_arr[5].Width-2*MRG01,MRG17);
  with r_pnl_arr[11] do
    SetBounds(r_pnl_arr[0].Left,r_pnl_arr[0].Left,F_AstrillVPN.Width-2*r_pnl_arr[0].Left,F_AstrillVPN.Height-2*r_pnl_arr[0].Left);
  with r_pnl_arr[12] do
    SetBounds(r_pnl_arr[6].Left,MRG14,r_pnl_arr[6].Height,r_pnl_arr[6].Height);
  with r_pnl_arr[13] do
    SetBounds(r_pnl_arr[1].Left,MRG21,r_pnl_arr[11].Width-2*MRG01,r_pnl_arr[1].Height);
  with r_pnl_arr[14] do
    SetBounds(r_pnl_arr[1].Left,L_Optimal_Locations.Top+L_Optimal_Locations.Height+18{MRG22},r_pnl_arr[11].Width-2*MRG01,r_pnl_arr[1].Height-4);
  with r_pnl_arr[15] do
    SetBounds(r_pnl_arr[1].Left,L_Optimal_Locations.Top+L_Optimal_Locations.Height+18+(r_pnl_arr[1].Height-4)+16{MRG22+(r_pnl_arr[1].Height-4)+16},r_pnl_arr[11].Width-2*MRG01,r_pnl_arr[1].Height-4);
  for I:=16 to 20 do
    with r_pnl_arr[I] do
      SetBounds(r_pnl_arr[1].Left,L_Other_Locations.Top+L_Other_Locations.Height+18+(I-16)*((r_pnl_arr[1].Height-4)+16){MRG23+(I-16)*((r_pnl_arr[1].Height-4)+16)},r_pnl_arr[11].Width-2*MRG01,r_pnl_arr[1].Height-4);
  with r_pnl_arr[21] do
    SetBounds((r_pnl_arr[0].Width-MRG24)>>1,(r_pnl_arr[02].Top+r_pnl_arr[02].Height+r_pnl_arr[01].Top-MRG25)>>1,MRG24,MRG25);
  with r_pnl_arr[22] do
    SetBounds((r_pnl_arr[21].Width-(r_pnl_arr[21].Width-40))>>1,r_pnl_arr[21].Height-((r_pnl_arr[21].Width-(r_pnl_arr[21].Width-40))>>1)-r_pnl_arr[4].Height,r_pnl_arr[21].Width-40,r_pnl_arr[4].Height);
  for I:=0 to Length(r_pnl_arr)-1 do
    if (not (I in [6,7,9,12])) then
      with r_pnl_arr[I] do
        begin
          geom_2D_arr[0].RctDst:=Bounds(0,0,Width,Height);
          if (I in [1,2,3,4,13]) or ((I>=14) and (I<=20)) then
            if (Length(geom_2D_arr)>=1) then
              geom_2D_arr[1].RctDst:=Bounds(0,0,Width-1,Height-1);
        end;

  SetParamsDynamic0;
  SetParamsDynamic1;

  for I:=0 to Length(p_lbl_arr)-1 do
    with p_lbl_arr[I] do
      begin
        Left:=51;
        Top :=(Parent.Height-Height)>>1;
      end;

  L_Astrill          .Left :=(F_AstrillVPN.Width-(L_Astrill.Width+L_VPN.Width+I_Star.Width))>>1;
  L_Login            .Left :=(L_Login.Parent.Width-L_Login.Width)>>1;
  L_Remember_Password.Left := r_pnl_arr[3].Left+r_pnl_arr[3].Width+5;
  L_Login2           .Left :=(L_Login2.Parent.Width-L_Login2.Width)>>1;
  I_Star             .Left := L_Astrill.Left+L_Astrill.Width+L_VPN.Width;
  L_Forgot_Password  .Left := L_Forgot_Password.Parent.Width-L_Register.Left-L_Forgot_Password.Width;
  L_AstrillVPN       .Left :=(L_AstrillVPN.Parent.Width-L_AstrillVPN.Width)>>1;
  L_United_States    .Left :=60;
  L_IP               .Left :=60;
  L_Connect_Status   .Left :=(L_Connect_Status.Parent.Width-L_Connect_Status.Width)>>1;
  L_Session_Time     .Left :=(L_Session_Time.Parent.Width-L_Session_Time.Width)>>1;
  L_VPN_Protocol     .Left :=(L_VPN_Protocol.Parent.Width-L_VPN_Protocol.Width)>>1;
  L_Expires          .Left :=(L_Expires.Parent.Width-L_Expires.Width)>>1;
  L_Upload           .Left :=r_pnl_arr[10].geom_2D_arr[2].RctDst.Left+r_pnl_arr[10].geom_2D_arr[2].Radius1+16;
  L_Download         .Left :=r_pnl_arr[10].geom_2D_arr[3].RctDst.Left+r_pnl_arr[10].geom_2D_arr[3].Radius1+16;;
  L_Upload_Speed     .Left :=L_Upload.Left;
  L_Download_Speed   .Left :=L_Download.Left;
  L_Invite_Friends   .Left :=(L_Invite_Friends.Parent.Width-L_Invite_Friends.Width)>>1;
  L_Select_Server    .Left :=(L_Select_Server.Parent.Width-L_Select_Server.Width)>>1;
  L_Optimal_Locations.Left :=25;
  L_Other_Locations  .Left :=25;
  L_Error_Ok         .Left :=(L_Error_Ok.Parent.Width-L_Error_Ok.Width)>>1;
  L_Error_Header     .Left :=(L_Error_Header .Parent.Width-L_Error_Header .Width)>>1;
  L_Error_Content    .Left :=(L_Error_Content.Parent.Width-L_Error_Content.Width)>>1;

  E_Username         .Top  :=(E_Username        .Parent.Height-E_Username        .Height)>>1-1;
  E_Password         .Top  :=(E_Password        .Parent.Height-E_Password        .Height)>>1-1;
  E_Search_Locations .Top  :=(E_Search_Locations.Parent.Height-E_Search_Locations.Height)>>1-1;
  L_Register         .Top  := r_pnl_arr[2].Top+r_pnl_arr[2].Height+13;
  L_Remember_Password.Top  := r_pnl_arr[3].Top+r_pnl_arr[3].Height>>1-L_Remember_Password.Height>>1;
  L_Login2           .Top  :=(r_pnl_arr[4].Height-L_Login2.Height)>>1-1;
  L_Forgot_Password  .Top  :=L_Register.Top;
  L_AstrillVPN       .Top  :=r_pnl_arr[6].Top+r_pnl_arr[6].Top>>1-L_AstrillVPN.Height>>1;
  L_Select_Server    .Top  :=L_AstrillVPN.Top;
  L_United_States    .Top  :=14;
  L_IP               .Top  :=34;
  L_Connect_Status   .Top  := r_pnl_arr[9].Top+r_pnl_arr[9].Height+16;
  L_Session_Time     .Top  :=(r_pnl_arr[10].Top+r_pnl_arr[9].Top+r_pnl_arr[9].Height)>>1-20;
  L_VPN_Protocol     .Top  := r_pnl_arr[10].Top-52;
  L_Expires          .Top  := r_pnl_arr[10].Top-32;
  L_Upload           .Top  :=54;
  L_Download         .Top  :=L_Upload.Top;
  L_Upload_Speed     .Top  :=26;
  L_Download_Speed   .Top  :=L_Upload_Speed.Top;
  L_Invite_Friends   .Top  :=(r_pnl_arr[5].Height+r_pnl_arr[10].Top+r_pnl_arr[10].Height)>>1-10;
  L_Error_Ok         .Top  :=(L_Error_Ok.Parent.Height-L_Error_Ok.Height)>>1;
  L_Error_Header     .Top  :=50;
  L_Error_Content    .Top  :=L_Error_Header.Top+L_Error_Content.Height+25;

  E_Username         .Width :=E_Username        .Parent.Width-2*E_Username        .Left+10;
  E_Password         .Width :=E_Password        .Parent.Width-2*E_Password        .Left+10;
  E_Search_Locations .Width :=E_Search_Locations.Parent.Width-2*E_Search_Locations.Left+10;

  I:=0;
  if (L_United_States.Width<=r_pnl_arr[8].geom_2D_arr[4].Pt3[0].X-L_United_States.Left) then
    Exit
  else
    while (L_United_States.Width>=r_pnl_arr[8].geom_2D_arr[4].Pt3[0].X-L_United_States.Left) do
           L_United_States.Font.Height:=19-I;
end;
procedure TF_AstrillVPN.AddPanel    (Parent_:TWinControl; W,H:Integer; AddLabel_:Boolean=False; Visible_:Boolean=True);

  procedure AddLabel(r_pnl_arr_ind:Integer);
  begin
    p_lbl_arr[Length(p_lbl_arr)-1]:=TLabel.Create(r_pnl_arr[r_pnl_arr_ind]);
    r_pnl_arr[Length(r_pnl_arr)-1].label_ind:=Length(p_lbl_arr)-1;
    with p_lbl_arr[Length(p_lbl_arr)-1] do
      begin
        AutoSize   :=True;
        Caption    :='';
        Enabled    :=True;
        Transparent:=True;
        Visible    :=True;
        Parent     :=r_pnl_arr[r_pnl_arr_ind];
        Left       :=51;
        Top        :=(r_pnl_arr[r_pnl_arr_ind].Top+Height)>>1;
        Font       :=L_United_States.Font;
        Font.Color :=COL15;
      end;
  end;

begin
  SetLength(r_pnl_arr,Length(r_pnl_arr)+1);
       r_pnl_arr[Length(r_pnl_arr)-1]:=TBGRARoundedPanel.Create(Parent_);
  with r_pnl_arr[Length(r_pnl_arr)-1] do
    begin
      FBmp.SetSize(W,H);
      Parent :=Parent_;
      Visible:=Visible_;
      if AddLabel_ then
        begin
          SetLength(p_lbl_arr,Length(p_lbl_arr)+1);
          AddLabel(Length(r_pnl_arr)-1);
        end;
    end;
end;

{UI logic}
procedure TF_AstrillVPN.ArrowBackMouseDown          (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[2].Alpha:=155;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.ArrowBackMouseUp            (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[2].Alpha:=0;
      Repaint;
    end;
  ShowPage(1);
  if (not r_pnl_arr[3].geom_2D_arr[2].IsChecked) then
    begin
      L_Login2  .Caption:='Login';
      E_Username.Enabled:=True;
      E_Password.Enabled:=True;
    end;
end;
procedure TF_AstrillVPN.ArrowBack2MouseUp           (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[2].Alpha:=0;
      Repaint;
    end;
  ShowPage(2);
  if (not r_pnl_arr[3].geom_2D_arr[2].IsChecked) then
    begin
      L_Login2  .Caption:='Login';
      E_Username.Enabled:=True;
      E_Password.Enabled:=True;
    end;
end;
procedure TF_AstrillVPN.SettingsMouseDown           (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[2].Alpha:=155;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.SettingsMouseUp             (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[2].Alpha:=0;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.UnitedStatesMouseDown       (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[0].Color:=COL4__;
      geom_2D_arr[3].Color:=geom_2D_arr[0].Color;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.UnitedStatesMouseDown2      (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[0].Color:=COL4__;
      geom_2D_arr[3].Color:=geom_2D_arr[0].Color;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.UnitedStatesMouseUp         (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[0].Color:=COL4;
      geom_2D_arr[3].Color:=geom_2D_arr[0].Color;
      ShowPage(1);
    end;
end;
procedure TF_AstrillVPN.UnitedStatesMouseUp2        (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[0].Color:=COL4;
      geom_2D_arr[3].Color:=geom_2D_arr[0].Color;
      with r_pnl_arr[8].geom_2D_arr[2] do
        case (Sender as TBGRARoundedPanel).label_ind of
          0,1,2:
            begin
              BGRABmpPtr             :=@ImgListBmpArr[07];
              L_United_States.Caption:='United States';
            end;
          3:
            begin
              BGRABmpPtr             :=@ImgListBmpArr[08];
              L_United_States.Caption:='Netherlands';
            end;
          4:
            begin
              BGRABmpPtr             :=@ImgListBmpArr[09];
              L_United_States.Caption:='United Kingdom';
            end;
          5:
            begin
              BGRABmpPtr             :=@ImgListBmpArr[10];
              L_United_States.Caption:='France';
            end;
          6:
            begin
              BGRABmpPtr             :=@ImgListBmpArr[11];
              L_United_States.Caption:='Switzerland';
            end;
        end;
      with r_pnl_arr[9] do
        begin
          geom_2D_arr[2].Color:=COL0;
          geom_2D_arr[3].Color:=clWhite;
          geom_2D_arr[4].Color:=COL0;
          geom_2D_arr[5].Color:=COL0;
        end;
      L_Connect_Status.Font.Color:=COL10;
      L_Connect_Status.Caption   :='Disconnected';
      L_Session_Time.Caption     :='00 : 00 : 00';
      L_Upload_Speed.Caption     :='0 mbps';
      L_Download_Speed.Caption   :='0 mbps';
      TimeBeforeConnect          :=0;
      IsConnected                :=False;
      T_Session_Time.Enabled     :=False;
      ShowPage(2);
    end;
end;
procedure TF_AstrillVPN.ConnectMouseDown            (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if (not IsConnected) then
    with (Sender as TBGRARoundedPanel) do
      begin
        geom_2D_arr[3].Color:=COL12;
        Repaint;
      end;
end;
procedure TF_AstrillVPN.ConnectMouseUp              (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if (not IsConnected) then
    with (Sender as TBGRARoundedPanel) do
      begin
        L_Connect_Status.Caption:='';
        T_Session_Time  .Enabled:=True;
        geom_2D_arr[3]  .Color  :=clWhite;
        Repaint;
      end;
end;
procedure TF_AstrillVPN.T_Session_TimeTimer         (Sender:TObject);
type
  TSessionTime=record
    Seconds: Integer;
    Minutes: Integer;
    Hours  : Integer;
  end;
  TSSessionTime=record
    SSeconds: string;
    SMinutes: string;
    SHours  : string;
  end;
var
  SessionTime : TSessionTime;
  SSessionTime: TSSessionTime;
  PureTime    : Integer=0;

  procedure GetSessionTime(Time_:Integer);

     procedure GetTimeField(TimeField:Integer; var STimeField:string);
     begin
       STimeField:=IntToStr(TimeField);
       if (TimeField<10) then
         STimeField:='0'+STimeField;
     end;

  begin
    with SessionTime,SSessionTime do
      begin
        Seconds:= Time_ mod 60;
        Minutes:= Time_ div 60;
        Hours  :=(Time_ div 60) div 60;
        if (Time_>=60*60*60) then
          begin
            Seconds:=0;
            Minutes:=0;
            Hours  :=0;
          end;
        GetTimeField(Seconds,SSeconds);
        GetTimeField(Minutes,SMinutes);
        GetTimeField(Hours  ,SHours  );
        L_Session_Time.Caption:=SHours+' : '+SMinutes+' : '+SSeconds;
      end;
  end;

begin
  PureTime:=TimeBeforeConnect-3;
  if (TimeBeforeConnect=3) then
    with r_pnl_arr[9] do
      begin
        geom_2D_arr[2].Color:=COL8;
        geom_2D_arr[3].Color:=COL8;
        geom_2D_arr[4].Color:=clWhite;
        geom_2D_arr[5].Color:=clWhite;
        Repaint;
        L_Connect_Status.Caption   :='Connected';
        L_Connect_Status.Font.Color:=COL8;
        IsConnected                :=True;
      end
  else
  if (TimeBeforeConnect>3) then
    with r_pnl_arr[9] do
      begin
        GetSessionTime(PureTime);
        L_Upload_Speed  .Caption:=IntToStr(30+Random(10))+'.'+IntToStr(Random(10))+'mbps';
        L_Download_Speed.Caption:=IntToStr(40+Random(10))+'.'+IntToStr(Random(10))+'mbps';
      end
  else
    begin
          L_Connect_Status.Caption:=
          L_Connect_Status.Caption +' .';
      if (L_Connect_Status.Caption =' . . . . . .') then
          L_Connect_Status.Caption:=' .';
    end;
          L_Connect_Status.Left   :=
         (L_Connect_Status.Parent.Width-
          L_Connect_Status.Width)>>1;
  {L_Session_Time.Caption:=IntToStr(Random(100));}
  Inc(TimeBeforeConnect);
end;
procedure TF_AstrillVPN.HighLightBounds             (Sender:TObject);
begin
  if (Sender is TEdit) then
    begin
      with (TEdit(Sender).Parent as TBGRARoundedPanel) do
        begin
          geom_2D_arr[1].Color:=COL4_;
          Repaint;
        end;
      Exit;
    end;
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          geom_2D_arr[1].Color:=COL4_;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[1].Color:=COL4_;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.HighLightBounds2            (Sender:TObject);
begin
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          TLabel(Sender).Font.Color:=clWhite;
          geom_2D_arr[0]     .Color:=COL4;
          geom_2D_arr[1]     .Color:=COL2;
          geom_2D_arr[3]     .Color:=COL4;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      p_lbl_arr[label_ind].Font.Color:=clWhite;
      geom_2D_arr[0]           .Color:=COL4;
      geom_2D_arr[1]           .Color:=COL2;
      geom_2D_arr[3]           .Color:=COL4;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.HighLightBounds3            (Sender:TObject);
begin
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          geom_2D_arr[1].Color:=COL8_;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[1].Color:=COL8_;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.DarkenBounds                (Sender:TObject);
begin
  if (Sender is TEdit) then
    begin
      with (TEdit(Sender).Parent as TBGRARoundedPanel) do
        begin
          if (TEdit(Sender).Parent=r_pnl_arr[4]) then
            geom_2D_arr[1].Color:=COL2
          else
            geom_2D_arr[1].Color:=COL0;
          Repaint;
        end;
      Exit;
    end;
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          if (TLabel(Sender).Parent=r_pnl_arr[4]) then
            geom_2D_arr[1].Color:=COL2
          else
            geom_2D_arr[1].Color:=COL0;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[1].Color:=COL0;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.DarkenBounds2               (Sender:TObject);
begin
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          TLabel(Sender).Font.Color:=COL15;
          geom_2D_arr[0]     .Color:=COL0;
          geom_2D_arr[1]     .Color:=COL4__;
          geom_2D_arr[3]     .Color:=COL0;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      p_lbl_arr[label_ind].Font.Color:=COL15;
      geom_2D_arr[0]           .Color:=COL0;
      geom_2D_arr[1]           .Color:=COL4__;
      geom_2D_arr[3]           .Color:=COL0;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.DarkenBounds3               (Sender:TObject);
begin
  if (Sender is TLabel) then
    begin
      with (TLabel(Sender).Parent as TBGRARoundedPanel) do
        begin
          geom_2D_arr[1].Color:=COL8;
          Repaint;
        end;
      Exit;
    end;
  with (Sender as TBGRARoundedPanel) do
    begin
      geom_2D_arr[1].Color:=COL8;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.RoundedPanelMouseEnter      (Sender:TObject);
var
  Pnl: TBGRARoundedPanel;
begin
  if (Sender is TLabel) then
    begin
      if (TControl(Sender).Parent=r_pnl_arr[8]) then
        with (TLabel(Sender).Parent as TBGRARoundedPanel) do
          begin
            geom_2D_arr[1].Color:=COL4_;
            Repaint;
            Exit;
          end;
      if (TControl(Sender).Parent is TBGRARoundedPanel) then
        begin
          if (TLabel(Sender).Parent.Parent=F_AstrillVPN) then
              TLabel(Sender).Font.Style:=[fsUnderline]
          else
            with (TLabel(Sender).Parent as TBGRARoundedPanel) do
              begin
                geom_2D_arr[0].Color:=COL4_;
                if (Length(geom_2D_arr)>=3) then
                  geom_2D_arr[2].Color:=COL4_;
                Repaint;
              end
        end;
      Exit;
    end;
  Pnl:=Sender as TBGRARoundedPanel;
  with Pnl do
    begin
      if (Pnl=r_pnl_arr[8]) then
        with Pnl do
          begin
            geom_2D_arr[1].Color:=COL4_;
            Repaint;
            Exit;
          end;
      geom_2D_arr[0].Color:=COL4_;
      if (Length(geom_2D_arr)>=3) then
        geom_2D_arr[2].Color:=COL4_;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.RoundedPanelMouseLeave      (Sender:TObject);
var
  Pnl: TBGRARoundedPanel;
begin
  if (Sender is TLabel) then
    begin
      if (TControl(Sender).Parent=r_pnl_arr[8]) then
        with (TLabel(Sender).Parent as TBGRARoundedPanel) do
          begin
            geom_2D_arr[1].Color:=COL4;
            Repaint;
            Exit;
          end;
      if (TControl(Sender).Parent is TBGRARoundedPanel) then
        begin
          if (TLabel(Sender).Parent.Parent=F_AstrillVPN) then
              TLabel(Sender).Font.Style:=[]
          else
            with (TLabel(Sender).Parent as TBGRARoundedPanel) do
              begin
                geom_2D_arr[0].Color:=COL4;
                if (Length(geom_2D_arr)>=3) then
                  geom_2D_arr[2].Color:=COL4;
                Repaint;
              end
        end;
      Exit;
    end;
  Pnl:=Sender as TBGRARoundedPanel;
  with Pnl do
    begin
      if (Pnl=r_pnl_arr[8]) then
        with Pnl do
          begin
            geom_2D_arr[1].Color:=COL4;
            Repaint;
            Exit;
          end;
      if (Pnl<>r_pnl_arr[9]) then
        geom_2D_arr[0].Color:=COL4
      else
      if IsConnected then
        Exit;
      if (Length(geom_2D_arr)>=3) then
        with geom_2D_arr[2] do
          begin
            if (Pnl=r_pnl_arr[9]) then
              Color:=COL0
            else
              Color:=COL4;
          end;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.RoundedPanelMouseMove       (Sender:TObject; Shift:TShiftState; X,Y:Integer);
var
  Pnl: TBGRARoundedPanel;
begin
  Pnl:=Sender as TBGRARoundedPanel;
  with Pnl do
    if (Pnl=r_pnl_arr[9]) then
      if (Length(geom_2D_arr)>=3) then
        if (not IsConnected) then
          with geom_2D_arr[2] do
            begin
              if (Sqr(X-r_pnl_arr[9].Width>>1)+Sqr(Y-r_pnl_arr[9].Height>>1)<=Sqr(Radius1)) then
                Color:=COL4_
              else
                Color:=COL0;
              Repaint;
            end;
end;
procedure TF_AstrillVPN.RoundedPanelMouseDown       (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
var
  Pnl: TBGRARoundedPanel;
begin
  Pnl:=Sender as TBGRARoundedPanel;
  with Pnl do
    begin
      if (Pnl=r_pnl_arr[3]) then
        with geom_2D_arr[2] do
          begin
            IsChecked:=not IsChecked;
            if IsChecked then
              Color:=COL11{COL0}
            else
              Color:=COL1;
          end;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.L_Remember_PasswordMouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  with r_pnl_arr[3].geom_2D_arr[2] do
    begin
      IsChecked:=not IsChecked;
      if IsChecked then
        Color:=COL11{COL0}
      else
        Color:=COL1;
      Repaint;
    end;
end;
procedure TF_AstrillVPN.E_UsernameMouseDown         (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if (E_Username.Text='Username') then
      E_Username.Text:='';
end;
procedure TF_AstrillVPN.E_PasswordMouseDown         (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if (E_Password.Text='Password') then
      E_Password.Text:='';
end;
procedure TF_AstrillVPN.E_Search_LocationsMouseDown (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin

end;
procedure TF_AstrillVPN.LabelsMouseDown             (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
      TLabel(Sender).Top:=TLabel(Sender).Top+1;//TLabel(Sender).Font.Size:=TLabel(Sender).Font.Size+1;//TLabel(Sender).Font.Style:=[fsBold];//TLabel(Sender).Font.Height:=TLabel(Sender).Font.Height+1;
  if (TLabel(Sender)<>L_Invite_Friends) then
      TLabel(Sender).Font.Color:=COL9
end;
procedure TF_AstrillVPN.LabelsMouseUp               (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
      TLabel(Sender).Top:=TLabel(Sender).Top-1;//TLabel(Sender).Font.Size:=TLabel(Sender).Font.Size-1;//TLabel(Sender).Font.Style:=[];//TLabel(Sender).Font.Height:=TLabel(Sender).Font.Height-1;
  if (TLabel(Sender)<>L_Invite_Friends) then
      TLabel(Sender).Font.Color:=COL10;
end;

{Client-server interactions}
procedure TF_AstrillVPN.ShowPage          (PageInd_:Integer);
begin
  PageInd              :=PageInd_;
  r_pnl_arr[00].Visible:=False;
  r_pnl_arr[11].Visible:=False;
  r_pnl_arr[05].Visible:=False;
  case PageInd_ of
    0: r_pnl_arr[00].Visible:=True;
    1: r_pnl_arr[11].Visible:=True;
    2: r_pnl_arr[05].Visible:=True;
  end;
  FormResize(Self);
  Repaint;
end;
procedure TF_AstrillVPN.HandleLoginSuccess(RespJSON:TJSONObject);
begin
  LoginSuccess    :=True;
  L_Login2.Caption:='Next'; // test@test.com   testpass
  //ShowMessage('Login success!'+LineEnding+'Expiry: '+RespJSON.Get('expiry','0'));
  // TODO: show server list
end;
procedure TF_AstrillVPN.HandleLoginError  (RespJSON:TJSONObject);
begin
  LoginSuccess:=False;
  r_pnl_arr[21].Visible:=True; // ShowMessage(RespJSON.Get('error_message','Unknown error'));
end;
procedure TF_AstrillVPN.LoginClick        (Sender  :TObject);
var
  Client    : TFPHTTPClient;
  ReqJSON   : TJSONObject;
  RespJSON  : TJSONObject;
  ReqStream : TStringStream;
  RespStream: TStringStream;
begin
  if (L_Login2.Caption='Next') then
    begin
      ShowPage(2);
      E_Username.Enabled:=False;
      E_Password.Enabled:=False;
      Exit;
    end
  else
    begin
      TimeBeforeConnect     :=0;
      IsConnected           :=False;
      T_Session_Time.Enabled:=False;
    end;
  if (Trim(E_Username.Text)='') or
     (Trim(E_Password.Text)='') or
          (E_Username.Text ='Username') or
          (E_Password.Text ='Password') then
    begin
      r_pnl_arr[21]      .Visible:=True; // ShowMessage('Please enter username and password');
      r_pnl_arr[01]      .Enabled:=not r_pnl_arr[21].Visible;
      r_pnl_arr[02]      .Enabled:=not r_pnl_arr[21].Visible;
      r_pnl_arr[03]      .Enabled:=not r_pnl_arr[21].Visible;
      r_pnl_arr[04]      .Enabled:=not r_pnl_arr[21].Visible;
      L_Register         .Enabled:=not r_pnl_arr[21].Visible;
      L_Forgot_Password  .Enabled:=not r_pnl_arr[21].Visible;
      L_Remember_Password.Enabled:=not r_pnl_arr[21].Visible;
      E_Username         .Enabled:=not r_pnl_arr[21].Visible;
      E_Password         .Enabled:=not r_pnl_arr[21].Visible;
      FormResize(Self);
      Repaint;
      Exit;
    end;

  Client    :=TFPHTTPClient.Create(Nil);
  ReqJSON   :=TJSONObject  .Create;
  ReqStream :=TStringStream.Create('',TEncoding.UTF8);
  RespStream:=TStringStream.Create('',TEncoding.UTF8);

  try

    {JSON body}
    ReqJSON.Add('action'  ,'login');
    ReqJSON.Add('username',E_Username.Text);
    ReqJSON.Add('password',E_Password.Text);

    ReqStream.WriteString(ReqJSON.AsJSON);
    ReqStream.Position:=0;

    Client.AddHeader('Content-Type','application/json');
    Client.AddHeader('Accept'      ,'application/json');
    Client.RequestBody:=ReqStream;

    {Post,ResponseStream}
    Client.Post('https://www.astrill.com/mockapi1.php',RespStream);

    RespStream.Position:=0;
    RespJSON           :=TJSONObject(GetJSON(RespStream.DataString));

    {Response processing}
    if (RespJSON.Get('status','')='ok') then
      HandleLoginSuccess(RespJSON)
    else
      HandleLoginError(RespJSON);

  except
    on E: Exception do
      ShowMessage('Network error: '+E.Message);
  end;

  ReqJSON   .Free;
  ReqStream .Free;
  RespStream.Free;
  Client.Free;
end;

{Error handling}
procedure TF_AstrillVPN.ErrorOkClick      (Sender  :TObject);
begin
  r_pnl_arr[21]      .Visible:=False; // ShowMessage('Please enter username and password');
  r_pnl_arr[01]      .Enabled:=not r_pnl_arr[21].Visible;
  r_pnl_arr[02]      .Enabled:=not r_pnl_arr[21].Visible;
  r_pnl_arr[03]      .Enabled:=not r_pnl_arr[21].Visible;
  r_pnl_arr[04]      .Enabled:=not r_pnl_arr[21].Visible;
  L_Register         .Enabled:=not r_pnl_arr[21].Visible;
  L_Forgot_Password  .Enabled:=not r_pnl_arr[21].Visible;
  L_Remember_Password.Enabled:=not r_pnl_arr[21].Visible;
  E_Username         .Enabled:=not r_pnl_arr[21].Visible;
  E_Password         .Enabled:=not r_pnl_arr[21].Visible;
  FormResize(Self);
  Repaint;
end;

initialization
  {$I main.lrs}

end.


