$PBExportHeader$w_gteacr030.srw
forward
global type w_gteacr030 from window
end type
type dp_2 from datepicker within w_gteacr030
end type
type dp_1 from datepicker within w_gteacr030
end type
type cb_2 from commandbutton within w_gteacr030
end type
type cb_1 from commandbutton within w_gteacr030
end type
type st_3 from statictext within w_gteacr030
end type
type st_2 from statictext within w_gteacr030
end type
type dw_1 from datawindow within w_gteacr030
end type
end forward

global type w_gteacr030 from window
integer width = 3831
integer height = 2340
boolean titlebar = true
string title = "(W_Gteacr004) Journal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
dp_1 dp_1
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_2 st_2
dw_1 dw_1
end type
global w_gteacr030 w_gteacr030

type variables
string ls_co_cd
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

on w_gteacr030.create
this.dp_2=create dp_2
this.dp_1=create dp_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.dp_1,&
this.cb_2,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.dw_1}
end on

on w_gteacr030.destroy
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

end event

type dp_2 from datepicker within w_gteacr030
integer x = 1120
integer y = 8
integer width = 357
integer height = 100
integer taborder = 70
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-04"), Time("16:26:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteacr030
integer x = 562
integer y = 8
integer width = 352
integer height = 100
integer taborder = 60
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-04"), Time("16:26:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_2 from commandbutton within w_gteacr030
integer x = 1833
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacr030
integer x = 1568
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
string text = "Ok"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

if  len(trim(dp_1.text)) = 0 or isnull(dp_1.text) then
	messagebox ('From date is blank','please Enter the from date.')
	return 1
end if;

if  len(trim(dp_2.text)) = 0 or isnull(dp_2.text) then
	messagebox ('To date is blank','please Enter the To date.')
	return 1
end if;
	
if  date(dp_2.text) < date(dp_1.text) then
	messagebox ('Enter the correct To Date','To Date cannot be less than from date.')
	return 1
end if;

dw_1.retrieve(dp_1.text,dp_2.text,'1');
end event

type st_3 from statictext within w_gteacr030
integer x = 983
integer y = 24
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteacr030
integer x = 46
integer y = 24
integer width = 507
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From (dd/mm/yyyy):"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr030
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3712
integer height = 2020
string dataobject = "dw_gteacr030"
boolean hscrollbar = true
boolean vscrollbar = true
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

