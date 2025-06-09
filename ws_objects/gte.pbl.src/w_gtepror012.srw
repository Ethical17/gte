$PBExportHeader$w_gtepror012.srw
forward
global type w_gtepror012 from window
end type
type cb_1 from commandbutton within w_gtepror012
end type
type st_3 from statictext within w_gtepror012
end type
type dp_1 from datepicker within w_gtepror012
end type
type cb_2 from commandbutton within w_gtepror012
end type
type dw_1 from datawindow within w_gtepror012
end type
end forward

global type w_gtepror012 from window
integer width = 3483
integer height = 2296
boolean titlebar = true
string title = "(Gtepror012) - Packed stock List"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_1 cb_1
st_3 st_3
dp_1 dp_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtepror012 w_gtepror012

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

on w_gtepror012.create
this.cb_1=create cb_1
this.st_3=create st_3
this.dp_1=create dp_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_3,&
this.dp_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtepror012.destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime(today())

end event

type cb_1 from commandbutton within w_gtepror012
integer x = 768
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

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter As on Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','As On Date Should Be <= Current Date  !!!')
	return 1
end if


dw_1.retrieve(dp_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found  !!!')
	return 1
end if
end event

type st_3 from statictext within w_gtepror012
integer y = 32
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As On Date : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtepror012
integer x = 347
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-20"), Time("23:05:27.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_2 from commandbutton within w_gtepror012
integer x = 1042
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

type dw_1 from datawindow within w_gtepror012
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3438
integer height = 2056
string dataobject = "dw_gtepror012"
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

