$PBExportHeader$w_gteacr034.srw
forward
global type w_gteacr034 from window
end type
type st_3 from statictext within w_gteacr034
end type
type ddlb_1 from dropdownlistbox within w_gteacr034
end type
type em_2 from editmask within w_gteacr034
end type
type st_1 from statictext within w_gteacr034
end type
type rb_2 from radiobutton within w_gteacr034
end type
type rb_1 from radiobutton within w_gteacr034
end type
type cb_3 from commandbutton within w_gteacr034
end type
type st_2 from statictext within w_gteacr034
end type
type em_1 from editmask within w_gteacr034
end type
type cb_2 from commandbutton within w_gteacr034
end type
type cb_1 from commandbutton within w_gteacr034
end type
type gb_1 from groupbox within w_gteacr034
end type
type dw_1 from datawindow within w_gteacr034
end type
end forward

global type w_gteacr034 from window
integer width = 4603
integer height = 2408
boolean titlebar = true
string title = "W_Gteacr034- TDS Detail"
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
em_2 em_2
st_1 st_1
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
st_2 st_2
em_1 em_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
end type
global w_gteacr034 w_gteacr034

type variables
////string ls_veh_no,ls_emp_name,ls_str,ls_ts_ind
n_cst_powerfilter iu_powerfilter
string ls_ts_ind, ls_ledger, ls_so
end variables

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

on w_gteacr034.create
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.em_2=create em_2
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.st_2=create st_2
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.ddlb_1,&
this.em_2,&
this.st_1,&
this.rb_2,&
this.rb_1,&
this.cb_3,&
this.st_2,&
this.em_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_1}
end on

on w_gteacr034.destroy
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
em_1.text = string(today(),'YYYYMM')
dw_1.modify("t_co.text = '"+gs_co_name+"'")

dw_1.settransobject(sqlca)


ddlb_1.additem('ALL')

declare c1 cursor for
select initcap(ACLEDGER_MANID)||' ['||ACLEDGER_ID||']' ledger, ACLEDGER_TDS_IND from fb_acledger where nvl(ACLEDGER_TDS_IND,'N') in ('Y') order by 2 desc;
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_ledger, :ls_so;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_ledger)
		fetch c1 into :ls_ledger, :ls_so;
	loop
	close c1;
end if

ddlb_1.text='ALL'
setpointer(arrow!)


//select co_cd,vou_no,rec_type,tds_accd,initcap(ACLEDGER_MANID)||'('||tds_accd||')' tds_name,tds_type,party_cd,CC_MANID pm_name,pan,
//         SUM(NVL(amt_on_tds,0)) amt_on_tds,
//	     date_which_amt_paid,it_rate,
//	     it_rate Consolidate_tds,
//         SUM(NVL(i_tax_amt,0)) i_tax_amt,
//         SUM(NVL(tot_tds_amt,0)) tot_tds_amt,to_char(to_date(:fr_yymm,'YYYYMM'),'Mon-YYYY') yymm,
//		(co_cd||' '||vou_no||' '||rec_type||' '||tds_accd||' '||initcap(ACLEDGER_MANID)||'('||tds_accd||')'||' '||tds_type||' '||party_cd||' '||CC_MANID) vousearch 
//from (  select VH_CO_ID co_cd,VH_VOU_NO vou_no,'VOU' rec_type,VD_GL_CD tds_accd,VD_DC_IND,
//		           null tds_type,VD_COSTCENTER_ID party_cd,
//			      sum(nvl(VD_ORIGINAL_AMT,0)) amt_on_tds,VH_VOU_DATE date_which_amt_paid,
//			      nvl(VD_TDS_PER,0) it_rate,
//			      sum(round(nvl(VD_AMOUNT,0),0)) i_tax_amt,
//			     sum(round(nvl(VD_AMOUNT,0),0)) tot_tds_amt				
//		  from fb_vou_head,fb_vou_det,fb_acledger
//		where VH_DOC_SRL = VD_DOC_SRL and VH_APPROVED_BY is not null and VD_GL_CD=ACLEDGER_ID(+) and vh_status <> 'C' and
//			     to_char(VH_VOU_DATE,'YYYYMM')=:fr_yymm and ((:ra_ts_ind = 'S' and nvl(ACLEDGER_TDS_IND,'N') = 'S') or (:ra_ts_ind = 'T' and  nvl(ACLEDGER_TDS_IND,'N')='Y')) 
//		 group by VH_CO_ID ,VH_VOU_NO,'VOU', VD_GL_CD,VD_DC_IND,VD_COSTCENTER_ID,
//		          VH_VOU_DATE,nvl(VD_TDS_PER,0)) tds_temp,fb_costcentre,fb_acledger,
//         ( select 'S' ty, CC_ID id, SUP_PAN pan from fb_supplier where SUP_ACTIVE = '1'
//          union select 'B' ty, CC_ID id, BROK_PANNO pan from fb_broker where BROK_ACTIVE = '1'
//          union  select 'C',CC_ID, CUS_PANNO  from  fb_customer where CUS_ACTIVE = '1'
//          union select 'T', CC_ID, CARRIER_PANNO  from  fb_carrier where CARRIER_ACTIVE = '1') sup
// where party_cd =CC_ID (+) and party_cd = id(+) and tds_accd=ACLEDGER_ID(+) and VD_DC_IND = 'C'
//GROUP BY co_cd,vou_no,rec_type,tds_accd,initcap(ACLEDGER_MANID)||'('||tds_accd||')',tds_type,party_cd,CC_MANID,
//          date_which_amt_paid,it_rate,(co_cd||' '||vou_no||' '||rec_type||' '||tds_accd||' '||initcap(ACLEDGER_MANID)||'('||tds_accd||')'||' '||tds_type||' '||party_cd||' '||CC_MANID),pan
end event

