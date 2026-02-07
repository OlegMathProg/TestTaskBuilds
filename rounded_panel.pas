unit rounded_panel;

{$mode objfpc}{$H+}

interface

uses //

  {rtl}
  Classes, Controls, Graphics, StdCtrls,

  {3d party units}
  BGRABitmap, BGRABitmapTypes, BGRACanvas2D;



type

  PLabel           =^TLabel;
  PBGRABitmap      =^TBGRABitmap;
  TPtPos           =record
    X,Y: integer;
  end;
  TPtPos3          =array[0..2] of TPtPos;
  TGeom2DType      =(g2DtRectangle,
                     g2DtFilledRectangle,
                     g2DtCircle,
                     g2DtFilledCircle,
                     g2DtVertLine,
                     g2DtHorizLine,
                     g2DtArrowLeftRight,
                     g2DtCapArc,
                     g2DtStar,
                     g2DtImage);
  TGeom2DObj       =record
    BGRABmpPtr: PBGRABitmap;
    Pt3       : TPtPos3;
    RctDst    : TRect;
    Radius1   : Integer;
    Radius2   : Integer;
    Angle1    : Single;
    Angle2    : Single;
    Scale     : Single;
    Thikness  : Integer;
    Color     : TColor;
    Alpha     : Word;
    Geom2DType: TGeom2DType;
    DrawMode  : TDrawMode;
    IsChecked : Boolean;
  end;
  TBGRARoundedPanel=class(TCustomControl)
    public
      FBmp       : TBGRABitmap;
      BkgndColor : TColor;
      geom_2D_arr: array of TGeom2DObj;
      label_ind  : Integer;
      constructor Create    (AOwner     :TComponent);  override;
      procedure   Paint;                               override;
      procedure   Resize;                              override;
      procedure   Geom2DAdd (Geom2DType_:TGeom2DType);
      procedure   Geom2DDraw(Geom2DObj_ :TGeom2DObj);
    published
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseDown;
      property OnMouseUp;
      property OnClick;
  end;



implementation

uses

  main;



function    ColorWithAlpha              (const Color:TColor; const Alpha:Byte):TBGRAPixel; inline;
var
  C: TBGRAPixel;
begin
  Result      :=ColorToBGRA(Color);
  Result.Alpha:=Alpha;
end;
procedure   DrawEmptyRect               (Bmp:TBGRABitmap; R:TRect; Rx,Ry:Single; Thickness:Single; Color:TBGRAPixel);
begin
  with bmp.Canvas2D do
    begin
      StrokeStyle(Color);
      LineWidth:=Thickness;
      BeginPath;
      RoundRect
      (
        R.Left,
        R.Top,
        R.Width,
        R.Height,
        Rx,
        Ry
      );
      Stroke;
    end;
end;
procedure   DrawStar                    (Bmp:TBGRABitmap; Cx,Cy:Single; Rad1_,Rad2_:Single; Color:TBGRAPixel);
var
  I: Integer;
  A: Single;
begin
  with bmp.Canvas2D do
    begin
      FillStyle(Color);
      BeginPath;
      for I:=0 to 9 do
        begin
          A:=Pi/2+I*Pi/5;
          if (I and 1)=0 then
            LineTo(Cx+Cos(A)*Rad1_,
                   Cy+Sin(A)*Rad1_)
          else
            LineTo(
                   Cx+Cos(A)*Rad2_,
                   Cy+Sin(A)*Rad2_);
        end;
      ClosePath;
      Fill;
    end;
end;
constructor TBGRARoundedPanel.Create    (AOwner:TComponent);
begin
  inherited Create(AOwner);
  DoubleBuffered:=True;
  FBmp          :=TBGRABitmap.Create;
end;
procedure   TBGRARoundedPanel.Paint;
var
  I: Integer;
begin
  FBmp.SetSize(Width,Height);
  FBmp.Fill   (BkgndColor);
  for I:=0 to Length(geom_2D_arr)-1 do
    Geom2DDraw(geom_2D_arr[I]);
  FBmp.Draw(Canvas,0,0,True);
  inherited Paint;
end;
procedure   TBGRARoundedPanel.Resize;
begin
  inherited Resize;
  FBmp.SetSize(Width,Height);
