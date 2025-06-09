$PBExportHeader$w_gteinr005.srw
forward
global type w_gteinr005 from window
end type
type st_3 from statictext within w_gteinr005
end type
type ddlb_1 from dropdownlistbox within w_gteinr005
end type
type rb_1 from radiobutton within w_gteinr005
end type
type rb_2 from radiobutton within w_gteinr005
end type
type rb_3 from radiobutton within w_gteinr005
end type
type dp_2 from datepicker within w_gteinr005
end type
type dp_1 from datepicker within w_gteinr005
end type
type st_2 from statictext within w_gteinr005
end type
type st_1 from statictext within w_gteinr005
end type
type cb_2 from commandbutton within w_gteinr005
end type
type cb_4 from commandbutton within w_gteinr005
end type
type gb_1 from groupbox within w_gteinr005
end type
type dw_1 from datawindow within w_gteinr005
end type
type dw_2 from datawindow within w_gteinr005
end type
end forward

global type w_gteinr005 from window
integer width = 4507
integer height = 2444
boolean titlebar = true
string title = "(W_gteinr005) Item wise Stock Summary"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
ddlb_1 ddlb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
dp_2 dp_2
dp_1 dp_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gteinr005 w_gteinr005

type variables
n_cst_powerfilter iu_powerfilter 
string ls_div
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

on w_gteinr005.create
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.st_3,&
this.ddlb_1,&
this.rb_1,&
this.rb_2,&
this.rb_3,&
this.dp_2,&
this.dp_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gteinr005.destroy
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
end event

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.show()
dw_2.hide()

string ls_def_div,ls_div_ind

declare c1 cursor for
select initcap(FIELD_NAME)||' ['||FIELD_ID||']' ,decode(field_id,:gs_storeid,'Y','N') from fb_field where nvl(FIELD_ACTIVE_IND,'N')='Y'
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_div,:ls_div_ind;
	
	do while sqlca.sqlcode <> 100
		if ls_div_ind ='Y' then
			ls_def_div = ls_div
		end if
		
		ddlb_1.additem(string(ls_div))
		fetch c1 into :ls_div,:ls_div_ind;
	loop
	close c1;
end if
ddlb_1.text = ls_def_div

end event

type st_3 from statictext within w_gteinr005
integer x = 14
integer y = 32
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

type ddlb_1 from dropdownlistbox within w_gteinr005
integer x = 302
integer y = 20
integer width = 686
integer height = 696
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_gteinr005
integer x = 1024
integer y = 28
integer width = 334
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Essential"
boolean checked = true
end type

type rb_2 from radiobutton within w_gteinr005
integer x = 1358
integer y = 28
integer width = 443
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Non Essential"
end type

type rb_3 from radiobutton within w_gteinr005
integer x = 1801
integer y = 28
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ALL"
end type

type dp_2 from datepicker within w_gteinr005
integer x = 3136
integer y = 16
integer width = 398
integer height = 100
integer taborder = 20
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-20"), Time("22:43:13.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteinr005
integer x = 2491
integer y = 16
integer width = 398
integer height = 100
integer taborder = 10
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-20"), Time("22:43:13.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteinr005
integer x = 2894
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

type st_1 from statictext within w_gteinr005
integer x = 2185
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

type cb_2 from commandbutton within w_gteinr005
integer x = 3552
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
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

if  isnull(ddlb_1.text) or ddlb_1.text="" then
	messagebox ('Division Not Selected','Please Select Valid Division')
	return 1
end if;

ls_div = left(right(ddlb_1.text,6),5)

string ls_fy,ls_fr_dt

ls_fr_dt = dp_1.text

select  to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_fr_dt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_fr_dt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_fr_dt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy') into :ls_fy from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error: During FY Select',sqlca.sqlerrtext)
	return 1
end if
 
if rb_1.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(dp_1.text,dp_2.text,'1',ls_fy,ls_div)
elseif rb_2.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(dp_1.text,dp_2.text,'0',ls_fy,ls_div)
elseif rb_3.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(dp_1.text,dp_2.text,'ALL',ls_fy,ls_div)	
end if

	//dw_1.settransobject(sqlca)
	//dw_1.retrieve(dp_1.text,dp_2.text)

end event

type cb_4 from commandbutton within w_gteinr005
integer x = 3822
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
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

type gb_1 from groupbox within w_gteinr005
integer x = 1001
integer width = 1056
integer height = 128
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type dw_1 from datawindow within w_gteinr005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 136
integer width = 4411
integer height = 2180
integer taborder = 50
string dataobject = "dw_gteinr005"
boolean vscrollbar = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event clicked;if row > 0 then
	ls_div = left(right(ddlb_1.text,6),5)
	dw_2.show()
	dw_2.settransobject(sqlca)
	dw_2.retrieve(dp_1.text,dp_2.text,dw_1.getitemstring(row,'item_cd'),ls_div)
end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type dw_2 from datawindow within w_gteinr005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
boolean visible = false
integer y = 132
integer width = 3762
integer height = 2180
integer taborder = 60
string dataobject = "dw_gteinr005a"
boolean vscrollbar = true
end type

event rbuttondown;DW_2.HIDE()
DW_1.SHOW()
end event

