$PBExportHeader$w_gteinr007.srw
forward
global type w_gteinr007 from window
end type
type cbx_1 from checkbox within w_gteinr007
end type
type ddlb_3 from dropdownlistbox within w_gteinr007
end type
type st_5 from statictext within w_gteinr007
end type
type st_4 from statictext within w_gteinr007
end type
type ddlb_2 from dropdownlistbox within w_gteinr007
end type
type st_3 from statictext within w_gteinr007
end type
type ddlb_1 from dropdownlistbox within w_gteinr007
end type
type dp_2 from datepicker within w_gteinr007
end type
type dp_1 from datepicker within w_gteinr007
end type
type st_2 from statictext within w_gteinr007
end type
type st_1 from statictext within w_gteinr007
end type
type cb_2 from commandbutton within w_gteinr007
end type
type cb_4 from commandbutton within w_gteinr007
end type
type dw_1 from datawindow within w_gteinr007
end type
end forward

global type w_gteinr007 from window
integer width = 4293
integer height = 2608
boolean titlebar = true
string title = "(W_gteinr007) Expense Head wise consumption"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
ddlb_3 ddlb_3
st_5 st_5
st_4 st_4
ddlb_2 ddlb_2
st_3 st_3
ddlb_1 ddlb_1
dp_2 dp_2
dp_1 dp_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gteinr007 w_gteinr007

type variables
string ls_temp,ls_frym,ls_toym,ls_exhead,ls_exsubhead, ls_div
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();//if dw_1.visible = true then
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
//else
//	choose case gs_ueoption
//		case "PRINT"
//				OpenWithParm(w_print,this.dw_2)
//		case "PRINTPREVIEW"
//				this.dw_2.modify("datawindow.print.preview = yes")
//		case "RESETPREVIEW"
//				this.dw_2.modify("datawindow.print.preview = no")
//		case "ZOOM"
//				SetPointer (HourGlass!)											
//				OpenwithParm (w_zoom,dw_2)
//				SetPointer (Arrow!)						
//		case "SAVEAS"
//				this.dw_2.saveas()
//		case "SFILTER"
//				iu_powerfilter.checked = NOT iu_powerfilter.checked
//				iu_powerfilter.event ue_clicked()
//				m_main.m_file.m_filter.checked = iu_powerfilter.checked
//		case "FILTER"
//				setnull(gs_filtertext)
//				this.dw_2.setredraw(false)
//				this.dw_2.setfilter(gs_filtertext)
//				this.dw_2.filter()
//				this.dw_2.groupcalc()
//				if this.dw_2.rowcount() > 0 then;
//					this.dw_2.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//		case "SORT"
//				setnull(gs_sorttext)
//				this.dw_2.setredraw(false)
//				this.dw_2.setsort(gs_sorttext)
//				this.dw_2.sort()
//				this.dw_2.groupcalc()
//				if this.dw_2.rowcount() > 0 then;
//					this.dw_2.setredraw(true)
//				else
//					Messagebox('Warning','Data Not Available In Given Criteria')
//				end if
//	end choose
//end if	
end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gteinr007.create
this.cbx_1=create cbx_1
this.ddlb_3=create ddlb_3
this.st_5=create st_5
this.st_4=create st_4
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.ddlb_3,&
this.st_5,&
this.st_4,&
this.ddlb_2,&
this.st_3,&
this.ddlb_1,&
this.dp_2,&
this.dp_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gteinr007.destroy
destroy(this.cbx_1)
destroy(this.ddlb_3)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//dw_2.modify("t_co.text = '"+gs_co_name+"'")
//dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)
ddlb_1.reset()

ddlb_1.additem('ALL')
declare c1 cursor for
select distinct ACSUBLEDGER_NAME||' ('|| ACSUBLEDGER_ID||')' 
from fb_acsubledger where EXP_HEAD_IND='Y' 	
order by 1 ;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
ddlb_1.text='ALL'

setpointer(arrow!)

setpointer(hourglass!)
ddlb_2.reset()
ddlb_2.additem('ALL')
declare c2 cursor for

 select initcap(EACSUBHEAD_NAME)||'('||EACSUBHEAD_ID||')' 
 from FB_EXPENSEACSUBHEAD
order by 1;	
		
open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_temp)
		fetch c2 into :ls_temp;
	loop
	close c2;
end if
ddlb_2.text='ALL'


ddlb_3.reset()
ddlb_3.additem('ALL')

declare c3 cursor for
	
 select initcap(FIELD_NAME)||'('||FIELD_ID||')' 
 from fb_field where  nvl(FIELD_ACTIVE_IND,'N')='Y'
 order by 1;	
 
