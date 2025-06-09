$PBExportHeader$w_gtelar067.srw
forward
global type w_gtelar067 from window
end type
type em_2 from editmask within w_gtelar067
end type
type st_6 from statictext within w_gtelar067
end type
type cb_3 from commandbutton within w_gtelar067
end type
type ddlb_2 from dropdownlistbox within w_gtelar067
end type
type st_5 from statictext within w_gtelar067
end type
type em_1 from editmask within w_gtelar067
end type
type st_4 from statictext within w_gtelar067
end type
type ddlb_1 from dropdownlistbox within w_gtelar067
end type
type st_2 from statictext within w_gtelar067
end type
type dp_2 from datepicker within w_gtelar067
end type
type st_1 from statictext within w_gtelar067
end type
type dp_1 from datepicker within w_gtelar067
end type
type st_3 from statictext within w_gtelar067
end type
type cb_2 from commandbutton within w_gtelar067
end type
type cb_1 from commandbutton within w_gtelar067
end type
type dw_1 from datawindow within w_gtelar067
end type
end forward

global type w_gtelar067 from window
integer width = 3675
integer height = 2700
boolean titlebar = true
string title = "(Gtelar067) - PF Form 1"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_2 em_2
st_6 st_6
cb_3 cb_3
ddlb_2 ddlb_2
st_5 st_5
em_1 em_1
st_4 st_4
ddlb_1 ddlb_1
st_2 st_2
dp_2 dp_2
st_1 st_1
dp_1 dp_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelar067 w_gtelar067

type variables
long ll_yrmn, ll_ctr, ll_pfno, ll_year_mon
string ls_temp,ls_gpf,ls_division, ls_emp_id, ls_empname
n_cst_powerfilter iu_powerfilter
datetime ld_frdt, ld_todt
double ll_ctot_pf, ll_adv_made, ll_adv_ref, ll_adv_int
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

on w_gtelar067.create
this.em_2=create em_2
this.st_6=create st_6
this.cb_3=create cb_3
this.ddlb_2=create ddlb_2
this.st_5=create st_5
this.em_1=create em_1
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.dp_2=create dp_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_2,&
this.st_6,&
this.cb_3,&
this.ddlb_2,&
this.st_5,&
this.em_1,&
this.st_4,&
this.ddlb_1,&
this.st_2,&
this.dp_2,&
this.st_1,&
this.dp_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelar067.destroy
destroy(this.em_2)
destroy(this.st_6)
destroy(this.cb_3)
destroy(this.ddlb_2)
destroy(this.st_5)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.st_2)
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

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
ddlb_1.text = 'ALL'

select nvl(UNIT_PFACCD,'x') into :ls_gpf from fb_gardenmaster where UNIT_SHORTNAME = :gs_garden_snm; 

setpointer(hourglass!)

ddlb_2.reset()

declare c2 cursor for
select distinct decode(nvl(FIELD_PFACCD,'x'),'x','Other ('||:ls_gpf||')',FIELD_NAME||' ('||FIELD_PFACCD||')') from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

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

type em_2 from editmask within w_gtelar067
integer x = 274
integer y = 124
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
end type

type st_6 from statictext within w_gtelar067
integer x = 23
integer y = 136
integer width = 411
integer height = 64
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PF Year : "
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_gtelar067
integer x = 2217
integer y = 124
integer width = 535
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Confirm and Save"
end type

event clicked;string ls_gapf
long ll_pfyear

dw_1.settransobject(sqlca)

setpointer(hourglass!)

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

if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Alert!','Please Enter Valid Year Month or 000000  !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text = '0000' or len(em_2.text) = 0 then
	messagebox('Alert!','Please Enter Valid P.F. Year !!!')
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


if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Alert!','Please Select A Employee Status !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Alert!','Please Select A PF Code !!!')
	return 1
end if

dw_1.reset()

if gs_garden_state = '03' then
	dw_1.retrieve(dp_1.text,dp_2.text,'ALL',long(em_1.text), left(right(ddlb_2.text,11),10),ls_gapf, long(em_2.text))
else
	dw_1.retrieve(dp_1.text,dp_2.text,'ALL',long(em_1.text), ls_gapf,ls_gapf, long(em_2.text))
end if
	
ll_pfyear = long(em_2.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

//select distinct 'x' into :ls_temp  from fb_pfform1_exp where trunc(frdt) = trunc(:ld_frdt) or trunc(todt) = trunc(:ld_todt) ;
select distinct 'x' into :ls_temp  from fb_pfform1_exp where trunc(:ld_frdt) between  trunc(frdt) and trunc(todt) or trunc(:ld_todt) between  trunc(frdt) and trunc(todt);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking saved records : '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning','Data already exists for this payment period')
	return 1
