$PBExportHeader$w_manuvalley.srw
forward
global type w_manuvalley from window
end type
type rb_6 from radiobutton within w_manuvalley
end type
type rb_5 from radiobutton within w_manuvalley
end type
type rb_4 from radiobutton within w_manuvalley
end type
type rb_3 from radiobutton within w_manuvalley
end type
type cb_1 from commandbutton within w_manuvalley
end type
type rb_2 from radiobutton within w_manuvalley
end type
type rb_1 from radiobutton within w_manuvalley
end type
type gb_1 from groupbox within w_manuvalley
end type
end forward

global type w_manuvalley from window
integer width = 1499
integer height = 1384
boolean titlebar = true
string title = "Select Garden"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_manuvalley w_manuvalley

on w_manuvalley.create
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.cb_1,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_manuvalley.destroy
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event open;disconnect using sqlca;

end event

type rb_6 from radiobutton within w_manuvalley
boolean visible = false
integer x = 320
integer y = 940
integer width = 731
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

type rb_5 from radiobutton within w_manuvalley
integer x = 320
integer y = 788
integer width = 731
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
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "gpote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "gpote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type rb_4 from radiobutton within w_manuvalley
integer x = 320
integer y = 636
integer width = 731
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pearacherra Tea Estate"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
gs_loginuser = 'pcote'
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "pcote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "pcote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type rb_3 from radiobutton within w_manuvalley
integer x = 320
integer y = 472
integer width = 731
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Jagannathpur Tea Estate"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
gs_loginuser = 'jpote'
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "jpote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "jpote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type cb_1 from commandbutton within w_manuvalley
integer x = 530
integer y = 1156
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

type rb_2 from radiobutton within w_manuvalley
boolean visible = false
integer x = 320
integer y = 328
integer width = 699
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manu Tea Factory"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "mfote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "mfote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type rb_1 from radiobutton within w_manuvalley
integer x = 315
integer y = 180
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
string text = "Manuvalley Tea Estate"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
gs_loginuser = 'mvote'
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "mvote"
SQLCA.ServerName = "ltcdb"
//SQLCA.ServerName = "ltcdbho"
SQLCA.LogId = "mvote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if
open(w_welcome)
end event

type gb_1 from groupbox within w_manuvalley
integer x = 210
integer y = 68
integer width = 1051
integer height = 1052
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

