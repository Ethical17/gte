$PBExportHeader$w_gtelar020.srw
forward
global type w_gtelar020 from window
end type
type ddlb_2 from dropdownlistbox within w_gtelar020
end type
type st_5 from statictext within w_gtelar020
end type
type st_4 from statictext within w_gtelar020
end type
type em_1 from editmask within w_gtelar020
end type
type st_2 from statictext within w_gtelar020
end type
type ddlb_1 from dropdownlistbox within w_gtelar020
end type
type st_3 from statictext within w_gtelar020
end type
type dp_1 from datepicker within w_gtelar020
end type
type st_1 from statictext within w_gtelar020
end type
type dp_2 from datepicker within w_gtelar020
end type
type cb_2 from commandbutton within w_gtelar020
end type
type cb_1 from commandbutton within w_gtelar020
end type
type dw_1 from datawindow within w_gtelar020
end type
type dw_2 from datawindow within w_gtelar020
end type
end forward

global type w_gtelar020 from window
integer width = 4997
integer height = 2292
boolean titlebar = true
string title = "(Gtelar020) - Annual PF"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_2 ddlb_2
st_5 st_5
st_4 st_4
em_1 em_1
st_2 st_2
ddlb_1 ddlb_1
st_3 st_3
dp_1 dp_1
st_1 st_1
dp_2 dp_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelar020 w_gtelar020

type variables
n_cst_powerfilter iu_powerfilter
string ls_active_ind
end variables

event ue_option();if dw_1.visible = true then
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
elseif dw_2.visible = true then
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

on w_gtelar020.create
this.ddlb_2=create ddlb_2
this.st_5=create st_5
this.st_4=create st_4
this.em_1=create em_1
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.dp_1=create dp_1
this.st_1=create st_1
this.dp_2=create dp_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.ddlb_2,&
this.st_5,&
this.st_4,&
this.em_1,&
this.st_2,&
this.ddlb_1,&
this.st_3,&
this.dp_1,&
this.st_1,&
this.dp_2,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtelar020.destroy
destroy(this.ddlb_2)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.dp_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
ddlb_1.text = 'ALL'
ddlb_2.text = 'ALL'

if gs_garden_snm <> 'NP'  then
	dw_2.visible = false
	dw_1.visible = true
	st_4.visible = false
	em_1.visible = false	
elseif gs_garden_snm = 'NP'then
	dw_1.visible = false
	dw_2.visible = true
	st_4.visible = true
	em_1.visible = true
end if

end event

type ddlb_2 from dropdownlistbox within w_gtelar020
integer x = 2889
integer y = 20
integer width = 471
integer height = 376
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"ALL","Active","Inactive"}
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_gtelar020
integer x = 2533
integer y = 32
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active Status"
boolean focusrectangle = false
end type

type st_4 from statictext within w_gtelar020
integer x = 3415
integer y = 28
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Interest Rate"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar020
integer x = 3753
integer y = 20
integer width = 178
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtelar020
integer x = 1691
integer y = 28
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emp Status"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar020
integer x = 1998
integer y = 20
integer width = 503
integer height = 588
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"ALL","Regular","Retired","Resigned","NameOut","Expired","Transfer"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtelar020
integer x = 18
integer y = 28
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

type dp_1 from datepicker within w_gtelar020
integer x = 677
integer y = 16
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-03-16"), Time("18:02:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar020
integer x = 1061
integer y = 28
integer width = 229
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

type dp_2 from datepicker within w_gtelar020
integer x = 1303
integer y = 16
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-03-16"), Time("18:02:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_2 from commandbutton within w_gtelar020
integer x = 4206
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

type cb_1 from commandbutton within w_gtelar020
integer x = 3941
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
dw_2.settransobject(sqlca)

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

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Alert!','Please Select A Employee Status !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Alert!','Please Select A Active Status !!!')
	return 1
end if

if ddlb_2.text = 'ALL' then
	ls_active_ind = 'ALL'
elseif ddlb_2.text = 'Active' then
	ls_active_ind = '1'
elseif ddlb_2.text = 'Inactive' then
	ls_active_ind = '0'
end if	

if gs_garden_snm <> 'NP'  then
	dw_2.visible = false
	dw_1.visible = true
	dw_1.retrieve(dp_1.text,dp_2.text,ddlb_1.text,ls_active_ind)
elseif gs_garden_snm = 'NP' then
	dw_1.visible = false
	dw_2.visible = true
	dw_2.retrieve(dp_1.text,dp_2.text,ddlb_1.text,double(em_1.text),ls_active_ind)
end if

if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gtelar020
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4914
integer height = 2056
string dataobject = "dw_gtelar020"
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

type dw_2 from datawindow within w_gtelar020
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4416
integer height = 2056
integer taborder = 40
string dataobject = "dw_gtelar020_a"
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

