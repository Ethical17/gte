$PBExportHeader$w_gtelar055.srw
forward
global type w_gtelar055 from window
end type
type ddlb_3 from dropdownlistbox within w_gtelar055
end type
type st_4 from statictext within w_gtelar055
end type
type ddlb_2 from dropdownlistbox within w_gtelar055
end type
type st_2 from statictext within w_gtelar055
end type
type rb_2 from radiobutton within w_gtelar055
end type
type rb_1 from radiobutton within w_gtelar055
end type
type ddlb_1 from dropdownlistbox within w_gtelar055
end type
type st_3 from statictext within w_gtelar055
end type
type cb_1 from commandbutton within w_gtelar055
end type
type cb_2 from commandbutton within w_gtelar055
end type
type gb_1 from groupbox within w_gtelar055
end type
type dw_1 from datawindow within w_gtelar055
end type
type dw_2 from datawindow within w_gtelar055
end type
end forward

global type w_gtelar055 from window
integer width = 4078
integer height = 2420
boolean titlebar = true
string title = "(w_gtelar031) Fortnight Advance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_3 ddlb_3
st_4 st_4
ddlb_2 ddlb_2
st_2 st_2
rb_2 rb_2
rb_1 rb_1
ddlb_1 ddlb_1
st_3 st_3
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelar055 w_gtelar055

type variables
string  ls_yrmn,ls_lwawid,ls_lwawid1,ls_dt, ls_type, ls_ded_ty
long ll_pbno
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();if dw_1.visible = true then
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
		case "PDF"
				this.dw_1.saveas("C:\reports\Gtelar031.pdf",pdf!,true)
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
else
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
	case "PDF"
			this.dw_2.saveas("C:\reports\Gtelar031.pdf",pdf!,true)
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
end if

end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtelar055.create
this.ddlb_3=create ddlb_3
this.st_4=create st_4
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.ddlb_3,&
this.st_4,&
this.ddlb_2,&
this.st_2,&
this.rb_2,&
this.rb_1,&
this.ddlb_1,&
this.st_3,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtelar055.destroy
destroy(this.ddlb_3)
destroy(this.st_4)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_CO_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
dw_2.modify("t_co.text = '"+gs_CO_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.settransobject(sqlca)


setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy')||'-'||LWW_ID,LWW_ID
  from fb_LABOURWAGESWEEK b
  where lww_paidflag='0'
order by LWW_ID desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ls_lwawid;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ls_lwawid;
	loop
	close c1;
end if
setpointer(arrow!)


ddlb_2.reset()
ddlb_2.additem('0')

declare c2 cursor for
select distinct ls_id  from FB_EMPLOYEE a where emp_type in ('LP','LT','LO') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '0'


declare c3 cursor for
select DM_NAME from fb_dedtype_master order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_ded_ty;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_ded_ty)
		fetch c3 into :ls_ded_ty;
	loop
	close c3;
end if
setpointer(arrow!)


if not isnull(gs_opt) and len(trim(gs_opt) ) > 0 then
	ddlb_1.text = gs_opt
	ddlb_2.text =gs_opt1
	
	dw_1.retrieve(gs_opt,long(gs_opt1),gs_opt2)
	//cb_1.PostEvent(Clicked!)
end if

end event

type ddlb_3 from dropdownlistbox within w_gtelar055
integer x = 2025
integer y = 28
integer width = 649
integer height = 608
integer taborder = 40
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

event selectionchanged;//ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//setpointer(hourglass!)
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
//where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//ddlb_3.text = 'ALL'
//setpointer(Arrow!)
end event

type st_4 from statictext within w_gtelar055
integer x = 1586
integer y = 44
integer width = 443
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deduction Type : "
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtelar055
integer x = 3003
integer y = 28
integer width = 325
integer height = 608
integer taborder = 40
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

type st_2 from statictext within w_gtelar055
integer x = 2706
integer y = 40
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book "
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gtelar055
integer x = 3630
integer y = 32
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;dw_2.visible = true
dw_1.visible = false
end event

type rb_1 from radiobutton within w_gtelar055
integer x = 3374
integer y = 32
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_2.visible = false
dw_1.visible = true
end event

type ddlb_1 from dropdownlistbox within w_gtelar055
integer x = 443
integer y = 32
integer width = 1138
integer height = 608
integer taborder = 30
boolean bringtotop = true
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

event selectionchanged;//ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//setpointer(hourglass!)
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
//where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//ddlb_3.text = 'ALL'
//setpointer(Arrow!)
end event

type st_3 from statictext within w_gtelar055
integer x = 32
integer y = 44
integer width = 439
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Payment Week : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar055
integer x = 3479
integer y = 124
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

event clicked;dw_1.settransobject(sqlca)
string ls_ind
setpointer(hourglass!)

if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select  A Week ID !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text)  = 0 then
	messagebox('Alert!','Please Select  A Paybook !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if

ls_type = ddlb_3.text

ls_lwawid = right(trim(ddlb_1.text),13)
ll_pbno = long(ddlb_2.text)

if rb_1.checked then
	dw_1.retrieve(ls_lwawid,ll_pbno, ls_type)
elseif rb_2.checked then
	dw_2.retrieve(ls_lwawid,ll_pbno, ls_type)
end if

setpointer(arrow!)
if dw_1.rowcount() = 0 AND dw_2.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtelar055
integer x = 3744
integer y = 124
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

type gb_1 from groupbox within w_gtelar055
integer x = 3346
integer width = 645
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type dw_1 from datawindow within w_gtelar055
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 14
integer y = 232
integer width = 3941
integer height = 2028
string dataobject = "dw_gtelar055"
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

type dw_2 from datawindow within w_gtelar055
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 14
integer y = 232
integer width = 3461
integer height = 2028
integer taborder = 40
string dataobject = "dw_gtelar055a"
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

