$PBExportHeader$w_makaibari.srw
forward
global type w_makaibari from window
end type
type cb_1 from commandbutton within w_makaibari
end type
type rb_2 from radiobutton within w_makaibari
end type
type rb_1 from radiobutton within w_makaibari
end type
type gb_1 from groupbox within w_makaibari
end type
end forward

global type w_makaibari from window
integer width = 1527
integer height = 752
boolean titlebar = true
string title = "Select Garden"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_makaibari w_makaibari

on w_makaibari.create
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_makaibari.destroy
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event open;disconnect using sqlca;

end event

type cb_1 from commandbutton within w_makaibari
integer x = 530
integer y = 440
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

type rb_2 from radiobutton within w_makaibari
integer x = 315
integer y = 248
integer width = 914
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Makaibari Tea Estate (Non P.F.)"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "msote"
SQLCA.ServerName = "ltcdb"
SQLCA.LogId = "msote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error During SQL Connect',sqlca.sqlerrtext)
	return 1
end if

open(w_welcome)
end event

type rb_1 from radiobutton within w_makaibari
integer x = 315
integer y = 140
integer width = 795
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Makaibari Tea Estate (P.F.)"
boolean automatic = false
end type

event clicked;disconnect using sqlca;
gs_loginuser = 'mkote'
SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
SQLCA.LogPass = "mkote"
SQLCA.ServerName = "ltcdb"
//SQLCA.ServerName = "ltcdbho"
SQLCA.LogId = "mkote"
SQLCA.AutoCommit = False
SQLCA.DBParm = ""

connect using sqlca;
open(w_welcome)
end event

type gb_1 from groupbox within w_makaibari
integer x = 210
integer y = 68
integer width = 1051
integer height = 332
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

