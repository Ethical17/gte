$PBExportHeader$w_gtedsf007a_mf.srw
forward
global type w_gtedsf007a_mf from window
end type
type dw_1 from datawindow within w_gtedsf007a_mf
end type
type cb_2 from commandbutton within w_gtedsf007a_mf
end type
end forward

global type w_gtedsf007a_mf from window
integer width = 2597
integer height = 992
boolean titlebar = true
string title = "Despatch Details"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
end type
global w_gtedsf007a_mf w_gtedsf007a_mf

type variables
string ls_temp1
end variables

on w_gtedsf007a_mf.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.Control[]={this.dw_1,&
this.cb_2}
end on

on w_gtedsf007a_mf.destroy
destroy(this.dw_1)
destroy(this.cb_2)
end on

event open;setpointer(hourglass!)
dw_1.settransobject(sqlca)
ls_temp1 = Message.StringParm
dw_1.retrieve(ls_temp1)

setpointer(arrow!)

end event

type dw_1 from datawindow within w_gtedsf007a_mf
integer x = 23
integer y = 28
integer width = 2533
integer height = 764
integer taborder = 10
string title = "none"
string dataobject = "dw_gtedsf007b_mf"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtedsf007a_mf
integer x = 2313
integer y = 800
integer width = 251
integer height = 104
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;gb_retval = false
Close(parent)
end event

