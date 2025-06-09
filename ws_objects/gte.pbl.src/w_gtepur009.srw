$PBExportHeader$w_gtepur009.srw
forward
global type w_gtepur009 from window
end type
type cb_4 from commandbutton within w_gtepur009
end type
type cb_2 from commandbutton within w_gtepur009
end type
type ddlb_1 from dropdownlistbox within w_gtepur009
end type
type st_3 from statictext within w_gtepur009
end type
type dw_1 from datawindow within w_gtepur009
end type
end forward

global type w_gtepur009 from window
integer width = 6935
integer height = 2816
boolean titlebar = true
string title = "(w_gtepur009) Supplier List"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_2 cb_2
ddlb_1 ddlb_1
st_3 st_3
dw_1 dw_1
end type
global w_gtepur009 w_gtepur009

type variables
n_cst_powerfilter iu_powerfilter
string ls_supty
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

on w_gtepur009.create
this.cb_4=create cb_4
this.cb_2=create cb_2
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_2,&
this.ddlb_1,&
this.st_3,&
this.dw_1}
end on

on w_gtepur009.destroy
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

ddlb_1.reset()
ddlb_1.additem('ALL')

declare c2 cursor for
select distinct SUP_TYPE from fb_supplier order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_supty;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_supty)
		fetch c2 into:ls_supty;
	loop
	close c2;
end if

ddlb_1.text = 'ALL'
setpointer(arrow!)
end event

type cb_4 from commandbutton within w_gtepur009
integer x = 1568
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
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

type cb_2 from commandbutton within w_gtepur009
integer x = 1298
integer y = 8
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;dw_1.settransobject(sqlca)
if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Supplier Type !!!')
	return 
end if

dw_1.retrieve(ddlb_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if


	

end event

type ddlb_1 from dropdownlistbox within w_gtepur009
integer x = 421
integer y = 16
integer width = 841
integer height = 528
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtepur009
integer x = 14
integer y = 28
integer width = 384
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier Type "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtepur009
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 116
integer width = 6862
integer height = 2544
string dataobject = "dw_gtepur009"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

