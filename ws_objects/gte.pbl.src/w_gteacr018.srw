$PBExportHeader$w_gteacr018.srw
forward
global type w_gteacr018 from window
end type
type ddlb_3 from dropdownlistbox within w_gteacr018
end type
type st_2 from statictext within w_gteacr018
end type
type st_3 from statictext within w_gteacr018
end type
type dp_1 from datepicker within w_gteacr018
end type
type dp_2 from datepicker within w_gteacr018
end type
type ddlb_2 from dropdownlistbox within w_gteacr018
end type
type ddlb_1 from dropdownlistbox within w_gteacr018
end type
type cb_2 from commandbutton within w_gteacr018
end type
type cb_1 from commandbutton within w_gteacr018
end type
type st_7 from statictext within w_gteacr018
end type
type st_5 from statictext within w_gteacr018
end type
type st_1 from statictext within w_gteacr018
end type
type em_3 from editmask within w_gteacr018
end type
type dw_1 from datawindow within w_gteacr018
end type
end forward

global type w_gteacr018 from window
integer width = 3835
integer height = 2424
boolean titlebar = true
string title = "(W_gteacr018) Expense Sub Head"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_3 ddlb_3
st_2 st_2
st_3 st_3
dp_1 dp_1
dp_2 dp_2
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_7 st_7
st_5 st_5
st_1 st_1
em_3 em_3
dw_1 dw_1
end type
global w_gteacr018 w_gteacr018

type variables
string ls_gl,ls_sgl,ls_name,ls_frym,ls_toym,ls_egl,ls_ename
n_cst_powerfilter iu_powerfilter
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

on w_gteacr018.create
this.ddlb_3=create ddlb_3
this.st_2=create st_2
this.st_3=create st_3
this.dp_1=create dp_1
this.dp_2=create dp_2
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_7=create st_7
this.st_5=create st_5
this.st_1=create st_1
this.em_3=create em_3
this.dw_1=create dw_1
this.Control[]={this.ddlb_3,&
this.st_2,&
this.st_3,&
this.dp_1,&
this.dp_2,&
this.ddlb_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_7,&
this.st_5,&
this.st_1,&
this.em_3,&
this.dw_1}
end on

on w_gteacr018.destroy
destroy(this.ddlb_3)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.dp_2)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.em_3)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject( sqlca);

ddlb_1.reset()
ddlb_2.reset()
ddlb_3.reset()

declare c1 cursor for
select distinct a.ACLEDGER_ID,ACLEDGER_NAME||' ['||a.ACLEDGER_ID||']' from fb_acledger a,fb_acsubledger b
  where a.ACLEDGER_ID = b.ACLEDGER_ID and nvl(EXP_HEAD_IND,'N')='Y' order by 2;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_gl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_name)
		fetch c1 into :ls_gl,:ls_name;
	loop
	close c1;
end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct ACSUBLEDGER_ID,ACSUBLEDGER_NAME||' ['||ACSUBLEDGER_ID||']' from fb_acsubledger where nvl(EXP_HEAD_IND,'N')='Y' order by 2;
 
		
open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_sgl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_name)
		fetch c2 into :ls_sgl,:ls_name;
	loop
	close c2;
end if

ddlb_3.additem('ALL')

declare c3 cursor for
select distinct EACSUBHEAD_ID,EACSUBHEAD_NAME||' ['||EACSUBHEAD_ID||']' 
  from FB_EXPENSEACSUBHEAD,fb_acsubledger  
where ACSUBLEDGER_ID=EACHEAD_ID  and nvl(EXP_HEAD_IND,'N')='Y' order by 2;

open c3;

IF sqlca.sqlcode = 0 THEN
	fetch c3 into :ls_egl,:ls_ename;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_ename)
		fetch c3 into :ls_egl,:ls_ename;
	loop
	close c3;
end if
ddlb_2.text='ALL'
ddlb_3.text='ALL'

end event

type ddlb_3 from dropdownlistbox within w_gteacr018
integer x = 1285
integer y = 128
integer width = 1006
integer height = 1364
integer taborder = 50
integer textsize = -8
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

type st_2 from statictext within w_gteacr018
integer x = 928
integer y = 140
integer width = 393
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expense Head"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gteacr018
integer x = 9
integer y = 24
integer width = 210
integer height = 124
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From "
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteacr018
integer x = 238
integer y = 20
integer width = 366
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-10-12"), Time("10:24:18.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_2 from datepicker within w_gteacr018
integer x = 709
integer y = 20
integer width = 366
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-10-12"), Time("10:24:18.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type ddlb_2 from dropdownlistbox within w_gteacr018
integer x = 2601
integer y = 28
integer width = 1042
integer height = 1364
integer taborder = 40
integer textsize = -8
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

