$PBExportHeader$w_gtelar042.srw
forward
global type w_gtelar042 from window
end type
type st_2 from statictext within w_gtelar042
end type
type ddlb_2 from dropdownlistbox within w_gtelar042
end type
type dp_2 from datepicker within w_gtelar042
end type
type dp_1 from datepicker within w_gtelar042
end type
type st_3 from statictext within w_gtelar042
end type
type st_1 from statictext within w_gtelar042
end type
type cb_1 from commandbutton within w_gtelar042
end type
type cb_2 from commandbutton within w_gtelar042
end type
type dw_1 from datawindow within w_gtelar042
end type
end forward

global type w_gtelar042 from window
integer width = 3954
integer height = 2292
boolean titlebar = true
string title = "(Gtelar042) - Labour Absentism Percentage"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
ddlb_2 ddlb_2
dp_2 dp_2
dp_1 dp_1
st_3 st_3
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar042 w_gtelar042

type variables
n_cst_powerfilter iu_powerfilter
string ls_division
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

on w_gtelar042.create
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.ddlb_2,&
this.dp_2,&
this.dp_1,&
this.st_3,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtelar042.destroy
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

ddlb_2.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

setpointer(arrow!)
end event

type st_2 from statictext within w_gtelar042
integer x = 1655
integer y = 40
integer width = 206
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtelar042
integer x = 1865
integer y = 24
integer width = 699
integer height = 564
integer taborder = 30
integer textsize = -9
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

type dp_2 from datepicker within w_gtelar042
integer x = 1262
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-01-17"), Time("09:57:39.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtelar042
integer x = 649
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-01-17"), Time("09:57:39.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelar042
integer x = 9
integer y = 32
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar042
integer x = 1033
integer y = 32
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar042
integer x = 2578
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
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

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

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Select Division !!!')
	return 
end if

ls_division = left(right(ddlb_2.text,6),5)

dw_1.retrieve(dp_1.text,dp_2.text,ls_division)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtelar042
integer x = 2843
integer y = 16
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

type dw_1 from datawindow within w_gtelar042
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3685
integer height = 2056
string dataobject = "dw_gtelar042"
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