end;
procedure   TBGRARoundedPanel.Geom2DAdd (Geom2DType_:TGeom2DType);
begin
  SetLength(geom_2D_arr,Length(geom_2D_arr)+1);
  geom_2D_arr[Length(geom_2D_arr)-1].Geom2DType:=Geom2DType_;
  if (Geom2DType_=g2DtImage) then
    geom_2D_arr[Length(geom_2D_arr)-1].Scale:=1;
end;
procedure   TBGRARoundedPanel.Geom2DDraw(Geom2DObj_:TGeom2DObj);
begin
  with Geom2DObj_ do
    case Geom2DType of
      g2DtRectangle:
        with FBmp do
          begin
            DrawEmptyRect
            (
              FBmp,
              RctDst,
              Radius1,
              Radius2,
              Thikness,
              ColorToBGRA(Color)
            );
          end;
      g2DtFilledRectangle:
        with FBmp do
          begin
            FillRoundRectAntialias
            (
              RctDst.Left  +1,
              RctDst.Top   +1,
              RctDst.Width -2,
              RctDst.Height-2,
              Radius1,
              Radius2,
              ColorToBGRA(Color)
            );
          end;
      g2DtCircle:
        with FBmp do
          begin
            EllipseAntialias
            (
              RctDst.Left,
              RctDst.Top,
              Radius1,
              Radius2,
              ColorToBGRA(Color),
              Thikness
            );
          end;
      g2DtFilledCircle:
        with FBmp do
          begin
            FillEllipseAntialias
            (
              RctDst.Left,
              RctDst.Top,
              Radius1,
              Radius2,
              ColorWithAlpha(Color,Alpha)
            );
          end;
      g2DtVertLine:
        with FBmp,Canvas2D do
          begin
            StrokeStyle(Color);
            LineWidth:=Thikness;
            LineCap  :='round';
            BeginPath;
            MoveTo(Pt3[0].X,Pt3[0].Y);
            LineTo(Pt3[0].X,Pt3[1].Y);
            Stroke;
          end;
      g2DtHorizLine:
        with FBmp do
          begin
            HorizLine
            (
              Pt3[0].X,
              Pt3[0].Y,
              Pt3[1].X,
              Color,
              DrawMode,
              Alpha
            );
          end;
      g2DtArrowLeftRight:
        with FBmp do
          begin
            DrawLineAntialias
            (
              Pt3[0].X,
              Pt3[0].Y,
              Pt3[1].X,
              Pt3[1].Y,
              Color,
              Thikness
            );
            DrawLineAntialias
            (
              Pt3[0].X,
              Pt3[0].Y,
              Pt3[1].X,
              Pt3[0].Y*2-Pt3[1].Y,
              Color,
              Thikness
            );
          end;
      g2DtCapArc:
        with FBmp,Canvas2D do
          begin
            StrokeStyle(Color);
            LineWidth:=Thikness;
            LineCap  :='round';
            BeginPath;
            Arc
            (
              RctDst.Left,
              RctDst.Top,
              Radius1,
              Angle1,
              Angle2,
              False
            );
            Stroke;
          end;
      g2DtStar:
        with FBmp do
          begin
            DrawStar
            (
              FBmp,
              RctDst.Left,
              RctDst.Top,
              Radius1,
              Radius2,
              Color
            );
          end;
      g2DtImage:
        with FBmp do
          begin
            {if (Scale=1) then
              PutImage
              (
                RctDst.Left-BGRABmpPtr^.Width >>1,
                RctDst.Top -BGRABmpPtr^.Height>>1,
                BGRABmpPtr^,
                dmDrawWithTransparency,
                255
              )
            else}
              StretchPutImage
              (
                Rect
                (
                  Trunc(                        +RctDst.Left-Scale*BGRABmpPtr^.Width /2),
                  Trunc(                        +RctDst.Top -Scale*BGRABmpPtr^.Height/2),
                  Trunc(Scale*BGRABmpPtr^.Width +RctDst.Left-Scale*BGRABmpPtr^.Width /2),
                  Trunc(Scale*BGRABmpPtr^.Height+RctDst.Top -Scale*BGRABmpPtr^.Height/2)
                ),
                BGRABmpPtr^,
                dmDrawWithTransparency
              );
          end;
    end;
end;

end.

end.

