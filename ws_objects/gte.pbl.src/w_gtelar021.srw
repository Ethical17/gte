$PBExportHeader$w_gtelar021.srw
forward
global type w_gtelar021 from window
end type
type em_1 from editmask within w_gtelar021
end type
type st_3 from statictext within w_gtelar021
end type
type dp_1 from datepicker within w_gtelar021
end type
type ddlb_1 from dropdownlistbox within w_gtelar021
end type
type st_5 from statictext within w_gtelar021
end type
type st_4 from statictext within w_gtelar021
end type
type st_1 from statictext within w_gtelar021
end type
type cb_1 from commandbutton within w_gtelar021
end type
type cb_2 from commandbutton within w_gtelar021
end type
type st_2 from statictext within w_gtelar021
end type
type dw_1 from datawindow within w_gtelar021
end type
type ddlb_2 from dropdownlistbox within w_gtelar021
end type
end forward

global type w_gtelar021 from window
integer width = 3758
integer height = 2468
boolean titlebar = true
string title = "(Gtelar021) - Form-3A"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_3 st_3
dp_1 dp_1
ddlb_1 ddlb_1
st_5 st_5
st_4 st_4
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
ddlb_2 ddlb_2
end type
global w_gtelar021 w_gtelar021

type variables
long ll_year
string ls_emp
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
	case "PDF"
			this.dw_1.saveas("c:\reports\dyperf01.pdf",pdf!,true)
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

on w_gtelar021.create
this.em_1=create em_1
this.st_3=create st_3
this.dp_1=create dp_1
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.ddlb_2=create ddlb_2
this.Control[]={this.em_1,&
this.st_3,&
this.dp_1,&
this.ddlb_1,&
this.st_5,&
this.st_4,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1,&
this.ddlb_2}
end on

on w_gtelar021.destroy
destroy(this.em_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.ddlb_2)
end on

event open;dw_1.settransobject(sqlca)
this.dw_1.modify("datawindow.print.preview = yes")
setpointer(hourglass!)
//em_1.text = string(today(),'dd/mm/yyyy')

declare c1 cursor for
//select distinct nvl(LPW_YEAR,0)  lyear from FB_LABOURPFWEEK order by 1 desc;
select distinct  to_number(to_char(LWW_STARTDATE,'yyyy')) lyear from  fb_labourwagesweek order by 1 desc;
open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ll_year;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ll_year))
		fetch c1 into :ll_year;
	loop
	close c1;
end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct LABOUR_ID||' ('||emp_name||')' from 
	(SELECT lww1.labour_id LABOUR_ID,lww1.lww_id FROM (SELECT lww_id, emp_id labour_id FROM fb_labourwagesweek lww1 LEFT OUTER JOIN fb_employee l ON lww1.lww_id <> l.emp_id ) lww1
	  LEFT OUTER JOIN 
	  (SELECT labour_id,lww_id FROM fb_labourweeklywages lww4 
		UNION ALL 
		SELECT llww.labour_id,lww3.lww_id 
		FROM fb_lablww llww, fb_lablwwperiod llp,fb_lablwwseason lls, fb_labourwagesweek lww3
		WHERE llww.llp_id = llp.llp_id AND llp.lls_id = lls.lls_id AND lls.lls_pdate = lww3.lww_startdate AND 
			  lls.lls_confirm = '1') lww2 
	ON lww1.lww_id = lww2.lww_id AND lww1.labour_id = lww2.labour_id
	order by 1) a,fb_employee c
where a.LABOUR_ID = c.emp_id;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_emp;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_emp)
		fetch c2 into :ls_emp;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'
setpointer(arrow!)
em_1.text = '999999'


end event

type em_1 from editmask within w_gtelar021
integer x = 1774
integer y = 120
integer width = 334
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "######"
end type

type st_3 from statictext within w_gtelar021
integer x = 1751
integer width = 407
integer height = 116
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PF Code  (999999 for ALL)"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelar021
integer x = 2126
integer y = 116
integer width = 398
integer height = 100
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2013-02-09"), Time("08:49:38.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type ddlb_1 from dropdownlistbox within w_gtelar021
integer x = 128
integer y = 120
integer width = 384
integer height = 968
integer taborder = 10
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

event selectionchanged;setpointer(hourglass!)
ll_year = long(ddlb_1.text)
ddlb_2.reset()

