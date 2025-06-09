$PBExportHeader$w_gteacf025.srw
forward
global type w_gteacf025 from window
end type
type cbx_1 from checkbox within w_gteacf025
end type
type cb_9 from commandbutton within w_gteacf025
end type
type cb_7 from commandbutton within w_gteacf025
end type
type cb_8 from commandbutton within w_gteacf025
end type
type cb_10 from commandbutton within w_gteacf025
end type
type dw_1 from datawindow within w_gteacf025
end type
type cb_4 from commandbutton within w_gteacf025
end type
type cb_3 from commandbutton within w_gteacf025
end type
type cb_2 from commandbutton within w_gteacf025
end type
type cb_1 from commandbutton within w_gteacf025
end type
end forward

global type w_gteacf025 from window
integer width = 4919
integer height = 2672
boolean titlebar = true
string title = "(w_ltcacf061) Payment Advice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
cbx_1 cbx_1
cb_9 cb_9
cb_7 cb_7
cb_8 cb_8
cb_10 cb_10
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_gteacf025 w_gteacf025

type variables
long ll_ctr,net, ll_cnt,ll_year,ll_user_level,ll_stage, ll_count,ll_retage, ll_doc_no, ll_vou_no, ll_acpd, ll_acyear
double ld_amt
boolean lb_neworder, lb_query
datetime ld_dob, ld_doj,ld_dt, ld_entry_dt

datawindowchild idw_paybook, idw_stage,idw_spouse_emp,idw_branch

long ll_docno, ll_doc_srl
string ls_party, ls_pledger, ls_dt, ls_temp,ls_ac_dt, ls_ym, ls_vou_no, ls_glcr, ls_gldr, ls_bledger, ls_bcd, ls_tmp_id, ls_appr_ind, ls_narr,ls_Chequeno,ls_Chequedt, ls_chqpay_to, ls_bac, ls_sup_acno, ls_smobile, ls_bfnm, ls_bbnm, ls_bbbrnm, ls_ifsc_cd
double ld_exp_amt, ls_sexp_amt, ld_pv_amt, ls_spv_amt, ld_net_amt, ls_sav_amt, ls_sdav_amt, ld_mpay1_amt, ld_mpay2_amt, ld_mded1_amt, ld_mded2_amt, ls_ddn_amt, ls_sddn_amt, ls_avd_amt, ls_savd_amt
datetime  ld_dofconf,ld_dofprm,ld_doflev
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer check_duplicate_fields (string fl_field, string fl_value, string fl_message)
public function integer wf_cal_netamt (string fs_field, double fd_val)
end prototypes

public function integer wf_check_fillcol (integer fl_row);//if employee_details.tabpage_1.dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_co_cd')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_co_cd'))=0 or &
//	    isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_emp_name')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_emp_name'))=0 or &
//	    isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_working_location')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_working_location'))=0 or &
//		isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_department')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_department'))=0 or &
//		isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_m_f_ind')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_m_f_ind'))=0 or &
//		isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_religion')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_religion'))=0 or &
//		isnull(employee_details.tabpage_1.dw_1.getitemdatetime(fl_row,'em_date_of_join')) or &
//		isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_temp_state')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_temp_state'))=0 or &
//		isnull(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_desg_cd')) or  len(employee_details.tabpage_1.dw_1.getitemstring(fl_row,'em_desg_cd'))=0 ) then
//		  messagebox('Warning: One Of The Following Fields Are Blank','Company,Employee code, Employee Name,  Date Of Joining, Gender, Religion, Working Location, Department, Designation Code, Please Check !!!')
//	    // messagebox('Warning: One Of The Following Fields Are Blank','Company,Employee code, Employee Name, Date Of Birth, Date Of Joining, Gender, Religion, Marital Status, Working Location, Department, Designation Code,Permanent/Local Address, City, Country, State, Pin, Please Check !!!')
//		 return -1
//	end if
//end if
return 1
end function

public function integer check_duplicate_fields (string fl_field, string fl_value, string fl_message);long fl_row
string  ls_value

//employee_details.tabpage_1.dw_1.SelectRow(0, FALSE)
//if employee_details.tabpage_1.dw_1.rowcount() > 1 then
//	for fl_row = 1 to (employee_details.tabpage_1.dw_1.rowcount() - 1)
//		if fl_field = 'em_pf_code' then
//			ls_value = string(employee_details.tabpage_1.dw_1.getitemnumber(fl_row,''+fl_field+''))
//		else
//			ls_value = employee_details.tabpage_1.dw_1.getitemstring(fl_row,''+fl_field+'')
//		end if;
//		
//		if ls_value = fl_value then
//			employee_details.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate "+fl_message +" At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 

return 1
end function

