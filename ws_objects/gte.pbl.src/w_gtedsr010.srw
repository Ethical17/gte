$PBExportHeader$w_gtedsr010.srw
forward
global type w_gtedsr010 from window
end type
type sle_1 from singlelineedit within w_gtedsr010
end type
type st_3 from statictext within w_gtedsr010
end type
type dp_1 from datepicker within w_gtedsr010
end type
type st_1 from statictext within w_gtedsr010
end type
type cb_1 from commandbutton within w_gtedsr010
end type
type cb_2 from commandbutton within w_gtedsr010
end type
type dw_1 from datawindow within w_gtedsr010
end type
end forward

global type w_gtedsr010 from window
integer width = 4023
integer height = 2300
boolean titlebar = true
string title = "(Gtedsr010) - Tasting Sample Labels"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
sle_1 sle_1
st_3 st_3
dp_1 dp_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtedsr010 w_gtedsr010

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

on w_gtedsr010.create
this.sle_1=create sle_1
this.st_3=create st_3
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.st_3,&
this.dp_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtedsr010.destroy
destroy(this.sle_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
sle_1.text = 'ALL'
end event

type sle_1 from singlelineedit within w_gtedsr010
integer x = 1189
integer y = 16
integer width = 411
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtedsr010
integer x = 5
integer y = 28
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtedsr010
integer x = 503
integer y = 16
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2017-02-16"), Time("17:33:36.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtedsr010
integer x = 887
integer y = 32
integer width = 352
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Invoice No:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtedsr010
integer x = 1632
integer y = 16
integer width = 265
integer height = 100
integer taborder = 10
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
	messagebox('Warning','Please Enter/Select a Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','Date Should Be <= Current Date  !!!')
	return 1
end if


if isnull(sle_1.text) or len(sle_1.text) = 0 then
	messagebox('Warning','Please Enter Invoice No !!!')
	return 
end if

dw_1.retrieve(trim(sle_1.text), string(dp_1.value,'dd/mm/yyyy'))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtedsr010
integer x = 1897
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
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

type dw_1 from datawindow within w_gtedsr010
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3973
integer height = 2056
string dataobject = "dw_gtedsr010"
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

