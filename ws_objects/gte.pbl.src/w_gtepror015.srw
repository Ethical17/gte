$PBExportHeader$w_gtepror015.srw
forward
global type w_gtepror015 from window
end type
type dp_2 from datepicker within w_gtepror015
end type
type st_3 from statictext within w_gtepror015
end type
type ddlb_1 from dropdownlistbox within w_gtepror015
end type
type st_2 from statictext within w_gtepror015
end type
type dp_1 from datepicker within w_gtepror015
end type
type st_1 from statictext within w_gtepror015
end type
type cb_2 from commandbutton within w_gtepror015
end type
type cb_4 from commandbutton within w_gtepror015
end type
type dw_1 from datawindow within w_gtepror015
end type
end forward

global type w_gtepror015 from window
integer width = 3694
integer height = 2736
boolean titlebar = true
string title = "(w_gtepror015) Daily Ball And Shootcount"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
st_3 st_3
ddlb_1 ddlb_1
st_2 st_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtepror015 w_gtepror015

type variables
boolean lb_neworder, lb_query
string ls_rundt,ls_temp, ls_supid, ls_frdt,ls_todt
date ld_date
long ll_pos
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

on w_gtepror015.create
this.dp_2=create dp_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.st_3,&
this.ddlb_1,&
this.st_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtepror015.destroy
destroy(this.dp_2)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;string ls_suptmp, ls_supidtmp
dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

declare c1 cursor for 
select sup_id,sup_name from fb_supplier where sup_type in ('GLS') order by sup_name;

ddlb_1.additem('ALL')
 
 open c1;
 
 if sqlca.sqlcode = 0 then
 	fetch c1 into :ls_supidtmp, :ls_suptmp;
 	do while sqlca.sqlcode<>100
		if ls_supidtmp<>'SUP00001' then
			ddlb_1.additem( ls_supidtmp + " - "+ls_suptmp)
		end if
		fetch c1 into :ls_supidtmp, :ls_suptmp;
	loop
	close c1;
END IF



lb_neworder = false

setpointer(hourglass!)

setpointer(arrow!)



end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type dp_2 from datepicker within w_gtepror015
integer x = 759
integer y = 20
integer width = 375
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-17"), Time("14:31:06.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
boolean valueset = true
end type

type st_3 from statictext within w_gtepror015
integer x = 640
integer y = 36
integer width = 160
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To : "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtepror015
integer x = 1440
integer y = 24
integer width = 1253
integer height = 456
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtepror015
integer x = 1170
integer y = 36
integer width = 274
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtepror015
integer x = 229
integer y = 20
integer width = 375
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-01"), Time("12:32:53.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
boolean valueset = true
end type

type st_1 from statictext within w_gtepror015
integer x = 37
integer y = 36
integer width = 206
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtepror015
integer x = 2747
integer y = 20
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)
setpointer(hourglass!)
if ddlb_1.text = 'ALL' then
	setnull(ls_supid)
else
	ll_pos = pos(ddlb_1.text,"-")
	ls_supid = left(ddlb_1.text,ll_pos - 2)
end if
ls_frdt = dp_1.text
ls_todt = dp_2.text
if date(ls_frdt) > date(ls_todt) then
	messagebox("Warning","From Date Can Not Be Greater Than To Date")
	return 1
end if
if isnull(ls_frdt) or ls_frdt = "00/00/0000" then
	messagebox("Warning","Please Enter From Date")
	return 1
end if
if isnull(ls_todt) or ls_todt = "00/00/0000" then
	messagebox("Warning","Please Enter Valid To Date")
	return 1
end if
dw_1.retrieve(ls_supid,ls_frdt,ls_todt)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
setpointer(arrow!)
end event

type cb_4 from commandbutton within w_gtepror015
integer x = 3017
integer y = 20
integer width = 265
integer height = 100
integer taborder = 60
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

type dw_1 from datawindow within w_gtepror015
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 144
integer width = 3607
integer height = 1936
string dataobject = "dw_gtepror015"
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

