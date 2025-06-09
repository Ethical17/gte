$PBExportHeader$w_gteacr002.srw
forward
global type w_gteacr002 from window
end type
type dp_1 from datepicker within w_gteacr002
end type
type dp_2 from datepicker within w_gteacr002
end type
type ddlb_1 from dropdownlistbox within w_gteacr002
end type
type em_1 from editmask within w_gteacr002
end type
type cb_2 from commandbutton within w_gteacr002
end type
type cb_1 from commandbutton within w_gteacr002
end type
type st_5 from statictext within w_gteacr002
end type
type st_4 from statictext within w_gteacr002
end type
type st_2 from statictext within w_gteacr002
end type
type st_1 from statictext within w_gteacr002
end type
type dw_1 from datawindow within w_gteacr002
end type
end forward

global type w_gteacr002 from window
integer width = 4101
integer height = 2228
boolean titlebar = true
string title = "(W_gteacr002) Cash Book"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_1 dp_1
dp_2 dp_2
ddlb_1 ddlb_1
em_1 em_1
cb_2 cb_2
cb_1 cb_1
st_5 st_5
st_4 st_4
st_2 st_2
st_1 st_1
dw_1 dw_1
end type
global w_gteacr002 w_gteacr002

type variables
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

on w_gteacr002.create
this.dp_1=create dp_1
this.dp_2=create dp_2
this.ddlb_1=create ddlb_1
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.dp_1,&
this.dp_2,&
this.ddlb_1,&
this.em_1,&
this.cb_2,&
this.cb_1,&
this.st_5,&
this.st_4,&
this.st_2,&
this.st_1,&
this.dw_1}
end on

on w_gteacr002.destroy
destroy(this.dp_1)
destroy(this.dp_2)
destroy(this.ddlb_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca);
this.tag = Message.StringParm
ll_user_level = long(this.tag)

em_1.text = gs_CO_ID
ddlb_1.text = gs_garden_snm

end event

type dp_1 from datepicker within w_gteacr002
integer x = 1463
integer width = 352
integer height = 100
integer taborder = 10
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("10:20:31.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_2 from datepicker within w_gteacr002
integer x = 1989
integer width = 357
integer height = 100
integer taborder = 20
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("10:20:31.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type ddlb_1 from dropdownlistbox within w_gteacr002
integer x = 864
integer y = 8
integer width = 274
integer height = 252
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 134217750
boolean enabled = false
boolean autohscroll = true
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_gteacr002
integer x = 421
integer y = 8
integer width = 146
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "0"
string minmax = "1~~6"
end type

type cb_2 from commandbutton within w_gteacr002
integer x = 2702
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

type cb_1 from commandbutton within w_gteacr002
integer x = 2437
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;
if len(em_1.text) <> 1 or isnull(em_1.text) then 
	messagebox('Error At Company Code','The Company Code Should Not Be Blank')
	return 1
end if;

if len(ddlb_1.text) <> 2 or isnull(ddlb_1.text) then 
	messagebox('Error At Unit Code','The Unit Code Should Not Be Blank')
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

string ls_co_cd,ls_div_cd,ls_fr_dt,ls_to_dt,ls_frdt,ls_depo_cd
double ld_opn, ld_damt, ld_camt
em_1.text=gs_CO_ID
ddlb_1.text=gs_garden_snm
ls_co_cd  = em_1.text
ls_div_cd = ddlb_1.text
ls_fr_dt   = dp_1.text
ls_frdt = dp_1.text
ls_to_dt   = dp_2.text

setpointer(hourglass!)
ld_opn=0;	


/// nvl(vh_co_id,'1') = nvl(:ls_co_cd,'1')  and
SELECT  sum(DECODE(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)) into :ld_opn
     from fb_vou_head,fb_vou_det,fb_acledger a,fb_acsubledger b
 WHERE vh_doc_srl = vd_doc_srl and VD_GL_CD = a.ACLEDGER_ID and VD_SGL_CD= ACSUBLEDGER_ID and
 			ACLEDGER_LEDGERTYPE ='CASH' and 
			nvl(vh_unit_id,'aa') = nvl(:ls_div_cd,'aa')  and
       	    trunc(VH_VOU_DATE) < to_date(:ls_fr_dt,'dd/mm/yyyy')  and vh_approved_dt is not null ;

if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During The Debit/Credit Select',sqlca.sqlerrtext)
	return 1
end if;

setpointer(arrow!)

commit using sqlca;

dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,ls_div_cd,ls_fr_dt,ls_to_dt,ld_opn)


end event

type st_5 from statictext within w_gteacr002
integer x = 1865
integer y = 16
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

type st_4 from statictext within w_gteacr002
integer x = 1166
integer y = 16
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

type st_2 from statictext within w_gteacr002
integer x = 590
integer y = 16
integer width = 283
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unit Code"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteacr002
integer x = 23
integer y = 16
integer width = 398
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Company Code"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr002
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 14
integer y = 104
integer width = 3822
integer height = 1980
string dataobject = "dw_gteacr002"
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

event clicked;//if row > 0 then
//	gs_opt = dw_1.getitemstring(row,'vh_vou_type')
//	gs_vou_no = dw_1.getitemstring(row,'vh_vou_no')
//	if not isnull(gs_vou_no)  and len(gs_vou_no) > 0 then
//		opensheetwithparm(w_gteacr001,ll_user_level,w_mdi,0,layered!)
//	end if
//END IF
end event