open c3;

IF sqlca.sqlcode = 0 THEN
	fetch c3 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_temp)
		fetch c3 into :ls_temp;
	loop
	close c3;
end if
ddlb_3.text='ALL'

setpointer(arrow!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type cbx_1 from checkbox within w_gteinr007
integer x = 3259
integer y = 140
integer width = 480
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Without Division"
boolean lefttext = true
end type

type ddlb_3 from dropdownlistbox within w_gteinr007
integer x = 370
integer y = 132
integer width = 946
integer height = 856
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_gteinr007
integer x = 18
integer y = 136
integer width = 325
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division: "
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteinr007
integer x = 1413
integer y = 140
integer width = 485
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expense Sub Head: "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gteinr007
integer x = 1915
integer y = 132
integer width = 1271
integer height = 856
integer taborder = 50
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

type st_3 from statictext within w_gteinr007
integer x = 1477
integer y = 28
integer width = 421
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expense Head: "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteinr007
integer x = 1915
integer y = 20
integer width = 1271
integer height = 856
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;	setpointer(hourglass!)
	ddlb_2.reset()
	ls_exhead = left(right(ddlb_1.text,9),8)
	ddlb_2.additem('ALL')
	declare c2 cursor for
	
	 select initcap(EACSUBHEAD_NAME)||'('||EACSUBHEAD_ID||')' 
	 from FB_EXPENSEACSUBHEAD where EACHEAD_ID=decode(:ls_exhead,'ALL',EACHEAD_ID,:ls_exhead)
	 order by 1;	
			//decode(:ls_exhead,'ALL',EACHEAD_ID,:ls_exhead)
	open c2;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_2.additem(ls_temp)
			fetch c2 into :ls_temp;
		loop
		close c2;
	end if
	ddlb_2.text='ALL'
	
	setpointer(arrow!)

end event

type dp_2 from datepicker within w_gteinr007
integer x = 1010
integer y = 16
integer width = 398
integer height = 100
integer taborder = 20
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-01-30"), Time("08:08:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteinr007
integer x = 320
integer y = 16
integer width = 398
integer height = 100
integer taborder = 10
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-01-30"), Time("08:08:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteinr007
integer x = 745
integer y = 36
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteinr007
integer x = 9
integer y = 36
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteinr007
integer x = 3200
integer y = 16
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if  len(trim(dp_1.text)) = 0 or isnull(dp_1.text) then
	messagebox ('From date is blank','please Enter the from date.')
	return 1
end if;

if  len(trim(dp_2.text)) = 0 or isnull(dp_2.text) then
	messagebox ('To date is blank','please Enter the To date.')
	return 1
end if;
	
if  date(dp_2.text) < date(dp_1.text) then
	messagebox ('Enter the correct To Date','To Date cannot be less than from date.')
	return 1
end if;

if  isnull(ddlb_1.text) or ddlb_1.text = "" then 
	messagebox('Error At Expense Head','Please Select Expense Head')
	return 1
end if;

if  isnull(ddlb_2.text) or ddlb_2.text = "" then 
	messagebox('Error At Product Category','Please Select Expense Sub Head')
	return 1
end if;

if  isnull(ddlb_3.text) or ddlb_3.text = "" then 
	messagebox('Error At Division ','Please Select A Division')
	return 1
end if;


ls_frym =dp_1.text
ls_toym =dp_2.text

ls_exhead = left(right(ddlb_1.text,9),8)
ls_exsubhead = left(right(ddlb_2.text,9),8)
ls_div = left(right(ddlb_3.text,6),5)


//dw_2.settransobject(sqlca)

if cbx_1.checked then
//	dw_1.visible = false
//	dw_2.visible = true
//	dw_2.retrieve(ls_frym,ls_toym,ls_exhead,ls_exsubhead)
	dw_1.dataobject='dw_gteinr007a'
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ls_frym,ls_toym,ls_exhead,ls_exsubhead)
else
//	dw_2.visible = false
//	dw_1.visible = true
	dw_1.dataobject='dw_gteinr007'
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ls_frym,ls_toym,ls_exhead,ls_exsubhead,ls_div)
end if


end event

type cb_4 from commandbutton within w_gteinr007
integer x = 3470
integer y = 16
integer width = 265
integer height = 100
integer taborder = 70
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

type dw_1 from datawindow within w_gteinr007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 228
integer width = 4251
integer height = 2276
integer taborder = 80
string dataobject = "dw_gteinr007"
boolean hscrollbar = true
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

