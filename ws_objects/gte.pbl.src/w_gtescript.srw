$PBExportHeader$w_gtescript.srw
forward
global type w_gtescript from window
end type
type cb_1 from commandbutton within w_gtescript
end type
type em_1 from editmask within w_gtescript
end type
type cb_2 from commandbutton within w_gtescript
end type
type cb_4 from commandbutton within w_gtescript
end type
end forward

global type w_gtescript from window
integer width = 3456
integer height = 2448
boolean titlebar = true
string title = "(w_gtescript) Script"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_1 cb_1
em_1 em_1
cb_2 cb_2
cb_4 cb_4
end type
global w_gtescript w_gtescript

type variables
boolean lb_neworder, lb_query
string ls_frym,ls_toym,ls_unit,ls_unitnm, ls_supplier, ls_temp,ls_catg,ls_po_ind, ls_cat
long ll_cat
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

public function integer wf_inquiry (long fl_year);
return 1
end function

on w_gtescript.create
this.cb_1=create cb_1
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.Control[]={this.cb_1,&
this.em_1,&
this.cb_2,&
this.cb_4}
end on

on w_gtescript.destroy
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_4)
end on

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

event open;
setpointer(hourglass!)

end event

type cb_1 from commandbutton within w_gtescript
integer x = 1669
integer y = 40
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Browse"
end type

event clicked;string ls_file, ls_filter, ls_dir, ls_content
integer li_rc, li_fh

// File Filter
ls_filter = "Text Files (*.txt),*.txt;All Files (*.*),*.*"

// Open File Dialog
li_rc = GetFileOpenName("Select File", ls_file, ls_dir, ls_filter, "*.txt")

IF li_rc < 1 THEN
    MessageBox("Info", "No file selected.")
    RETURN
END IF

em_1.text=ls_file


end event

type em_1 from editmask within w_gtescript
integer x = 50
integer y = 44
integer width = 1582
integer height = 104
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
maskdatatype maskdatatype = stringmask!
end type

type cb_2 from commandbutton within w_gtescript
integer x = 2016
integer y = 44
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;string ls_sql,ls_file
integer li_fh


ls_file = em_1.text

if len(ls_file) = 0 or isnull(ls_file) then
	messagebox('Warning','Nothing Selected')
end if


li_fh=FileOpen(ls_file, StreamMode!)
FileRead(li_fh, ls_sql)
FileClose(li_fh)

EXECUTE IMMEDIATE :ls_sql USING SQLCA;
if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	return 1
end if

messagebox("Success","Done Check")
commit using sqlca;
end event

type cb_4 from commandbutton within w_gtescript
integer x = 2286
integer y = 44
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

