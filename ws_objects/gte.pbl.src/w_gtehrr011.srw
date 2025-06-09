$PBExportHeader$w_gtehrr011.srw
forward
global type w_gtehrr011 from window
end type
type st_2 from statictext within w_gtehrr011
end type
type dp_2 from datepicker within w_gtehrr011
end type
type dp_1 from datepicker within w_gtehrr011
end type
type st_3 from statictext within w_gtehrr011
end type
type ddlb_1 from dropdownlistbox within w_gtehrr011
end type
type st_1 from statictext within w_gtehrr011
end type
type cb_2 from commandbutton within w_gtehrr011
end type
type cb_4 from commandbutton within w_gtehrr011
end type
type dw_1 from datawindow within w_gtehrr011
end type
end forward

global type w_gtehrr011 from window
integer width = 3749
integer height = 2736
boolean titlebar = true
string title = "(w_gtehrr011) Employee Wise Attandance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
dp_2 dp_2
dp_1 dp_1
st_3 st_3
ddlb_1 ddlb_1
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtehrr011 w_gtehrr011

type variables
boolean lb_neworder, lb_query
string ls_rundt,ls_temp,ls_emp
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtehrr011.create
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.dp_2,&
this.dp_1,&
this.st_3,&
this.ddlb_1,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtehrr011.destroy
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

lb_neworder = false

setpointer(hourglass!)
ddlb_1.reset()
ddlb_1.additem('ALL')

declare c1 cursor for
	 
select distinct decode(EMP_TYPE,'SS','Sub Staff','ST','Staff','AT','Apperentice') emp_type from fb_employee
order by 1 desc;		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if

ddlb_1.text = 'ALL'
setpointer(arrow!)



end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_2 from statictext within w_gtehrr011
integer x = 1056
integer y = 24
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

type dp_2 from datepicker within w_gtehrr011
integer x = 1307
integer y = 12
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-29"), Time("09:28:08.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtehrr011
integer x = 672
integer y = 12
integer width = 370
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-29"), Time("09:28:08.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtehrr011
integer x = 32
integer y = 24
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

type ddlb_1 from dropdownlistbox within w_gtehrr011
integer x = 2126
integer y = 20
integer width = 677
integer height = 508
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"","","",""}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gtehrr011
integer x = 1701
integer y = 28
integer width = 411
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtehrr011
integer x = 2825
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)

if isnull(ddlb_1.text) or len(trim(ddlb_1.text)) = 0 then
	messagebox('Warning','Please Select Employee Type !!!')
	return 1
end if	

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

//if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
//	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
//	return 1
//end if

//if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
//	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
//	return 1
//end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

setpointer(hourglass!)

if ddlb_1.text = 'Sub Staff' then
    ls_emp = 'SS'
elseif ddlb_1.text = 'Staff' then
	ls_emp ='ST'
elseif ddlb_1.text = 'Apperentice' then
	ls_emp ='AT'
elseif 	ddlb_1.text = 'ALL' then
	ls_emp ='ALL'
end if

dw_1.retrieve(dp_1.text,dp_2.text,ls_emp)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
setpointer(arrow!)
end event

type cb_4 from commandbutton within w_gtehrr011
integer x = 3095
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
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

type dw_1 from datawindow within w_gtehrr011
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 120
integer width = 3671
integer height = 1936
string dataobject = "dw_gtehrr011"
boolean vscrollbar = true
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

