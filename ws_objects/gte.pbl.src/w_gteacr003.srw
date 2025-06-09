$PBExportHeader$w_gteacr003.srw
forward
global type w_gteacr003 from window
end type
type dp_1 from datepicker within w_gteacr003
end type
type dp_2 from datepicker within w_gteacr003
end type
type st_2 from statictext within w_gteacr003
end type
type ddlb_1 from dropdownlistbox within w_gteacr003
end type
type cb_2 from commandbutton within w_gteacr003
end type
type cb_1 from commandbutton within w_gteacr003
end type
type st_5 from statictext within w_gteacr003
end type
type st_4 from statictext within w_gteacr003
end type
type dw_1 from datawindow within w_gteacr003
end type
end forward

global type w_gteacr003 from window
integer width = 3781
integer height = 2532
boolean titlebar = true
string title = "(W_gteacr003) Bank Day Book"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_1 dp_1
dp_2 dp_2
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_5 st_5
st_4 st_4
dw_1 dw_1
end type
global w_gteacr003 w_gteacr003

type variables
string ls_bank
n_cst_powerfilter iu_powerfilter
long ll_user_level
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

on w_gteacr003.create
this.dp_1=create dp_1
this.dp_2=create dp_2
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_5=create st_5
this.st_4=create st_4
this.dw_1=create dw_1
this.Control[]={this.dp_1,&
this.dp_2,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_5,&
this.st_4,&
this.dw_1}
end on

on w_gteacr003.destroy
destroy(this.dp_1)
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
this.tag = Message.StringParm
ll_user_level = long(this.tag)

setpointer(hourglass!)
dw_1.settransobject(sqlca)
//ddlb_1.additem('ALL')

declare c1 cursor for
select distinct initcap(ACSUBLEDGER_NAME)||' ['||ACLEDGER_ID||']' 
from  fb_acsubledger
where ACLEDGER_ID in (select ACLEDGER_ID from fb_acledger where ACLEDGER_LEDGERTYPE = 'BANK')
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

//ddlb_1.text='ALL'
setpointer(arrow!)
end event

type dp_1 from datepicker within w_gteacr003
integer x = 2222
integer width = 366
integer height = 92
integer taborder = 20
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-11-29"), Time("17:50:19.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_2 from datepicker within w_gteacr003
integer x = 2702
integer width = 361
integer height = 92
integer taborder = 30
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-11-29"), Time("17:50:19.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteacr003
integer x = 27
integer y = 20
integer width = 485
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bank Sub Ledger :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr003
integer x = 517
integer y = 4
integer width = 1394
integer height = 960
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gteacr003
integer x = 3351
integer width = 265
integer height = 100
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

type cb_1 from commandbutton within w_gteacr003
integer x = 3077
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;
if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At Bank ','The Bank Should Not Be Blank, Please Check...!')
	return 1
end if;

if isdate(dp_1.text) = false then 
	messagebox('Error At From Date','Please Enter the Valid From Date...!')
	return 1
end if;

if isdate(dp_2.text) = false  then 
	messagebox('Error At To Date','Please Enter the Valid To Date...!')
	return 1
end if;

if date(dp_2.text) < date(dp_1.text) then 
	messagebox('Error At From/To Date',"The 'To Date' Should Not be Less than 'From Date', Please Check...!")
	return 1
end if;
dw_1.settransobject(sqlca)
setpointer(hourglass!)
string ls_fr_dt,ls_to_dt,ls_gl_cd,ls_bank_cd
ls_fr_dt   = dp_1.text
ls_to_dt   = dp_2.text
ls_bank_cd =(left(right(ddlb_1.text,8),7))
setpointer(hourglass!)

select distinct ACLEDGER_ID into  :ls_gl_cd from fb_acsubledger where ACLEDGER_ID = :ls_bank_cd;
if sqlca.sqlcode = -1 then 
	messagebox('Error During Getting Div/GL Code',sqlca.sqlerrtext)
	return 1
end if;	

dw_1.retrieve(ls_gl_cd,ls_fr_dt,ls_to_dt,gs_user)
	
setpointer(arrow!)

end event

type st_5 from statictext within w_gteacr003
integer x = 2597
integer y = 20
integer width = 105
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteacr003
integer x = 1929
integer y = 20
integer width = 306
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From  Date"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr003
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 14
integer y = 104
integer width = 3726
integer height = 2292
string dataobject = "dw_gteacr003"
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

event clicked;if row > 0 then
	gs_opt = dw_1.getitemstring(row,'vh_vou_type')
	gs_vou_no = dw_1.getitemstring(row,'vh_vou_no')
	if not isnull(gs_vou_no)  and len(gs_vou_no) > 0 then
		opensheetwithparm(w_gteacr001,ll_user_level,w_mdi,0,layered!)
	end if
END IF
end event

