$PBExportHeader$w_import_rows_information.srw
forward
global type w_import_rows_information from window
end type
type st_tname from statictext within w_import_rows_information
end type
type st_2 from statictext within w_import_rows_information
end type
type st_1 from statictext within w_import_rows_information
end type
type sle_1 from singlelineedit within w_import_rows_information
end type
end forward

global type w_import_rows_information from window
integer width = 1541
integer height = 472
boolean titlebar = true
string title = "Rows Import Information"
long backcolor = 67108864
st_tname st_tname
st_2 st_2
st_1 st_1
sle_1 sle_1
end type
global w_import_rows_information w_import_rows_information

on w_import_rows_information.create
this.st_tname=create st_tname
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.st_tname,&
this.st_2,&
this.st_1,&
this.sle_1}
end on

on w_import_rows_information.destroy
destroy(this.st_tname)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;f_center(this)
end event

type st_tname from statictext within w_import_rows_information
integer x = 549
integer y = 20
integer width = 946
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_rows_information
integer x = 59
integer y = 28
integer width = 434
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Current Table:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_rows_information
integer x = 763
integer y = 156
integer width = 475
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rows Importing..."
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_import_rows_information
integer x = 306
integer y = 140
integer width = 402
integer height = 112
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