public function integer wf_cal_netamt (string fs_field, double fd_val);	if fs_field = 'pa_expn_vou_amt_sel' then
	    	ls_sexp_amt = fd_val 
	else
	    	ls_sexp_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_expn_vou_amt_sel')
	end if

	if fs_field = 'pa_purc_bill_amt_sel' then
		ls_spv_amt = fd_val
	else
		ls_spv_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_purc_bill_amt_sel')
	end if
	

	if fs_field = 'pa_adv_payment_amt_sel' then
		ls_sav_amt  = fd_val
	else
		ls_sav_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_adv_payment_amt_sel') 
	end if
	
	if fs_field = 'pa_misc1_pay_amt' then
		ld_mpay1_amt  = fd_val
	else
		ld_mpay1_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_misc1_pay_amt') 
	end if
	
	if fs_field = 'pa_misc2_pay_amt' then
		ld_mpay2_amt  = round(fd_val,0)
	else
		ld_mpay2_amt = round(dw_1.getitemnumber(dw_1.getrow(),'pa_misc2_pay_amt'),0) 
	end if	
	
	if fs_field = 'pa_debitnote_grn_amt_sel' then
		ls_sddn_amt  = fd_val
	else
		ls_sddn_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_debitnote_grn_amt_sel') 
	end if	
	
	if fs_field = 'pa_adv_dedn_amt_sel' then
		ls_sdav_amt  = fd_val
	else
		ls_sdav_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_adv_dedn_amt_sel') 
	end if	
	
	if fs_field = 'pa_misc1_dedn_amt' then
		ld_mded1_amt  = fd_val
	else
		ld_mded1_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_misc1_dedn_amt') 
	end if	
	
	if fs_field = 'pa_misc2_dedn_amt' then
		ld_mded2_amt  = fd_val
	else
		ld_mded2_amt =dw_1.getitemnumber(dw_1.getrow(),'pa_misc2_dedn_amt') 
	end if	
	
	
	if isnull(ls_sexp_amt) then ls_sexp_amt = 0;
	if isnull(ls_spv_amt) then ls_spv_amt = 0;
	if isnull(ls_sav_amt) then ls_sav_amt = 0;
	if isnull(ld_mpay1_amt) then ld_mpay1_amt = 0;
	if isnull(ld_mpay2_amt) then ld_mpay1_amt = 0;
	if isnull(ls_sdav_amt) then ls_sdav_amt = 0;
	
	if isnull(ld_mded1_amt) then ld_mded1_amt = 0;
	if isnull(ld_mded2_amt) then ld_mded2_amt = 0;

		

	ld_net_amt= ((ls_sexp_amt + ls_spv_amt  + ls_sav_amt + ld_mpay1_amt + ld_mpay2_amt)  - (ls_sddn_amt + ls_sdav_amt + ld_mded1_amt + ld_mded2_amt))
	dw_1.setitem(dw_1.getrow(),'pa_net_payable_amt',ld_net_amt)  

	
return 1
end function

on w_gteacf025.create
this.cbx_1=create cbx_1
this.cb_9=create cb_9
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_10=create cb_10
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cbx_1,&
this.cb_9,&
this.cb_7,&
this.cb_8,&
this.cb_10,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_gteacf025.destroy
destroy(this.cbx_1)
destroy(this.cb_9)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_10)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
lb_query = false	
lb_neworder = false


dw_1.settransobject(sqlca)



this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

type cbx_1 from checkbox within w_gteacf025
integer x = 1175
integer y = 28
integer width = 425
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
boolean checked = true
end type

type cb_9 from commandbutton within w_gteacf025
integer x = 4622
integer y = 12
integer width = 142
integer height = 88
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_7 from commandbutton within w_gteacf025
integer x = 4485
integer y = 12
integer width = 142
integer height = 88
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_8 from commandbutton within w_gteacf025
integer x = 4347
integer y = 12
integer width = 142
integer height = 88
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_10 from commandbutton within w_gteacf025
integer x = 4210
integer y = 12
integer width = 142
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type dw_1 from datawindow within w_gteacf025
integer x = 37
integer y = 112
integer width = 4745
integer height = 1932
integer taborder = 90
string title = "none"
string dataobject = "dw_gteacf025"
boolean livescroll = true
end type

