$PBExportHeader$w_gteacr020.srw
forward
global type w_gteacr020 from window
end type
type ddlb_2 from dropdownlistbox within w_gteacr020
end type
type dp_2 from datepicker within w_gteacr020
end type
type dp_1 from datepicker within w_gteacr020
end type
type st_3 from statictext within w_gteacr020
end type
type st_1 from statictext within w_gteacr020
end type
type cb_1 from commandbutton within w_gteacr020
end type
type cb_2 from commandbutton within w_gteacr020
end type
type st_2 from statictext within w_gteacr020
end type
type dw_1 from datawindow within w_gteacr020
end type
end forward

global type w_gteacr020 from window
integer width = 3845
integer height = 2292
boolean titlebar = true
string title = "(Gtelacr020) - Bill Detail"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_2 ddlb_2
dp_2 dp_2
dp_1 dp_1
st_3 st_3
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gteacr020 w_gteacr020

type variables
n_cst_powerfilter iu_powerfilter
string ls_billty
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

on w_gteacr020.create
this.ddlb_2=create ddlb_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_2,&
this.dp_2,&
this.dp_1,&
this.st_3,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gteacr020.destroy
destroy(this.ddlb_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

end event

type ddlb_2 from dropdownlistbox within w_gteacr020
integer x = 1911
integer y = 20
integer width = 672
integer height = 608
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
string item[] = {"Green Leaf","Local Purchase","HO Purchase","Hired Vehicles"}
end type

type dp_2 from datepicker within w_gteacr020
integer x = 1262
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-08-26"), Time("16:57:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;string ls_frdt,ls_todt
long ll_pbno

ls_frdt = dp_1.text
ls_todt = dp_2.text

setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('0')

declare c2 cursor for
select distinct ls_id
 from FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b 
 where  b.LABOUR_ID = a.emp_ID AND trunc(b.LDA_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '0'
setpointer(arrow!)
end event

type dp_1 from datepicker within w_gteacr020
integer x = 649
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-08-26"), Time("16:57:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;string ls_frdt,ls_todt
long ll_pbno

ls_frdt = dp_1.text
ls_todt = dp_2.text

setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('0')

declare c2 cursor for
select distinct ls_id
 from FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b 
 where  b.LABOUR_ID = a.emp_ID AND trunc(b.LDA_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '0'
setpointer(arrow!)
end event

type st_3 from statictext within w_gteacr020
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

type st_1 from statictext within w_gteacr020
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

type cb_1 from commandbutton within w_gteacr020
integer x = 2597
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
	messagebox('Alert!','Please Select A Bill Type !!!')
	return 1
end if

if ddlb_2.text = 'Green Leaf' then
	ls_billty = 'GREENLEAF'
elseif ddlb_2.text = 'Local Purchase' then
	ls_billty = 'LOCALPURC'
elseif ddlb_2.text = 'HO Purchase' then
	ls_billty = 'HOPURC'
elseif ddlb_2.text = 'Hired Vehicles' then
	ls_billty = 'HRVEHICLE'
end if

dw_1.retrieve(dp_1.text,dp_2.text,ls_billty)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gteacr020
integer x = 2862
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

type st_2 from statictext within w_gteacr020
integer x = 1664
integer y = 32
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bill Type"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr020
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3767
integer height = 2056
string dataobject = "dw_gteacr020"
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