end if

if em_1.text <> '000000' and not isnull(em_1.text) and em_1.text <> 'none' then
	ll_yrmn = long(em_1.text)
	select distinct 'x' into :ls_temp  from fb_pfform1_exp where year_mon = :ll_yrmn ;
	if sqlca.sqlcode = -1 then
		messagebox('Error','Error occured while checking saved records : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 0  then
		messagebox('Warning','Data already exists for this Year Month')
		return 1
	end if
end if

IF MessageBox("Alert", 'Are you sure that this data has been approved and you want to save this?' ,Exclamation!, YesNo!, 2) = 1 THEN
		for ll_ctr = 1 to dw_1.rowcount()
			ls_emp_id = dw_1.getitemstring(ll_ctr,'emp_id')
			ls_empname = dw_1.getitemstring(ll_ctr,'empname')
			ll_pfno = dw_1.getitemnumber(ll_ctr,'pfno')
			ll_ctot_pf = dw_1.getitemnumber(ll_ctr,'ctot_pf')
			ll_adv_made = dw_1.getitemnumber(ll_ctr,'adv_made')
			ll_adv_ref = dw_1.getitemnumber(ll_ctr,'adv_ref')
			ll_adv_int = dw_1.getitemnumber(ll_ctr,'adv_int')
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'frdt')
			ld_todt = dw_1.getitemdatetime(ll_ctr,'todt')
			ll_year_mon = dw_1.getitemnumber(ll_ctr,'year_mon')
			
			insert into  fb_pfform1_exp(EMP_ID, EMP_NAME, PF_NO, CONTRIBUTION, ADVANCE_MADE, ADVANCE_REFUND, ADVANCE_INTEREST, FRDT, TODT, YEAR_MON, ENTRY_BY, ENTRY_DT, PF_YEAR)
			values(:ls_emp_id,:ls_empname,:ll_pfno,:ll_ctot_pf,:ll_adv_made,:ll_adv_ref,:ll_adv_int,:ld_frdt,:ld_todt,:ll_year_mon,:gs_user, sysdate, :ll_pfyear);
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error occured while inserting records : '+sqlca.sqlerrtext)
				rollback;
				return 1
			end if 
		next
		messagebox('Message','Records saved successfully')
		commit using sqlca;
else
	return 1
end if
	


setpointer(arrow!)




end event

type ddlb_2 from dropdownlistbox within w_gtelar067
integer x = 722
integer y = 124
integer width = 937
integer height = 608
integer taborder = 70
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

type st_5 from statictext within w_gtelar067
integer x = 503
integer y = 140
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

type em_1 from editmask within w_gtelar067
integer x = 2373
integer y = 20
integer width = 215
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "000000"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type st_4 from statictext within w_gtelar067
integer x = 1701
integer y = 36
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

type ddlb_1 from dropdownlistbox within w_gtelar067
boolean visible = false
integer x = 1842
integer y = 8
integer width = 503
integer height = 588
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
string item[] = {"ALL","Regular","Retired","Resigned","NameOut","Expired","Transfer"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtelar067
boolean visible = false
integer x = 1696
integer y = 32
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Emp Status"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar067
integer x = 1307
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-02-28"), Time("16:44:18.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar067
integer x = 1065
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

type dp_1 from datepicker within w_gtelar067
integer x = 681
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-02-28"), Time("16:44:18.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelar067
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

type cb_2 from commandbutton within w_gtelar067
integer x = 1943
integer y = 124
integer width = 265
integer height = 100
integer taborder = 90
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

type cb_1 from commandbutton within w_gtelar067
integer x = 1678
integer y = 124
integer width = 265
integer height = 100
integer taborder = 80
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


if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Alert!','Please Enter Valid Year Month or 000000  !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text = '0000' or len(em_2.text) = 0 then
	messagebox('Alert!','Please Enter Valid P.F. Year !!!')
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

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Alert!','Please Select A Employee Status !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Alert!','Please Select A PF Code !!!')
	return 1
end if
if gs_garden_state = '03' then
	dw_1.retrieve(dp_1.text,dp_2.text,'ALL',long(em_1.text), left(right(ddlb_2.text,11),10),ls_gapf,long(em_2.text))
else
	dw_1.retrieve(dp_1.text,dp_2.text,'ALL',long(em_1.text), ls_gapf,ls_gapf,long(em_2.text))
end if
	

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)


end event

type dw_1 from datawindow within w_gtelar067
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 228
integer width = 2889
integer height = 2296
string dataobject = "dw_gtelar067"
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