event itemchanged;if lb_query = false then
	
	if dwo.name = 'pa_party_cd' then
			ls_party = trim(data)
			ls_dt = string(dw_1.getitemdatetime(row,'pa_acct_processing_dt'),'dd/mm/yyyy')
			
			select ACSUBLEDGER_ID into :ls_pledger  from fb_supplier where SUP_ID = :ls_party;
			
			select sum(decode(VD_DC_IND,'D',-1,1) * nvl(VD_AMOUNT,0)) ,
							 sum(decode(NVL(VD_PAYMENT_ADV_IND,'N'),'Y',(decode(VD_DC_IND,'D',-1,1) * nvl(VD_AMOUNT,0)),0)) amt into :ld_exp_amt, :ls_sexp_amt
			from fb_vou_det 
			where VD_DOC_SRL in (select VH_DOC_SRL from fb_vou_head  where vh_vou_type ='EXPV' and  vh_approved_by is not null and 
											VH_VOU_DATE >= to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy') and 
											(nvl(VH_payment_adv_no,0) =0 or nvl(VH_payment_adv_no,0) = :ll_docno) and VH_VOU_DATE >to_date('31/03/2023','dd/mm/yyyy') ) and
											VD_sGL_CD = (select ACSUBLEDGER_ID from fb_supplier where SUP_ID = :ls_party) and nvl(vd_payment_adv_ind,'N') = 'N'; //SUP00590
											
			if isnull(ld_exp_amt) then ld_exp_amt = 0;
			if isnull(ls_sexp_amt) then ls_sexp_amt = 0;
			
			dw_1.setitem(row,'pa_expn_vou_amt',ld_exp_amt)
			dw_1.setitem(row,'pa_expn_vou_amt_sel',ls_sexp_amt)
			
		SELECT sum(NET_AMT)  ,0  into :ld_pv_amt, :ls_spv_amt   
		FROM (
		select LPI_ID pi_id,ACSUBLEDGER_ID ACLEDGER_ID,LPI_ID PI_GRNNO,LPI_VOU_NO PI_VOU_NO, LPI_BILLNO PI_SUPINVNO,LPI_DATE bill_dt,(LPI_NETAMO) gross_amt,0 PI_TDS_AMT,(LPI_NETAMO) Net_Amt,LPI_PAYMENT_ADV_IND PI_PAYMENT_ADV_IND
		from fb_localpurchaseinvoice a,fb_localpurchaseorder b,FB_SUPPLIER C 
		where a.LPO_ID=b.lpo_ID AND B.SUP_ID=C.SUP_ID AND NVL(LPI_PAYMENT_ADV_IND,'N')='N' AND C.SUP_ID=:ls_party and
					trunc(LPI_DATE) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy')  and LPI_VOU_NO is not null
		UNION ALL
		SELECT LPI_ID pi_id,ACSUBLEDGER_ID ACLEDGER_ID,LPI_ID PI_GRNNO,LPI_VOU_NO PI_VOU_NO, LPI_BILLNO PI_SUPINVNO,LPI_DATE bill_dt,(LPI_NETAMO) gross_amt,0 PI_TDS_AMT,(LPI_NETAMO) Net_Amt,LPI_PAYMENT_ADV_IND PI_PAYMENT_ADV_IND 
		FROM fb_servicepurchaseinvoice A ,fb_servicepurchaseORDER B ,FB_SUPPLIER C 
		WHERE A.LPO_ID=B.LPO_ID AND B.SUP_ID=C.SUP_ID AND NVL(LPI_PAYMENT_ADV_IND,'N')='N' AND C.SUP_ID=:ls_party and
					trunc(LPI_DATE) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy')  and LPI_VOU_NO is not null);

		 if isnull(ld_pv_amt) then ld_pv_amt = 0;
		 if isnull(ls_spv_amt) then ls_spv_amt = 0;
			
		 dw_1.setitem(row,'pa_purc_bill_amt', ld_pv_amt)
		 dw_1.setitem(row,'pa_purc_bill_amt_sel', ls_spv_amt)
		 
		 
//		SELECT  sum(nvl(invoice_amt,0)), sum(decode(NVL(AD_PAYMENT_ADV_IND,'N'),'Y',nvl(invoice_amt,0))) into :ls_ddn_amt, :ls_sddn_amt   
//						FROM ( SELECT AD_PARTY_CD sup_id, pi.pi_id pi_id, AD_VOU_NO, trunc(AD_VOU_DT) AD_VOU_DT, nvl(AD_DR_AMT,0) invoice_amt, AD_PAYMENT_ADV_IND
//							FROM Fb_GRN_ADJ_DET pp,  fb_purinvoice pi
//						WHERE AD_REF_NO = pi.pi_id  and nvl(AD_DR_AMT,0) > 0 and
//						trunc(AD_VOU_DT) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy') and trunc(AD_VOU_DT)> to_date('31/03/2023','dd/mm/yyyy') 
//						)  a,
//					 FB_PURINVOICE b,FB_SUPPLIER c
//		  WHERE a.PI_ID=b.PI_ID  AND a.SUP_ID = c.SUP_ID AND a.SUP_ID = :ls_party  and nvl(AD_PAYMENT_ADV_IND,'N') = 'N' and
//						trunc(AD_VOU_DT) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy') and trunc(AD_VOU_DT)> to_date('31/03/2023','dd/mm/yyyy');		  
				
//				WHERE a.PI_ID=b.PI_ID  AND a.SUP_ID = c.SUP_ID AND a.SUP_ID = :ls_party and trunc(b.PI_RECEIVEDATE) >  to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-1,substr(:ls_dt,7,10)),'dd/mm/yyyy'); 
			//SUP00566

		 if isnull(ls_ddn_amt) then ls_ddn_amt = 0;
		 if isnull(ls_sddn_amt) then ls_sddn_amt = 0;

		 dw_1.setitem(row,'pa_debitnote_grn_amt', ls_ddn_amt)
		 dw_1.setitem(row,'pa_debitnote_grn_amt_sel', ls_sddn_amt)
		 
		 SELECT  sum(nvl(invoice_amt,0)), sum(nvl(invoice_amt,0)) into :ls_avd_amt, :ls_savd_amt   
						FROM ( SELECT PA_PARTY_CD sup_id, PA_DOCU_NO pi_id, PA_VOU_NO, trunc(PA_DOCU_DT) AD_VOU_DT, nvl(PA_ADV_PAYMENT_AMT_SEL,0) invoice_amt
							FROM FB_PAYMENT_ADV
						WHERE  nvl(PA_ADV_PAYMENT_AMT_SEL,0) > 0 and
						trunc(PA_DOCU_DT) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy') and trunc(PA_DOCU_DT)> to_date('31/03/2023','dd/mm/yyyy')
                        union all
                         SELECT PA_PARTY_CD sup_id, PA_DOCU_NO pi_id, PA_VOU_NO, trunc(PA_DOCU_DT) AD_VOU_DT, (-1) * nvl(PA_ADV_DEDN_AMT_SEL,0) invoice_amt
							FROM FB_PAYMENT_ADV
						WHERE  nvl(PA_ADV_DEDN_AMT_SEL,0) > 0 and
						trunc(PA_DOCU_DT) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy')  and trunc(PA_DOCU_DT)> to_date('31/03/2023','dd/mm/yyyy')
						)  a, FB_SUPPLIER c
		  WHERE a.SUP_ID = c.SUP_ID AND a.SUP_ID = :ls_party and 
						trunc(AD_VOU_DT) > to_date('01/04/'||decode(sign(substr(:ls_dt,4,2)-4),-1,substr(:ls_dt,7,10)-2,substr(:ls_dt,7,10)-1),'dd/mm/yyyy') and trunc(AD_VOU_DT)> to_date('31/03/2023','dd/mm/yyyy');

		 if isnull(ls_avd_amt) then ls_avd_amt = 0;
		 if isnull(ls_savd_amt) then ls_savd_amt = 0;
						
		dw_1.setitem(row,'pa_adv_dedn_amt', ls_avd_amt)
		dw_1.setitem(row,'pa_adv_dedn_amt_sel', ls_savd_amt)
		 
	end if
	
	if dwo.name = 'pa_bank_name' then
		ls_bcd = trim(data)
		
//		select a.ACLEDGER_ID INTO :ls_bledger
//		  from fb_bankledger a,fb_acledger b 
//		where a.ACLEDGER_ID=b.ACLEDGER_ID and nvl(BL_ACTIVE_IND,'N')='Y' and a.cb_id is not null and BL_ID = :ls_bcd;
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL Error : During getting Ledger Id',sqlca.sqlerrtext)
//			return -1
//		elseif sqlca.sqlcode = 0 then
//			dw_1.setitem(row,'pa_bank_gl_cd',ls_bledger)
//		end if

		select ACSUBLEDGER_ID  INTO :ls_bledger  from fb_acledger a ,fb_acsubledger b
		where a.ACLEDGER_ID=b.ACLEDGER_ID and upper(ACLEDGER_LEDGERTYPE)  like 'BANK' and ACLEDGER_ACTIVE_IND='Y' and ACSUBLEDGER_ID=:ls_bcd;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error : During getting Ledger Id',sqlca.sqlerrtext)
			return -1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'pa_bank_gl_cd',ls_bledger)
		end if
		
	end if
	
	if dwo.name = 'pa_adv_payment_amt_sel' then
		dw_1.setitem(row,'pa_adv_payment_amt',double(data))	
	end if
	
	 if (dwo.name = 'pa_expn_vou_amt_sel' or dwo.name = 'pa_purc_bill_amt_sel' or dwo.name = 'pa_adv_payment_amt_sel' or dwo.name = 'pa_misc1_pay_amt' or dwo.name = 'pa_misc2_pay_amt' or dwo.name = 'pa_debitnote_grn_amt_sel' or dwo.name = 'pa_adv_dedn_amt_sel' or dwo.name = 'pa_misc1_dedn_amt' or dwo.name = 'pa_misc2_dedn_amt') then
		wf_cal_netamt(dwo.name,double(data))
	end if
	
	
