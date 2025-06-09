$PBExportHeader$w_gtelar033.srw
forward
global type w_gtelar033 from window
end type
type rb_2 from radiobutton within w_gtelar033
end type
type rb_1 from radiobutton within w_gtelar033
end type
type ddlb_1 from dropdownlistbox within w_gtelar033
end type
type st_4 from statictext within w_gtelar033
end type
type em_1 from editmask within w_gtelar033
end type
type st_2 from statictext within w_gtelar033
end type
type dp_2 from datepicker within w_gtelar033
end type
type st_1 from statictext within w_gtelar033
end type
type dp_1 from datepicker within w_gtelar033
end type
type st_3 from statictext within w_gtelar033
end type
type cb_2 from commandbutton within w_gtelar033
end type
type cb_1 from commandbutton within w_gtelar033
end type
type gb_1 from groupbox within w_gtelar033
end type
type dw_4 from datawindow within w_gtelar033
end type
type dw_3 from datawindow within w_gtelar033
end type
type dw_2 from datawindow within w_gtelar033
end type
type dw_1 from datawindow within w_gtelar033
end type
end forward

global type w_gtelar033 from window
integer width = 4146
integer height = 2552
boolean titlebar = true
string title = "(w_gtelar033) - PF ECR"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_2 rb_2
rb_1 rb_1
ddlb_1 ddlb_1
st_4 st_4
em_1 em_1
st_2 st_2
dp_2 dp_2
st_1 st_1
dp_1 dp_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_gtelar033 w_gtelar033

type variables
long ll_yrmn
string ls_temp, ls_division,ls_gpf
n_cst_powerfilter iu_powerfilter
datetime ld_frdt, ld_todt
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
elseif dw_3.visible = true then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_3)
		case "PRINTPREVIEW"
				this.dw_3.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_3.modify("datawindow.print.preview = no")
		case "ZOOM"
				SetPointer (HourGlass!)											
				OpenwithParm (w_zoom,dw_3)
				SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_3.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_3.setredraw(false)
				this.dw_3.setfilter(gs_filtertext)
				this.dw_3.filter()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_3.setredraw(false)
				this.dw_3.setsort(gs_sorttext)
				this.dw_3.sort()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
elseif dw_4.visible = true then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_4)
		case "PRINTPREVIEW"
				this.dw_4.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_4.modify("datawindow.print.preview = no")
		case "ZOOM"
				SetPointer (HourGlass!)											
				OpenwithParm (w_zoom,dw_4)
				SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_4.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_4.setredraw(false)
				this.dw_4.setfilter(gs_filtertext)
				this.dw_4.filter()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_4.setredraw(false)
				this.dw_4.setsort(gs_sorttext)
				this.dw_4.sort()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
