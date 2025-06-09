$PBExportHeader$w_gtelar048_mr_bs.srw
forward
global type w_gtelar048_mr_bs from window
end type
type cb_3 from commandbutton within w_gtelar048_mr_bs
end type
type ddlb_2 from dropdownlistbox within w_gtelar048_mr_bs
end type
type st_1 from statictext within w_gtelar048_mr_bs
end type
type cb_1 from commandbutton within w_gtelar048_mr_bs
end type
type cb_2 from commandbutton within w_gtelar048_mr_bs
end type
type st_2 from statictext within w_gtelar048_mr_bs
end type
type ddlb_1 from dropdownlistbox within w_gtelar048_mr_bs
end type
type dw_1 from datawindow within w_gtelar048_mr_bs
end type
end forward

global type w_gtelar048_mr_bs from window
integer width = 4279
integer height = 2604
boolean titlebar = true
string title = "(Gtelar048) - Wages Bank Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
ddlb_2 ddlb_2
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelar048_mr_bs w_gtelar048_mr_bs

type variables
long ll_pbno
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour, ls_type, ls_bank
datetime ld_dt
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

on w_gtelar048_mr_bs.create
this.cb_3=create cb_3
this.ddlb_2=create ddlb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.ddlb_2,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelar048_mr_bs.destroy
destroy(this.cb_3)
destroy(this.ddlb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy'),LWW_STARTDATE
  from FB_LABOURWEEKLYWAGES a, fb_LABOURWAGESWEEK b
  where a.LWW_ID=b.LWW_ID
order by LWW_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ld_dt;
	loop
	close c1;
end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct EMP_BANK_NAME from FB_employee order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_bank;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_bank)
		setnull(ls_bank);
		fetch c2 into :ls_bank;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'

setpointer(Arrow!)
end event

type cb_3 from commandbutton within w_gtelar048_mr_bs
integer x = 3840
integer y = 16
integer width = 334
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Genrate File"
boolean cancel = true
end type

