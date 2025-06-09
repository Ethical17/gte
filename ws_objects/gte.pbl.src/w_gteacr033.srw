$PBExportHeader$w_gteacr033.srw
forward
global type w_gteacr033 from window
end type
type cb_3 from commandbutton within w_gteacr033
end type
type st_2 from statictext within w_gteacr033
end type
type ddlb_1 from dropdownlistbox within w_gteacr033
end type
type cb_2 from commandbutton within w_gteacr033
end type
type cb_1 from commandbutton within w_gteacr033
end type
type st_1 from statictext within w_gteacr033
end type
type dp_1 from datepicker within w_gteacr033
end type
type dw_1 from datawindow within w_gteacr033
end type
end forward

global type w_gteacr033 from window
integer width = 4818
integer height = 2392
boolean titlebar = true
string title = "(Gteflr005) - Daily Plucking"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dp_1 dp_1
dw_1 dw_1
end type
global w_gteacr033 w_gteacr033

type variables
n_cst_powerfilter iu_powerfilter
string ls_division,ls_bank
string ls_bank_cd,ls_gl_cd,ls_sgl_cd,ls_bnm
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

on w_gteacr033.create
this.cb_3=create cb_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dp_1=create dp_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dp_1,&
this.dw_1}
end on

on w_gteacr033.destroy
destroy(this.cb_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")

dw_1.settransobject(sqlca);

setpointer(hourglass!)
declare c1 cursor for
select distinct initcap(ACSUBLEDGER_MANID)||' ('||ACSUBLEDGER_ID||')' bankname
from  fb_acledger  a ,fb_acsubledger b
where a.ACLEDGER_ID=b.ACLEDGER_ID and upper(ACLEDGER_LEDGERTYPE)  like 'BANK' and ACLEDGER_ACTIVE_IND='Y'
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_bank;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_bank))
		fetch c1 into :ls_bank;
	loop
	close c1;
end if

setpointer(arrow!)         

end event

type cb_3 from commandbutton within w_gteacr033
integer x = 3237
integer y = 12
integer width = 265
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Search"
boolean cancel = true
end type

type st_2 from statictext within w_gteacr033
integer x = 23
integer y = 36
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bank ledger"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr033
integer x = 462
integer y = 20
integer width = 1339
integer height = 608
integer taborder = 20
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

type cb_2 from commandbutton within w_gteacr033
integer x = 2944
integer y = 8
integer width = 265
integer height = 100
integer taborder = 30
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

type cb_1 from commandbutton within w_gteacr033
integer x = 2656
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At Bank ','The Bank Should Not Be Blank, Please Check...!')
	return -1
end if;

if isdate(dp_1.text) = false then 
	messagebox('Error At From Date','Please Enter the Valid From Date...!')
	return -1
end if;

string ls_fr_dt,ls_to_dt
ls_fr_dt   = dp_1.text

ls_bank_cd =(left(right(ddlb_1.text,9),8))

select distinct ACSUBLEDGER_ID, ACSUBLEDGER_MANID into  :ls_sgl_cd, :ls_bnm   from fb_acledger  a ,fb_acsubledger b where a.ACLEDGER_ID=b.ACLEDGER_ID and ACSUBLEDGER_ID = :ls_bank_cd;

if sqlca.sqlcode = -1 then 
	messagebox('Error During Getting GL Code',sqlca.sqlerrtext)
	return 1
end if;	

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_sgl_cd,ls_fr_dt,ls_bnm)


if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if

end event

type st_1 from statictext within w_gteacr033
integer x = 1842
integer y = 28
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As on Date : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteacr033
integer x = 2231
integer y = 12
integer width = 389
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-05-22"), Time("15:15:54.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dw_1 from datawindow within w_gteacr033
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4485
integer height = 2088
string dataobject = "dw_gteacr033"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

