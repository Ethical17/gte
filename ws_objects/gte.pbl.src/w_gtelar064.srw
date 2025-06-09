$PBExportHeader$w_gtelar064.srw
forward
global type w_gtelar064 from window
end type
type st_3 from statictext within w_gtelar064
end type
type ddlb_3 from dropdownlistbox within w_gtelar064
end type
type cb_2 from commandbutton within w_gtelar064
end type
type cb_1 from commandbutton within w_gtelar064
end type
type st_1 from statictext within w_gtelar064
end type
type ddlb_1 from dropdownlistbox within w_gtelar064
end type
type dw_1 from datawindow within w_gtelar064
end type
end forward

global type w_gtelar064 from window
integer width = 3502
integer height = 2440
boolean titlebar = true
string title = "(Gtelar064) - Population Register"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
ddlb_3 ddlb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelar064 w_gtelar064

type variables
long ll_pbno
string ls_type
n_cst_powerfilter iu_powerfilter
end variables

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

on w_gtelar064.create
this.st_3=create st_3
this.ddlb_3=create ddlb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.ddlb_3,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelar064.destroy
destroy(this.st_3)
destroy(this.ddlb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

ddlb_3.reset()
ddlb_3.additem('ALL')
setpointer(hourglass!)
declare c3 cursor for
select distinct rh_manid||' ('||RH_ID||')' from fb_residentialhouse where nvl(rh_active_ind,'N') = 'Y' order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_type)
		fetch c3 into:ls_type;
	loop
	close c3;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)

end event

type st_3 from statictext within w_gtelar064
integer x = 1134
integer y = 40
integer width = 357
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Line"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar064
integer x = 1490
integer y = 32
integer width = 695
integer height = 636
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
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

type cb_2 from commandbutton within w_gtelar064
integer x = 2491
integer y = 32
integer width = 265
integer height = 100
integer taborder = 50
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

type cb_1 from commandbutton within w_gtelar064
integer x = 2217
integer y = 32
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)
setpointer(hourglass!)
dw_1.retrieve(left(right(ddlb_3.text,9),8),left(ddlb_1.text,2))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

setpointer(arrow!)

end event

type st_1 from statictext within w_gtelar064
integer x = 18
integer y = 52
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar064
integer x = 430
integer y = 32
integer width = 677
integer height = 508
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL","LP - Permanent ","LT - Temporary","LO - Outside"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ddlb_3.reset()
ddlb_3.additem('ALL')
setpointer(hourglass!)
declare c3 cursor for
select distinct rh_manid||' ('||RH_ID||')' from fb_residentialhouse where nvl(rh_active_ind,'N') = 'Y' order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_type)
		fetch c3 into:ls_type;
	loop
	close c3;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)
end event

type dw_1 from datawindow within w_gtelar064
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 160
integer width = 3360
integer height = 2056
integer taborder = 40
string dataobject = "dw_gtelar064"
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