event clicked;//string ls_rec_ty,ls_rec, ls_gsn,ls_gstn, ls_yymm
//string ls_doc_nat, ls_srfr, ls_srto, ls_srl
//double ld_cont,ld_cncl
//long ll_stno,ll_endno, ll_waybill, ll_season, ll_srlno
//double  ld_delvqnty
//integer li_filenum, li_rec, li_ctr
//li_ctr=0;
//setpointer(hourglass!) 
//
//string ls_fr_dt
//string ls_aa, ls_bb, ls_cc, ls_dd, ls_ee, ls_ff, ls_gg, ls_hh, ls_ii, ls_jj, ls_kk, ls_ll, ls_mm, ls_nn, ls_oo, ls_pp, ls_qq, ls_rr, ls_ss, ls_tt, ls_uu, ls_vv
//
//if isnull(ddlb_2.text) or len(ddlb_2.text) = 0  then
//	messagebox('Warning','Please Select Bank !!!')
//	return 
//end if
//
//if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
//	messagebox('Warning','Please Enter Week Start Date !!!')
//	return 
//else
//	
//	ls_fr_dt = left(ddlb_1.text,10)
//	
//	ls_bank = ddlb_2.text
//	
//	select to_number(substr(lWW_ID,4,13)) into :ll_srlno from fb_labourwagesweek where trunc(LWW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy');
//	if sqlca.sqlcode = -1 then
//		messagebox('Error : While Getting Week Serial No !!!',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	end if
//
//
//	if fileexists("c:\temp\LUXMI"+string(today(),"ddmmyy")+string(ll_srlno)+".xls") = true then
//		filedelete("c:\temp\LUXMI"+string(today(),"ddmmyy")+string(ll_srlno)+".xls")
//	end if
//	
//	li_filenum =  fileopen("c:\temp\LUXMI"+string(today(),"ddmmyy")+string(ll_srlno)+".xls",linemode!,write!,lockreadwrite!,replace!)
//	
//	DECLARE c1 CURSOR FOR
//    select 'H' aa, to_char(sysdate,'dd/mm/yyyy') bb, rpad('LUXMITEA',20,' ') cc, null dd, null ee, null ff, null gg, null hh, null ii, null jj, null kk, null ll, null mm, null nn, null oo, null pp, null qq, null rr, null ss, null tt, null uu, null vv from dual
//    union all
//    SELECT  'D','R41',lpad('01908130001061',15,'0') ss,rpad('LUXMITEA',35,' '), rpad(COM_ADD2,35,' '),rpad(COM_ADD3,35,' '),rpad(substr(UNIT_ADD,36,35),35,' '), EMP_IFSC_CODE, lpad(EMP_BANKAC_NO,34,'0'), rpad(a.EMP_NAME,35,' ') employeename, rpad(substr(UNIT_NAME,1,35),35,' '),rpad(substr(UNIT_ADD,1,35),35,' '),rpad(substr(UNIT_ADD,36,35),35,' '), rpad(' ',35,' '), rpad(b.LWW_ID,16,' '), to_char(sysdate,'dd/mm/yyyy') ,lpad(nvl(e.LABOUR_NETPAYABLEAMOUNT,0),11,0)||'.00' netpayable, rpad('WAGE PAYMENT',27,' '), rpad('',33,' '), rpad('',33,' '), rpad('',33,' '), rpad('',33,' ')
//     FROM   FB_EMPLOYEE a, FB_LABOURWAGESWEEK b, FB_LABOURSHEET c, FB_FIELD d, FB_LABOURWEEKLYWAGES e, (select COM_ADD2, COM_ADD3 from fb_company where COM_ID = '1' ), (select UNIT_ID, UNIT_NAME, UNIT_SHORTNAME, UNIT_ADD from fb_gardenmaster where nvl(UNIT_ACTIVE_IND,'N') = 'Y')
//     WHERE  c.FIELD_ID=d.FIELD_ID AND c.LS_ID=e.LS_ID AND b.LWW_ID=e.LWW_ID AND a.EMP_ID=e.LABOUR_ID AND 
//                      trunc(b.LWW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy') AND nvl(e.LABOUR_NETPAYABLEAMOUNT,0) > 0 and  EMP_BANKAC_NO is not null and 
//                      (:ls_bank = 'ALL' or upper(trim(EMP_BANK_NAME)) = :ls_bank)
//    union all
//    select 'F', lpad(to_char(sum(1)),5,0) cnt, lpad(to_char(sum(nvl(e.LABOUR_NETPAYABLEAMOUNT,0))),11,0)||'.00' netpayable, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null 
//     FROM   FB_EMPLOYEE a, FB_LABOURWAGESWEEK b, FB_LABOURSHEET c, FB_FIELD d, FB_LABOURWEEKLYWAGES e
//     WHERE  c.FIELD_ID=d.FIELD_ID AND c.LS_ID=e.LS_ID AND b.LWW_ID=e.LWW_ID AND a.EMP_ID=e.LABOUR_ID AND 
//                      trunc(b.LWW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy') AND nvl(e.LABOUR_NETPAYABLEAMOUNT,0) > 0 and  EMP_BANKAC_NO is not null and 
//                      (:ls_bank = 'ALL' or upper(trim(EMP_BANK_NAME)) = :ls_bank);
//	 
//	 open c1;
//	
//	 if sqlca.sqlcode = 0 then
//		
//		setnull(ls_aa); setnull(ls_bb); setnull(ls_cc); setnull(ls_dd); setnull(ls_ee); setnull(ls_ff); setnull(ls_gg); setnull(ls_hh); setnull(ls_ii); setnull(ls_jj); setnull(ls_kk); setnull(ls_ll); setnull(ls_mm); setnull(ls_nn); setnull(ls_oo); setnull(ls_pp); setnull(ls_qq); setnull(ls_rr); setnull(ls_ss); setnull(ls_tt); setnull(ls_uu); setnull(ls_vv);
//		ld_cont = 0; ld_cncl = 0; 
//		
//		fetch c1 into :ls_aa, :ls_bb, :ls_cc, :ls_dd, :ls_ee, :ls_ff, :ls_gg, :ls_hh, :ls_ii, :ls_jj, :ls_kk, :ls_ll, :ls_mm, :ls_nn, :ls_oo, :ls_pp, :ls_qq, :ls_rr, :ls_ss, :ls_tt, :ls_uu, :ls_vv;
//	
//		do while sqlca.sqlcode <> 100
//			
//			
//			if isnull(ls_aa) then; ls_aa=""; end if;
//			if isnull(ls_bb) then; ls_bb=""; end if;
//			if isnull(ls_cc) then; ls_cc=""; end if;
//			if isnull(ls_dd) then; ls_dd=""; end if;
//			if isnull(ls_ee) then; ls_ee=""; end if;
//			if isnull(ls_ff) then; ls_ff=""; end if;
//			if isnull(ls_gg) then; ls_gg=""; end if;
//			if isnull(ls_hh) then; ls_hh=""; end if;
//			if isnull(ls_ii) then; ls_ii=""; end if;
//			if isnull(ls_jj) then; ls_jj=""; end if;
//			if isnull(ls_kk) then; ls_kk=""; end if;
//			if isnull(ls_ll) then; ls_ll=""; end if;
//			if isnull(ls_mm) then; ls_mm=""; end if;
//			if isnull(ls_nn) then; ls_nn=""; end if;
//			if isnull(ls_oo) then; ls_oo=""; end if;
//			if isnull(ls_pp) then; ls_pp=""; end if;
//			if isnull(ls_qq) then; ls_qq=""; end if;
//			if isnull(ls_rr) then; ls_rr=""; end if;
//			if isnull(ls_ss) then; ls_ss=""; end if;
//			if isnull(ls_tt) then; ls_tt=""; end if;
//			if isnull(ls_uu) then; ls_uu=""; end if;
//			if isnull(ls_vv) then; ls_vv=""; end if;
//
//
////			if pos(ls_place_supp,"'") > 0 then; ls_place_supp = replace(ls_place_supp,pos(ls_place_supp,"'"),1,"`"); end if;
////			
////			if pos(ls_place_supp,",") > 0 then
////				do while pos(ls_place_supp,",") > 0
////					 ls_place_supp = replace(ls_place_supp,pos(ls_place_supp,","),1," "); 
////				loop
////			end if;
//
//			
//			//ls_rec = ls_doc_nat +"," + ls_srfr +"," + ls_srto +"," + string(ld_cont) + "," + string(ld_cncl)
//			ls_rec = ls_aa +"," +ls_bb +"," +ls_cc +"," +ls_dd +"," +ls_ee +"," +ls_ff +"," +ls_gg +"," +ls_hh +"," +ls_ii +"," +ls_jj +"," +ls_kk +"," +ls_ll +"," +ls_mm +"," +ls_nn +"," +ls_oo +"," +ls_pp +"," +ls_qq +"," +ls_rr +"," +ls_ss +"," +ls_tt +"," +ls_uu +"," +ls_vv
//	
//			
//			filewrite(li_filenum,ls_rec)
//		
////			update fb_saleadvice set sa_unitsend_dt = sysdate where sa_id = :ls_said;
////			
////			 if sqlca.sqlcode = -1 then
////				messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
////				rollback using sqlca;
////				return -1
////			end if
//			
//			li_rec++
//			li_ctr++
//			
//		setnull(ls_aa); setnull(ls_bb); setnull(ls_cc); setnull(ls_dd); setnull(ls_ee); setnull(ls_ff); setnull(ls_gg); setnull(ls_hh); setnull(ls_ii); setnull(ls_jj); setnull(ls_kk); setnull(ls_ll); setnull(ls_mm); setnull(ls_nn); setnull(ls_oo); setnull(ls_pp); setnull(ls_qq); setnull(ls_rr); setnull(ls_ss); setnull(ls_tt); setnull(ls_uu); setnull(ls_vv);
//		ld_cont = 0; ld_cncl = 0; 
//		
//		fetch c1 into :ls_aa, :ls_bb, :ls_cc, :ls_dd, :ls_ee, :ls_ff, :ls_gg, :ls_hh, :ls_ii, :ls_jj, :ls_kk, :ls_ll, :ls_mm, :ls_nn, :ls_oo, :ls_pp, :ls_qq, :ls_rr, :ls_ss, :ls_tt, :ls_uu, :ls_vv;
//		
//		loop
//		close c1;
//	else
//		messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
//		return -1
//	end if
//	
//	fileclose(li_filenum)
//	
//	setpointer(arrow!) 
//	messagebox('Confirmation, File Generated Successfully !','Total No Of Records : '+string(li_ctr))
//	return 1
//end if
//
//
end event

