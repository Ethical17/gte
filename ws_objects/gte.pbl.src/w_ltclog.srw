$PBExportHeader$w_ltclog.srw
forward
global type w_ltclog from window
end type
type em_2 from editmask within w_ltclog
end type
type st_3 from statictext within w_ltclog
end type
type em_1 from editmask within w_ltclog
end type
type st_1 from statictext within w_ltclog
end type
type cb_2 from commandbutton within w_ltclog
end type
type cb_4 from commandbutton within w_ltclog
end type
type dw_1 from datawindow within w_ltclog
end type
end forward

global type w_ltclog from window
integer width = 5207
integer height = 2448
boolean titlebar = true
string title = "(w_ltclog) Audit Trail Data"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_2 em_2
st_3 st_3
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_ltclog w_ltclog

type variables
boolean lb_neworder, lb_query
string ls_frym,ls_toym,ls_unit,ls_unitnm, ls_supplier, ls_temp,ls_catg,ls_po_ind, ls_cat
long ll_cat
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "SAVEAS"
			this.dw_1.saveas()
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose

end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_ltclog.create
this.em_2=create em_2
this.st_3=create st_3
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.em_2,&
this.st_3,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_ltclog.destroy
destroy(this.em_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_co_nameadd+"'")

em_1.text =string(today(),'yyyymm')
em_2.text =string(today(),'yyyymm')

setpointer(hourglass!)

end event

type em_2 from editmask within w_ltclog
integer x = 741
integer y = 12
integer width = 343
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "000000"
end type

type st_3 from statictext within w_ltclog
integer x = 599
integer y = 24
integer width = 123
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from editmask within w_ltclog
integer x = 224
integer y = 12
integer width = 347
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "000000"
end type

type st_1 from statictext within w_ltclog
integer x = 23
integer y = 24
integer width = 192
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ltclog
integer x = 1193
integer y = 8
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

event clicked;

if isnull(em_1.text) or em_1.text='00000000' then
	messagebox('Warning','Please Enter Valid From Date !!!')
	return 
end if

if isnull(em_2.text) or em_2.text='00000000' then
	messagebox('Warning','Please Enter Valid To Date !!!')
	return 
end if

if long(em_1.text) > long(em_2.text) then
	messagebox('Warning','From Year Month can not be greater than To Year Month!!!')
	return 
end if 




dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(em_1.text,em_2.text)


if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
end event

type cb_4 from commandbutton within w_ltclog
integer x = 1458
integer y = 8
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

type dw_1 from datawindow within w_ltclog
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 5
integer y = 116
integer width = 5152
integer height = 2120
string dataobject = "dw_ltclog"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF

end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

