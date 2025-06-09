$PBExportHeader$w_gtelar050.srw
forward
global type w_gtelar050 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelar050
end type
type st_4 from statictext within w_gtelar050
end type
type dp_2 from datepicker within w_gtelar050
end type
type st_1 from statictext within w_gtelar050
end type
type dp_1 from datepicker within w_gtelar050
end type
type st_3 from statictext within w_gtelar050
end type
type cb_2 from commandbutton within w_gtelar050
end type
type cb_1 from commandbutton within w_gtelar050
end type
type dw_1 from datawindow within w_gtelar050
end type
end forward

global type w_gtelar050 from window
integer width = 4087
integer height = 2552
boolean titlebar = true
string title = "(w_gtelar050) - PF ECR"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_4 st_4
dp_2 dp_2
st_1 st_1
dp_1 dp_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelar050 w_gtelar050

type variables
long ll_yrmn
string ls_temp, ls_division,ls_gpf
n_cst_powerfilter iu_powerfilter
datetime ld_frdt, ld_todt
end variables

event ue_option();	choose case gs_ueoption
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

on w_gtelar050.create
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.dp_2=create dp_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_4,&
this.dp_2,&
this.st_1,&
this.dp_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelar050.destroy
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.dp_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")



select nvl(UNIT_PFACCD,'x') into :ls_gpf from fb_gardenmaster where UNIT_SHORTNAME = :gs_garden_snm; 

setpointer(hourglass!)

ddlb_1.reset()

declare c2 cursor for
select distinct decode(nvl(FIELD_PFACCD,'x'),'x','Other ('||:ls_gpf||')',FIELD_NAME||' ('||FIELD_PFACCD||')') from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if
setpointer(arrow!)

end event

type ddlb_1 from dropdownlistbox within w_gtelar050
integer x = 1957
integer y = 24
integer width = 1266
integer height = 608
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type st_4 from statictext within w_gtelar050
integer x = 1737
integer y = 36
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
string text = "PF Code"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar050
integer x = 1344
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2017-03-22"), Time("09:14:12.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar050
integer x = 1134
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

type dp_1 from datepicker within w_gtelar050
integer x = 645
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2017-03-22"), Time("09:14:12.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelar050
integer x = 23
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

type cb_2 from commandbutton within w_gtelar050
integer x = 3502
integer y = 16
integer width = 265
integer height = 100
integer taborder = 60
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

type cb_1 from commandbutton within w_gtelar050
integer x = 3237
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
string text = "&Run"
boolean default = true
end type

event clicked;string ls_gapf

dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select PF Code !!!')
	return 
end if

select UNIT_PFACCD  into :ls_gapf  from fb_gardenmaster where UNIT_ACTIVE_IND = 'Y';


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

ld_frdt = dp_1.value
ld_todt = dp_2.value

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = trunc(:ld_frdt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid From Date, Should Be Start Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_ENDDATE) = trunc(:ld_todt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid To Date, Should Be End Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

dw_1.retrieve(dp_1.text,dp_2.text,gs_garden_snm,left(right(ddlb_1.text,11),10),ls_gapf)		

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)
end event

type dw_1 from datawindow within w_gtelar050
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 4041
integer height = 1916
integer taborder = 50
string dataobject = "dw_gtelar050"
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

