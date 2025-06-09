$PBExportHeader$w_gteacr025.srw
forward
global type w_gteacr025 from window
end type
type em_1 from editmask within w_gteacr025
end type
type st_1 from statictext within w_gteacr025
end type
type sle_1 from singlelineedit within w_gteacr025
end type
type st_3 from statictext within w_gteacr025
end type
type ddlb_1 from dropdownlistbox within w_gteacr025
end type
type cb_2 from commandbutton within w_gteacr025
end type
type cb_1 from commandbutton within w_gteacr025
end type
type st_5 from statictext within w_gteacr025
end type
type dw_1 from datawindow within w_gteacr025
end type
end forward

global type w_gteacr025 from window
integer width = 3406
integer height = 2368
boolean titlebar = true
string title = "(w_gteacr025) Staff PF Advance Ledger"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_1 st_1
sle_1 sle_1
st_3 st_3
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_5 st_5
dw_1 dw_1
end type
global w_gteacr025 w_gteacr025

type variables
string ls_emp,ls_name,ls_frym,ls_toym
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();	choose case gs_ueoption
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

on w_gteacr025.create
this.em_1=create em_1
this.st_1=create st_1
this.sle_1=create sle_1
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_5=create st_5
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.sle_1,&
this.st_3,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_5,&
this.dw_1}
end on

on w_gteacr025.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject( sqlca);

ddlb_1.reset()

declare c1 cursor for
//select initcap(emp_name)||' ('||emp_id||')' from fb_employee where emp_type in ('LP','LT','LO') and emp_active = '1' order by 1;

select emp_id||' ('||initcap(emp_name)||')' from fb_employee where emp_type not in ('LP','LT','LO') and emp_active = '1' order by 1;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_emp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_emp)
		fetch c1 into :ls_emp;
	loop
	close c1;
end if


end event

type em_1 from editmask within w_gteacr025
integer x = 649
integer y = 24
integer width = 238
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "000000"
end type

type st_1 from statictext within w_gteacr025
integer x = 2245
integer y = 40
integer width = 78
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ID"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_gteacr025
integer x = 2341
integer y = 24
integer width = 288
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gteacr025
integer x = 37
integer y = 32
integer width = 603
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month (YYYYMM)"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr025
integer x = 1189
integer y = 24
integer width = 1006
integer height = 1160
integer taborder = 30
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

event selectionchanged;sle_1.text = left(ddlb_1.text,7)
end event

type cb_2 from commandbutton within w_gteacr025
integer x = 2926
integer y = 16
integer width = 242
integer height = 100
integer taborder = 60
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

type cb_1 from commandbutton within w_gteacr025
integer x = 2688
integer y = 16
integer width = 242
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if isnull(em_1.text) or em_1.text='000000' then
	messagebox('Warning','Please Enter Year Month First !!!')
	return 
end if


dw_1.show()
dw_1.settransobject(sqlca)

setpointer(hourglass!)
	dw_1.retrieve(em_1.text,sle_1.text)
setpointer(arrow!)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if

end event

type st_5 from statictext within w_gteacr025
integer x = 937
integer y = 32
integer width = 242
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr025
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 23
integer y = 124
integer width = 3273
integer height = 1996
string dataobject = "dw_gteacr025"
boolean maxbox = true
boolean vscrollbar = true
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