end if //if lb_query = false then


if dwo.name = 'appr_flag'  then
	ls_tmp_id =data
	if ls_tmp_id = 'Y' then
		ld_entry_dt = dw_1.getitemdatetime(row,'pa_entry_dt')	
		if date(today()) < date(ld_entry_dt) then
			messagebox('Warning !!!','Approval Date Will Be > Entry Date, Please Check !!!')
			return 1
		end if
		
		dw_1.setitem(row,'pa_approved_by',gs_user)
		dw_1.setitem(row,'pa_approved_dt',datetime(today())) 
	elseif ls_tmp_id = 'N' then		
		setnull(ls_temp)
		dw_1.setitem(row,'pa_approved_by',ls_temp)
		dw_1.setitem(row,'pa_approved_dt',datetime(ls_temp)) 
	end if		
end if;

//	messagebox('33','33')
	cb_3.enabled = true
//end if
end event

event clicked;if dwo.name = 'ev_ind' then
	if dw_1.rowcount() > 0 then
		ls_dt = string(dw_1.getitemdatetime(row,'pa_acct_processing_dt'),'dd/mm/yyyy')
		ls_party = dw_1.getitemstring(row,'pa_party_cd')
		ll_docno = dw_1.getitemnumber(row,'pa_docu_no')
		if isnull(ll_docno) then ll_docno = 0
		if isnull(gd_selpv_amt) then gd_selpv_amt = 0;
		if isnull(gd_selav_amt) then gd_selav_amt = 0;
		
		if not isnull(dw_1.getitemdatetime(row,'pa_approved_dt')) then
			gs_apr_ind = 'Y'
		else
			gs_apr_ind = 'N'
		end if
		
		if gs_apr_ind = 'N' then
			openwithparm(w_gteacf025_ev,ls_dt+ls_party+string(ll_docno,'000000'))
			
			if gd_selev_amt > 0 then 			
				     dw_1.setitem(row,'pa_expn_vou_amt_sel',gd_selev_amt)
					 ld_net_amt = gd_selev_amt + gd_selpv_amt + gd_selav_amt
					 dw_1.setitem(row,'pa_net_payable_amt',ld_net_amt)

			end if;
		end if
	end if
