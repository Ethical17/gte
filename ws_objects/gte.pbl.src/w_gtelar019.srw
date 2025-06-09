$PBExportHeader$w_gtelar019.srw
forward
global type w_gtelar019 from window
end type
type rb_2 from radiobutton within w_gtelar019
end type
type rb_1 from radiobutton within w_gtelar019
end type
type st_2 from statictext within w_gtelar019
end type
type cb_2 from commandbutton within w_gtelar019
end type
type cb_1 from commandbutton within w_gtelar019
end type
type gb_1 from groupbox within w_gtelar019
end type
type ddlb_1 from dropdownlistbox within w_gtelar019
end type
type dw_1 from datawindow within w_gtelar019
end type
end forward

global type w_gtelar019 from window
integer width = 3717
integer height = 2240
boolean titlebar = true
string title = "(Gtelar019) - Monthly PF"
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
st_2 st_2
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelar019 w_gtelar019

type variables
long ll_yrmn
n_cst_powerfilter iu_powerfilter
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

on w_gtelar019.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_2,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelar019.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text =string(today(),'yyyymm')

//setpointer(hourglass!)
//declare c1 cursor for
//select distinct ((nvl(LPW_YEAR,0) * 100) + nvl(LPW_MONTH,0)) yrmn from FB_LABOURPFWEEK
//order by ((nvl(LPW_YEAR,0) * 100) + nvl(LPW_MONTH,0)) desc;
//
//open c1;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c1 into :ll_yrmn;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(string(ll_yrmn))
//		fetch c1 into:ll_yrmn;
//	loop
//	close c1;
//end if



end event

type rb_2 from radiobutton within w_gtelar019
integer x = 1499
integer y = 44
integer width = 530
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LT - Temporary"
end type

type rb_1 from radiobutton within w_gtelar019
integer x = 1015
integer y = 44
integer width = 475
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LP - Permanent"
boolean checked = true
end type

type st_2 from statictext within w_gtelar019
integer x = 23
integer y = 44
integer width = 603
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month (YYYYMM)"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar019
integer x = 2345
integer y = 24
integer width = 265
integer height = 100
integer taborder = 20
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

type cb_1 from commandbutton within w_gtelar019
integer x = 2080
integer y = 24
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -10
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

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 or ddlb_1.text = '000000' then
	messagebox('Warning','Please Enter Year Month !!!')
	return 
end if

if long(ddlb_1.text) > long(string(today(),'YYYYMM')) then
	messagebox('Warning!','Year Month Should Not Be > Current Year Month, Please Check !!!')
	return 1
end if

if rb_1.checked then
	dw_1.retrieve(ddlb_1.text,'LP')
else
	dw_1.retrieve(ddlb_1.text,'LT')
end if

//if rb_1.checked then
//	dw_1.retrieve(em_1.text,'LP')
//else
//	dw_1.retrieve(em_1.text,'LT')
//end if

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

setpointer(arrow!)


end event

type gb_1 from groupbox within w_gtelar019
integer x = 987
integer width = 1070
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type ddlb_1 from dropdownlistbox within w_gtelar019
integer x = 635
integer y = 32
integer width = 338
integer height = 612
integer taborder = 40
integer textsize = -10
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

type dw_1 from datawindow within w_gtelar019
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 136
integer width = 3666
integer height = 1988
string dataobject = "dw_gtelar019"
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

