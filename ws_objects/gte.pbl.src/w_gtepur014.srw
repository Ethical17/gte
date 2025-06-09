$PBExportHeader$w_gtepur014.srw
forward
global type w_gtepur014 from window
end type
type st_2 from statictext within w_gtepur014
end type
type em_2 from editmask within w_gtepur014
end type
type em_1 from editmask within w_gtepur014
end type
type st_1 from statictext within w_gtepur014
end type
type cb_2 from commandbutton within w_gtepur014
end type
type cb_4 from commandbutton within w_gtepur014
end type
type dw_1 from datawindow within w_gtepur014
end type
end forward

global type w_gtepur014 from window
integer width = 5632
integer height = 2804
boolean titlebar = true
string title = "(W_gtepur014) B2B For GR2 (For WEP)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
em_2 em_2
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtepur014 w_gtepur014

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_frym,ls_toym, ls_nppc
string ls_srep, ls_type
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
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
	case "ZOOM"
		SetPointer (HourGlass!)											
		OpenwithParm (w_zoom,dw_1)
		SetPointer (Arrow!)						
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

on w_gtepur014.create
this.st_2=create st_2
this.em_2=create em_2
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.em_2,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtepur014.destroy
destroy(this.st_2)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
lb_query = false	
lb_neworder = false
em_1.enabled = true
setpointer(hourglass!)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_2 from statictext within w_gtepur014
integer x = 763
integer y = 36
integer width = 457
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Year Month:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtepur014
integer x = 1230
integer y = 24
integer width = 219
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type em_1 from editmask within w_gtepur014
integer x = 521
integer y = 24
integer width = 219
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type st_1 from statictext within w_gtepur014
integer x = 55
integer y = 36
integer width = 457
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Year Month:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtepur014
integer x = 1467
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;

if isnull(em_1.text) or em_1.text='000000' then
	messagebox('Warning','Please Enter The Year Month !!!')
	return 
end if

if isnull(em_2.text) or em_2.text='000000' then
	messagebox('Warning','Please Enter The Year Month !!!')
	return 
end if

if long(em_1.text) > long(em_2.text) then
	messagebox('Warning','From Year Month can not be greater than To Year Month!!!')
	return 
end if 

dw_1.settransobject(sqlca)
dw_1.retrieve(em_1.text, em_2.text)

end event

type cb_4 from commandbutton within w_gtepur014
integer x = 1737
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
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

type dw_1 from datawindow within w_gtepur014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 37
integer y = 128
integer width = 5463
integer height = 2552
integer taborder = 50
string dataobject = "dw_gtepur014"
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

