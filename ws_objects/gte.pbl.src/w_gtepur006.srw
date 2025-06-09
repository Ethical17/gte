$PBExportHeader$w_gtepur006.srw
forward
global type w_gtepur006 from window
end type
type rb_2 from radiobutton within w_gtepur006
end type
type rb_1 from radiobutton within w_gtepur006
end type
type rb_4 from radiobutton within w_gtepur006
end type
type rb_3 from radiobutton within w_gtepur006
end type
type dp_2 from datepicker within w_gtepur006
end type
type dp_1 from datepicker within w_gtepur006
end type
type st_2 from statictext within w_gtepur006
end type
type st_1 from statictext within w_gtepur006
end type
type cb_2 from commandbutton within w_gtepur006
end type
type cb_4 from commandbutton within w_gtepur006
end type
type gb_2 from groupbox within w_gtepur006
end type
type gb_3 from groupbox within w_gtepur006
end type
type dw_2 from datawindow within w_gtepur006
end type
type dw_1 from datawindow within w_gtepur006
end type
end forward

global type w_gtepur006 from window
integer width = 3621
integer height = 2244
boolean titlebar = true
string title = "(W_gtepur006) Indent Wise O/S Goods"
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
rb_4 rb_4
rb_3 rb_3
dp_2 dp_2
dp_1 dp_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
gb_2 gb_2
gb_3 gb_3
dw_2 dw_2
dw_1 dw_1
end type
global w_gtepur006 w_gtepur006

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id
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

on w_gtepur006.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.rb_4=create rb_4
this.rb_3=create rb_3
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.rb_4,&
this.rb_3,&
this.dp_2,&
this.dp_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.gb_2,&
this.gb_3,&
this.dw_2,&
this.dw_1}
end on

on w_gtepur006.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
lb_query = false	
lb_neworder = false

setpointer(hourglass!)
dw_1.GetChild ("eacsubhead_id", idw_subexp)
idw_subexp.settransobject(sqlca)	

dp_1.visible=false;
dp_2.visible=false;

st_1.visible=false;
st_2.visible=false;

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type rb_2 from radiobutton within w_gtepur006
integer x = 475
integer y = 56
integer width = 425
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Local Indent"
end type

type rb_1 from radiobutton within w_gtepur006
integer x = 55
integer y = 56
integer width = 425
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "H.O. Indent"
boolean checked = true
end type

type rb_4 from radiobutton within w_gtepur006
integer x = 1179
integer y = 64
integer width = 288
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Range"
end type

event clicked;dp_1.visible=true;
dp_2.visible=true;

st_1.visible=true;
st_2.visible=true;
end event

type rb_3 from radiobutton within w_gtepur006
integer x = 960
integer y = 64
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As on Date"
boolean checked = true
end type

event clicked;dp_1.visible=false;
dp_2.visible=false;

st_1.visible=false;
st_2.visible=false;
end event

type dp_2 from datepicker within w_gtepur006
integer x = 2583
integer y = 48
integer width = 398
integer height = 100
integer taborder = 50
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-30"), Time("09:25:29.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtepur006
integer x = 1893
integer y = 48
integer width = 398
integer height = 100
integer taborder = 40
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-30"), Time("09:25:29.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gtepur006
integer x = 2309
integer y = 68
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

type st_1 from statictext within w_gtepur006
integer x = 1568
integer y = 68
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

type cb_2 from commandbutton within w_gtepur006
integer x = 2994
integer y = 44
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

ls_frym =dp_1.text
ls_toym =dp_2.text

if rb_1.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	if rb_3.checked then
		dw_1.retrieve(ls_frym,ls_toym,'B')
	elseif rb_4.checked then
		dw_1.retrieve(ls_frym,ls_toym,'A')
	end if	
elseif rb_2.checked then
	dw_1.hide()
	dw_2.show()
	dw_2.settransobject(sqlca)
	if rb_3.checked then
		dw_2.retrieve(ls_frym,ls_toym,'B')
	elseif rb_4.checked then
		dw_2.retrieve(ls_frym,ls_toym,'A')
	end if
end if
end event

type cb_4 from commandbutton within w_gtepur006
integer x = 3264
integer y = 44
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

type gb_2 from groupbox within w_gtepur006
integer x = 937
integer y = 20
integer width = 553
integer height = 144
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_gtepur006
integer x = 37
integer y = 20
integer width = 878
integer height = 144
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from datawindow within w_gtepur006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 192
integer width = 3547
integer height = 1920
integer taborder = 50
string dataobject = "dw_gtepur006a"
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

type dw_1 from datawindow within w_gtepur006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 192
integer width = 3575
integer height = 1936
integer taborder = 60
string dataobject = "dw_gtepur006"
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