end if

if dwo.name = 'pv_ind' then
	if dw_1.rowcount() > 0 then
		ls_dt = string(dw_1.getitemdatetime(row,'pa_acct_processing_dt'),'dd/mm/yyyy')
		ls_party = dw_1.getitemstring(row,'pa_party_cd')
		ll_docno = dw_1.getitemnumber(row,'pa_docu_no')
		if isnull(ll_docno) then ll_docno = 0
		if isnull(gd_selpv_amt) then gd_selpv_amt = 0;
		if isnull(gd_selav_amt) then gd_selav_amt = 0;
		
		if not isnull(dw_1.getitemdatetime(row,'pa_approved_dt')) then
			gs_apr_ind = 'Y'
		else
			gs_apr_ind = 'N'
		end if
		
		if gs_apr_ind = 'N' then
			openwithparm(w_gteacf025_pv,ls_dt+ls_party+string(ll_docno))
			
			if gd_selpv_amt > 0 then 			
				     dw_1.setitem(row,'pa_purc_bill_amt_sel',gd_selpv_amt)
					 ld_net_amt = gd_selev_amt + gd_selpv_amt + gd_selav_amt
					 dw_1.setitem(row,'pa_net_payable_amt',ld_net_amt)

			end if;
		end if
	end if
end if				

//if dwo.name = 'ap_ind' then
//	if dw_1.rowcount() > 0 then
//		ls_party = dw_1.getitemstring(row,'pa_party_cd')
//		ll_docno = dw_1.getitemnumber(row,'pa_docu_no')
//		if isnull(ll_docno) then ll_docno = 0
//		if isnull(gd_selpv_amt) then gd_selpv_amt = 0;
//		if isnull(gd_selav_amt) then gd_selav_amt = 0;
//		
//		if not isnull(dw_1.getitemdatetime(row,'pa_approved_dt')) then
//			gs_apr_ind = 'Y'
//		else
//			gs_apr_ind = 'N'
//		end if
//		
//		if gs_apr_ind = 'N' then
//			openwithparm(w_ltcacf061_ev,ls_party+string(ll_docno,'000000'))
//			
//			if gd_selev_amt > 0 then 			
//				     dw_1.setitem(row,'pa_expn_vou_amt_sel',gd_selev_amt)
//					 ld_net_amt = gd_selev_amt + gd_selpv_amt + gd_selav_amt
//					 dw_1.setitem(row,'pa_net_payable_amt',ld_net_amt)
////					wf_cal_netamt(dwo.name,double(data))
//			end if;
//		end if
//	end if
//end if	

//if dwo.name = 'dn_ind' then
//	if dw_1.rowcount() > 0 then
//		ls_dt = string(dw_1.getitemdatetime(row,'pa_acct_processing_dt'),'dd/mm/yyyy')
//		ls_party = dw_1.getitemstring(row,'pa_party_cd')
//		ll_docno = dw_1.getitemnumber(row,'pa_docu_no')
//		if isnull(ll_docno) then ll_docno = 0
//		if isnull(gd_selpv_amt) then gd_selpv_amt = 0;
//		if isnull(gd_selav_amt) then gd_selav_amt = 0;
//		
//		if not isnull(dw_1.getitemdatetime(row,'pa_approved_dt')) then
//			gs_apr_ind = 'Y'
//		else
//			gs_apr_ind = 'N'
//		end if
//		
//		if gs_apr_ind = 'N' then
//			openwithparm(w_gteacf025_dn,ls_dt+ls_party) //+string(ll_docno,'000000')
//			
//			if gd_selev_amt > 0 then 			
//				     dw_1.setitem(row,'pa_debitnote_grn_amt_sel',gd_selev_amt)
//					 ld_net_amt = gd_selev_amt + gd_selpv_amt + gd_selav_amt
//					 dw_1.setitem(row,'pa_debitnote_grn_amt',ld_net_amt)
////					wf_cal_netamt(dwo.name,double(data))
//			end if;
//		end if
//	end if
//end if	
//

