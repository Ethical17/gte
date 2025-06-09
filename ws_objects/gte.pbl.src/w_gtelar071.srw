$PBExportHeader$w_gtelar071.srw
forward
global type w_gtelar071 from window
end type
type dw_2 from datawindow within w_gtelar071
end type
type rb_1 from radiobutton within w_gtelar071
end type
type rb_2 from radiobutton within w_gtelar071
end type
type st_3 from statictext within w_gtelar071
end type
type dp_1 from datepicker within w_gtelar071
end type
type st_1 from statictext within w_gtelar071
end type
type dp_2 from datepicker within w_gtelar071
end type
type cb_1 from commandbutton within w_gtelar071
end type
type cb_2 from commandbutton within w_gtelar071
end type
type dw_1 from datawindow within w_gtelar071
end type
type gb_1 from groupbox within w_gtelar071
end type
end forward

global type w_gtelar071 from window
integer width = 3790
integer height = 2604
boolean titlebar = true
string title = "(Gtelar071) - LPG Issue Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_2 dw_2
rb_1 rb_1
rb_2 rb_2
st_3 st_3
dp_1 dp_1
st_1 st_1
dp_2 dp_2
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelar071 w_gtelar071

type variables
long ll_pbno
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour
datetime ld_dt
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if rb_1.checked then
	choose case gs_ueoption
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
elseif rb_2.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
		case "ZOOM"
				SetPointer (HourGlass!)											
				OpenwithParm (w_zoom,dw_2)
				SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
end if

end event

on w_gtelar071.create
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_3=create st_3
this.dp_1=create dp_1
this.st_1=create st_1
this.dp_2=create dp_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.rb_1,&
this.rb_2,&
this.st_3,&
this.dp_1,&
this.st_1,&
this.dp_2,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_gtelar071.destroy
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.dp_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

end event

type dw_2 from datawindow within w_gtelar071
integer x = 18
integer y = 124
integer width = 3333
integer height = 2372
integer taborder = 50
string title = "Summary"
string dataobject = "dw_gtelar071a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_gtelar071
integer x = 55
integer y = 36
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_1.show()
dw_2.hide()
end event

type rb_2 from radiobutton within w_gtelar071
integer x = 334
integer y = 36
integer width = 311
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;dw_2.show()
dw_1.hide()
end event

type st_3 from statictext within w_gtelar071
integer x = 709
integer y = 32
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelar071
integer x = 1367
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-11-16"), Time("14:30:00.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar071
integer x = 1751
integer y = 32
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar071
integer x = 1993
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-11-16"), Time("14:30:00.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_1 from commandbutton within w_gtelar071
integer x = 2405
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
string text = "&Run"
boolean default = true
end type

event clicked;string ls_start_dt, ls_end_dt
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if



setpointer(hourglass!)

if rb_1.checked then
	dw_1.show()
	dw_2.hide()
	dw_1.retrieve(dp_1.text, dp_2.text)

	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(Arrow!)
		return 1
	end if
elseif  rb_2.checked then
	dw_2.show()
	dw_1.hide()
	dw_2.retrieve(dp_1.text, dp_2.text)

	if dw_2.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(Arrow!)
		return 1
	end if
end if

end event

type cb_2 from commandbutton within w_gtelar071
integer x = 2670
integer y = 16
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

type dw_1 from datawindow within w_gtelar071
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 18
integer y = 124
integer width = 3333
integer height = 2372
string title = "Detail"
string dataobject = "dw_gtelar071"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type gb_1 from groupbox within w_gtelar071
integer x = 37
integer width = 608
integer height = 124
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

