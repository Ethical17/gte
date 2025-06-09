$PBExportHeader$w_gteinr011.srw
forward
global type w_gteinr011 from window
end type
type st_3 from statictext within w_gteinr011
end type
type ddlb_1 from dropdownlistbox within w_gteinr011
end type
type dp_2 from datepicker within w_gteinr011
end type
type dp_1 from datepicker within w_gteinr011
end type
type st_2 from statictext within w_gteinr011
end type
type st_1 from statictext within w_gteinr011
end type
type cb_2 from commandbutton within w_gteinr011
end type
type cb_4 from commandbutton within w_gteinr011
end type
type dw_1 from datawindow within w_gteinr011
end type
end forward

global type w_gteinr011 from window
integer width = 3799
integer height = 2488
boolean titlebar = true
string title = "(W_gteinr011) Requisition Slip"
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
dp_2 dp_2
dp_1 dp_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gteinr011 w_gteinr011

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_div
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
n_cst_powerfilter iu_powerfilter
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

on w_gteinr011.create
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.ddlb_1,&
this.dp_2,&
this.dp_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gteinr011.destroy
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

lb_query = false	
lb_neworder = false

//setpointer(hourglass!)
//dw_1.GetChild ("eacsubhead_id", idw_subexp)
//idw_subexp.settransobject(sqlca)	
//
	setpointer(hourglass!)
	ddlb_1.reset()
	ddlb_1.additem('ALL')
	
	declare c2 cursor for
		
	 select initcap(FIELD_NAME)||'('||FIELD_ID||')' 
	 from fb_field where  nvl(FIELD_ACTIVE_IND,'N')='Y'
	 order by 1;	
	 
	open c2;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_temp)
			fetch c2 into :ls_temp;
		loop
		close c2;
	end if
	ddlb_1.text='ALL'
	
	setpointer(arrow!)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_3 from statictext within w_gteinr011
integer x = 1431
integer y = 36
integer width = 279
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
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteinr011
integer x = 1710
integer y = 20
integer width = 946
integer height = 856
integer taborder = 20
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

event selectionchanged;//	setpointer(hourglass!)
//	ddlb_1.reset()
//	ddlb_1.additem('ALL')
//	
//	declare c2 cursor for
//		
//	 select initcap(FIELD_NAME)||'('||FIELD_ID||')' 
//	 from fb_field where  nvl(FIELD_ACTIVE_IND,'N')='Y'
//	 order by 1;	
//	 
//	open c2;
//	
//	IF sqlca.sqlcode = 0 THEN
//		fetch c2 into :ls_temp;
//		
//		do while sqlca.sqlcode <> 100
//			ddlb_1.additem(ls_temp)
//			fetch c2 into :ls_temp;
//		loop
//		close c2;
//	end if
//	ddlb_1.text='ALL'
//	
//	setpointer(arrow!)

end event

type dp_2 from datepicker within w_gteinr011
integer x = 1010
integer y = 20
integer width = 398
integer height = 100
integer taborder = 20
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-24"), Time("08:58:53.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteinr011
integer x = 343
integer y = 24
integer width = 398
integer height = 100
integer taborder = 10
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-24"), Time("08:58:53.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteinr011
integer x = 750
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

type st_1 from statictext within w_gteinr011
integer x = 41
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

type cb_2 from commandbutton within w_gteinr011
integer x = 2679
integer y = 20
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

event clicked;string ls_frym,ls_toym


if  len(trim(dp_1.text)) = 0 or isnull(dp_1.text) then
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

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Warning!','Division Should Not Be Blank, Please Check !!!')
	return 1
end if;


ls_frym =dp_1.text
ls_toym =dp_2.text
ls_div = left(right(ddlb_1.text,6),5)
dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_frym,ls_toym,ls_div)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found !!!')
	return 1
end if

end event

type cb_4 from commandbutton within w_gteinr011
integer x = 2949
integer y = 20
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

type dw_1 from datawindow within w_gteinr011
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 132
integer width = 3726
integer height = 2236
integer taborder = 50
string dataobject = "dw_gteinr011"
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