if dwo.name = 'ad_ind' then
	if dw_1.rowcount() > 0 then
		ls_dt = string(dw_1.getitemdatetime(row,'pa_acct_processing_dt'),'dd/mm/yyyy')
		ls_party = dw_1.getitemstring(row,'pa_party_cd')
		ll_docno = dw_1.getitemnumber(row,'pa_docu_no')
		if isnull(ll_docno) then ll_docno = 0
		if isnull(gd_selpv_amt) then gd_selpv_amt = 0;
		if isnull(gd_selav_amt) then gd_selav_amt = 0;
		
		if not isnull(dw_1.getitemdatetime(row,'pa_approved_dt')) then
			gs_apr_ind = 'Y'
		else
			gs_apr_ind = 'N'
		end if
		
		if gs_apr_ind = 'N' then
			openwithparm(w_gteacf025_ad,ls_dt+ls_party)
			
//			if gd_selev_amt > 0 then 			
//				     dw_1.setitem(row,'pa_expn_vou_amt_sel',gd_selev_amt)
//					 ld_net_amt = gd_selev_amt + gd_selpv_amt + gd_selav_amt
//					 dw_1.setitem(row,'pa_net_payable_amt',ld_net_amt)
////				wf_cal_netamt(dwo.name,double(data))
//			end if;
		end if
	end if
end if	
//			ls_gl_cd = dw_2.getitemstring(row,'vd_gl_cd')
//			gs_dc_ind = dw_2.getitemstring(row,'vd_dc_ind')
//			
//			select ACLEDGER_REMIT_IND into:ls_remit_ind from fb_acledger	where nvl(ACLEDGER_ACTIVE,'0')='1' and trim(ACLEDGER_ID) = :ls_gl_cd;
//	
//			if sqlca.sqlcode = -1 then
//				messagebox('Sql Error: During Select Ledger Nature',sqlca.sqlerrtext)
//				return 1
//			elseif	sqlca.sqlcode = 0 then
//				ll_doc_srl=dw_2.getitemnumber(row,'vd_doc_srl') 
//				ls_unitid  = dw_2.getitemstring(row,'vd_unit_id')
//				ld_amt = dw_2.getitemnumber(row,'vd_amount')
//				
//				if ls_remit_ind = 'Y'  then
//					if ls_unitid = '0000' then			
//						messagebox('Error','Please Select A Garden related to Remittance in Business Segment')
//						dw_2.setcolumn('vd_business_segment')				
//						return 1
//					elseif ls_unitid <> '0000' then				
//						if ld_amt > 0  and gs_dc_ind = 'D'  and ((gs_CO_ID= '1' and ls_gl_cd = 'ACL000577') or (gs_CO_ID= '2' and ls_gl_cd = 'ACL000687') or (gs_CO_ID= '3' and ls_gl_cd = 'ACL000996') or (gs_CO_ID= '9' and ls_gl_cd = 'ACL000027')) then //ls_gl_cd = 'ACL000577' then
//							 //openwithparm(w_ltcacf011b,string(ll_doc_srl)+ls_unitid)	
//							//openwithparm(w_ltcacf011b,ls_unitid+string(ll_doc_srl))	
							
							//  open(w_ltcacf061_ev)
							//dw_1.Retrieve(ll_doc_srl,ls_unitid)
//						 end if
//					end if
//				end if
//			end if	


end event

type cb_4 from commandbutton within w_gteacf025
integer x = 827
integer y = 4
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

event clicked;//if employee_details.tabpage_1.dw_1.modifiedcount() > 0 or employee_details.tabpage_1.dw_1.deletedcount() > 0 then
//	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
//		close(parent)
//	else
//		return
//	end if
//else
	close(parent)
//end if
end event

