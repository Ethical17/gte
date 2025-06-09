$PBExportHeader$w_gtelar010mt.srw
forward
global type w_gtelar010mt from window
end type
type rb_3 from radiobutton within w_gtelar010mt
end type
type rb_2 from radiobutton within w_gtelar010mt
end type
type rb_1 from radiobutton within w_gtelar010mt
end type
type ddlb_2 from dropdownlistbox within w_gtelar010mt
end type
type st_2 from statictext within w_gtelar010mt
end type
type st_3 from statictext within w_gtelar010mt
end type
type cb_2 from commandbutton within w_gtelar010mt
end type
type cb_1 from commandbutton within w_gtelar010mt
end type
type ddlb_1 from dropdownlistbox within w_gtelar010mt
end type
type gb_1 from groupbox within w_gtelar010mt
end type
type dw_1 from datawindow within w_gtelar010mt
end type
type dw_2 from datawindow within w_gtelar010mt
end type
type dw_3 from datawindow within w_gtelar010mt
end type
end forward

global type w_gtelar010mt from window
integer width = 3904
integer height = 2456
boolean titlebar = true
string title = "(Gtelar010) - Ration Distribution"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
ddlb_2 ddlb_2
st_2 st_2
st_3 st_3
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_gtelar010mt w_gtelar010mt

type variables
string ls_LWW_ID ,ls_division
long ll_si,ll_pbno
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if rb_1.checked then
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
elseif rb_2.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_2)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
elseif rb_3.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_3)
		case "PRINTPREVIEW"
				this.dw_3.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_3.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_3)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_3.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_3.setredraw(false)
				this.dw_3.setfilter(gs_filtertext)
				this.dw_3.filter()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_3.setredraw(false)
				this.dw_3.setsort(gs_sorttext)
				this.dw_3.sort()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose		
end if
end event

on w_gtelar010mt.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.ddlb_2,&
this.st_2,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_gtelar010mt.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)

setpointer(hourglass!)
string ls_dt, ls_period

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(RPFW_STARTDATE,'dd/mm/yyyy')||' - '||to_char(RPFW_ENDDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')') lww_id,rpfw_startdate
   from fb_labourweeklyration a, fb_rationperiodforweek b 
   where a.LRW_ID = b.RPFW_ID
 order by rpfw_startdate desc;

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if

ddlb_2.reset()
//ddlb_2.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

//ddlb_2.text = 'ALL'
setpointer(arrow!)
end event

type rb_3 from radiobutton within w_gtelar010mt
integer x = 599
integer y = 124
integer width = 320
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Work"
end type

type rb_2 from radiobutton within w_gtelar010mt
integer x = 379
integer y = 124
integer width = 233
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "New"
boolean checked = true
end type

type rb_1 from radiobutton within w_gtelar010mt
integer x = 178
integer y = 124
integer width = 210
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Old"
end type

type ddlb_2 from dropdownlistbox within w_gtelar010mt
integer x = 1755
integer y = 16
integer width = 928
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

type st_2 from statictext within w_gtelar010mt
integer x = 1536
integer y = 24
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelar010mt
integer x = 23
integer y = 24
integer width = 352
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ration Weeks"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar010mt
integer x = 1216
integer y = 112
integer width = 256
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gtelar010mt
integer x = 960
integer y = 112
integer width = 256
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select A Ration Week !!!')
	return 
end if

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Select A Division !!!')
	return 
end if

ls_division = left(right(ddlb_2.text,6),5)

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

if rb_1.checked then 
	dw_2.visible = false
	dw_3.visible = false
	dw_1.visible = true
	dw_1.retrieve(left(right(ddlb_1.text,15),14),ls_division)
elseif rb_2.checked then
	dw_1.visible = false
	dw_3.visible = false
	dw_2.visible = true	
	dw_2.retrieve(left(right(ddlb_1.text,15),14),ls_division)
elseif rb_3.checked then
	dw_1.visible = false
	dw_2.visible = false
	dw_3.visible = true	
	dw_3.retrieve(left(right(ddlb_1.text,15),14),ls_division)	
end if
//dw_1.retrieve(left(right(ddlb_1.text,9),8),ls_division)
if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if

end event

type ddlb_1 from dropdownlistbox within w_gtelar010mt
integer x = 375
integer y = 16
integer width = 1147
integer height = 1104
integer taborder = 10
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

type gb_1 from groupbox within w_gtelar010mt
integer x = 155
integer y = 88
integer width = 777
integer height = 128
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gtelar010mt
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 216
integer width = 3849
integer height = 2104
string dataobject = "dw_gtelar010mt"
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

type dw_2 from datawindow within w_gtelar010mt
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 216
integer width = 3849
integer height = 2104
integer taborder = 30
string dataobject = "dw_gtelar010mt_n"
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

type dw_3 from datawindow within w_gtelar010mt
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 216
integer width = 3849
integer height = 2104
integer taborder = 40
string dataobject = "dw_gtelar010mt_nw"
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

