$PBExportHeader$w_ltcvoucherlog.srw
forward
global type w_ltcvoucherlog from window
end type
type cb_2 from commandbutton within w_ltcvoucherlog
end type
type cb_4 from commandbutton within w_ltcvoucherlog
end type
end forward

global type w_ltcvoucherlog from window
integer width = 3456
integer height = 2448
boolean titlebar = true
string title = "(w_voucherlog) Voucher Cancel"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
cb_4 cb_4
end type
global w_ltcvoucherlog w_ltcvoucherlog

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

on w_ltcvoucherlog.create
this.cb_2=create cb_2
this.cb_4=create cb_4
this.Control[]={this.cb_2,&
this.cb_4}
end on

on w_ltcvoucherlog.destroy
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

type cb_2 from commandbutton within w_ltcvoucherlog
integer x = 1111
integer y = 408
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;string ls_sql
integer li_fh

li_fh=FileOpen( "C:\sql\script.txt", StreamMode!)
FileRead(li_fh, ls_sql)
FileClose(li_fh)

EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end event

type cb_4 from commandbutton within w_ltcvoucherlog
integer x = 1513
integer y = 404
integer width = 265
integer height = 100
integer taborder = 50
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