ddlb_2.additem('ALL')
declare c2 cursor for
select distinct LABOUR_ID||' ('||emp_name||')' from 
	(SELECT lww1.labour_id LABOUR_ID,lww1.lww_id FROM (SELECT lww_id, emp_id labour_id FROM fb_labourwagesweek lww1 LEFT OUTER JOIN fb_employee l ON lww1.lww_id <> l.emp_id ) lww1
	  LEFT OUTER JOIN 
	  (SELECT labour_id,lww_id FROM fb_labourweeklywages lww4 
		UNION ALL 
		SELECT llww.labour_id,lww3.lww_id 
		FROM fb_lablww llww, fb_lablwwperiod llp,fb_lablwwseason lls, fb_labourwagesweek lww3
		WHERE llww.llp_id = llp.llp_id AND llp.lls_id = lls.lls_id AND lls.lls_pdate = lww3.lww_startdate AND 
			  lls.lls_confirm = '1') lww2 
	ON lww1.lww_id = lww2.lww_id AND lww1.labour_id = lww2.labour_id
	order by 1) a, FB_LABOURPFWEEK b, fb_employee c
where a.LABOUR_ID = c.emp_id and a.lww_id = b.lww_id and LPW_YEAR = :ll_year	;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_emp;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_emp)
		fetch c2 into :ls_emp;
	loop
	close c2;
end if
ddlb_2.text = 'ALL'
setpointer(Arrow!)
end event

type st_5 from statictext within w_gtelar021
integer x = 2199
integer y = 48
integer width = 256
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print Date"
boolean focusrectangle = false
end type

type st_4 from statictext within w_gtelar021
integer x = 59
integer y = 52
integer width = 603
integer height = 60
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "(2008 Means Mar-07 to Feb-08)"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar021
integer x = 649
integer width = 471
integer height = 116
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Code (ALL for ALL)"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar021
integer x = 2811
integer y = 116
integer width = 279
integer height = 104
integer taborder = 50
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

type cb_2 from commandbutton within w_gtelar021
integer x = 2528
integer y = 116
integer width = 279
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;long ld_dt

dw_1.settransobject(sqlca)
dw_1.show()

if isnull(ddlb_1.text) or len(ddlb_1.text) <=0 then
	messagebox('Error','Please Enter Current Year as (YYYY)')
	return 1
end if

if (isnull(ddlb_2.text) or len(ddlb_2.text) <=0) and  (isnull(em_1.text) or len(em_1.text) <=0)  then
	messagebox('Error','Please Enter Employee \ PF Code ')
	return 1
end if

setpointer(hourglass!)
dw_1.settransobject(sqlca)
dw_1.retrieve(long(trim(ddlb_1.text)),trim(left(upper(ddlb_2.text),7)),trim(em_1.text),dp_1.text)
setpointer(arrow!)
end event

type st_2 from statictext within w_gtelar021
integer x = 155
integer y = 4
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year(YYYY)"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar021
integer x = 41
integer y = 220
integer width = 3666
integer height = 2132
string title = "none"
string dataobject = "dw_gtelar021"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_2 from dropdownlistbox within w_gtelar021
integer x = 635
integer y = 120
integer width = 1115
integer height = 968
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_temp

select distinct 'x' into :ls_temp from 
	(SELECT lww1.labour_id LABOUR_ID,lww1.lww_id FROM (SELECT lww_id, emp_id labour_id FROM fb_labourwagesweek lww1 LEFT OUTER JOIN fb_employee l ON lww1.lww_id <> l.emp_id ) lww1
	  LEFT OUTER JOIN 
	  (SELECT labour_id,lww_id FROM fb_labourweeklywages lww4 
		UNION ALL 
		SELECT llww.labour_id,lww3.lww_id 
		FROM fb_lablww llww, fb_lablwwperiod llp,fb_lablwwseason lls, fb_labourwagesweek lww3
		WHERE llww.llp_id = llp.llp_id AND llp.lls_id = lls.lls_id AND lls.lls_pdate = lww3.lww_startdate AND 
			  lls.lls_confirm = '1') lww2 
	ON lww1.lww_id = lww2.lww_id AND lww1.labour_id = lww2.labour_id
	order by 1) a,fb_employee c
where a.LABOUR_ID = c.emp_id;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid Employee Code/ Name, Please Check !!!')
	return 1
end if	
	

end event

