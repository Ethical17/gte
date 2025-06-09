$PBExportHeader$w_golokpur.srw
forward
global type w_golokpur from window
end type
type rb_3 from radiobutton within w_golokpur
end type
type cb_1 from commandbutton within w_golokpur
end type
type rb_2 from radiobutton within w_golokpur
end type
type rb_1 from radiobutton within w_golokpur
end type
type gb_1 from groupbox within w_golokpur
end type
end forward

global type w_golokpur from window
integer width = 1481
integer height = 860
boolean titlebar = true
string title = "Select Garden"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rb_3 rb_3
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_golokpur w_golokpur

on w_golokpur.create
this.rb_3=create rb_3
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.rb_3,&
this.cb_1,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_golokpur.destroy
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event open;disconnect using sqlca;

end event

type rb_3 from radiobutton within w_golokpur
integer x = 315
integer y = 352
integer width = 667
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sarojini Tea Estate"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "sjote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "sjote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
open(w_welcome)
end event

type cb_1 from commandbutton within w_golokpur
integer x = 530
integer y = 548
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(parent)
end event

type rb_2 from radiobutton within w_golokpur
integer x = 315
integer y = 248
integer width = 667
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Golokpur Tea Factory"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "gfote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "gfote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type rb_1 from radiobutton within w_golokpur
integer x = 315
integer y = 140
integer width = 667
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Golokpur Tea Estate"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
gs_loginuser = 'gpote'
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "gpote"
SQLCA.ServerName = "ltcdb"
//SQLCA.ServerName = "ltcdbho"
SQLCA.LogId = "gpote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
open(w_welcome)
end event

type gb_1 from groupbox within w_golokpur
integer x = 210
integer y = 68
integer width = 1051
integer height = 436
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