type st_3 from statictext within w_gteacr034
integer x = 1984
integer y = 44
integer width = 270
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ledger :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr034
integer x = 2267
integer y = 36
integer width = 1394
integer height = 960
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_gteacr034
integer x = 901
integer y = 32
integer width = 251
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
end type

type st_1 from statictext within w_gteacr034
integer x = 763
integer y = 48
integer width = 146
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gteacr034
integer x = 1504
integer y = 44
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "TDS Bill No"
end type

event clicked;//ddlb_1.additem('ALL')
//
//declare c1 cursor for
//select initcap(ACLEDGER_MANID)||' ['||ACLEDGER_ID||']' ledger, ACLEDGER_TDS_IND from fb_acledger where nvl(ACLEDGER_TDS_IND,'N') in ('S') order by 2 desc;
//open c1;
//
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_ledger, :ls_so;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(ls_ledger)
//		fetch c1 into :ls_ledger, :ls_so;
//	loop
//	close c1;
//end if
//
//ddlb_1.text='ALL'
//setpointer(arrow!)
ddlb_1.additem('ALL')

declare c1 cursor for
select initcap(ACLEDGER_MANID)||' ['||ACLEDGER_ID||']' ledger, ACLEDGER_TDS_IND from fb_acledger where nvl(ACLEDGER_TDS_IND,'N') in ('Y') order by 2 desc;
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_ledger, :ls_so;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_ledger)
		fetch c1 into :ls_ledger, :ls_so;
	loop
	close c1;
end if

ddlb_1.text='ALL'
setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gteacr034
integer x = 1225
integer y = 44
integer width = 242
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tds"
boolean checked = true
end type

event clicked;ddlb_1.additem('ALL')

declare c1 cursor for
select initcap(ACLEDGER_MANID)||' ['||ACLEDGER_ID||']' ledger, ACLEDGER_TDS_IND from fb_acledger where nvl(ACLEDGER_TDS_IND,'N') in ('Y') order by 2 desc;
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_ledger, :ls_so;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_ledger)
		fetch c1 into :ls_ledger, :ls_so;
	loop
	close c1;
end if

ddlb_1.text='ALL'
setpointer(arrow!)
end event

type cb_3 from commandbutton within w_gteacr034
integer x = 3968
integer y = 32
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Search"
boolean cancel = true
end type

event clicked;SetPointer (HourGlass!)											
OpenwithParm (w_search,dw_1)
SetPointer (Arrow!)			
end event

type st_2 from statictext within w_gteacr034
integer x = 50
integer y = 44
integer width = 430
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Year-Month:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gteacr034
integer x = 498
integer y = 28
integer width = 251
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
end type

type cb_2 from commandbutton within w_gteacr034
integer x = 4238
integer y = 32
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacr034
integer x = 3698
integer y = 32
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if isnull(em_1.text) then
      messagebox('Year-Month Error','From Year/Month Is Blank, Please Enter The Year-Month.')
      return 1
end if;

if isnull(em_2.text) then
      messagebox('Year-Month Error','To Year/Month Is Blank, Please Enter The Year-Month.')
      return 1
end if;

if rb_1.checked then
	ls_ts_ind = 'T'
	dw_1.settransobject(sqlca)
	dw_1.dataobject='dw_gteacr034'
elseif rb_2.checked then
	ls_ts_ind = 'B'
	dw_1.settransobject(sqlca)
	dw_1.dataobject='dw_gteacr034_b'
end if

ls_ledger = left(right(ddlb_1.text,10),9)

dw_1.settransobject(sqlca)
dw_1.retrieve((left(em_1.text,4)+right(em_1.text,2)),(left(em_2.text,4)+right(em_2.text,2)),ls_ts_ind, ls_ledger)

if dw_1.rowcount() = 0 then	
	messagebox('Alert!','No Data Found For Selected Year Month !!!')
	return 1
end if


end event

type gb_1 from groupbox within w_gteacr034
integer x = 1193
integer width = 731
integer height = 132
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

type dw_1 from datawindow within w_gteacr034
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 144
integer width = 4498
integer height = 2116
integer taborder = 40
string dataobject = "dw_gteacr034"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