type ddlb_2 from dropdownlistbox within w_gtelar048_mr_bs
integer x = 1842
integer y = 20
integer width = 1422
integer height = 608
integer taborder = 30
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

type st_1 from statictext within w_gtelar048_mr_bs
integer x = 9
integer y = 32
integer width = 475
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start && End Date : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar048_mr_bs
integer x = 3291
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
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

if isnull(ddlb_1.text)  then
	messagebox('Warning','Please Enter Week Start Date !!!')
	return 
end if

if isnull(ddlb_2.text)  then
	messagebox('Warning','Please Select Bank !!!')
	return 
end if


string ls_fr_dt

ls_fr_dt = left(ddlb_1.text,10)

ls_bank = ddlb_2.text
//if cbx_1.checked then
//	dw_1.dataobject = 'dw_gtelar048_mrcl'
//	dw_1.settransobject(sqlca)
//	dw_1.retrieve(ls_fr_dt,ls_bank,gs_garden_snm,'07/07/2018','123456789')
//else
//	dw_1.dataobject = 'dw_gtelar048_mr'
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ls_fr_dt,ls_bank,gs_garden_snm)
//end if

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar048_mr_bs
integer x = 3557
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
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

type st_2 from statictext within w_gtelar048_mr_bs
integer x = 1673
integer y = 32
integer width = 169
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bank"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar048_mr_bs
integer x = 485
integer y = 20
integer width = 1152
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

event selectionchanged;ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
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
end event

type dw_1 from datawindow within w_gtelar048_mr_bs
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4215
integer height = 2372
string dataobject = "dw_gtelar048_mr"
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