event selectionchanged;ddlb_3.reset()

ls_gl = left(right(ddlb_1.text,8),7)
ls_sgl = left(right(ddlb_2.text,9),8)
ddlb_3.additem('ALL')

declare c3 cursor for
select distinct EACSUBHEAD_ID,EACSUBHEAD_NAME||' ['||EACSUBHEAD_ID||']' 
  from FB_EXPENSEACSUBHEAD,fb_acsubledger  
where ACSUBLEDGER_ID=EACHEAD_ID and nvl(EXP_HEAD_IND,'N')='Y'  and ACLEDGER_ID=:ls_gl and ACSUBLEDGER_ID = :ls_sgl order by 2;

open c3;

IF sqlca.sqlcode = 0 THEN
	fetch c3 into :ls_egl,:ls_ename;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_ename)
		fetch c3 into :ls_egl,:ls_ename;
	loop
	close c3;
end if

ddlb_3.text='ALL'
end event

type ddlb_1 from dropdownlistbox within w_gteacr018
integer x = 1285
integer y = 32
integer width = 1006
integer height = 1160
integer taborder = 30
integer textsize = -8
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

event selectionchanged;ddlb_2.reset()

ls_gl = left(right(ddlb_1.text,8),7)
ddlb_2.additem('ALL')

declare c2 cursor for
select distinct ACSUBLEDGER_ID,ACSUBLEDGER_NAME||' ['||ACSUBLEDGER_ID||']' from fb_acsubledger  where nvl(EXP_HEAD_IND,'N')='Y'  and ACLEDGER_ID=:ls_gl order by 2;
 
		
open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_sgl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_name)
		fetch c2 into :ls_sgl,:ls_name;
	loop
	close c2;
end if
ddlb_2.text='ALL'
end event

type cb_2 from commandbutton within w_gteacr018
integer x = 2843
integer y = 120
integer width = 242
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

type cb_1 from commandbutton within w_gteacr018
integer x = 2606
integer y = 120
integer width = 242
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

if date(dp_1.text) < date('01/04/2012')  then
	messagebox('Warning ','The From Date Should be >= 01-apr-2012  , Please check ...!')
	return 1
end if

if isnull(dp_2.text) or dp_2.text='00/00/0000' then
	messagebox('Warning','Please Enter The "To" Date !!!')
	return 
end if

if date(dp_1.text) > date(dp_2.text)  then
	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
	return 1
end if

ls_frym =dp_1.text
ls_toym =dp_2.text

if isnull(ddlb_1.text) or len(ddlb_1.text) =0 then 
	messagebox('Warning ','Please Select a Valid Ledger Id ...!') 
	return  1
end if

//messagebox('a','11'+ddlb_2.text)
if isnull(ddlb_2.text) or len(ddlb_2.text) =0 then 
	messagebox('Warning ','Please Select a Valid Sub Ledger Id ....!') 
	return  1
end if
//messagebox('b','22'+ddlb_3.text)
if isnull(ddlb_3.text) or len(ddlb_3.text) =0 then 
	messagebox('Warning ','Please Select a Valid Expense Head ....!') 
	return  1
end if

ls_gl = left(right(ddlb_1.text,8),7)
ls_sgl = left(right(ddlb_2.text,9),8)
ls_egl = left(right(ddlb_3.text,9),8)



dw_1.show()
dw_1.settransobject(sqlca)

setpointer(hourglass!)
	dw_1.retrieve(ls_frym,ls_toym,ls_gl,ls_sgl,ls_egl)
setpointer(arrow!)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if

end event

type st_7 from statictext within w_gteacr018
integer x = 617
integer y = 40
integer width = 87
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To"
boolean focusrectangle = false
end type

type st_5 from statictext within w_gteacr018
integer x = 1102
integer y = 40
integer width = 174
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ledger"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteacr018
integer x = 2313
integer y = 40
integer width = 283
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sub Ledger"
boolean focusrectangle = false
end type

type em_3 from editmask within w_gteacr018
boolean visible = false
integer x = 402
integer y = 32
integer width = 78
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#"
end type

type dw_1 from datawindow within w_gteacr018
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 23
integer y = 224
integer width = 3726
integer height = 2084
string dataobject = "dw_gteacr018"
boolean maxbox = true
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

