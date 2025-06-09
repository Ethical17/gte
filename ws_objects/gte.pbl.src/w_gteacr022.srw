$PBExportHeader$w_gteacr022.srw
forward
global type w_gteacr022 from window
end type
type em_1 from editmask within w_gteacr022
end type
type st_1 from statictext within w_gteacr022
end type
type cb_2 from commandbutton within w_gteacr022
end type
type cb_1 from commandbutton within w_gteacr022
end type
type dw_1 from datawindow within w_gteacr022
end type
end forward

global type w_gteacr022 from window
integer width = 3918
integer height = 2676
boolean titlebar = true
string title = "(w_gteacr022) Statutory Payment / Dues Return"
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
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr022 w_gteacr022

type variables
n_cst_powerfilter iu_powerfilter
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

on w_gteacr022.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr022.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject( sqlca);

em_1.text = string(today(),'YYYYMM')

//dp_1.text = string(today())
//dp_2.text = string(today())

end event

type em_1 from editmask within w_gteacr022
integer x = 384
integer y = 16
integer width = 247
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
string mask = "000000"
end type

type st_1 from statictext within w_gteacr022
integer x = 18
integer y = 24
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacr022
integer x = 928
integer y = 4
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

type cb_1 from commandbutton within w_gteacr022
integer x = 667
integer y = 4
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

event clicked;if isnull(em_1.text) or len(em_1.text) = 0 or em_1.text = '000000' then
	messagebox('Warning!','Please Enter The Year Month First  !!!')
	return 1
end if


dw_1.settransobject(sqlca)
dw_1.retrieve(em_1.text, upper(trim(gs_garden_nm)))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if

end event

type dw_1 from datawindow within w_gteacr022
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 18
integer y = 108
integer width = 3781
integer height = 2228
string dataobject = "dw_gteacr022"
boolean hscrollbar = true
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

