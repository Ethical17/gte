$PBExportHeader$w_gteflr016.srw
forward
global type w_gteflr016 from window
end type
type st_2 from statictext within w_gteflr016
end type
type ddlb_1 from dropdownlistbox within w_gteflr016
end type
type em_1 from editmask within w_gteflr016
end type
type st_1 from statictext within w_gteflr016
end type
type cb_2 from commandbutton within w_gteflr016
end type
type cb_1 from commandbutton within w_gteflr016
end type
type dw_1 from datawindow within w_gteflr016
end type
end forward

global type w_gteflr016 from window
integer width = 4581
integer height = 2356
boolean titlebar = true
string title = "(Gteflr016) - Plucking Chart"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
ddlb_1 ddlb_1
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteflr016 w_gteflr016

type variables
long ll_year
double ld_teamade,ld_recper,ld_totgl, ld_unallocated, ld_indirectcost, ld_gardenarea, ld_una_costph, ld_ind_costph
n_cst_powerfilter iu_powerfilter
string ls_field
end variables

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

on w_gteflr016.create
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.ddlb_1,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteflr016.destroy
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

em_1.text = string(today(),'yyyymm')

ddlb_1.reset( )

declare c1 cursor for
select field_name||'                                              ('||field_id||')' from fb_field order by field_id;

open c1;
IF sqlca.sqlcode = 0 THEN 
		fetch c1 into :ls_field;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_field)
		setnull(ls_field);
		fetch c1 into :ls_field;
	loop
	close c1;
end if
setpointer(arrow!)
end event

type st_2 from statictext within w_gteflr016
integer x = 631
integer y = 32
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division : "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteflr016
integer x = 891
integer y = 20
integer width = 882
integer height = 352
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_gteflr016
integer x = 361
integer y = 20
integer width = 238
integer height = 84
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
string mask = "YYYYMM"
end type

type st_1 from statictext within w_gteflr016
integer x = 14
integer y = 28
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteflr016
integer x = 2048
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteflr016
integer x = 1783
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;string ra_frdt,ra_todt
dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(em_1.text) or em_1.text='000000' then
	messagebox('Warning','Please Enter The Year Month !!!')
	return 
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select A Division !!!')
	return 
end if


dw_1.retrieve(em_1.text,left(right(ddlb_1.text,6),5) )

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gteflr016
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4489
integer height = 2116
string dataobject = "dw_gteflr016"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