//elseif dw_5.visible = true then
//	choose case gs_ueoption
//		case "PRINT"
//				OpenWithParm(w_print,this.dw_5)
//		case "PRINTPREVIEW"
//				this.dw_5.modify("datawindow.print.preview = yes")
//		case "RESETPREVIEW"
//				this.dw_5.modify("datawindow.print.preview = no")
//		case "ZOOM"
//				SetPointer (HourGlass!)											
//				OpenwithParm (w_zoom,dw_5)
//				SetPointer (Arrow!)						
//		case "SAVEAS"
//				this.dw_5.saveas()
//		case "SFILTER"
//				iu_powerfilter.checked = NOT iu_powerfilter.checked
//				iu_powerfilter.event ue_clicked()
//				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
//		case "FILTER"
//				setnull(gs_filtertext)
//				this.dw_5.setredraw(false)
//				this.dw_5.setfilter(gs_filtertext)
//				this.dw_5.filter()
//				this.dw_5.groupcalc()
//				if this.dw_5.rowcount() > 0 then;
//					this.dw_5.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//		case "SORT"
//				setnull(gs_sorttext)
//				this.dw_5.setredraw(false)
//				this.dw_5.setsort(gs_sorttext)
//				this.dw_5.sort()
//				this.dw_5.groupcalc()
//				if this.dw_5.rowcount() > 0 then;
//					this.dw_5.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//	end choose	
//elseif dw_6.visible = true then
//	choose case gs_ueoption
//		case "PRINT"
//				OpenWithParm(w_print,this.dw_6)
//		case "PRINTPREVIEW"
//				this.dw_6.modify("datawindow.print.preview = yes")
//		case "RESETPREVIEW"
//				this.dw_6.modify("datawindow.print.preview = no")
//		case "ZOOM"
//				SetPointer (HourGlass!)											
//				OpenwithParm (w_zoom,dw_6)
//				SetPointer (Arrow!)						
//		case "SAVEAS"
//				this.dw_6.saveas()
//		case "SFILTER"
//				iu_powerfilter.checked = NOT iu_powerfilter.checked
//				iu_powerfilter.event ue_clicked()
//				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
//		case "FILTER"
//				setnull(gs_filtertext)
//				this.dw_6.setredraw(false)
//				this.dw_6.setfilter(gs_filtertext)
//				this.dw_6.filter()
//				this.dw_6.groupcalc()
//				if this.dw_6.rowcount() > 0 then;
//					this.dw_6.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//		case "SORT"
//				setnull(gs_sorttext)
//				this.dw_6.setredraw(false)
//				this.dw_6.setsort(gs_sorttext)
//				this.dw_6.sort()
//				this.dw_6.groupcalc()
//				if this.dw_6.rowcount() > 0 then;
//					this.dw_6.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//	end choose	
end if
end event

on w_gtelar033.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.em_1=create em_1
this.st_2=create st_2
this.dp_2=create dp_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.ddlb_1,&
this.st_4,&
this.em_1,&
this.st_2,&
this.dp_2,&
this.st_1,&
this.dp_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on w_gtelar033.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_3.modify("t_co.text = '"+gs_co_name+"'")
dw_3.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_4.modify("t_co.text = '"+gs_co_name+"'")
dw_4.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
//dw_5.modify("t_co.text = '"+gs_co_name+"'")
//dw_5.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
//dw_6.modify("t_co.text = '"+gs_co_name+"'")
//dw_6.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


//	if gs_garden_state = '03' and (gs_garden_snm <> 'PC'  and gs_garden_snm <> 'JP') then
//		dw_2.visible = true
//		dw_1.visible = false
//		dw_3.visible = false
//		dw_4.visible = false	
////		dw_5.visible = false		
////		dw_6.visible = false
//	elseif gs_garden_state = '03' and (gs_garden_snm = 'PC'  or gs_garden_snm = 'JP') then
//		dw_3.visible = true
//		dw_1.visible = false
//		dw_2.visible = false
//		dw_4.visible = false	
////		dw_5.visible = false		
////		dw_6.visible = false
//	else
		if rb_1.checked then
			dw_1.visible = true
			dw_2.visible = false
			dw_3.visible = false
			dw_4.visible = false
		else
			dw_4.visible = true
			dw_2.visible = false
			dw_3.visible = false
			dw_1.visible = false			
		end if
//		dw_2.visible = false
//		dw_3.visible = false		
////		dw_5.visible = false		
////		dw_6.visible = false
//	end if
//elseif rb_2.checked then	
//	if gs_garden_state = '03' and (gs_garden_snm <> 'PC'  and gs_garden_snm <> 'JP') then
//		dw_5.visible = true
//		dw_1.visible = false
//		dw_3.visible = false
//		dw_4.visible = false	
//		dw_2.visible = false		
//		dw_6.visible = false
//	elseif gs_garden_state = '03' and (gs_garden_snm = 'PC'  or gs_garden_snm = 'JP') then
//		dw_6.visible = true
//		dw_1.visible = false
//		dw_2.visible = false
//		dw_3.visible = false	
//		dw_5.visible = false		
//		dw_4.visible = false
//	else
//		dw_4.visible = true
//		dw_1.visible = false
//		dw_2.visible = false
//		dw_3.visible = false
//		dw_5.visible = false		
//		dw_6.visible = false
//	end if
//end if