type cb_3 from commandbutton within w_gteacf025
integer x = 562
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if (isnull(dw_1.getitemstring(dw_1.getrow(),'pa_bank_name')) or len(dw_1.getitemstring(dw_1.getrow(),'pa_bank_name'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'pa_reason')) or  len(dw_1.getitemstring(dw_1.getrow(),'pa_reason'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'pa_pay_type')) or  len(dw_1.getitemstring(dw_1.getrow(),'pa_pay_type'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'pa_cheque_name')) or  len(dw_1.getitemstring(dw_1.getrow(),'pa_cheque_name'))=0 ) then
		messagebox('Warning:','One Of The Fields Are Blank :Bank, Narration, Payment Type, Cheque name !!!')
		dw_1.setfocus()
		dw_1.setcolumn('pa_bank_name')
		return
	end if
	
	if dw_1.rowcount() > 0 then
	 	if lb_neworder = false and dw_1.getitemstring(dw_1.getrow(),'appr_flag') = 'Y'  and (isnull(dw_1.getitemstring(dw_1.getrow(),'pa_vou_no')) or len(dw_1.getitemstring(dw_1.getrow(),'pa_vou_no')) = 0) then
                 if (not isnull(dw_1.getitemstring(dw_1.getrow(),'pa_approved_by')) or len(dw_1.getitemstring(dw_1.getrow(),'pa_approved_by')) > 0) then
					  ll_doc_no = f_get_lastno_withoutyear('VDN')
					  
					if ll_doc_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return -1
					end if
               ///Generate voucher no
     				   ll_vou_no = 0
						  
					   ld_amt = dw_1.getitemnumber(dw_1.getrow(),'pa_net_payable_amt')  
					   ls_ac_dt = string(dw_1.getitemdatetime(dw_1.getrow(),'pa_acct_processing_dt'),'dd/mm/yyyy')
					   ls_ym = string(dw_1.getitemdatetime(dw_1.getrow(),'pa_acct_processing_dt'),'yyyymm')
					   ls_glcr = dw_1.getitemstring(dw_1.getrow(),'pa_bank_gl_cd')
					   ls_party = dw_1.getitemstring(dw_1.getrow(),'pa_party_cd')
					   ls_narr = dw_1.getitemstring(dw_1.getrow(),'pa_reason')
					   ls_Chequeno= dw_1.getitemstring(dw_1.getrow(),'pa_cheque_no')
					   ls_Chequedt = string(dw_1.getitemdatetime(dw_1.getrow(),'pa_cheque_dt'),'dd/mm/yyyy')
					   ls_chqpay_to = dw_1.getitemstring(dw_1.getrow(),'pa_cheque_name')
						
						if(dw_1.getitemstring(dw_1.getrow(),'pa_pay_type') ="B" and len(ls_Chequeno)=0 ) then
							messagebox('Warning:Cheque no Cannot be blank ',+len(ls_Chequeno))
							rollback using sqlca;
							return -1
						end if
						
						
					   select ACLEDGER_ID, SUP_BANK_ACNO, SUP_MOBILE into :ls_gldr, :ls_sup_acno, :ls_smobile  from fb_supplier where SUP_ID = :ls_party;
//					   if today() > date('10/04/2024') then
							if isnull(ls_sup_acno) then
								messagebox('Error : Supplier Account','Supplier Account No Is Blank, Please Update First !!!')
								rollback using sqlca;
								return -1
							end if;
