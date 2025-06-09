$PBExportHeader$w_gteinr003.srw
forward
global type w_gteinr003 from window
end type
type cbx_2 from checkbox within w_gteinr003
end type
type cbx_1 from checkbox within w_gteinr003
end type
type ddlb_2 from dropdownlistbox within w_gteinr003
end type
type st_4 from statictext within w_gteinr003
end type
type ddlb_1 from dropdownlistbox within w_gteinr003
end type
type st_3 from statictext within w_gteinr003
end type
type dp_1 from datepicker within w_gteinr003
end type
type dp_2 from datepicker within w_gteinr003
end type
type st_2 from statictext within w_gteinr003
end type
type st_1 from statictext within w_gteinr003
end type
type cb_2 from commandbutton within w_gteinr003
end type
type cb_4 from commandbutton within w_gteinr003
end type
type dw_1 from datawindow within w_gteinr003
end type
end forward

global type w_gteinr003 from window
integer width = 4594
integer height = 2184
boolean titlebar = true
string title = "(W_gteinr003) Item Wise Stock"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_2 cbx_2
cbx_1 cbx_1
ddlb_2 ddlb_2
st_4 st_4
ddlb_1 ddlb_1
st_3 st_3
dp_1 dp_1
dp_2 dp_2
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gteinr003 w_gteinr003

type variables

n_cst_powerfilter iu_powerfilter 
string ls_div,ls_catg,ls_nppc
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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gteinr003.create
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.ddlb_2=create ddlb_2
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.dp_1=create dp_1
this.dp_2=create dp_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.cbx_2,&
this.cbx_1,&
this.ddlb_2,&
this.st_4,&
this.ddlb_1,&
this.st_3,&
this.dp_1,&
this.dp_2,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gteinr003.destroy
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.ddlb_2)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


setpointer(hourglass!)

ddlb_1.additem("ALL")
declare c1 cursor for
select initcap(SPC_NAME)||' ['||SPC_ID||']'  from FB_STOREPRODUCTCATEGORY where nvl(SPC_ACTIVE_IND,'N')='Y'
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_catg;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_catg))
		fetch c1 into :ls_catg;
	loop
	close c1;
end if

ddlb_1.text = "ALL"

string ls_def_div,ls_div_ind

declare c2 cursor for
select initcap(FIELD_NAME)||' ['||FIELD_ID||']' ,decode(field_id,:gs_storeid,'Y','N') from fb_field where nvl(FIELD_ACTIVE_IND,'N')='Y'
order by 1 asc;
	
open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_div,:ls_div_ind;
	
	do while sqlca.sqlcode <> 100
		if ls_div_ind ='Y' then
			ls_def_div = ls_div
		end if
		
		ddlb_2.additem(string(ls_div))
		fetch c2 into :ls_div,:ls_div_ind;
	loop
	close c2;
end if
ddlb_2.text = ls_def_div
setpointer(arrow!)

if GS_USER = 'ADMIN' then
	cbx_2.visible = true
else
	cbx_2.visible = false
end if
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type cbx_2 from checkbox within w_gteinr003
integer x = 3607
integer y = 60
integer width = 343
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "NPPC Ind"
end type

type cbx_1 from checkbox within w_gteinr003
integer x = 3593
integer width = 384
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transaction"
end type

type ddlb_2 from dropdownlistbox within w_gteinr003
integer x = 224
integer y = 8
integer width = 686
integer height = 696
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_gteinr003
integer y = 20
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
string text = "Division:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteinr003
integer x = 1362
integer y = 12
integer width = 974
integer height = 1052
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gteinr003
integer x = 905
integer y = 20
integer width = 443
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Product Category:"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteinr003
integer x = 2619
integer y = 12
integer width = 398
integer height = 100
integer taborder = 30
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-24"), Time("09:38:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_2 from datepicker within w_gteinr003
integer x = 3182
integer y = 12
integer width = 398
integer height = 100
integer taborder = 40
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-24"), Time("09:38:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteinr003
integer x = 3022
integer y = 32
integer width = 146
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteinr003
integer x = 2341
integer y = 32
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

type cb_2 from commandbutton within w_gteinr003
integer x = 3973
integer y = 8
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

if  isnull(ddlb_1.text) or trim(ddlb_1.text) ="" then
	messagebox ('Wrong Product Category','Please select The Product Category')
	return 1
end if;

if  isnull(ddlb_2.text) or trim(ddlb_2.text) ="" then
	messagebox ('Wrong Division','Please select The Division')
	return 1
end if;

if cbx_2.checked then
	ls_nppc = 'Y'
else
	ls_nppc = 'N'
end if


ls_catg = left(right(ddlb_1.text,9),8)
ls_div = left(right(ddlb_2.text,6),5)

dw_1.settransobject(sqlca)
if cbx_1.checked then
	dw_1.retrieve(dp_1.text,dp_2.text,ls_div,ls_catg,'Y', gs_user,ls_nppc)
else
	dw_1.retrieve(dp_1.text,dp_2.text,ls_div,ls_catg,'N', gs_user,ls_nppc)
end if

end event

type cb_4 from commandbutton within w_gteinr003
integer x = 4242
integer y = 8
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

type dw_1 from datawindow within w_gteinr003
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4530
integer height = 1936
string dataobject = "dw_gteinr003"
boolean vscrollbar = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