em_1.text = string(today())

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

type rb_2 from radiobutton within w_gtelar033
integer x = 2939
integer y = 132
integer width = 832
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "New Logic (September onwrds)"
boolean checked = true
end type

type rb_1 from radiobutton within w_gtelar033
integer x = 2560
integer y = 132
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Old Logic"
end type

type ddlb_1 from dropdownlistbox within w_gtelar033
integer x = 247
integer y = 132
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

type st_4 from statictext within w_gtelar033
integer x = 27
integer y = 144
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

type em_1 from editmask within w_gtelar033
integer x = 2510
integer y = 16
integer width = 215
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type st_2 from statictext within w_gtelar033
integer x = 1838
integer y = 32
integer width = 649
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "For Employee Year Month"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar033
integer x = 1344
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-11"), Time("10:54:30.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar033
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

type dp_1 from datepicker within w_gtelar033
integer x = 645
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-11"), Time("10:54:30.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelar033
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

type cb_2 from commandbutton within w_gtelar033
integer x = 1792
integer y = 124
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

type cb_1 from commandbutton within w_gtelar033
integer x = 1527
integer y = 124
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
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

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

if isnull(em_1.text) or em_1.text = '000000' or len(em_1.text) = 0 then
	messagebox('Alert!','Please Enter Year Month !!!')
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
//if gs_garden_state = '03'  and (gs_garden_snm <> 'PC'  and gs_garden_snm <> 'JP') then
//	dw_1.visible = false
//	dw_3.visible = false
//	dw_4.visible = false
////	dw_5.visible = false
////	dw_6.visible = false
//	dw_2.visible = true
//	dw_2.retrieve(dp_1.text,dp_2.text,gs_garden_snm,long(em_1.text), left(right(ddlb_1.text,11),10),ls_gapf)
//elseif gs_garden_state = '03'  and (gs_garden_snm = 'PC'  or gs_garden_snm = 'JP') then
//	dw_1.visible = false
//	dw_2.visible = false
//	dw_4.visible = false
////	dw_5.visible = false
////	dw_6.visible = false
//	dw_3.visible = true
//	dw_3.retrieve(dp_1.text,dp_2.text,gs_garden_snm,long(em_1.text), left(right(ddlb_1.text,11),10),ls_gapf)	
//else
//	dw_2.visible = false
//	dw_3.visible = false
//	dw_4.visible = false
//	dw_5.visible = false
//	dw_6.visible = false
	if rb_1.checked then
		dw_4.visible = false
		dw_1.visible = true	
		dw_1.retrieve(dp_1.text,dp_2.text,gs_garden_snm,long(em_1.text), left(right(ddlb_1.text,11),10),ls_gapf)
	else
		dw_1.visible = false
		dw_4.visible = true	
		dw_4.retrieve(dp_1.text,dp_2.text,gs_garden_snm,long(em_1.text), left(right(ddlb_1.text,11),10),ls_gapf)		
	end if
//end if

if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 and dw_3.rowcount() = 0 and dw_4.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)
end event

type gb_1 from groupbox within w_gtelar033
integer x = 2542
integer y = 96
integer width = 1257
integer height = 132
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_4 from datawindow within w_gtelar033
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 232
integer width = 4041
integer height = 1916
integer taborder = 50
string dataobject = "dw_gtelar033d"
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

type dw_3 from datawindow within w_gtelar033
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 232
integer width = 3822
integer height = 1916
integer taborder = 60
string dataobject = "dw_gtelar033b"
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

type dw_2 from datawindow within w_gtelar033
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 232
integer width = 3822
integer height = 1916
integer taborder = 50
string dataobject = "dw_gtelar033a"
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

type dw_1 from datawindow within w_gtelar033
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 232
integer width = 4055
integer height = 1916
string dataobject = "dw_gtelar033"
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

