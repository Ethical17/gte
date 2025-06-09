$PBExportHeader$w_print.srw
forward
global type w_print from window
end type
type st_3 from statictext within w_print
end type
type sle_2 from singlelineedit within w_print
end type
type cb_3 from commandbutton within w_print
end type
type cb_2 from commandbutton within w_print
end type
type cb_1 from commandbutton within w_print
end type
type st_2 from statictext within w_print
end type
type sle_1 from singlelineedit within w_print
end type
type rb_range from radiobutton within w_print
end type
type rb_all from radiobutton within w_print
end type
type st_1 from statictext within w_print
end type
type em_1 from editmask within w_print
end type
type gb_1 from groupbox within w_print
end type
end forward

global type w_print from window
integer x = 699
integer y = 460
integer width = 1522
integer height = 1068
boolean titlebar = true
string title = "Print"
windowtype windowtype = response!
long backcolor = 12632256
boolean toolbarvisible = false
st_3 st_3
sle_2 sle_2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_2 st_2
sle_1 sle_1
rb_range rb_range
rb_all rb_all
st_1 st_1
em_1 em_1
gb_1 gb_1
end type
global w_print w_print

type variables
string ls_printername,ls_printstring,ls_copy_text
datawindow idw_dw


end variables

event open;f_center(this)
idw_dw = message.powerobjectparm

ls_printername = idw_dw.Describe("DataWindow.Printer")
sle_2.text = ls_printername
end event

on w_print.create
this.st_3=create st_3
this.sle_2=create sle_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_1=create sle_1
this.rb_range=create rb_range
this.rb_all=create rb_all
this.st_1=create st_1
this.em_1=create em_1
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.sle_2,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.sle_1,&
this.rb_range,&
this.rb_all,&
this.st_1,&
this.em_1,&
this.gb_1}
end on

on w_print.destroy
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.rb_range)
destroy(this.rb_all)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.gb_1)
end on

type st_3 from statictext within w_print
integer x = 32
integer y = 16
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Printer:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_print
integer x = 279
integer y = 12
integer width = 1152
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type cb_3 from commandbutton within w_print
integer x = 1138
integer y = 724
integer width = 229
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Setup"
end type

event clicked;printsetup()
ls_printername = idw_dw.Describe("DataWindow.Printer")
sle_2.text = ls_printername
end event

type cb_2 from commandbutton within w_print
integer x = 1138
integer y = 508
integer width = 229
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

on clicked;close(parent)
end on

type cb_1 from commandbutton within w_print
integer x = 1138
integer y = 292
integer width = 229
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Print"
boolean default = true
end type

event clicked;ls_printstring = ""
SETPOINTER(HOURGLASS!)
ls_copy_text = "datawindow.print.copies=" + trim(em_1.text)
if rb_range.checked then;
  	ls_printstring  = sle_1.text;
end if

idw_dw.modify(ls_copy_text)
idw_dw.modify("DataWindow.Print.Page.Range =' " + ls_printstring + "'" )  
idw_dw.print()
SETPOINTER(arrow!)
close(parent)


end event

type st_2 from statictext within w_print
integer x = 55
integer y = 744
integer width = 1024
integer height = 136
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
boolean enabled = false
string text = "Enter page  number and / or page ranges seprated by commas. for Examp. 1,4,7-10"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_print
integer x = 375
integer y = 584
integer width = 370
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean autohscroll = false
borderstyle borderstyle = styleshadowbox!
end type

on getfocus;rb_range.checked = true
end on

type rb_range from radiobutton within w_print
integer x = 101
integer y = 588
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
string text = "&Range"
end type

on clicked;setfocus(sle_1)
end on

type rb_all from radiobutton within w_print
integer x = 105
integer y = 404
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
string text = " &All"
end type

type st_1 from statictext within w_print
integer x = 169
integer y = 112
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Copies"
boolean focusrectangle = false
end type

type em_1 from editmask within w_print
integer x = 425
integer y = 108
integer width = 247
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "######"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~100"
end type

type gb_1 from groupbox within w_print
integer x = 41
integer y = 244
integer width = 1051
integer height = 648
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
string text = "Page Range"
borderstyle borderstyle = styleraised!
end type

