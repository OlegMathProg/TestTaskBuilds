unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;



type

  {TF_Switch_Pages}

  TF_Switch_Pages=class(TForm)
    BB_Prev: TBitBtn;
    BB_Next: TBitBtn;
    procedure BB_PrevClick  (    Sender     :TObject);
    procedure BB_NextClick  (    Sender     :TObject);
    procedure FormClose     (    Sender     :TObject;
                             var CloseAction:TCloseAction);
    procedure FormCreate    (    Sender     :TObject);
    procedure FormMouseLeave(    Sender     :TObject);
    procedure FormResize    (    Sender     :TObject);
  end;



var
  F_Switch_Pages: TF_Switch_Pages;



implementation

uses

  main;

{TF_Switch_Pages}


procedure TF_Switch_Pages.FormCreate    (Sender:TObject);
begin
  PageInd:=0;
  Width  :=F_AstrillVPN.Width;
end;
procedure TF_Switch_Pages.FormResize    (Sender:TObject);
begin
  BB_Next.Left:=F_Switch_Pages.Width>>1;
end;
procedure TF_Switch_Pages.FormMouseLeave(Sender:TObject);
begin
  DefocusControl(ActiveControl,True);
  BB_Prev.Enabled:=False;
  BB_Next.Enabled:=False;
  BB_Prev.Enabled:=True;
  BB_Next.Enabled:=True;
end;
procedure TF_Switch_Pages.FormClose     (Sender:TObject; var CloseAction:TCloseAction);
begin
  F_AstrillVPN.Close;
  //Halt;
end;
procedure TF_Switch_Pages.BB_PrevClick  (Sender:TObject);
begin
  with F_AstrillVPN do
    case PageInd of
      0: Exit;
      1: ShowPage(0);
      2: ShowPage(1);
    end;
end;
procedure TF_Switch_Pages.BB_NextClick  (Sender:TObject);
begin
  with F_AstrillVPN do
    case PageInd of
      0: ShowPage(1);
      1: ShowPage(2);
      2: Exit;
    end;
end;

initialization
  {$I unit1.lrs}

end.