//						end if
						
						 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
						where SN_DOC_TYPE in ('JV','CV','BV','EV','NCRN','NDBN','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');
						
						if sqlca.sqlcode = 100 then
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'EV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'NCRN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'NDBN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm'));
							commit using sqlca;
						end if	
						
						ll_vou_no = f_get_lastno('BV',ls_ym)						
						if ll_vou_no < 0 then
							messagebox('Error At Last No Getting',sqlca.sqlerrtext)
							return -1
						end if
					  	if ll_vou_no >= 0 then
							ls_vou_no = string(ll_vou_no,'0000')
							ls_vou_no ='BV'+string(ls_ym)+"-"+ls_vou_no		
							 messagebox('Information;',' Voucher No Created :'+ls_vou_no)
						end if 					
						select distinct min(AP_PERIOD_ID),min(AY_FY_YEAR) into :ll_acpd,:ll_acyear from fb_ac_year a,fb_acyear_period b 
							where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
									to_date(:ls_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
				
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During Accounting Year Period Select : ',sqlca.sqlerrtext);
							return -1;
						end if;  		
						// insert into Voucher Head :ls_gsnm
						insert into fb_vou_head(VH_CO_ID,vh_ledger_type, VH_UNIT_ID, VH_DOC_SRL, VH_VOU_NO, VH_VOU_DATE, VH_VOU_TYPE, VH_AC_YEAR, vh_ac_period,VH_ENTRY_DT, VH_ENTRY_BY, VH_APPROVED_BY, VH_APPROVED_DT, vh_status)
									values( :gs_CO_ID,'G', null,:ll_doc_no,:ls_vou_no,to_date(:ls_ac_dt,'dd/mm/yyyy'),'BPV',:ll_acyear,:ll_acpd,sysdate,:gs_user,:gs_user,sysdate,'A');   
			
						if sqlca.sqlcode = -1 then
							messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
							rollback using sqlca;
							return -1
						end if;

						//Update Voucher No /Date
						dw_1.setitem(dw_1.getrow(),'pa_vou_no',ls_vou_no)
						dw_1.setitem(dw_1.getrow(),'pa_vou_dt',datetime(today()))
		//					Update fb_purchase_hdr set PH_VOU_NO=:ls_vou_no ,PH_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
		//					  where PH_VOU_NO is null and PH_REF_NO= :ls_ref_no ;
		//					
		//					if sqlca.sqlcode = -1 then 		 
		//						messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
		//						rollback using sqlca;
		//						return -1;
		//					end if;	
		
//						if ll_doc_srl=0 then
//						//ll_doc_srl = f_get_lastno_withoutyear('RTGS')
//							select nvl(sn_srl_no,0)  into :ll_doc_srl from fb_serial_no where sn_doc_type = 'RTGS' for update wait 120;
//							
//							if sqlca.sqlcode = -1 then
//								messagebox('Sql Error During Getting Last No',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return -1
//							elseif sqlca.sqlcode = 100 then
//								messagebox('Sql Error During Getting Last No',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return -1
//							end if
//						end if
//						ll_doc_srl = ll_doc_srl + 1
//						
//						if isnull(ls_sup_acno) then
//							messagebox('Error : Supplier Account','Supplier Account No Is Blank, Please Update First !!!')
//							rollback using sqlca;
//							return -1
//						end if;
//						
//						select  BEN_FULL_NAME, BEN_AC_NO, BEN_BANK_NAME, BEN_BRANCH_NAME, BEN_IFSC_CODE
//						into :ls_bfnm,:ls_bac,:ls_bbnm,:ls_bbbrnm,:ls_ifsc_cd
//						from fb_rtgs_master
//						where BEN_AC_NO=:ls_sup_acno;
//						
//						if sqlca.sqlcode = -1 then
//							messagebox('SQL Error : During Getting Supplier Account Details',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return -1
//						end if;
//						
//						Insert into FB_RTGS_TRAN
//							(RT_DOC_SRL, RT_DATE, RT_AMOUNT, RT_BNAME, RT_ACNO, 
//							 RT_CHEQUE_NO, RT_BBANK, RT_BBRANCH, RT_IFSC, RT_ENTRY_BY, RT_ENTRY_DT, RT_PURPOSE, RT_MOBILE, RT_ACNO1)
//						 Values
//							(:ll_doc_srl, to_date(:ls_ac_dt,'dd/mm/yyyy'), :ld_amt, :ls_bfnm, :ls_bac, 
//							 nvl(:ls_Chequeno,'RTGS'), :ls_bbnm,:ls_bbbrnm,:ls_ifsc_cd,:gs_user, sysdate, 'TRANSFER', :ls_smobile, :ls_bac);
//
//							if sqlca.sqlcode = -1 then
//								messagebox('Sql Error During Getting Last No',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return -1
//							end if		
		
		end if ;
		// Find Credit GL/SGL
		    	   
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_VOU_NO,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_COSTCENTER_ID,VD_AMOUNT,VD_DC_IND,VD_DETAIL,vd_party_cd,VD_CHEQUE_NO, VD_CHEQUE_DT,VD_CHEQUE_PAYTO)
			values ('FA','0000',:ll_doc_no,:ls_vou_no,:gs_CO_ID,null,to_number(to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_glcr,null,:ld_amt,'C','BV For Payment Advice '||:ls_narr,:ls_party,:ls_Chequeno,to_date(:ls_Chequedt,'dd/mm/yyyy'),:ls_chqpay_to);
	
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (cr)  ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
	              
		// Find Dedit GL/SGL
			    
			   	
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_VOU_NO,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_COSTCENTER_ID,VD_AMOUNT,VD_DC_IND,VD_DETAIL,vd_party_cd,VD_CHEQUE_NO, VD_CHEQUE_DT,VD_CHEQUE_PAYTO)
			values ('FA','0000',:ll_doc_no,:ls_vou_no,:gs_CO_ID,null,to_number(to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gldr,null,:ld_amt,'D','BV For Payment Advice '||:ls_narr,:ls_party,:ls_Chequeno,to_date(:ls_Chequedt,'dd/mm/yyyy'), :ls_chqpay_to);
	
	       	if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (dr)  ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			///update last no doc no
			if ll_doc_no > 0 then  
				if f_upd_lastno_withoutyear('VDN',ll_doc_no) = -1 then
					rollback using sqlca;			
					return 1
				end if	
			end if
			 ///update last no
			if ll_vou_no > 0 then
				if f_upd_lastno('BV',ls_ym,ll_vou_no) = -1 then
					rollback using sqlca;			
					return -1
				end if	
			end if
//			if ll_doc_srl > 0 then  
//				 if f_upd_lastno_withoutyear('RTGS',ll_doc_srl) = -1 then
//					  rollback using sqlca;   
//					  return -1
//				 end if 
//			end if
		end if	
	end if			

		if dw_1.update(true,false) = 1 then 
			dw_1.resetupdate();
			commit using sqlca;
			dw_1.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		cb_3.enabled = false
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteacf025
integer x = 297
integer y = 4
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
   	cb_3.enabled = false
  	cb_10.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	//dw_1.settaborder('pa_adv_no',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('pa_acct_processing_dt')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.settaborder('pa_acct_processing_dt',0)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind, gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_10.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true
end if
lb_neworder = false
end event

type cb_1 from commandbutton within w_gteacf025
integer x = 32
integer y = 4
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if lb_neworder = true then
		 ll_docno = f_get_lastno_withoutyear('PA')
end if

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pa_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pa_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pa_acct_processing_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pa_docu_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pa_docu_no',ll_docno)
	dw_1.setcolumn('pa_acct_processing_dt')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pa_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pa_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pa_acct_processing_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pa_docu_dt',datetime(today()))	
	dw_1.setitem(dw_1.getrow(),'pa_docu_no',ll_docno)
	dw_1.setcolumn('pa_acct_processing_dt')
end if


if ll_docno> 0 then  
 if f_upd_lastno_withoutyear('PA',ll_docno) = -1 then
  rollback using sqlca;   
  return 1
 else
  commit using sqlca;
 end if 
end if

end event

