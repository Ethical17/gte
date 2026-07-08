$PBExportHeader$w_gtepswr001.srw
forward
global type w_gtepswr001 from window
end type
type cb_2 from commandbutton within w_gtepswr001
end type
type cb_1 from commandbutton within w_gtepswr001
end type
type dw_1 from datawindow within w_gtepswr001
end type
end forward

global type w_gtepswr001 from window
integer width = 3049
integer height = 2548
boolean titlebar = true
string title = "User Password Details :"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtepswr001 w_gtepswr001

on w_gtepswr001.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtepswr001.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.SetTransObject(SQLCA)
//dw_1.Retrieve()
end event

type cb_2 from commandbutton within w_gtepswr001
integer x = 2359
integer y = 28
integer width = 256
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtepswr001
integer x = 2075
integer y = 28
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Run"
end type

event clicked;dw_1.SetTransObject(SQLCA)
dw_1.Reset()
dw_1.Retrieve()

IF dw_1.RowCount() = 0 THEN
    MessageBox("Information", "No data found!")
END IF

end event

type dw_1 from datawindow within w_gtepswr001
integer x = 37
integer y = 136
integer width = 2578
integer height = 2188
integer taborder = 10
string title = "none"
string dataobject = "dw_gtepswr001"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

