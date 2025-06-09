$PBExportHeader$w_gtedsr012.srw
forward
global type w_gtedsr012 from window
end type
type cb_3 from commandbutton within w_gtedsr012
end type
type dp_2 from datepicker within w_gtedsr012
end type
type st_5 from statictext within w_gtedsr012
end type
type dp_1 from datepicker within w_gtedsr012
end type
type st_3 from statictext within w_gtedsr012
end type
type cb_1 from commandbutton within w_gtedsr012
end type
type cb_2 from commandbutton within w_gtedsr012
end type
type dw_1 from datawindow within w_gtedsr012
end type
end forward

global type w_gtedsr012 from window
integer width = 5129
integer height = 2360
boolean titlebar = true
string title = "(Gtedsr012) - Tax Invoice Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
dp_2 dp_2
st_5 st_5
dp_1 dp_1
st_3 st_3
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtedsr012 w_gtedsr012

type variables
string ls_brok, ls_brokid, ls_unit, ls_unitnm, ls_filename, ls_filename2
long ll_return, ll_return2
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

on w_gtedsr012.create
this.cb_3=create cb_3
this.dp_2=create dp_2
this.st_5=create st_5
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.dp_2,&
this.st_5,&
this.dp_1,&
this.st_3,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtedsr012.destroy
destroy(this.cb_3)
destroy(this.dp_2)
destroy(this.st_5)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))



end event

type cb_3 from commandbutton within w_gtedsr012
integer x = 1902
integer width = 347
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Make CSV"
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

dw_1.retrieve(dp_1.text,dp_2.text)

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found, Please Check !!!')
	return 1
end if

ls_filename = "C:\temp\taxinvdetails_"+gs_garden_snm+"_"+string(today(), 'ddmmyyyy')+".csv"

ls_filename2 = "C:\temp\taxinvdetails_"+gs_garden_snm+"_"+string(today(), 'ddmmyyyy')+".pdf"

ll_return  = dw_1.saveas(ls_filename, CSV!, true)

ll_return2 = dw_1.saveas(ls_filename2, PDF!, true)

if ll_return = 1 and ll_return2 = 1 then
	messagebox('Success', 'CSV and PDF has been generated. File Location : '+ls_filename+", "+ls_filename2)
elseif ll_return = -1 then
	messagebox('Error occured', 'File not generated')
	return 1
end if





end event

type dp_2 from datepicker within w_gtedsr012
integer x = 832
integer y = 4
integer width = 370
integer height = 100
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-07-29"), Time("09:02:01.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_5 from statictext within w_gtedsr012
integer x = 718
integer y = 16
integer width = 110
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To :"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtedsr012
integer x = 329
integer y = 4
integer width = 370
integer height = 100
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-07-29"), Time("09:02:01.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtedsr012
integer x = 23
integer y = 16
integer width = 334
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date From : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtedsr012
integer x = 1253
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

dw_1.retrieve(dp_1.text,dp_2.text)

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found, Please Check !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtedsr012
integer x = 1518
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

type dw_1 from datawindow within w_gtedsr012
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 112
integer width = 5065
integer height = 2056
string dataobject = "dw_gtedsr012"
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

