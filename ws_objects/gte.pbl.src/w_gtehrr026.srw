$PBExportHeader$w_gtehrr026.srw
forward
global type w_gtehrr026 from window
end type
type ddlb_1 from dropdownlistbox within w_gtehrr026
end type
type st_5 from statictext within w_gtehrr026
end type
type em_2 from editmask within w_gtehrr026
end type
type st_3 from statictext within w_gtehrr026
end type
type ddlb_3 from dropdownlistbox within w_gtehrr026
end type
type st_4 from statictext within w_gtehrr026
end type
type cb_1 from commandbutton within w_gtehrr026
end type
type cb_2 from commandbutton within w_gtehrr026
end type
type dw_1 from datawindow within w_gtehrr026
end type
end forward

global type w_gtehrr026 from window
integer width = 4078
integer height = 2420
boolean titlebar = true
string title = "(Gtehrr026) All Deductions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_5 st_5
em_2 em_2
st_3 st_3
ddlb_3 ddlb_3
st_4 st_4
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtehrr026 w_gtehrr026

type variables
string  ls_yrmn,ls_lwawid,ls_lwawid1,ls_dt, ls_type,ls_ym, ls_ded_ty, ls_emptype
long ll_pbno
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();
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


end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtehrr026.create
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.em_2=create em_2
this.st_3=create st_3
this.ddlb_3=create ddlb_3
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_5,&
this.em_2,&
this.st_3,&
this.ddlb_3,&
this.st_4,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtehrr026.destroy
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.ddlb_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_CO_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

setpointer(hourglass!)
declare c3 cursor for
select DM_NAME from fb_emp_dedtype_master order by 1;

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
	em_2.text = left(gs_opt,4)+'-'+right(gs_opt,2)
	ddlb_1.text =gs_opt1
	ddlb_3.text =gs_opt2
	dw_1.retrieve(gs_opt,gs_opt1,gs_opt2)
	//cb_1.PostEvent(Clicked!)
end if



end event

type ddlb_1 from dropdownlistbox within w_gtehrr026
integer x = 2021
integer y = 24
integer width = 379
integer height = 316
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ST-Staff","SS-Sub Staff","AT-Apprentice"}
end type

type st_5 from statictext within w_gtehrr026
integer x = 1778
integer y = 36
integer width = 238
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emp Type"
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtehrr026
integer x = 352
integer y = 32
integer width = 279
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
end type

type st_3 from statictext within w_gtehrr026
integer x = 32
integer y = 40
integer width = 315
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtehrr026
integer x = 1093
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

type st_4 from statictext within w_gtehrr026
integer x = 654
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

type cb_1 from commandbutton within w_gtehrr026
integer x = 2533
integer y = 20
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
	messagebox('Alert!','Please Select Employee Type !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text  = '0000-00' then
	messagebox('Alert!','Please Enter Valid Year Month !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if

dw_1.reset()

ls_ym = left(em_2.text,4) + right(em_2.text,2)

ls_ded_ty  = ddlb_3.text

ls_emptype = left(ddlb_1.text,2)

dw_1.retrieve(ls_ym, trim(ls_emptype) , trim(ls_ded_ty))


setpointer(arrow!)
if dw_1.rowcount() = 0  then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtehrr026
integer x = 2798
integer y = 20
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

type dw_1 from datawindow within w_gtehrr026
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 14
integer y = 136
integer width = 3941
integer height = 2124
string dataobject = "dw_gtehrr026"
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

