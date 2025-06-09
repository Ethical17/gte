$PBExportHeader$n_fames.sru
forward
global type n_fames from nonvisualobject
end type
end forward

global type n_fames from nonvisualobject
end type
global n_fames n_fames

type variables
 string ls_temp
 long ll_ctr

end variables

forward prototypes
public function integer wf_purchase_tostore_ac (string fs_transid, string fs_ac_dt)
public function integer wf_store_to_account (string fs_transid, string fs_ac_dt)
public function integer wf_store_transfer_ac (string fs_transid, string fs_ac_dt)
public function integer wf_purchase_to_account (string fs_transid, string fs_ac_dt)
public function integer wf_upd_mes (string fs_date, string fs_mesac, double fd_value, string fs_mes_col, string fs_old_rec)
public function integer wf_remittancekind_tostore (string fs_transid, string fs_ac_dt)
public function integer wf_store_adjustment (string fs_transid, string fs_ac_dt)
public function integer wf_return_to_store (string fs_transid, string fs_ac_dt)
public function integer wf_return_to_supplier (string fs_transid, string fs_ac_dt)
public function integer wf_wages_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt)
public function integer wf_partweek_wages_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt)
public function integer wf_arrear_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt)
public function integer wf_upd_dailystock (string fs_ref_no, string fs_date, string fs_sp_id, double fd_qnty, double fd_rate, double fd_value, string fs_ref_type, string fs_rec_ty, string fs_old_rec, string fs_div)
public function integer wf_cash_plucking (string fs_transid, string fs_ac_dt)
public function integer wf_unitstore_transfer_ac (string fs_transid, string fs_ac_dt)
public function integer wf_wages_to_account_mt (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt)
public function integer wf_purchase_adjto_account (string fs_transid, string fs_ac_dt)
public function integer wf_horemittance_entry (string fs_ac_dt, string fs_st_dt, string fs_end_dt)
public function integer wf_purchase_tostore_ac_gst (string fs_transid, string fs_ac_dt)
public function integer wf_remittancekind_tostore_gst (string fs_transid, string fs_ac_dt)
public function integer wf_wages_to_account_mr (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt)
public function integer wf_servicepurchase_to_ac_gst (string fs_transid, string fs_ac_dt)
public function integer wf_salary_to_account_mr (string fs_transdt, date fs_ac_dt)
public function integer wf_salary_to_account (string fs_transdt, date fs_ac_dt)
end prototypes

public function integer wf_purchase_tostore_ac (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_supp_id,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
double ld_amt ,ld_otheramt,ld_supp_val

ls_ym = 	string(date(fs_ac_dt),'yyyymm')



declare c1 cursor for 
	SELECT pi.LPI_ID,To_char(LPI_DATE,'dd/mm/yyyy') LPI_DATE,SUP_ID, 
       (SUM(decode(nvl(pid.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+((lpi_effectiveunitprice* LPI_QUANTITY)*(pid.LPI_SALETAX/100))))) store_catg_val,
       (SUM(decode(nvl(pid.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+((lpi_effectiveunitprice* LPI_QUANTITY)*(pid.LPI_SALETAX/100))))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt)) other_val,
	   totamt+(nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0)) supplier_val,
	   a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name
  FROM fb_localpurchaseinvoice pi,fb_lpidetails pid,fb_localpurchaseorder c,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
	   (select lpi_id,  round(SUM(decode(nvl(LPI_SALETAX,0),0,(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY),(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)+((LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)*(LPI_SALETAX/100)))),2) totamt from fb_lpidetails group by lpi_id) x
 WHERE pi.lpi_id = pid.lpi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and pi.LPO_ID = c.LPO_ID(+) and 
       pi.LPI_ID = x.LPI_ID and pi.LPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and LPI_VOU_NO is null
 GROUP BY pi.LPI_ID,LPI_DATE,a.acledger_id,SUP_ID,spc.spc_id,spc.spc_name,totamt,nvl(LPI_FREIGHT,0),nvl(LPI_INSURANCE,0),nvl(LPI_OTHERAMO,0)
 order by 1,2;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);
	ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id,:ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_name;

	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');

			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_localpurchaseinvoice set LPI_VOU_NO=:ls_vou_no , LPI_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where LPI_VOU_NO is null and LPI_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	
		// Find Credit GL/SGL
			
			select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
             where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
	
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;

			// insert into Voucher Detail for supplier_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_supp_val,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		  	   
			    if sqlca.sqlcode = -1 then 		 
				  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				  rollback using sqlca;
				  return -1;
				end if;	
	       			
            end if;
				
		// Dedit
			
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		         
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

		setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);
	     ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id,:ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_name;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;		
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_store_to_account (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym,ls_esub_head, ls_section, ls_ecc
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')

declare c1 cursor for 
select  issue_id,to_char(PRIS_DATE,'dd/mm/yyyy') PRIS_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind,esub_head,ECC_ID, SECTION_ID
   from (SELECT pi.PRIS_ID issue_id, PRIS_DATE,SUM (pid.pris_value) mysum, sub.acsubledger_manid,sub.acsubledger_id,ACLEDGER_ID,'D' Dc_ind ,pid.eacsubhead_id esub_head,ECC_ID, SECTION_ID
  			FROM fb_productissue pi,fb_productissuedetails pid,fb_expenseacsubhead esh,
			          (SELECT * FROM fb_acsubledger WHERE NVL(EXP_HEAD_IND,'N')='Y') sub 
 		  WHERE pi.pris_id = pid.pris_id AND pid.eacsubhead_id = esh.eacsubhead_id AND esh.eachead_id = sub.acsubledger_id and 
					//ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='REVENUEEXPENDITURE') and 
					pi.PRIS_ID = :fs_transid and PRIS_VOU_NO is null 
 		  GROUP BY pi.PRIS_ID, PRIS_DATE,sub.acsubledger_manid, sub.acsubledger_id,ACLEDGER_ID,pid.eacsubhead_id,ECC_ID, SECTION_ID
 		  union 
 		  SELECT pi.PRIS_ID, PRIS_DATE,SUM (pid.pris_value) mysum, spc.spc_name, spc.spc_id,ACLEDGER_ID,'C' dc_ind ,null, null,null
   			FROM fb_productissue pi,fb_productissuedetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger 
  		  WHERE pi.pris_id = pid.pris_id 
        				AND pid.sp_id = sp.sp_id 
        				AND sp.spc_id = spc.spc_id and
					spc.spc_id=ACSUBLEDGER_ID and
					ACLEDGER_ID in (select acledger_id from fb_acledger where acledger_ledgertype='STORE') 
					and pi.PRIS_ID = :fs_transid and PRIS_VOU_NO is null 
   		  GROUP BY pi.PRIS_ID, PRIS_DATE,spc.spc_id, spc.spc_name,ACLEDGER_ID)
order by 1,2,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head); setnull(ls_ecc); setnull(ls_section);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head, :ls_ecc, :ls_section;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				  select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
   				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					
               
			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
            
             
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update fb_productissue set PRIS_VOU_NO=:ls_vou_no , PRIS_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy'),pris_confirmflag='1',pris_active='1'
			where PRIS_VOU_NO is null and PRIS_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	   end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_EXPSUBHEAD,VD_PREFERRED_MES)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,decode(nvl(:ls_section,'x'),'x',:ls_ecc,:ls_section),:ld_amt,:ls_dc_ind,'JV For Store To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_esub_head,decode(:ls_esub_head,null,null,'T'));
	
	 
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head); setnull(ls_ecc); setnull(ls_section);
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head, :ls_ecc, :ls_section;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then				
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;			
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_store_transfer_ac (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym 
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')
	
//	select transfer_id,to_char(PRIS_DATE,'dd/mm/yyyy') PRIS_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind
//from  (SELECT pi.PRIS_ID transfer_id, PRIS_DATE,ACLEDGER_ID, acsub.acsubledger_id acsubledger_id ,SUM (pid.pris_value) mysum,'D' dc_ind
//   		  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_supplier sup,fb_acsubledger acsub,fb_gardenmaster 
//  		WHERE acsub.acsubledger_id = sup.acsubledger_id 
//       			    AND sup.sup_id = UNIT_SUPID
//					and UNIT_MAIN_STORE=pi.sup_id 
//        			    AND pi.pris_id = pid.pris_id and pi.PRIS_TRANSFERTO_IND='U'
//				    and ACLEDGER_ID in(select acledger_id from fb_acledger where acledger_ledgertype='BANK')
//				    and pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='T' 
//  		 GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,sup.sup_id, acsub.acsubledger_id			 	  
//  	    union
//     	    SELECT pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id,SUM (pid.pris_value) mysum, 'C' dc_ind
//       	  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger 
//         WHERE pi.pris_id = pid.pris_id 
//                       AND pid.sp_id = sp.sp_id 
//                       AND sp.spc_id = spc.spc_id 
//		            and spc.spc_id= ACSUBLEDGER_ID and pi.PRIS_TRANSFERTO_IND='U'
//		            and ACLEDGER_ID in (select acledger_id from fb_acledger where acledger_ledgertype='STORE')
//		            and pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='T' 
//         GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id)
//Order by 1,2,3;

declare c1 cursor for 
select transfer_id,to_char(PRIS_DATE,'dd/mm/yyyy') PRIS_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind
from  (SELECT pi.PRIS_ID transfer_id, PRIS_DATE,ACLEDGER_ID, acsub.acsubledger_id acsubledger_id ,SUM (pid.pris_value) mysum,'D' dc_ind
   		  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_supplier sup,fb_acsubledger acsub 
  		WHERE pi.pris_id = pid.pris_id and sup.sup_id = pi.SUP_ID AND acsub.acsubledger_id = sup.acsubledger_id AND pi.PRIS_TRANSFERTO_IND='U' and 
		  		  pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='T' 
  		 GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,sup.sup_id, acsub.acsubledger_id			 	  
  	    union
     	    SELECT pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id,SUM (pid.pris_value) mysum, 'C' dc_ind
       	  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger 
         WHERE pi.pris_id = pid.pris_id AND pid.sp_id = sp.sp_id  AND sp.spc_id = spc.spc_id  and spc.spc_id= ACSUBLEDGER_ID and 
				  pi.PRIS_TRANSFERTO_IND='U' and ACLEDGER_ID in (select acledger_id from fb_acledger where acledger_ledgertype='STORE')
		            and pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='T' 
         GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id)
Order by 1,2,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym )						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
					
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update fb_producttransfer set PRIS_VOU_NO=:ls_vou_no , PRIS_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			  where PRIS_VOU_NO is null and PRIS_ID= :ls_ref_no ; 
			  
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,:ld_amt,:ls_dc_ind,'JV For Store Transfer To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
	
	  
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;	
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_purchase_to_account (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_dgl,ls_dsgl,ls_cgl,ls_csgl,ls_dexp,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_name,ls_supid,ls_ym,ls_detail,ls_gttype
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 
 
ls_ym = string(date(fs_ac_dt),'yyyymm')
declare c1 cursor for 
	SELECT GT_ID, trunc(GT_DATE),pi.gt_netamount,sup.sup_id, sup.sup_name,  
				decode(pi.gt_type,'PURCHASE',ac_gl,ACLEDGER_ID) debit_gl,decode(pi.gt_type,'PURCHASE',ac_sgl,sup.acsubledger_id) debit_sgl,
				decode(pi.gt_type,'PURCHASE',ACLEDGER_ID,ac_gl) credit_gl,decode(pi.gt_type,'PURCHASE',sup.acsubledger_id,ac_sgl) credit_sgl,
				decode(pi.gt_type,'PURCHASE',ac_exp,null) debit_exphead,
				pi.gt_type
        FROM fb_gltransaction pi, fb_supplier sup,
			  (select decode(AC_PROCESS_DETAIL,'Purchase  Leaf','PURCHASE','SALE') rectype,
						decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_ACLEDGER_ID,CR_ACLEDGER_ID) ac_gl,
						decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_ACSUBLEDGER_ID,CR_ACSUBLEDGER_ID) ac_sgl,
						decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_EACSUBHEAD_ID,CR_EACSUBHEAD_ID) ac_exp
				from fb_acautoprocess
				where AC_PROCESS='Green Leaf Purchase'),
				fb_acsubledger a
     WHERE pi.sup_id = sup.sup_id AND pi.gt_type  in ('PURCHASE','SALE') and pi.gt_type = rectype and 
	  		   GT_VOU_NO is null and sup.acsubledger_id = a.ACSUBLEDGER_ID and GT_ID=:fs_transid
    order by 1,2;
		  
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supid);setnull(ls_name);setnull(ls_detail);setnull(ls_dgl);setnull(ls_dsgl);setnull(ls_cgl);setnull(ls_csgl);setnull(ls_dexp);setnull(ls_gttype);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_amt,:ls_supid,:ls_name,:ls_dgl,:ls_dsgl,:ls_cgl,:ls_csgl,:ls_dexp,:ls_gttype;
	
	do while sqlca.sqlcode <> 100 
       messagebox('In Nfames After  Cursor','ls_ref_no'  +string(ls_ref_no) + '  ls_ref_dt:' +ls_ref_dt + ' ld_amt:'+ string(ld_amt)+ ' ls_supid:'+ string(ls_supid) + ' ls_name:'+ string(ls_name)+ ' ls_dgl:'+ string(ls_dgl)+ ' ls_cgl:'+ string(ls_cgl)+ ' ls_csgl:'+ string(ls_csgl)+ ' ls_dexp:'+ string(ls_dexp)+ ' ls_gttype:'+ string(ls_gttype))
					
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
					if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return -1
					end if
				  if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;

		//Update Voucher No /Date
			Update fb_gltransaction set GT_VOU_NO=:ls_vou_no , GT_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where GT_VOU_NO is null and GT_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
		end if ;
			// insert into Voucher Detail
			
			 messagebox('In Nfames BEFORE Insert','ll_doc_no'  +string(ll_doc_no) + ' gs_CO_ID:' +gs_CO_ID + ' gs_garden_snm:'+ string(gs_garden_snm)+ ' gs_garden_snm:'+ string(gs_garden_snm) + 'date :' +string(fs_ac_dt,'dd/mm/yyyy'))
	
			
			
				insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
				values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_amt,'C',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
		      
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (cr)  ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
	              
		// Find Dedit GL/SGL
		
              
			// insert into Voucher Detail
			insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_dgl,:ls_dsgl,:ls_dexp,null,decode(:ls_gttype,'SALE',null,'C'),:ld_amt,'D',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
	
	       	if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (dr)  ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
				
		setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_supid);setnull(ls_name);setnull(ls_gttype);setnull(ls_detail);setnull(ls_dgl);setnull(ls_dsgl);setnull(ls_cgl);setnull(ls_csgl);setnull(ls_dexp);setnull(ls_gttype);
	      ld_amt = 0; 
	
		fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_amt,:ls_supid,:ls_name,:ls_dgl,:ls_dsgl,:ls_cgl,:ls_csgl,:ls_dexp,:ls_gttype;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;	
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_upd_mes (string fs_date, string fs_mesac, double fd_value, string fs_mes_col, string fs_old_rec);double ld_salarytodatety,ld_wagestodatety,ld_storestodatety,ld_otherstodatety

if isnull(fs_mes_col) then		
	messagebox('MES Error','The MES Column is not define, Please check..!')
	return -1
end if

 ////for update record 
if fs_old_rec='Y' then
		
	select distinct 9 into :ll_ctr from fb_dailyexpense where de_date=to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac;
	
	if sqlca.sqlcode = 0 then

		update  fb_dailyexpense
			set de_salarytodayty = nvl(de_salarytodayty,0) - decode(:fs_mes_col,'S',:fd_value,0),
				 de_wagestodayty = nvl(de_wagestodayty,0) - decode(:fs_mes_col,'W',:fd_value,0),
				 de_storestodayty = nvl(de_storestodayty,0) - decode(:fs_mes_col,'T',:fd_value,0),
				 de_otherstodayty = nvl(de_otherstodayty,0) - decode(:fs_mes_col,'C',:fd_value,0)
		 where de_date = to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac ;

		
//		update  fb_dailyexpense
//			set de_salarytodayty = nvl(de_salarytodayty,0) - decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'S',:fd_value,0),0),
//				 de_wagestodayty = nvl(de_wagestodayty,0) - decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'W',:fd_value,0),0),
//				 de_storestodayty = nvl(de_storestodayty,0) - decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'T',:fd_value,0),0),
//				 de_otherstodayty = nvl(de_otherstodayty,0) - decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'C',:fd_value,0),0),
//				 de_salarytodatety = nvl(de_salarytodatety,0) - decode(:fs_mes_col,'S',:fd_value,0),
//				 de_wagestodatety = nvl(de_wagestodatety,0) - decode(:fs_mes_col,'W',:fd_value,0),
//				 de_storestodatety = nvl(de_storestodatety,0) - decode(:fs_mes_col,'T',:fd_value,0) ,
//				 de_otherstodatety = nvl(de_otherstodatety,0) - decode(:fs_mes_col,'C',:fd_value,0)
//		 where de_date >= to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac and 
//				 to_number(to_char(de_date,'yyyymm')) <= ((decode(sign(to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'mm')) - 4),-1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')),to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')) + 1) * 100)+03);
																																																													
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Daily Expense Wages Update 2 : ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		end if;    	
	 end if;
else 
	/// for new record
	    
		select distinct 9 into :ll_ctr from fb_dailyexpense where de_date=to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac;
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Daily Expense Select ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		end if;

		if sqlca.sqlcode = 100 then	// Not found 
//			select nvl(de_salarytodatety,0),nvl(de_wagestodatety,0),nvl(de_storestodatety,0),nvl(de_otherstodatety,0)
//			    into :ld_salarytodatety,:ld_wagestodatety,:ld_storestodatety,:ld_otherstodatety
//			  from fb_dailyexpense 
//			where eacsubhead_id=:fs_mesac and 
//					de_date=(select max(de_date)  from fb_dailyexpense 
//								where eacsubhead_id=:fs_mesac and 
//										to_number(to_char(de_date,'yyyymm')) between ((decode(sign(to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'mm')) - 4),-1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')) -1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy'))) * 100)+04) and 
//																									((decode(sign(to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'mm')) - 4),-1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')),to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')) + 1) * 100)+03) and 
//										de_date < to_date(:fs_date,'DD/MM/YYYY'));
//										  
//			if sqlca.sqlcode = -1 then
//				messagebox('Sql Error During geting Daily Expense detail : ',sqlca.sqlerrtext);
//				rollback using sqlca;
//				return -1
//			elseif sqlca.sqlcode = 100 then
//				ld_salarytodatety = 0;
//				ld_wagestodatety = 0;
//				ld_storestodatety = 0;
//				ld_otherstodatety = 0;
//			end if;

			  
//				insert into fb_dailyexpense (de_date,eacsubhead_id,de_salarytodayty,de_wagestodayty,de_storestodayty,de_otherstodayty,
//						 														  de_salarytodatety,de_wagestodatety,de_storestodatety,de_otherstodatety)
//				 values (to_date(:fs_date,'dd/mm/yyyy'),:fs_mesac,
//				 			decode(:fs_mes_col,'S',:fd_value,0),decode(:fs_mes_col,'W',:fd_value,0),decode(:fs_mes_col,'T',:fd_value,0),decode(:fs_mes_col,'C',:fd_value,0),
//							(nvl(:ld_salarytodatety,0) + decode(:fs_mes_col,'S',:fd_value,0)) ,(nvl(:ld_wagestodatety,0) + decode(:fs_mes_col,'W',:fd_value,0)),
//							(nvl(:ld_storestodatety,0) + decode(:fs_mes_col,'T',:fd_value,0)), (nvl(:ld_otherstodatety,0) + decode(:fs_mes_col,'C',:fd_value,0)));
//					 
				insert into fb_dailyexpense (de_date,eacsubhead_id,de_salarytodayty,de_wagestodayty,de_storestodayty,de_otherstodayty,
						 														  de_salarytodatety,de_wagestodatety,de_storestodatety,de_otherstodatety)
				 values (to_date(:fs_date,'dd/mm/yyyy'),:fs_mesac,
				 			decode(:fs_mes_col,'S',:fd_value,0),decode(:fs_mes_col,'W',:fd_value,0),decode(:fs_mes_col,'T',:fd_value,0),decode(:fs_mes_col,'C',:fd_value,0),
							0,0,0,0);

				  if sqlca.sqlcode = -1 then
					messagebox('Sql Error During Daily Expense Insert : ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				 end if;
			
//				 update fb_dailyexpense 
//				 	 set de_salarytodatety = nvl(de_salarytodatety,0) + decode(:fs_mes_col,'S',:fd_value,0),
//					  	  de_wagestodatety = nvl(de_wagestodatety,0) + decode(:fs_mes_col,'W',:fd_value,0),
//						  de_storestodatety = nvl(de_storestodatety,0) + decode(:fs_mes_col,'T',:fd_value,0) ,
//						  de_otherstodatety = nvl(de_otherstodatety,0) + decode(:fs_mes_col,'C',:fd_value,0)
//				 where de_date > to_date(:fs_date,'DD/MM/YYYY') and 
//						 eacsubhead_id=:fs_mesac and to_number(to_char(de_date,'yyyymm')) <= ((decode(sign(to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'mm')) - 4),-1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')),to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')) + 1) * 100)+03);
//		
//				  if sqlca.sqlcode = -1 then
//					messagebox('Sql Error During Daily Expense Wages Update : ',sqlca.sqlerrtext);
//					rollback using sqlca;
//					return -1;
//				end if;					
		 
		else		
//			update  fb_dailyexpense
//				set de_salarytodayty = nvl(de_salarytodayty,0) + decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'S',:fd_value,0),0),
//					 de_wagestodayty = nvl(de_wagestodayty,0) + decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'W',:fd_value,0),0),
//					 de_storestodayty = nvl(de_storestodayty,0) + decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'T',:fd_value,0),0),
//					 de_otherstodayty = nvl(de_otherstodayty,0) + decode(de_date,to_date(:fs_date,'DD/MM/YYYY'),decode(:fs_mes_col,'C',:fd_value,0),0),
//					 de_salarytodatety = nvl(de_salarytodatety,0) + decode(:fs_mes_col,'S',:fd_value,0),
//					 de_wagestodatety = nvl(de_wagestodatety,0) + decode(:fs_mes_col,'W',:fd_value,0),
//					 de_storestodatety = nvl(de_storestodatety,0) + decode(:fs_mes_col,'T',:fd_value,0) ,
//					 de_otherstodatety = nvl(de_otherstodatety,0) + decode(:fs_mes_col,'C',:fd_value,0)
//			 where de_date >= to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac and 
//					to_number(to_char(de_date,'yyyymm'))<=((decode(sign(to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'mm')) - 4),-1,to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')),to_number(to_char(to_date(:fs_date,'DD/MM/YYYY'),'yyyy')) + 1) * 100)+03);

			update  fb_dailyexpense
				set de_salarytodayty = nvl(de_salarytodayty,0) + decode(:fs_mes_col,'S',:fd_value,0),
					 de_wagestodayty = nvl(de_wagestodayty,0) + decode(:fs_mes_col,'W',:fd_value,0),
					 de_storestodayty = nvl(de_storestodayty,0) + decode(:fs_mes_col,'T',:fd_value,0),
					 de_otherstodayty = nvl(de_otherstodayty,0) + decode(:fs_mes_col,'C',:fd_value,0)
			 where de_date = to_date(:fs_date,'DD/MM/YYYY') and eacsubhead_id=:fs_mesac ;

																																																															
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error During Daily Expense Wages Update 2 : ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;    	
		 end if;
end if; 

return 1;
end function

public function integer wf_remittancekind_tostore (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_sup
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
double ld_amt ,ld_otheramt,ld_kind_val

ls_ym = 	string(date(fs_ac_dt),'yyyymm')



declare c1 cursor for 
	SELECT pi.HOPI_ID,To_char(HOPI_DATE,'dd/mm/yyyy') HOPI_DATE, pi.SUP_ID,
                   (SUM(decode(nvl(pid.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(pid.HOPI_SALETAX/100))))) store_catg_val,
                   (SUM(decode(nvl(pid.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(pid.HOPI_SALETAX/100))))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt)) other_val,
	              totamt+(nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0)) rem_kind_val,
	              a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name
        FROM fb_hopurchaseinvoice pi,fb_hopidetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
	              (select hopi_id, round(SUM(decode(nvl(HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(HOPI_SALETAX/100)))),2) totamt from fb_hopidetails group by hopi_id) x
     WHERE pi.hopi_id = pid.hopi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and 
                   pi.HOPI_ID = x.HOPI_ID and pi.HOPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and HOPI_VOU_NO is null
     GROUP BY pi.HOPI_ID,HOPI_DATE,pi.SUP_ID,a.acledger_id,spc.spc_id,spc.spc_name,totamt,nvl(HOPI_FREIGHT,0),nvl(HOPI_INSURANCE,0),nvl(HOPI_OTHERAMO,0)
         order by 1,2;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_sup);
	ld_amt = 0; ld_otheramt = 0;ld_kind_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_sup,:ld_amt,:ld_otheramt,:ld_kind_val,:ls_gl,:ls_sgl,:ls_name;

	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_hopurchaseinvoice set HOPI_VOU_NO=:ls_vou_no , HOPI_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where HOPI_VOU_NO is null and HOPI_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	
		// Find Credit GL/SGL
			 select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b 
	            where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and acledger_ledgertype='REMITTANCEKIND' and ACSUBLEDGER_NAME='REMITTANCE KIND';
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;

			// insert into Voucher Detail for rem_kind_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_kind_val,'C','JV For Remittance To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_sup);
		
		  	   
			  if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
	       			
            end if;
				
		// Dedit
			
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2),'D','JV For Remittance To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
		         
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

		setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_sup);
	     ld_amt = 0; ld_otheramt = 0;ld_kind_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_sup,:ld_amt,:ld_otheramt,:ld_kind_val,:ls_gl,:ls_sgl,:ls_name;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;		
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_store_adjustment (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym,ls_esub_head
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')

declare c1 cursor for 
//select SA_ADJ_ID,SA_ADJ_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind,EACSUBHEAD_ID
//  from (select SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy')SA_ADJ_DATE,ACLEDGER_ID,EACHEAD_ID acsubledger_id,
//		           decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C'))Dc_ind,
//			    	  sum(abs(nvl(SA_VALUE,0))) mysum,EACSUBHEAD_ID
//		   from fb_stores_adjustment a,fb_acsubledger b 
//		 where a.EACHEAD_ID=b.ACSUBLEDGER_ID and 
//		        	  b.ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='REVENUEEXPENDITURE'  and nvl(ACLEDGER_ACTIVE_IND,'N')='Y')
//			   	  and SA_ADJ_ID=  :fs_transid and SA_VOU_NO is null	  
//		  group by SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy'),ACLEDGER_ID,EACHEAD_ID,
//		           decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C')),EACSUBHEAD_ID
//		  having sum(abs(nvl(SA_VALUE,0))) < 0
//		union
//         select SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy')SA_ADJ_DATE,CR_ACLEDGER_ID ACLEDGER_ID,CR_ACSUBLEDGER_ID acsubledger_id,
//		           decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C'))Dc_ind,
//			    	  sum(abs(nvl(SA_VALUE,0))) mysum,EACSUBHEAD_ID
//		   from fb_stores_adjustment a, (select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID from fb_acautoprocess where upper(AC_PROCESS) ='STORE ADJUSTMENT') b
//		 where SA_ADJ_ID=  :fs_transid and SA_VOU_NO is null	
//		  group by SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy'),CR_ACLEDGER_ID,CR_ACSUBLEDGER_ID,
//		           decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C')),EACSUBHEAD_ID	
//		  having sum(abs(nvl(SA_VALUE,0))) > 0
//		union		 
//		select SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy')SA_ADJ_DATE,ACLEDGER_ID,c.spc_id acsubledger_id,
//		          decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'C','D'),decode(sign(SA_QUANTITY - 0),-1,'C','D'))Dc_ind,
//			      sum(abs(nvl(SA_VALUE,0))) mysum,null
//		  from fb_stores_adjustment a,fb_acsubledger b,fb_storeproductcategory c,fb_storeproduct d
//	     where a.sp_id = d.sp_id 
//		           and d.spc_id = c.spc_id and c.spc_id= b.ACSUBLEDGER_ID and
//		           b.ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='STORE' and nvl(ACLEDGER_ACTIVE_IND,'N')='Y')
//			      and SA_ADJ_ID=  :fs_transid	 and SA_VOU_NO is null	 
//	      group by SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy'),ACLEDGER_ID,c.spc_id,
//		        decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'C','D'),decode(sign(SA_QUANTITY - 0),-1,'C','D')))
//	   order by 1,2,3;	

select SA_ADJ_ID,SA_ADJ_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind,EACSUBHEAD_ID
  from (select SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy')SA_ADJ_DATE,ACLEDGER_ID,EACHEAD_ID acsubledger_id,
                   decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C'))Dc_ind,
                      sum(abs(nvl(SA_VALUE,0))) mysum,EACSUBHEAD_ID EACSUBHEAD_ID
           from fb_stores_adjustment a,fb_acsubledger b 
         where a.EACHEAD_ID=b.ACSUBLEDGER_ID and 
                      b.ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='REVENUEEXPENDITURE'  and nvl(ACLEDGER_ACTIVE_IND,'N')='Y')
                     and SA_ADJ_ID=  :fs_transid and SA_VOU_NO is null      
          group by SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy'),ACLEDGER_ID,EACHEAD_ID,
                   decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'D','C'),decode(sign(SA_QUANTITY - 0),-1,'D','C')),EACSUBHEAD_ID 
          union        
        select SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy')SA_ADJ_DATE,ACLEDGER_ID,c.spc_id acsubledger_id,
                  decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'C','D'),decode(sign(SA_QUANTITY - 0),-1,'C','D'))Dc_ind,
                  sum(abs(nvl(SA_VALUE,0))) mysum,null
		  from fb_stores_adjustment a,fb_acsubledger b,fb_storeproductcategory c,fb_storeproduct d
	     where a.sp_id = d.sp_id 
		           and d.spc_id = c.spc_id and c.spc_id= b.ACSUBLEDGER_ID and
		           b.ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='STORE' and nvl(ACLEDGER_ACTIVE_IND,'N')='Y')
			      and SA_ADJ_ID=  :fs_transid	 and SA_VOU_NO is null	 
	      group by SA_ADJ_ID,to_char(SA_ADJ_DATE,'dd/mm/yyyy'),ACLEDGER_ID,c.spc_id,
		        decode(nvl(SA_QUANTITY,0),0,decode(sign(SA_VALUE - 0),-1,'C','D'),decode(sign(SA_QUANTITY - 0),-1,'C','D')) )
	   order by 1,2,3;	


open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head)
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				   select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
   				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					
               

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
			
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update fb_stores_adjustment set SA_VOU_NO=:ls_vou_no , SA_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where SA_VOU_NO is null and SA_ADJ_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	   end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_EXPSUBHEAD,VD_PREFERRED_MES)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,:ld_amt,:ls_dc_ind,'JV For Store Adjustment ',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_esub_head,decode(:ls_esub_head,null,null,'T'));
		 
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head)
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head;	
    
	loop;
	
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then				
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;			
	
	close c1;
	
end if;	
	
return 1;	

end function

public function integer wf_return_to_store (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym,ls_esub_head
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')

declare c1 cursor for 
select  issue_id,to_char(PRET_DATE,'dd/mm/yyyy') PRET_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind,esub_head
   from (SELECT pi.PRET_ID issue_id, PRET_DATE,SUM (pid.pret_value) mysum, sub.acsubledger_manid,sub.acsubledger_id,ACLEDGER_ID,'C' Dc_ind ,pid.eacsubhead_id esub_head
  			FROM FB_PRODUCTRETURN pi,FB_PRODUCTRETURNDETAILS pid,fb_expenseacsubhead esh,(SELECT * FROM fb_acsubledger WHERE NVL(EXP_HEAD_IND,'N')='Y') sub 
 		  WHERE pi.pret_id = pid.pret_id and pid.eacsubhead_id = esh.eacsubhead_id AND esh.eachead_id =  sub.acsubledger_id and 
	   				//ACLEDGER_ID=(select acledger_id from fb_acledger where acledger_ledgertype='REVENUEEXPENDITURE')
       				pi.PRET_ID = :fs_transid and PRET_VOU_NO is null
 		  GROUP BY pi.PRET_ID, PRET_DATE,sub.acsubledger_manid, sub.acsubledger_id,ACLEDGER_ID,pid.eacsubhead_id
 		  union 
 		  SELECT pi.PRET_ID, PRET_DATE,SUM (pid.pret_value) mysum, spc.spc_name, spc.spc_id,ACLEDGER_ID,'D' dc_ind ,null
   			FROM FB_PRODUCTRETURN pi,FB_PRODUCTRETURNDETAILS pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger 
  		  WHERE pi.pret_id = pid.pret_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and spc.spc_id=ACSUBLEDGER_ID and
					ACLEDGER_ID in (select acledger_id from fb_acledger where acledger_ledgertype='STORE')  and 
					pi.PRET_ID = :fs_transid and PRET_VOU_NO is null
   		  GROUP BY pi.PRET_ID, PRET_DATE,spc.spc_id, spc.spc_name,ACLEDGER_ID)
order by 1,2,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head)
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
   				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					
               

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update FB_PRODUCTRETURN set PRET_VOU_NO=:ls_vou_no , PRET_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where PRET_VOU_NO is null and PRET_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	   end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_EXPSUBHEAD,VD_PREFERRED_MES)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,:ld_amt,:ls_dc_ind,'JV For Return To Store',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_esub_head,decode(:ls_esub_head,null,null,'T'));
	
	 
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_esub_head)
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind,:ls_esub_head;	
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then				
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;			
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_return_to_supplier (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym 
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')
	
declare c1 cursor for 
	
select transfer_id, SPR_DATE,ac_ledger,ac_subledger,mysum,Dc_ind			
from  (select a.SPR_ID transfer_id,To_char(SPR_DATE,'dd/mm/yyyy') SPR_DATE,e.acledger_id ac_ledger,c.spc_id ac_subledger,'C' dc_ind, 
				 round(SUM((SPR_QUANTITY * SPR_UNITPRICE)),2) mysum      
		from fb_supproductreturn a,fb_supproductreturndetails b,fb_storeproductcategory c,fb_storeproduct d,fb_acsubledger e
		where a.SPR_ID=b.SPR_ID and b.SP_ID=d.SP_ID and d.SPC_ID=c.SPC_ID and c.SPC_ID=e.ACSUBLEDGER_ID
				and a.SPR_ID = :fs_transid and SPR_VOU_NO is null
		group by a.SPR_ID,To_char(SPR_DATE,'dd/mm/yyyy'),SUP_ID,
				 e.acledger_id ,c.spc_id
		union 
		select a.SPR_ID transfer_id,To_char(SPR_DATE,'dd/mm/yyyy') SPR_DATE,
		         decode(SUP_TYPE,'HO',f.ac_ledger,e.acledger_id) ac_ledger,
				decode(SUP_TYPE,'HO',f.ac_subledger,d.ACSUBLEDGER_ID) ac_subledger,'D' dc_ind,
				 round(SUM((SPR_QUANTITY * SPR_UNITPRICE)),2) mysum        
		from fb_supproductreturn a,fb_supproductreturndetails b,fb_supplier d, fb_acsubledger e,
		       (select x.acledger_id ac_ledger,y.ACSUBLEDGER_ID ac_subledger from fb_acledger x,fb_acsubledger y 
	            where x.ACLEDGER_ID=y.ACLEDGER_ID(+) and acledger_ledgertype='REMITTANCEKIND' and ACSUBLEDGER_NAME='REMITTANCE KIND')f
		where a.SPR_ID=b.SPR_ID and a.SUP_ID=d.SUP_ID and d.ACSUBLEDGER_ID=e.ACSUBLEDGER_ID(+)
				and a.SPR_ID = :fs_transid and SPR_VOU_NO is null
		group by a.SPR_ID,To_char(SPR_DATE,'dd/mm/yyyy'),a.SUP_ID,
				decode(SUP_TYPE,'HO',f.ac_ledger,e.acledger_id)  ,decode(SUP_TYPE,'HO',f.ac_subledger,d.ACSUBLEDGER_ID))		
Order by 1,2,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym )						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
					
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update fb_supproductreturn set SPR_VOU_NO=:ls_vou_no , SPR_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			  where SPR_VOU_NO is null and SPR_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,:ld_amt,:ls_dc_ind,'JV For Return To Supplier',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
	
	  
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;	
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_wages_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_gl,ls_sgl,ls_ym,ls_acesubhead,ls_w2_stdt
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
//double ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction

double ld_amt,ld_lastcoinbf,ld_coinbfded,ld_advanceded,ld_electded,ld_pfded,ld_lwfded,ld_pfadvded,ld_pfintded,ld_rationded,ld_subsded,ld_netpayable,ld_attninc_amt,ld_lip_amt, ld_electadvded, ld_medadvded, ld_festadvded, ld_ptax, ld_lpg_Subs_ded;

ls_ym = 	string(date(fs_ac_dt),'yyyymm')

select to_char(LWW_STARTDATE + 7,'dd/mm/yyyy') into :ls_w2_stdt from fb_labourwagesweek  where lww_id=:fs_transid;

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During select 2ndweek Start : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

declare c1 cursor for 
select lww_id,:fs_frdt  start_dt,
		sum(nvl(labour_lastcoinbf,0)) lastcoinbf,
		sum(nvl(labour_coinbf,0)) coinbfded,
		sum(nvl(labour_advance,0)) advanceded,
		sum(nvl(labour_electricity,0)) electded,
		sum(nvl(labour_pf,0)+nvl(labour_fpf,0)) pfded,
		sum(nvl(labour_lwf,0)) lwfded,
		sum(nvl(labour_pfadvanceded,0)) pfadvded,
		sum(nvl(labour_pfinterestded,0)) pfintded ,
		sum(nvl(labour_ration,0)) rationded,
		sum(nvl(labour_subsded,0)) subsded,
		sum(nvl(LABOUR_NETPAYABLEAMOUNT,0)),
		sum(decode(:gs_garden_state,'03',nvl(LABOUR_ATTN_INC,0),0)) attninc_amt,
		sum(nvl(LABOUR_LIP,0)) lipded, sum(nvl(LABOUR_ELECTADVANCEDED,0)) electadvanceded, sum(nvl(LABOUR_MEDICALADVANCEDED,0)) medadvanceded,
	    sum(nvl(LABOUR_FESTIVALADVANCEDED,0)) festadvanceded, sum(nvl(LABOUR_PTAX,0)) ptax, sum(nvl(LABOUR_LPG_SUBS_DED, 0)) lpg_subs_Ded
  from fb_labourweeklywages where lww_id=:fs_transid
  group by lww_id,:fs_frdt ;			

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ls_ref_dt);
	ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0;  ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_ptax = 0; ld_lpg_Subs_ded = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_ptax, :ld_lpg_Subs_ded;
		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
			    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					

			select nvl(min(AP_PERIOD_ID),0) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			elseif sqlca.sqlcode = 100 then
				messagebox('Information !','Accounting Year Period Not Created, Please Create Period First !!!');
				return 1;		
			elseif sqlca.sqlcode = 0 then
				if ll_ac_period = 0 then
					messagebox('Information !','Accounting Year Period Not Created 1, Please Create Period First !!!');
					return 1;		
				end if;	
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_labourweeklywages set LABOUR_VOU_NO=:ls_vou_no , LABOUR_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where LABOUR_VOU_NO is null and LWW_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
			
			update fb_labourwagesweek set lww_paidflag='1' where LWW_ID= :fs_transid;
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
		// insert into Voucher Detail for coinbfded_val
		 if ld_lastcoinbf >0 then	// (Debit)
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin BF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin CF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin CF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lastcoinbf,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin BF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_coinbfded >0 then	//	(Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin CF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin BF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin BF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_coinbfded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin CF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		

		// insert into Voucher Detail for coinbfded_val
		 if ld_advanceded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Company Advance';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Company Advance Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Company Advance" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_advanceded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Company Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	

				
				
//////////////////////////////////////////////insert into Voucher Detail for elect advance ded

		 if ld_electadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Electric Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Electric Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_electadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Electric Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for medical advance ded

		 if ld_medadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Medical Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Medical Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Medical Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_medadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Medical Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for festival advance ded

		 if ld_festadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Festival Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Festival Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Festival Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_festadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Festival Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for lpg subsidy ded

		 if ld_lpg_subs_ded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL= 'LPG Subsidy Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LPG Subsidy Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"LPG Subsidy Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_lpg_subs_ded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour LPG Subsidy Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			if not isnull(ls_acesubhead) and len(ls_acesubhead) > 0 then
				if wf_upd_mes(fs_ac_dt,ls_acesubhead,(-1) * ld_lpg_subs_ded,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if		
           end if;	


//////////////////////////////////////////////

				
				
		 // insert into Voucher Detail for electded_val
		 if ld_electded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Electric Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_electded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Electric Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
			
//			//Update DailyExpense in expense subhead 'ESUB0054'
//			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_electded,'C','N')  = -1 then 
//				rollback using sqlca;
//				return 1;
//			end if;
            end if;

		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employee Contibution');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

      				
		// insert into Voucher Detail for employer_contribution_val		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,'C',(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employer Contibution');
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					

			//debit
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',(:ld_pfded) ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Deduction');
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead, (ld_pfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
          end if;
			 
		if  (ld_lwfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LWF/PUJA';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LWF/PUJA Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LWF/PUJA Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_lwfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LWF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
			
		 // insert into Voucher Detail for pfadvded_val
		 if ld_pfadvded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Advance Deductionn Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	
		 // insert into Voucher Detail for pfintded_val
		 if ld_pfintded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Intrest Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Intrest Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Intrest Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfintded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Intrest Advance Deduction' );
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;			
				
		 // insert into Voucher Detail for rationded_val
		 if ld_rationded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_rationded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;		
				
	 // insert into Voucher Detail for ld_attninc_amt  for tripura
		 if ld_attninc_amt >0 and gs_garden_state = '03'then		
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Weekly Incentive';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_attninc_amt,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Weekly Incentive Addition');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_attninc_amt ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
		// end attendance incentive for tripura		
		 if ld_lip_amt >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LIP Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lip_amt,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LIP Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
            end if;						
				
		// For Fulbari Ration Compensation in case of Tremporary labour should be debit		
		 if ld_rationded < 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',((-1) * nvl(:ld_rationded,0)),'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Ration Dr) ',sqlca.sqlerrtext);
			end if;	
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
				
		if  (ld_subsded)  > 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Subscription';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Subscription Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Subscription Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_subsded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Subscription Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
		
		//insert into voucher detail for ptax
		
		if ld_ptax >0 then		

			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where  AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PTAX';
		
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PTAX Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Mapping for PTAX Not Present, Please Create First !!!');
					return -1;		
				end if
		
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_ptax,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PTax Deduction');
						
				 if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
				
				if not isnull(ls_acesubhead) and len(ls_acesubhead) > 0 then
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,(-1) * ld_ptax,'C','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if				
		end if;		
		
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
			
			//ls_cgl='LEG0001'  //ls_csgl='SLEG0420'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_netpayable,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Net Payable');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
						
	// insert into Voucher Detail for Pary Week wages value
	
		if  right(left(fs_frdt,5),2)  <> right(left(fs_todt,5),2) then		
			
			declare c3 cursor for	
			select lwwid,:fs_frdt  ATTENDATE,'Provision For Wages' acsubledgername,ACLEDGER_ID,acsubledgerid,sum(dkw.wages) grwages
		  	   from (select lda.lww_id LWWID,lda.lda_date ATTENDATE,kam.kamsub_id KAMSUB_ID,sum(lda.lda_status) NODAYS,
							  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
						from fb_labourdailyattendance lda,fb_kamsubhead kam
					  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'
					  group by (lda.lww_id,lda.lda_date,kam.kamsub_id)) dkw,
					  (select CR_ACLEDGER_ID ACLEDGER_ID, CR_ACSUBLEDGER_ID acsubledgerid from fb_acautoprocess 
			             where AC_PROCESS='Partweek Wages To Account' and AC_PROCESS_DETAIL='Provision For Wages')
			where lwwid=:fs_transid and dkw.attendate>=to_date(:fs_frdt,'DD/MM/YYYY') and dkw.attendate<=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY')) 
			 group by lwwid,:fs_frdt,ACLEDGER_ID,acsubledgerid ;			
			
			open c3; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C3 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'D','JV For Part Week Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Part Week Reverse');
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	
								
					end if;	
                  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl)
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
					 
				loop;	 
				close c3;
			end if;	
		end if	
	end if	
	// Wages Posting
		declare c2 cursor for 
				select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID,
	   				 sum(dkw.wages) grwages
  			   from (select lda.lww_id LWWID,kamsub_id KAMSUB_ID,
               			 		  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
						from fb_labourdailyattendance lda
		 			  where lww_id=:fs_transid and 
	   							((to_char(to_date(:fs_frdt,'dd/mm/yyyy'),'mm')<>to_char(to_date(:fs_todt,'dd/mm/yyyy'),'mm') and 
											trunc(lda_date) >=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY'))+1) or
	   							 (to_char(to_date(:fs_frdt,'dd/mm/yyyy'),'mm')=to_char(to_date(:fs_todt,'dd/mm/yyyy'),'mm') and 
									 		trunc(lda_date) >=to_date(:fs_frdt,'DD/MM/YYYY'))) and
								trunc(lda_date) <=to_date(:fs_todt,'DD/MM/YYYY')  	   
						group by lda.lww_id,kamsub_id ) dkw,
			   		fb_expenseacsubhead eacsub, fb_acsubledger acsub 
 			where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
 			group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
			
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		     
			do while sqlca.sqlcode <> 100 							
				// insert into Voucher Detail		
				
			  if ld_amt > 0 then
				
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Kamjari Wages');
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	

			 end if
			  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			  	ld_amt = 0;
			  
		  		fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		 
		 	loop;	 	
				close c2;
	  	end if;	

// not for tripura
if gs_garden_state <> '03' then
// Attendance Incentive
	if gs_garden_snm <> 'FB' then
		long ll_adoleage;string ls_attn_inc_ind
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)) into :ll_adoleage from fb_param_detail 
		where pd_doc_type in ('ADOLEAGE') and to_date(:fs_frdt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return -1
		end if;
		
		select distinct AI_RATERANGE into :ls_attn_inc_ind from fb_attendanceincentive
		where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Rate Range checking ',sqlca.sqlerrtext)
			return -1
		end if;
	// Daily Attendance Incentive	
	 if ls_attn_inc_ind='D' and gs_garden_snm <> 'BE' and  gs_garden_snm <> 'KG'  then
			declare c4 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)))
									where emp_type = AI_LABOURTYPE(+)) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4;
			end if;	
			
	elseif ls_attn_inc_ind='D' and gs_garden_snm = 'BE'  then
		
			declare c4b cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy') ,EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
						 			     where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) and lda_status > 0
										 group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and lda.labour_id = c.emp_id and 
						  			lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) and nvl(lda_wages,0)>0 and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id union all
						  select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
							 			  where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') and lda_status > 0
									     group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4b; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4b;
			end if;
			
	elseif  ls_attn_inc_ind='D' and gs_garden_snm = 'KG' then
			declare c4c cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select LWWID,KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES from 
					(select lda.lww_id LWWID, lda.labour_id, lda_date, lda.kamsub_id KAMSUB_ID, nvl(atinc_rt,0) atinc_rt, LABOUR_ATTN_INC, ROW_NUMBER() OVER (PARTITION BY lda.labour_id ORDER BY lda_date) labour_order
							from fb_labourdailyattendance lda, fb_kamsubhead b,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)))
									where emp_type = AI_LABOURTYPE(+)) c, (select lww_id, labour_id, LABOUR_ATTN_INC from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0) d
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and                 
								   d.lww_id = lda.lww_id and d.labour_id = lda.labour_id and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE')
								   where  labour_order <= (LABOUR_ATTN_INC / atinc_rt) 
								   group by LWWID,KAMSUB_ID  ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
					where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
					group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;  		  
				
			open c4c; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor c4c : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4c into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4c into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4c;
			end if;	
			
	elseif ls_attn_inc_ind='W' then	// Weekly Attendance Incentive
		
			declare c5 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(nvl(atinc_rt,0)/nodays) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,nodays//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									  			(select labour_id,count(lda_status) nodays from fb_labourdailyattendance a,fb_kamsubhead b
									  		     where a.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and 
														 trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
												  group by labour_id) c
									where emp_type = AI_LABOURTYPE(+) and emp_id = c.labour_id) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
		  
			open c5; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 		
				  if ld_amt > 0 then
					// insert into Voucher Detail							
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'C','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c5;
			end if;	
		end if		// End Attendance Incentive Para
		//END not for tripura
	  end if
	end if
		setnull(ls_ref_no);setnull(ls_ref_dt);
		ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_ptax = 0;ld_lpg_subs_ded = 0;
		
		fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_ptax, :ld_lpg_subs_ded;
		 
loop;	 
		 ///update last no
	if ll_vou_no > 0 then							
		if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
			rollback using sqlca;			
			return -1
		end if	
	end if
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_partweek_wages_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_acesubhead
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
double ld_amt

ls_ym = 	string(date(fs_ac_dt),'yyyymm')

declare c1 cursor for	
  select lwwid,:fs_frdt  ATTENDATE,'Provision For Wages' acsubledgername, ACLEDGER_ID, acsubledgerid, sum(dkw.wages) grwages,'C' dc_ind 
	from (select lda.lww_id LWWID,lda.lda_date ATTENDATE,kam.kamsub_id KAMSUB_ID,sum(lda.lda_status)NODAYS,
				     sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
			 from fb_labourdailyattendance lda,fb_kamsubhead kam
			 where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' group by (lda.lww_id,lda.lda_date,kam.kamsub_id) ) dkw,
					   (select CR_ACLEDGER_ID ACLEDGER_ID, CR_ACSUBLEDGER_ID acsubledgerid from fb_acautoprocess 
			             where AC_PROCESS='Partweek Wages To Account' and AC_PROCESS_DETAIL='Provision For Wages')
		      where lwwid=:fs_transid and 
				    dkw.attendate>=to_date(:fs_frdt,'DD/MM/YYYY') and dkw.attendate<=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY')) 
		       group by lwwid,:fs_frdt,ACLEDGER_ID, acsubledgerid ;			

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	ld_amt= 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
			  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						
                  select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');

			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_labourwagesweek set LWW_PARTWEEK_VOU_NO =:ls_vou_no 
				where LWW_PARTWEEK_VOU_NO is null and LWW_ID= :ls_ref_no ; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Update Part Week wages Voucher No and Date ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
					
		// Credit GL/SGL
            
		// insert into Voucher Detail for netamt_val		
		if ld_amt >0 then					
			insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values (:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'C','JV For Part Week Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;			
		
		//Debit GL/SGL
		declare c2 cursor for 		
			select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID,
					 sum(dkw.wages) grwages,'D' dc_ind 
		  	   from (select lda.lww_id LWWID,lda.lda_date ATTENDATE,kam.kamsub_id KAMSUB_ID,sum(lda.lda_status)NODAYS,
				                  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
      		   			from fb_labourdailyattendance lda,fb_kamsubhead kam
					  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'  group by (lda.lww_id,lda.lda_date,kam.kamsub_id)) dkw,
					  fb_expenseacsubhead eacsub, fb_acsubledger acsub 
		      where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id and 
				       lwwid=:fs_transid and 
				       dkw.attendate>=to_date(:fs_frdt,'DD/MM/YYYY') and dkw.attendate<=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY')) 
		       group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;			
	
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
		     
			do while sqlca.sqlcode <> 100 							
				
				insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
				values (:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Part Week Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
			
			  setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			  ld_amt = 0;
			  
		  fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
		 
		 loop;	 	
		close c2;
	  end if;	
	end if;	
//end if;	
	
	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	ld_amt= 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
		 
		loop;	 
		 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
		close c1;
	end if;	
	
return 1;	

end function

public function integer wf_arrear_to_account (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_acesubhead
long  ll_vou_no,fymm,ll_last,ll_doc_no
double ld_amt,ld_grosswages,ld_cointhisweek,ld_coingiven,ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction

ls_ym = 	string(date(fs_ac_dt),'yyyymm')
 
declare c1 cursor for 

 SELECT d.AP_ID,to_date(:fs_ac_dt,'dd/mm/yyyy')arr_dt,sum(nvl(c.LA_AMOUNT,0)) amount, sum(nvl(c.LA_PF,0)) pf, sum(nvl(c.LA_FPF,0)) fpf
  FROM FB_EMPLOYEE a,FB_ARREARFORSHEET b, FB_LABOURARREAR c,FB_ARREARPERIOD d
 WHERE a.LS_ID = b.LS_ID AND a.EMP_ID = c.LABOUR_ID AND b.AFS_ID = c.AFS_ID AND 
       		b.AP_ID = d.AP_ID AND d.AP_ID=:fs_transid and 
	   		d.AP_STARTDATE = to_date(:fs_frdt,'dd/mm/yyyy') AND d.AP_ENDDATE = to_date(:fs_todt,'dd/mm/yyyy')
group by d.AP_ID,to_date(:fs_ac_dt,'dd/mm/yyyy');	 

open c1;   

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ls_ref_dt);
	ld_grosswages= 0;ld_pfded= 0;ld_fpfded= 0;ld_netdeduction=0;ld_netdeduction=0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_grosswages,:ld_pfded,:ld_fpfded;
	  ld_netdeduction= ld_pfded+ld_fpfded 
	  ld_netpayable=ld_grosswages - ld_netdeduction
	  		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
				
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID, VH_UNIT_ID, VH_DOC_SRL, VH_VOU_NO, VH_VOU_DATE, VH_VOU_TYPE, VH_AC_YEAR, VH_ENTRY_DT, VH_ENTRY_BY, VH_APPROVED_BY, VH_APPROVED_DT)
                values( :gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate);   
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update FB_LABOURARREAR set la_vou_no=:ls_vou_no , la_vou_dt=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where la_vou_no is null and AFS_ID in(select distinct AFS_ID from FB_ARREARFORSHEET  where ap_id = :ls_ref_no) ;  
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	
		// Credit GL/SGL
            
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
				select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			     where AC_PROCESS='Arrear To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0001'  //ls_csgl='SLEG0420'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_netpayable,'C','JV For Arrear To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
		end if;
		
		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded+ld_fpfded)  >0 then	 
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			     where AC_PROCESS='Arrear To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'    //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(:ld_pfded+:ld_fpfded) ,'C','JV For Arrear To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
      				
		// insert into Voucher Detail for employer_contribution_val		
			//credit
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			     where AC_PROCESS='Arrear To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(:ld_pfded+:ld_fpfded) ,'C','JV For Arrear To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					

			//debit
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			     where AC_PROCESS='Arrear To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'    //	ls_csgl='SLEG0004'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(:ld_pfded+:ld_fpfded) ,'D','JV For Arrear To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead, (ld_pfded+ld_fpfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
		
		///debit	
		 if  (ld_grosswages)  >0 then	
		 
		 select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			     where AC_PROCESS='Arrear To Account' and AC_PROCESS_DETAIL='Unpaid Arrear Wages';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Unpaid Arrear Wages Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Unpaid Arrear Wages Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_gl='LEG0001'  //ls_sgl='SLEG0640'  	
			
		// insert into Voucher Detail
		insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
		values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,:ld_grosswages ,'D','JV For Arrear To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
				
		if sqlca.sqlcode = -1 then 		 
			messagebox('Sql Error: During Insertion Of Voucher Detail 2 (Dr) ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		end if;	
		
	end if
  end if;	

	
	setnull(ls_ref_no);setnull(ls_ref_dt);
	ld_grosswages= 0;ld_pfded= 0;ld_fpfded= 0;ld_netdeduction=0;ld_netdeduction=0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_grosswages,:ld_pfded,:ld_fpfded;
	  ld_netdeduction= ld_pfded+ld_fpfded 
	  ld_netpayable=ld_grosswages - ld_netdeduction
		 
		loop;	 
		 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
		close c1;
	end if;	
	
return 1;	

end function

public function integer wf_upd_dailystock (string fs_ref_no, string fs_date, string fs_sp_id, double fd_qnty, double fd_rate, double fd_value, string fs_ref_type, string fs_rec_ty, string fs_old_rec, string fs_div);string ref_sgl
 ////for update record 

if fs_old_rec='Y' then			  
    delete from fb_daily_stock 
	 where DS_REF_NO = :fs_ref_no and DS_REF_DATE=to_date(:fs_date,'DD/MM/YYYY') and DS_REF_TYPE = :fs_ref_type and DS_ITEM_CD=:fs_sp_id and nvl(ds_rate,0)=:fd_rate;
		   
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During stock Update for old item: ',sqlca.sqlerrtext);
		rollback using sqlca;
		return -1;
	end if;	
	
else	/// for new record
    select distinct 'x' into :ls_temp from fb_daily_stock
	where DS_REF_NO = :fs_ref_no and DS_REF_DATE=to_date(:fs_date,'DD/MM/YYYY') and 
			DS_REF_TYPE = :fs_ref_type and DS_ITEM_CD=:fs_sp_id and nvl(ds_rate,0)=:fd_rate and DS_SECTION_ID=:fs_div;		   	  
 
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting stock detail : ',sqlca.sqlerrtext);
		rollback using sqlca;
		return -1;		
	elseif sqlca.sqlcode = 100 then
		  	
			insert into fb_daily_stock(DS_DATE, DS_REF_NO, DS_REF_DATE, DS_REF_TYPE, DS_REF_SGL, DS_ITEM_CD, DS_SECTION_ID, DS_QTY, DS_RATE, DS_VALUE, DS_REC_IND)
			select distinct to_date(:fs_date,'DD/MM/YYYY'),:fs_ref_no,to_date(:fs_date,'DD/MM/YYYY'),:fs_ref_type,a.SPC_ID,:fs_sp_id,:fs_div,nvl(:fd_qnty,0),nvl(:fd_rate,0),nvl(:fd_value,0),:fs_rec_ty
			  from fb_storeproduct a where a.SP_ID=:fs_sp_id;
	
		  if sqlca.sqlcode = -1 then
			messagebox('Sql Error During stock Insert : ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		 end if;		

	elseif sqlca.sqlcode = 0 then
		update fb_daily_stock set DS_QTY=nvl(DS_QTY,0) + nvl(:fd_qnty,0),
		                                          DS_VALUE=nvl(DS_VALUE,0 ) + nvl(:fd_value,0)
		where DS_REF_NO = :fs_ref_no and DS_REF_DATE=to_date(:fs_date,'DD/MM/YYYY') and 
			DS_REF_TYPE = :fs_ref_type and DS_ITEM_CD=:fs_sp_id and nvl(ds_rate,0)=:fd_rate and DS_SECTION_ID=:fs_div and rownum = 1;		
			
		 if sqlca.sqlcode = -1 then
			messagebox('Sql Error During stock Update : ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		 end if;	
		 
	end if;
  end if;	
return 1;
end function

public function integer wf_cash_plucking (string fs_transid, string fs_ac_dt);string ls_ref_dt,ls_sec_no,ls_old_ref_dt,ls_ym,ls_vou_no
string ls_dgl,ls_dsgl,ls_dsub_sgl,ls_cgl,ls_csgl

boolean lb_first_read

datetime ld_dt
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt ,ld_totamt

lb_first_read = true

ls_ym = string(date(fs_ac_dt),'yyyymm')

select  max(DR_ACLEDGER_ID) DR_ACLEDGER_ID,max(DR_ACSUBLEDGER_ID) DR_ACSUBLEDGER_ID,max(DR_EACSUBHEAD_ID) DR_EACSUBHEAD_ID,
			  			max(CR_ACLEDGER_ID) CR_ACLEDGER_ID,max(CR_ACSUBLEDGER_ID) CR_ACSUBLEDGER_ID
  into :ls_dgl,:ls_dsgl,:ls_dsub_sgl,:ls_cgl,:ls_csgl
  from fb_acautoprocess where AC_PROCESS = 'CASH Plucking';

if sqlca.sqlcode = -1 then 		 
	messagebox('Sql Error: During Getting Lesger/Sub Ledger (Cash Plucking) ',sqlca.sqlerrtext);
	rollback using sqlca;
	return -1;
end if;		

declare c1 cursor for 
select trunc(SPR_DATE) SPR_DATE,to_char(SPR_DATE,'dd/mm/yyyy') SPR_DATE,SECTION_ID, (nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) mysum
 from fb_sectionpluckinground
 where SPR_PLUCCKTYPE= 'C' and SPR_VOU_NO is null 
order by 1,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ld_dt); setnull(ls_ref_dt); setnull(ls_sec_no); ld_amt = 0; 
	
	fetch c1 into :ld_dt,:ls_ref_dt,:ls_sec_no,:ld_amt;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_dt <> ls_old_ref_dt) then
			
			if lb_first_read = false then
				
				if ld_totamt > 0 then
					
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_AMOUNT,VD_DC_IND,VD_DETAIL)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,:ld_totamt,'C','CPV For Cash PLucking');
			 
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Credit) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;
					ld_totamt = 0
				end if
				
			end if
			
			lb_first_read = false
			ls_old_ref_dt = ls_ref_dt
			
			/// Generate reference no
				select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
				ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				select distinct 'x' into :ls_temp from FB_SERIAL_NO  where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
   				   ll_vou_no = f_get_lastno('CV',ls_ym)
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='CV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					
               
		// insert into Voucher Head
		
			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_CONTRA_GL,VH_CONTRA_SGL,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'CPV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ls_cgl,:ls_csgl,:ll_ac_period,'G');
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date  
			Update fb_sectionpluckinground set SPR_VOU_NO=:ls_vou_no , SPR_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where SPR_PLUCCKTYPE='C' and SPR_VOU_NO is null trunc(SPR_DATE) = to_date(:ls_ref_dt,'dd/mm/yyyy'); 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	   end if ;
		ld_totamt = ld_totamt + ld_amt

		// insert into Voucher Detail
		if not isnull(ls_dgl) then
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_dgl,:ls_dsgl,:ls_dsub_sgl,:ls_sec_no,'C',:ld_amt,'D','CPV For Cash PLucking');
	
	 
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail  (Debit) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if

		setnull(ld_dt); setnull(ls_ref_dt); setnull(ls_sec_no); ld_amt = 0; 
		fetch c1 into :ld_dt,:ls_ref_dt,:ls_sec_no,:ld_amt;
    
	loop;
	
		if ld_totamt > 0 then
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_AMOUNT,VD_DC_IND,VD_DETAIL)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,:ld_totamt,'C','CPV For Cash PLucking');
	 
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Credit) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;

		end if

	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('CV',ls_ym,ll_vou_no) = -1 then				
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;			
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_unitstore_transfer_ac (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym 
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

ls_ym = string(date(fs_ac_dt),'yyyymm')
	
declare c1 cursor for 
select transfer_id,to_char(PRIS_DATE,'dd/mm/yyyy') PRIS_DATE,ACLEDGER_ID,acsubledger_id,mysum,Dc_ind
from  (SELECT pi.PRIS_ID transfer_id, PRIS_DATE,ACLEDGER_ID, acsub.acsubledger_id acsubledger_id ,SUM (pid.pris_value) mysum,'C' dc_ind
   		  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_supplier sup,fb_acsubledger acsub
  		WHERE acsub.acsubledger_id = sup.acsubledger_id 
       			    AND sup.sup_id = pi.sup_id
        			    AND pi.pris_id = pid.pris_id and pi.PRIS_TRANSFERTO_IND='U'
				     and pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='R' 
  		 GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,sup.sup_id, acsub.acsubledger_id			 	  
  	    union
     	    SELECT pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id,SUM (pid.pris_value) mysum, 'D' dc_ind
       	  FROM fb_producttransfer pi,fb_producttransferdetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger 
         WHERE pi.pris_id = pid.pris_id 
                       AND pid.sp_id = sp.sp_id 
                       AND sp.spc_id = spc.spc_id 
		            and spc.spc_id= ACSUBLEDGER_ID and pi.PRIS_TRANSFERTO_IND='U'
		            and ACLEDGER_ID in (select acledger_id from fb_acledger where acledger_ledgertype='STORE')
		            and pi.pris_id =:fs_transid and PRIS_VOU_NO is null and PRIS_REC_TYPE='R' 
         GROUP BY pi.PRIS_ID, PRIS_DATE,ACLEDGER_ID,spc.spc_id)
Order by 1,2,3;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);	setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym )						
				   if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
				   end if
				   if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				   end if 					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
					
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		//Update Voucher No /Date
			Update fb_producttransfer set PRIS_VOU_NO=:ls_vou_no , PRIS_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			  where PRIS_VOU_NO is null and PRIS_ID= :ls_ref_no ; 
			  
			  messagebox('Voucher No.',ls_vou_no)
			 			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if ;
		
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,:ld_amt,:ls_dc_ind,'JV For Unit Store Transfer To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
	
	  
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
	      setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
	      ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;	
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_wages_to_account_mt (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_gl,ls_sgl,ls_ym,ls_acesubhead,ls_w2_stdt
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
//double ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction

double ld_amt,ld_lastcoinbf,ld_coinbfded,ld_advanceded,ld_electded,ld_pfded,ld_lwfded,ld_pfadvded,ld_pfintded,ld_rationded,ld_subsded,ld_netpayable,ld_attninc_amt,ld_lip_amt;
double ld_koilded,ld_wagadvded,ld_elpded,ld_rdded,ld_ptaxded,ld_rstampded
ls_ym = 	string(date(fs_ac_dt),'yyyymm')

select to_char(LWW_STARTDATE + 7,'dd/mm/yyyy') into :ls_w2_stdt from fb_labourwagesweek  where lww_id=:fs_transid;

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During select 2ndweek Start : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if
    
declare c1 cursor for 
select lww_id,:fs_frdt  start_dt,
		sum(nvl(labour_lastcoinbf,0)) lastcoinbf,
		sum(nvl(labour_coinbf,0)) coinbfded,
		sum(nvl(labour_advance,0)) advanceded,
		sum(nvl(labour_electricity,0)) electded,
		sum(nvl(labour_pf,0)+nvl(labour_fpf,0)) pfded,
		sum(nvl(labour_lwf,0)) lwfded,
		sum(nvl(labour_pfadvanceded,0)) pfadvded,
		sum(nvl(labour_pfinterestded,0)) pfintded ,
		sum(nvl(labour_ration,0)) rationded,
		sum(nvl(labour_subsded,0)) subsded,
		sum(nvl(LABOUR_KOIL,0)) koilded,
         sum(nvl(LABOUR_WAGADVANCE,0)) wagadvded,
         sum(nvl(labour_elpearn,0)) elpded,
         sum(nvl(LABOUR_RD,0)) rdded,                     
         sum(nvl(LABOUR_PTAX,0)) ptaxded,                    
         sum(nvl(LABOUR_REVST,0)) rstampded,  
		sum(nvl(LABOUR_NETPAYABLEAMOUNT,0)),
		sum(decode(:gs_garden_state,'03',nvl(LABOUR_ATTN_INC,0),0)) attninc_amt,
		sum(nvl(LABOUR_LIP,0)) lipded
  from fb_labourweeklywages where lww_id=:fs_transid
  group by lww_id,:fs_frdt ;			
  
 
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ls_ref_dt);
	ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0
	ld_koilded= 0; ld_wagadvded = 0; ld_elpded= 0; ld_rdded= 0; ld_ptaxded= 0; ld_rstampded= 0;
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_koilded,:ld_wagadvded,:ld_elpded,:ld_rdded,:ld_ptaxded,:ld_rstampded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt;
		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
			    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_labourweeklywages set LABOUR_VOU_NO=:ls_vou_no , LABOUR_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where LABOUR_VOU_NO is null and LWW_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
			
			update fb_labourwagesweek set lww_paidflag='1' where LWW_ID= :fs_transid;
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
		// insert into Voucher Detail for coinbfded_val
		 if ld_lastcoinbf >0 then	// (Debit)
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin BF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin CF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin CF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lastcoinbf,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin BF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_coinbfded >0 then	//	(Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin CF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin BF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin BF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_coinbfded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin CF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		

		// insert into Voucher Detail for coinbfded_val
		 if ld_advanceded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Company Advance';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Company Advance Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Company Advance" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_advanceded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Company Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	
				
		 // insert into Voucher Detail for electded_val
		 if ld_electded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Electric Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_electded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Electric Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
			
//			//Update DailyExpense in expense subhead 'ESUB0054'
//			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_electded,'C','N')  = -1 then 
//				rollback using sqlca;
//				return 1;
//			end if;
            end if;

		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employee Contibution');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

      				
		// insert into Voucher Detail for employer_contribution_val		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,'C',(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employer Contibution');
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					

			//debit
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',(:ld_pfded) ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Deduction');
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead, (ld_pfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
          end if;
			 
		if  (ld_lwfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LWF/PUJA';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LWF/PUJA Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LWF/PUJA Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_lwfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LWF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
			
		 // insert into Voucher Detail for pfadvded_val
		 if ld_pfadvded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Advance Deductionn Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	
		 // insert into Voucher Detail for pfintded_val
		 if ld_pfintded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Intrest Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Intrest Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Intrest Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfintded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Intrest Advance Deduction' );
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;			
				
		 // insert into Voucher Detail for rationded_val
		 if ld_rationded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_rationded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;		
				
	 // insert into Voucher Detail for ld_attninc_amt  for tripura
	 if ld_attninc_amt >0 and gs_garden_state = '03'then		
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Weekly Incentive';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Weekly Incentive Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Weekly Incentive Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_attninc_amt,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Weekly Incentive Addition');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_attninc_amt ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
		// end attendance incentive for tripura		
		 if ld_lip_amt >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LIP Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LIP Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LIP Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lip_amt,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LIP Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
            end if;						
				
		// For Fulbari Ration Compensation in case of Tremporary labour should be debit		
		 if ld_rationded < 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',((-1) * nvl(:ld_rationded,0)),'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Ration Dr) ',sqlca.sqlerrtext);
			end if;	
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
				
		if  (ld_subsded)  > 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Subscription';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Subscription Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Subscription Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_subsded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Subscription Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
		
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
			
			//ls_cgl='LEG0001'  //ls_csgl='SLEG0420'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_netpayable,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Net Payable');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		    
			// insert into Voucher Detail for koilded_val		
		if ld_koilded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='K Oil';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select KOil Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','K Oil Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_koilded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'K Oil');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		
	
			// insert into Voucher Detail for F/N Advance		
		if ld_wagadvded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='F/N Advance';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select F/N Advance Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','F/N Advance Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_wagadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'F/N Advance');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		

			// insert into Voucher Detail for ELP Gross		
		if ld_elpded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='ELP Gross';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select F/N Advance Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ELP Gross Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_elpded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'ELP Gross');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		
		  /// ld_koilded,ld_wagadvded,ld_elpded,ld_rdded,ld_ptaxded,ld_rstampded
			// insert into Voucher Detail for RD		
		if ld_rdded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='RD';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select RD Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','RD Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_rdded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'RD');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		
		
			// insert into Voucher Detail for P Tax		
		if ld_ptaxded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='P Tax';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select P Tax Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','P Tax Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_ptaxded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'P Tax Deduction');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		
		 
			// insert into Voucher Detail for R Stamp		
		if ld_rstampded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='R Stamp';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select R Stamp Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','R Stamp Not Present, Please Create First !!!');
					return -1;		
				end if
			
						
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_rstampded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'R Stamp');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
		
	// insert into Voucher Detail for Pary Week wages value
	
		if  right(left(fs_frdt,5),2)  <> right(left(fs_todt,5),2) then		
			
			declare c3 cursor for	
			select lwwid,:fs_frdt  ATTENDATE,'Provision For Wages' acsubledgername,ACLEDGER_ID,acsubledgerid,sum(dkw.wages) grwages
		  	   from (select lda.lww_id LWWID,lda.lda_date ATTENDATE,kam.kamsub_id KAMSUB_ID,sum(lda.lda_status) NODAYS,
							  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
						from fb_labourdailyattendance lda,fb_kamsubhead kam
					  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'
					  group by (lda.lww_id,lda.lda_date,kam.kamsub_id)) dkw,
					  (select CR_ACLEDGER_ID ACLEDGER_ID, CR_ACSUBLEDGER_ID acsubledgerid from fb_acautoprocess 
			             where AC_PROCESS='Partweek Wages To Account' and AC_PROCESS_DETAIL='Provision For Wages')
			where lwwid=:fs_transid and dkw.attendate>=to_date(:fs_frdt,'DD/MM/YYYY') and dkw.attendate<=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY')) 
			 group by lwwid,:fs_frdt,ACLEDGER_ID,acsubledgerid ;			
			
			open c3; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C3 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'D','JV For Part Week Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Part Week Reverse');
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	
								
					end if;	
                  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl)
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
					 
				loop;	 
				close c3;
			end if;	
		end if	
	end if	
	// Wages Posting
		declare c2 cursor for 
			select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID,
                       sum(dkw.wages) grwages
              from (select lda.lww_id LWWID,kamsub_id KAMSUB_ID,
 	                            sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
  	                    from fb_labourdailyattendance lda
                      where lww_id=:fs_transid   	   
 	                  group by lda.lww_id,kamsub_id 
					 union
					( select lww_id LWWID,kamsub_id KAMSUB_ID,
						 (sum(decode(sign(nvl(lda_elp,0)-1),-1,0,nvl(lda_elp,0))) - sum(decode(sign(nvl(lda_elp,0)-1),-1,nvl(lda_elp,0) * -1,0))) elpearn  
						from fb_labourdailyattendance
					 where trunc(lda_date) between to_date('30/07/2012','dd/mm/yyyy') and to_date('31/07/2012','dd/mm/yyyy')  and
                                  to_char(to_date(:fs_frdt,'dd/mm/yyyy'),'yyyymm')= '201208' 
					  group by lww_id ,kamsub_id 
					 having sum(decode(sign(nvl(lda_elp,0)-1),-1,0,nvl(lda_elp,0)))>0 or  sum(decode(sign(nvl(lda_elp,0)-1),-1,nvl(lda_elp,0) * -1,0)) >0) ) dkw,
	                   fb_expenseacsubhead eacsub, fb_acsubledger acsub 
  where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
  group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;	
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		     
			do while sqlca.sqlcode <> 100 							
				// insert into Voucher Detail		
				
			  if ld_amt > 0 then
				
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Kamjari Wages');
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	

			 end if
			  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			  	ld_amt = 0;
			  
		  		fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		 
		 	loop;	 	
				close c2;
	  	end if;	

// not for tripura
if gs_garden_state <> '03' then
// Attendance Incentive
	if gs_garden_snm <> 'FB' then
		long ll_adoleage;string ls_attn_inc_ind
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)) into :ll_adoleage from fb_param_detail 
		where pd_doc_type in ('ADOLEAGE') and to_date(:fs_frdt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return -1
		end if;
		
		select distinct AI_RATERANGE into :ls_attn_inc_ind from fb_attendanceincentive
		where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Rate Range checking ',sqlca.sqlerrtext)
			return -1
		end if;
	// Daily Attendance Incentive	
	 if ls_attn_inc_ind='D' and gs_garden_snm <> 'BE' then
			declare c4 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)))
									where emp_type = AI_LABOURTYPE(+)) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4;
			end if;	
			
	elseif ls_attn_inc_ind='D' and gs_garden_snm = 'BE'  then
		
			declare c4b cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt//(((to_date(:fs_frdt,'dd/mm/yyyy') - EMP_DOB)/365))
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
						 			     where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) and lda_status=1
										 group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and lda.labour_id = c.emp_id and 
						  			lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) and nvl(lda_wages,0)>0 and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id union all
						  select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
							 			  where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') and lda_status=1
									     group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4b; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4b;
			end if;	
			
	elseif ls_attn_inc_ind='W' then	// Weekly Attendance Incentive
		
			declare c5 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(nvl(atinc_rt,0)/nodays) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,nodays
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									  			(select labour_id,count(lda_status) nodays from fb_labourdailyattendance a,fb_kamsubhead b
									  		     where a.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and 
														 trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
												  group by labour_id) c
									where emp_type = AI_LABOURTYPE(+) and emp_id = c.labour_id) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
		  
			open c5; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 		
				  if ld_amt > 0 then
					// insert into Voucher Detail							
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'C','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c5;
			end if;	
		end if		// End Attendance Incentive Para
		//END not for tripura
	  end if
	end if
		setnull(ls_ref_no);setnull(ls_ref_dt);
		ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0
		ld_koilded= 0; ld_wagadvded = 0; ld_elpded= 0; ld_rdded= 0; ld_ptaxded= 0; ld_rstampded= 0;
		fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_koilded,:ld_wagadvded,:ld_elpded,:ld_rdded,:ld_ptaxded,:ld_rstampded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt;
		 
loop;	 
		 ///update last no
	if ll_vou_no > 0 then							
		if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
			rollback using sqlca;			
			return -1
		end if	
	end if
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_purchase_adjto_account (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_dgl,ls_dsgl,ls_cgl,ls_csgl,ls_dexp,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_name,ls_supid,ls_ym,ls_detail,ls_gttype, ls_gtid
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 
date ld_ref_dt
 
ls_ym = string(date(fs_ac_dt),'yyyymm')
declare c1 cursor for 
	SELECT AJ_ID, trunc(AJ_DATE),pi.AJ_ADJAMOUNT,sup.sup_id, sup.sup_name,  
                decode(pi.gt_type,'PURCHASE',ac_gl,ACLEDGER_ID) debit_gl,decode(pi.gt_type,'PURCHASE',ac_sgl,sup.acsubledger_id) debit_sgl,
                decode(pi.gt_type,'PURCHASE',ACLEDGER_ID,ac_gl) credit_gl,decode(pi.gt_type,'PURCHASE',sup.acsubledger_id,ac_sgl) credit_sgl,
                decode(pi.gt_type,'PURCHASE',ac_exp,null) debit_exphead,
                pi.gt_type,GT_ID
        FROM fb_gltransaction_adj pi, fb_supplier sup,
              (select decode(AC_PROCESS_DETAIL,'Purchase  Leaf','PURCHASE','SALE') rectype,
                        decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_ACLEDGER_ID,CR_ACLEDGER_ID) ac_gl,
                        decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_ACSUBLEDGER_ID,CR_ACSUBLEDGER_ID) ac_sgl,
                        decode(AC_PROCESS_DETAIL,'Purchase  Leaf',DR_EACSUBHEAD_ID,CR_EACSUBHEAD_ID) ac_exp
                from fb_acautoprocess
                where AC_PROCESS='Green Leaf Purchase'),
                fb_acsubledger a
     WHERE pi.sup_id = sup.sup_id AND pi.gt_type  in ('PURCHASE','SALE') and pi.gt_type = rectype and 
                 aj_VOU_NO is null and sup.acsubledger_id = a.ACSUBLEDGER_ID and aj_ID=:fs_transid
    order by 1,2;
		  
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ld_ref_dt);setnull(ls_supid);setnull(ls_name);setnull(ls_detail);setnull(ls_dgl);setnull(ls_dsgl);setnull(ls_cgl);setnull(ls_csgl);setnull(ls_dexp);setnull(ls_gttype);setnull(ls_gtid);
	ld_amt = 0; 
	
	fetch c1 into :ls_ref_no,:ld_ref_dt,:ld_amt,:ls_supid,:ls_name,:ls_dgl,:ls_dsgl,:ls_cgl,:ls_csgl,:ls_dexp,:ls_gttype,:ls_gtid;
	
	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
					if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return -1
					end if
				  if ll_vou_no >= 0 then
						ls_vou_no = string(ll_vou_no,'0000')
						ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 					

			select min(AP_PERIOD_ID) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
													   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;

		//Update Voucher No /Date
			Update fb_gltransaction_adj set AJ_VOU_NO=:ls_vou_no , AJ_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where AJ_VOU_NO is null and AJ_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
		//Update Voucher No /Date
			Update fb_gltransaction set GT_ADJAMT = nvl(GT_ADJAMT,0) + nvl(:ld_amt,0) where GT_ID = :ls_gtid ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Adjusted Amount ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
	end if ;
		if ld_amt > 0 then
			// insert into Voucher Detail
				insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
				values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_amt,'C',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,:ld_ref_dt);
		      
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (cr)  ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
	              
			// Find Dedit GL/SGL
			// insert into Voucher Detail
			insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_dgl,:ls_dsgl,:ls_dexp,null,decode(:ls_gttype,'SALE',null,'C'),:ld_amt,'D',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,:ld_ref_dt);
	
	       	if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (dr)  ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;
		elseif  ld_amt < 0 then
				insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
				values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,(-1) * :ld_amt,'D',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,:ld_ref_dt);
		      
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (dr)  ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
	              
			// Find Dedit GL/SGL
			// insert into Voucher Detail
			insert into  fb_vou_det (VD_DOC_SRL,VD_CO_ID,vd_functions,vd_business_segment,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values (:ll_doc_no,:gs_CO_ID,'PLT',:gs_garden_snm,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_dgl,:ls_dsgl,:ls_dexp,null,decode(:ls_gttype,'SALE',null,'D'),(-1) *:ld_amt,'C',decode(:ls_gttype,'SALE','JV For Sale To Account','JV For Purchase To Account'),:ls_ref_no,:ld_ref_dt);
	
	       	if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (cr)  ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;			
		end if
				
		setnull(ls_ref_no);setnull(ld_ref_dt);	setnull(ls_supid);setnull(ls_name);setnull(ls_gttype);setnull(ls_detail);setnull(ls_dgl);setnull(ls_dsgl);setnull(ls_cgl);setnull(ls_csgl);setnull(ls_dexp);setnull(ls_gttype);setnull(ls_gtid);
	      ld_amt = 0; 
	
		fetch c1 into :ls_ref_no,:ld_ref_dt,:ld_amt,:ls_supid,:ls_name,:ls_dgl,:ls_dsgl,:ls_cgl,:ls_csgl,:ls_dexp,:ls_gttype,:ls_gtid;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;	
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_horemittance_entry (string fs_ac_dt, string fs_st_dt, string fs_end_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym,fs_transid, ls_year 
long  ll_vou_no,ll_doc_no
double ld_amt

ls_ym = string(date(fs_ac_dt),'yyyymm') 
		
SELECT  sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0),
                                                      'H',decode(trunc(VH_VOU_DATE),to_date(:fs_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)),
                                                            decode(sign(trunc(VH_VOU_DATE)- to_date(:fs_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0))))  -
        sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0),
                                                      'H',decode(trunc(VH_VOU_DATE),to_date(:fs_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)),
                                                            decode(sign(trunc(VH_VOU_DATE) - to_date(:fs_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)))) amt    
into :ld_amt
from FB_ACLEDGER a,fb_vou_head,Fb_vou_DET
where VH_DOC_SRL = vd_doc_srl and vd_gl_cd = ACLEDGER_ID AND ACLEDGER_CUMLATIVE_IND in ('C','H') and trunc(VH_VOU_DATE) <= TO_DATE (:fs_ac_dt,'dd/mm/yyyy') and VH_APPROVED_DT is not null;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting HO Remittance Openning Value',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	
	select min(a.ACLEDGER_ID), min(ACSUBLEDGER_ID) 
	into :ls_gl,:ls_sgl
	from fb_acledger a, fb_acsubledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and ACLEDGER_CUMLATIVE_IND in ('H');
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting HO Remittance Ledger, Subledger',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode  = 0 then
			if ld_amt > 0 then
				ls_dc_ind = 'D'
			else
				ls_dc_ind = 'C'
			end if
			
			if MessageBox("Process  Alert", 'The Adjustment Amount Will Be '+string(ld_amt) +' & '+ ls_dc_ind+ ' Type, Do You Want To Continue ....?' ,Exclamation!, YesNo!, 1) = 2 THEN
				return 1
			end if
//			if messagebox('Informarion !','

		/// Generate reference no
			 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
				ll_doc_no = ll_doc_no + 1
				///Generate voucher no
					ll_vou_no = 0
					  
			select distinct 'x' into :ls_temp from FB_SERIAL_NO 
			where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
			
			if sqlca.sqlcode = 100 then
				INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
				INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
				INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
				commit using sqlca;
			end if
			
			ll_vou_no = f_get_lastno('JV',ls_ym )						
			if ll_vou_no < 0 then
				messagebox('Error At Last No Getting',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if
			if ll_vou_no >= 0 then
				ls_vou_no = string(ll_vou_no,'0000')
				ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
			end if 					

//			select min(AP_PERIOD_ID) into :ll_ac_period
//			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
//					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


//			if sqlca.sqlcode = -1 then
//				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return -1
//			end if;
			
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,15,'G');
					
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
		
			ls_year = right(fs_end_dt,4)+'-'+string(long(right(fs_end_dt,2))+1)
		// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,:ld_amt,:ls_dc_ind,'Being Amt. Adj. To Trail Balance For The Year '||:ls_year,:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
	
	  
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	end if
end if
commit using sqlca;	
	
return 1;	

end function

public function integer wf_purchase_tostore_ac_gst (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_supp_id,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_rev_chg, ls_revinvno, ls_revchg_catg
string ls_tcs_dgl, ls_tcs_dsgl, ls_tcs_cgl, ls_tcs_csgl
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period,ll_dcno
double ld_amt ,ld_otheramt,ld_supp_val, ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_bill_amt,ld_ttax,  ld_tcgst_amt, ld_tsgst_amt, ld_tigst_amt, ld_tcs_amt

ls_ym = 	string(date(fs_ac_dt),'yyyymm')

//	SELECT pi.LPI_ID,To_char(LPI_DATE,'dd/mm/yyyy') LPI_DATE,SUP_ID, 
//       (SUM(decode(nvl(pid.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+((lpi_effectiveunitprice* LPI_QUANTITY)*(pid.LPI_SALETAX/100))))) store_catg_val,
//       (SUM(decode(nvl(pid.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+((lpi_effectiveunitprice* LPI_QUANTITY)*(pid.LPI_SALETAX/100))))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt)) other_val,
//	   totamt+(nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0)) supplier_val,
//	   a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name
//  FROM fb_localpurchaseinvoice pi,fb_lpidetails pid,fb_localpurchaseorder c,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
//	   (select lpi_id,  round(SUM(decode(nvl(LPI_SALETAX,0),0,(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY),(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)+((LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)*(LPI_SALETAX/100)))),2) totamt from fb_lpidetails group by lpi_id) x
// WHERE pi.lpi_id = pid.lpi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and pi.LPO_ID = c.LPO_ID(+) and 
//       pi.LPI_ID = x.LPI_ID and pi.LPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and LPI_VOU_NO is null
// GROUP BY pi.LPI_ID,LPI_DATE,a.acledger_id,SUP_ID,spc.spc_id,spc.spc_name,totamt,nvl(LPI_FREIGHT,0),nvl(LPI_INSURANCE,0),nvl(LPI_OTHERAMO,0)
// order by 1,2
//

declare c1 cursor for 
SELECT pi.LPI_ID,To_char(LPI_DATE,'dd/mm/yyyy') LPI_DATE,SUP_ID, SUM(nvl(LPI_CGST_AMT,0)) LPI_CGST_AMT, SUM(nvl(LPI_SGST_AMT,0)) LPI_SGST_AMT, SUM(nvl(LPI_IGST_AMT,0)) LPI_IGST_AMT,SUM((lpi_effectiveunitprice* lpi_QUANTITY)) amt, 
    (SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0))))) store_catg_val,
    (SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0))))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt)) other_val,
    totamt+(nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0)) supplier_val,
    a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name,LPI_REV_CHRG,nvl(LPI_REV_CAT,'I') LPI_REV_CAT
FROM fb_localpurchaseinvoice pi,fb_lpidetails pid,fb_localpurchaseorder c,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
    (select lpi_id,  round(SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)))),2) totamt from fb_lpidetails group by lpi_id) x
WHERE pi.lpi_id = pid.lpi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and pi.LPO_ID = c.LPO_ID(+) and 
    pi.LPI_ID = x.LPI_ID and pi.LPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and LPI_VOU_NO is null
GROUP BY pi.LPI_ID,LPI_DATE,a.acledger_id,SUP_ID,spc.spc_id,spc.spc_name,totamt,nvl(LPI_FREIGHT,0),nvl(LPI_INSURANCE,0),nvl(LPI_OTHERAMO,0),LPI_REV_CHRG,nvl(LPI_REV_CAT,'I'), lpi_tcs_amt
order by 1,2;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_rev_chg);setnull(ls_revinvno);setnull(ls_revchg_catg);
	ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; ld_bill_amt = 0; ld_ttax = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt, :ld_bill_amt, :ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_name,:ls_rev_chg,:ls_revchg_catg;

	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm'));
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	

				select min(AP_PERIOD_ID) into :ll_ac_period
				from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
						to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
	
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
										   
			// insert into Voucher Head
				insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
					 values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
			
			  //Update Voucher No /Date
				Update fb_localpurchaseinvoice set LPI_VOU_NO=:ls_vou_no , LPI_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
				where LPI_VOU_NO is null and LPI_ID= :ls_ref_no ; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
			
			if ls_rev_chg = 'Y'  then
				
		//-- Getting The Serial No
				 select nvl(sn_srl_no,0)+1 into :ll_dcno from fb_serial_no  where sn_doc_type = 'RCIN' and SN_ACCT_YEAR = to_number(:ls_ym) for update;
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Getting Reverse Charge No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
				
				select 'RC/'||:gs_garden_snm||'/'||decode(sign(to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm')) - 04),-1,to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))-1||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'),to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'))||'/'||lpad(:ll_dcno,3,'0') into :ls_revinvno
				from dual;
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Getting Reverse Charge Serial No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				update fb_serial_no set sn_srl_no = nvl(sn_srl_no,0) + 1   where sn_doc_type = 'RCIN' and  SN_ACCT_YEAR = to_number(:ls_ym);
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Updating Reverse Charge No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
				
				insert into FB_REVCHARGE_INVOICE (RCI_CO_CD, RCI_UNITCD, RCI_HSN_CODE, RCI_UOM, RCI_QNTY, RCI_RATE, RCI_AMOUNT, 
																 RCI_SGST_RATE, RCI_CGST_RATE, RCI_IGST_RATE, RCI_SGST_AMT, RCI_CGST_AMT, RCI_IGST_AMT, RCI_TOTAL_AMT, 
																 RCI_INVOICE_NO, RCI_INVOICE_DT, RCI_REF_NO, RCI_REF_DT, RCI_PARTY_CD, rci_item_catg)
				select :gs_CO_ID,:gs_garden_snm,LPI_HSN_NO,SP_UNIT,nvl(LPI_QUANTITY,0),nvl(LPI_EFFECTIVEUNITPRICE,0),((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100)) , 
						 LPI_sgst_per,LPI_CGST_PER,LPI_igst_per, LPI_sgst_amt,LPI_cgst_amt,LPI_igst_amt,
							  (nvl(LPI_cgst_amt,0) + nvl(LPI_sgst_amt,0) + nvl(LPI_igst_amt,0) + ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100))), 
							  :ls_revinvno,to_date(:fs_ac_dt,'dd/mm/yyyy'),:ls_vou_no,to_date(:ls_vou_dt,'dd/mm/yyyy'),sup_id, LPI_REV_CAT
				from fb_lpidetails a, fb_storeproduct b, fb_localpurchaseinvoice c, fb_localpurchaseorder d 
				where a.lpi_id = c.lpi_id and c.LPO_ID = d.LPO_ID and a.sp_id = b.sp_id and a.lpi_id = :fs_transid; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Inserting Reverse Charge Details ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				select SUM(nvl(LPI_CGST_AMT,0)) into :ld_tcgst_amt  from fb_lpidetails where  LPI_ID = :fs_transid;
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Total CGST Amount Calculation',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
					
				If ld_tcgst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='CGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 1: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
							
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl( :ld_tcgst_amt,0) ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
				
				select SUM(nvl(LPI_SGST_AMT,0)) into :ld_tsgst_amt  from fb_lpidetails where  LPI_ID = :fs_transid;
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Total SGST Amount Calculation',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
				
				If ld_tsgst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 2: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_tsgst_amt,0),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if

				select SUM(nvl(LPI_IGST_AMT,0)) into :ld_tigst_amt  from fb_lpidetails where  LPI_ID = :fs_transid;
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Total IGST Amount Calculation',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
				
				If ld_tigst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='IGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 3: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_tigst_amt,0),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
			else
				insert into FB_GST_PAYABLE (GP_VOU_NO, GP_VOU_DT, GP_CO_CD, GP_UNIT_SN, GP_HSN_CODE, GP_UOM, GP_QNTY, GP_RATE, GP_PARTY, GP_BILL_NO, GP_BILL_DT, GP_AMOUNT, 
													   GP_SGST_RATE, GP_CGST_RATE, GP_IGST_RATE, GP_SGST_AMT, GP_CGST_AMT, GP_IGST_AMT,  GP_TOTAL_AMOUNT, gp_item_catg)
				select :ls_vou_no,to_date(:ls_vou_dt,'dd/mm/yyyy'),:gs_CO_ID,:gs_garden_snm,LPI_HSN_NO,SP_UNIT,nvl(LPI_QUANTITY,0),nvl(LPI_EFFECTIVEUNITPRICE,0), sup_id, LPI_BILLNO, LPI_BILLDATE,
						  ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100)) , 
						 LPI_sgst_per,LPI_CGST_PER,LPI_igst_per, LPI_sgst_amt,LPI_cgst_amt,LPI_igst_amt,
							  (nvl(LPI_cgst_amt,0) + nvl(LPI_sgst_amt,0) + nvl(LPI_igst_amt,0) + ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100))), LPI_REV_CAT
				from fb_lpidetails a, fb_storeproduct b, fb_localpurchaseinvoice c, fb_localpurchaseorder d 
				where a.lpi_id = c.lpi_id and c.LPO_ID = d.LPO_ID and a.sp_id = b.sp_id and a.lpi_id = :fs_transid; 
			
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Inserting GST Payable Details ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				if ls_revchg_catg = 'I' then
				// Find Credit Sundry Creditors Gst payable
				
//					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
//					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SUNDRY CREDITORS GST PAYABLE';
//			
//					if sqlca.sqlcode = -1 then
//						messagebox('SQL Error 4: During Select Ledger',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return -1
//					end if;
// change on 30/05/2018
// Sundry Creditors Gst payable will be credited in party account
					select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
						 where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 6: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
					
					select SUM(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)) into :ld_ttax  from fb_lpidetails where  LPI_ID = :fs_transid;
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 5: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;					
					
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd,VD_SPAY_IND)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_ttax,0),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id,'S');
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
					end if

			end if;  //if ls_rev_chg = 'Yes'  then
			
	
		// Find Credit GL/SGL
			select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
             where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
	
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error 6: During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
			select SUM(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)) into :ld_ttax  from fb_lpidetails where  LPI_ID = :fs_transid;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error 5: During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;					

		
			if ls_revchg_catg = 'I' then 
			// insert into Voucher Detail for supplier_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(nvl(:ld_supp_val,0) - nvl(:ld_ttax,0)),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		  	   
			    if sqlca.sqlcode = -1 then 		 
				  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				  rollback using sqlca;
				  return -1;
				end if;	
			elseif ls_revchg_catg = 'N' then 
			// insert into Voucher Detail for supplier_val
				if ls_rev_chg = 'Y'  then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(nvl(:ld_supp_val,0) - nvl(:ld_ttax,0)) ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
			
					
					 if sqlca.sqlcode = -1 then 		 
					  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					  rollback using sqlca;
					  return -1;
					end if;
				else
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_supp_val ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
			
					
					 if sqlca.sqlcode = -1 then 		 
					  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					  rollback using sqlca;
					  return -1;
					end if;					
				end if
			elseif ls_revchg_catg = 'E' then 
			// insert into Voucher Detail for supplier_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_supp_val ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		  	   
			    if sqlca.sqlcode = -1 then 		 
				  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				  rollback using sqlca;
				  return -1;
				end if;		
			end if
	       			
       end if; //if (ls_ref_no <> ls_old_ref) then
				
		// Dedit
			
			if ls_revchg_catg = 'I' then
				
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2) - (nvl( :ld_cgst_amt,0) + nvl( :ld_sgst_amt,0) + nvl( :ld_igst_amt,0)),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		         
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
				
				If ld_cgst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='CGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 7: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl( :ld_cgst_amt,0) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
							  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
							  rollback using sqlca;
							  return -1;
						end if;	
				end if
					
				If ld_sgst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 8: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_sgst_amt,0),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
	
				If ld_igst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='IGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 9: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_igst_amt,0),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
			elseif ls_revchg_catg = 'N' then
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
			elseif ls_revchg_catg = 'E' then
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;				
			end if

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_rev_chg);setnull(ls_revchg_catg);
	ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; ld_bill_amt = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt, :ld_bill_amt, :ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_name,:ls_rev_chg,:ls_revchg_catg;
    
	loop;
	
	select lpi_tcs_amt, sup_id into :ld_tcs_amt, :ls_supp_id from fb_localpurchaseinvoice a, fb_localpurchaseorder b where a.lpo_id = b.lpo_id and lpi_id = :fs_transid;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while selecting TCS amount: '+sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning', 'No LPI found')
		rollback using sqlca;
		return 1	
	end if
	
	if ld_tcs_amt > 0 then
		select acledger_id, acsubledger_id into :ls_tcs_dgl, :ls_tcs_dsgl from fb_acsubledger where acsubledger_name = 'REMITTANCE REFUND (CASH)';
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while selecting REMITTANCE REFUND (CASH) ledger: '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning', 'REMITTANCE REFUND (CASH) ledger not found')
			rollback using sqlca;
			return 1		
		end if
		
		select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_tcs_cgl, :ls_tcs_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
          where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while selecting supplier ledger, subledger: '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning', 'Supplier ledger not found')
			rollback using sqlca;
			return 1		
		end if
	
		//credit tcs entry
		insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
		values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_tcs_cgl,:ls_tcs_csgl,null,null,:ld_tcs_amt,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		 if sqlca.sqlcode = -1 then 		 
		  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) TCS Amt. ',sqlca.sqlerrtext);
		  rollback using sqlca;
		  return -1;
		end if;
		
		//debit tcs entry
		insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
		values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_tcs_dgl,:ls_tcs_dsgl,null,null,:ld_tcs_amt ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
		if sqlca.sqlcode = -1 then 		 
			messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) TCS Amt. ',sqlca.sqlerrtext);
			rollback using sqlca;
			return -1;
		end if;
	end if
	
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;		
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_remittancekind_tostore_gst (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_sup
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
double ld_amt ,ld_otheramt,ld_kind_val

ls_ym = 	string(date(fs_ac_dt),'yyyymm')

//	SELECT pi.HOPI_ID,To_char(HOPI_DATE,'dd/mm/yyyy') HOPI_DATE, pi.SUP_ID,
//                   (SUM(decode(nvl(pid.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(pid.HOPI_SALETAX/100))))) store_catg_val,
//                   (SUM(decode(nvl(pid.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(pid.HOPI_SALETAX/100))))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt)) other_val,
//	              totamt+(nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0)) rem_kind_val,
//	              a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name
//        FROM fb_hopurchaseinvoice pi,fb_hopidetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
//	              (select hopi_id, round(SUM(decode(nvl(HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(HOPI_SALETAX/100)))),2) totamt from fb_hopidetails group by hopi_id) x
//     WHERE pi.hopi_id = pid.hopi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and 
//                   pi.HOPI_ID = x.HOPI_ID and pi.HOPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and HOPI_VOU_NO is null
//     GROUP BY pi.HOPI_ID,HOPI_DATE,pi.SUP_ID,a.acledger_id,spc.spc_id,spc.spc_name,totamt,nvl(HOPI_FREIGHT,0),nvl(HOPI_INSURANCE,0),nvl(HOPI_OTHERAMO,0)
//         order by 1,2

declare c1 cursor for 
SELECT pi.HOPI_ID,To_char(HOPI_DATE,'dd/mm/yyyy') HOPI_DATE, pi.SUP_ID,
                   SUM((nvl(hopi_effectiveunitprice,0) * nvl(HOPI_QUANTITY,0)) + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0))) store_catg_val,
                   (SUM((nvl(hopi_effectiveunitprice,0) * nvl(HOPI_QUANTITY,0)) + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0)))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt)) other_val,
	              totamt+(nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0)) rem_kind_val,
	              a.acledger_id ac_ledger,spc.spc_id ac_subledger,  spc.spc_name
        FROM fb_hopurchaseinvoice pi,fb_hopidetails pid,fb_storeproductcategory spc,fb_storeproduct sp,fb_acsubledger a,
	              (select hopi_id, round(SUM((nvl(hopi_effectiveunitprice,0) * nvl(HOPI_QUANTITY,0))  + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0))),2) totamt from fb_hopidetails group by hopi_id) x
     WHERE pi.hopi_id = pid.hopi_id AND pid.sp_id = sp.sp_id AND sp.spc_id = spc.spc_id and 
                   pi.HOPI_ID = x.HOPI_ID and pi.HOPI_ID = :fs_transid and sp.spc_id=a.ACSUBLEDGER_ID and HOPI_VOU_NO is null
     GROUP BY pi.HOPI_ID,HOPI_DATE,pi.SUP_ID,a.acledger_id,spc.spc_id,spc.spc_name,totamt,nvl(HOPI_FREIGHT,0),nvl(HOPI_INSURANCE,0),nvl(HOPI_OTHERAMO,0)
         order by 1,2;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_sup);
	ld_amt = 0; ld_otheramt = 0;ld_kind_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_sup,:ld_amt,:ld_otheramt,:ld_kind_val,:ls_gl,:ls_sgl,:ls_name;

	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				 ll_vou_no = f_get_lastno('JV',ls_ym)						
				 if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
				select min(AP_PERIOD_ID) into :ll_ac_period
				from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));


				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
										   
			// insert into Voucher Head
				insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
					 values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
											
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
				
			  //Update Voucher No /Date
				Update fb_hopurchaseinvoice set HOPI_VOU_NO=:ls_vou_no , HOPI_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
				where HOPI_VOU_NO is null and HOPI_ID= :ls_ref_no ; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
	
		// Find Credit GL/SGL
				select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b 
				where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and acledger_ledgertype='REMITTANCEKIND' and ACSUBLEDGER_NAME='REMITTANCE KIND';
			
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Select Ledger',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;

			// insert into Voucher Detail for rem_kind_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_kind_val,'C','JV For Remittance To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_sup);
		
		  	   
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
	       			
            end if;
				
		// Dedit
			
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,round((:ld_amt + :ld_otheramt),2),'D','JV For Remittance To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'));
		         
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

		setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_sup);
	     ld_amt = 0; ld_otheramt = 0;ld_kind_val = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_sup,:ld_amt,:ld_otheramt,:ld_kind_val,:ls_gl,:ls_sgl,:ls_name;
    
	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;		
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_wages_to_account_mr (string fs_transid, string fs_frdt, string fs_todt, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_gl,ls_sgl,ls_ym,ls_acesubhead,ls_w2_stdt
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period
//double ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction

double ld_amt,ld_lastcoinbf,ld_coinbfded,ld_advanceded,ld_electded,ld_pfded,ld_lwfded,ld_pfadvded,ld_pfintded,ld_rationded,ld_subsded,ld_netpayable,ld_attninc_amt,ld_lip_amt;
double ld_ACMS01, ld_BPUJA, ld_BMASAN, ld_CBME, ld_CHURCH, ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL, ld_mandir, ld_electadvded, ld_medadvded, ld_festadvded, ld_ptax, ld_lpg_Subs_ded ;

ls_ym = 	string(date(fs_ac_dt),'yyyymm')

select to_char(LWW_STARTDATE + 7,'dd/mm/yyyy') into :ls_w2_stdt from fb_labourwagesweek  where lww_id=:fs_transid;

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During select 2ndweek Start : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

declare c1 cursor for 
select lww_id,:fs_frdt  start_dt,
		sum(nvl(labour_lastcoinbf,0)) lastcoinbf,
		sum(nvl(labour_coinbf,0)) coinbfded,
		sum(nvl(labour_advance,0)) advanceded,
		sum(nvl(labour_electricity,0) + nvl(ELECTRICDED2,0) + nvl(ELECTRICDED3,0) + nvl(ELECTRICDED4,0)) electded,
		sum(nvl(labour_pf,0)+nvl(labour_fpf,0)) pfded,
		sum(nvl(labour_lwf,0)) lwfded,
		sum(nvl(labour_pfadvanceded,0)) pfadvded,
		sum(nvl(labour_pfinterestded,0)) pfintded ,
		sum(nvl(labour_ration,0)) rationded,
		sum(nvl(labour_subsded,0)) subsded,
		sum(nvl(LABOUR_NETPAYABLEAMOUNT,0)),
		sum(decode(:gs_garden_state,'03',nvl(LABOUR_ATTN_INC,0),0)) attninc_amt,
		sum(nvl(LABOUR_LIP,0)) lipded,
        sum(nvl(ACMS01,0)) ACMS01, sum(nvl(BPUJA1,0) + decode(:gs_garden_snm,'SP',0,nvl(BPUJA2,0))) BPUJA, sum(nvl(BMASAN,0)) BMASAN, sum(nvl(CBME,0)) CBME, sum(nvl(CHURCH,0)) CHURCH, 
        sum(nvl(COOPERATIVE,0)) COOPERATIVE, sum(nvl(ICICI,0)) ICICI, sum(nvl(PUJA1,0) + nvl(PUJA2,0) + nvl(PUJA3,0) + nvl(PUJA4,0) + nvl(PUJA5,0)) PUJA, 
        sum(nvl(MEDICAL,0)) MEDICAL, sum(nvl(bpuja2,0)) mandir, sum(nvl(LABOUR_ELECTADVANCEDED,0)) electadvanceded, sum(nvl(LABOUR_MEDICALADVANCEDED,0)) medadvanceded,
	    sum(nvl(LABOUR_FESTIVALADVANCEDED,0)) festadvanceded, sum(nvl(LABOUR_PTAX,0)) ptax, sum(nvl(LABOUR_LPG_SUBS_DED, 0)) lpg_subs_Ded
  from fb_labourweeklywages where lww_id=:fs_transid
  group by lww_id,:fs_frdt ;				

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ls_ref_dt);
	ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0;
	ld_ACMS01 = 0; ld_BPUJA = 0; ld_BMASAN = 0; ld_CBME = 0; ld_CHURCH = 0; ld_COOPERATIVE = 0; ld_ICICI = 0; ld_PUJA = 0; ld_MEDICAL = 0; ld_mandir  = 0;  ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_ptax = 0; ld_lpg_Subs_ded = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt, :ld_ACMS01, :ld_BPUJA, :ld_BMASAN, :ld_CBME, :ld_CHURCH, :ld_COOPERATIVE, :ld_ICICI, :ld_PUJA, :ld_MEDICAL, :ld_mandir, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_ptax, :ld_lpg_Subs_ded ;
		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
			    select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					

			select nvl(min(AP_PERIOD_ID),0) into :ll_ac_period
			from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
					to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			elseif sqlca.sqlcode = 100 then
				messagebox('Information !','Accounting Year Period Not Created, Please Create Period First !!!');
				return 1;		
			elseif sqlca.sqlcode = 0 then
				if ll_ac_period = 0 then
					messagebox('Information !','Accounting Year Period Not Created 1, Please Create Period First !!!');
					return 1;		
				end if;	
			end if;
										   
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
             values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_labourweeklywages set LABOUR_VOU_NO=:ls_vou_no , LABOUR_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
			where LABOUR_VOU_NO is null and LWW_ID= :ls_ref_no ; 
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		
			
			update fb_labourwagesweek set lww_paidflag='1' where LWW_ID= :fs_transid;
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
		// insert into Voucher Detail for coinbfded_val
		 if ld_lastcoinbf >0 then	// (Debit)
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin BF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin CF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin CF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lastcoinbf,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin BF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
				
		// Change for transferring carry-forward coins into mandir fund in Sepon
		if gs_garden_snm = 'SP' then
			ld_coinbfded = 0;
			ld_coinbfded = ld_mandir
		end if
				
		// insert into Voucher Detail for coinbfded_val
		 if ld_coinbfded >0 then	//	(Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Coin CF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin BF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin BF Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_coinbfded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Coin CF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		

		// insert into Voucher Detail for coinbfded_val
		 if ld_advanceded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Company Advance';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Company Advance Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Company Advance" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_advanceded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Company Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	
				
				
				
//////////////////////////////////////////////insert into Voucher Detail for elect advance ded

		 if ld_electadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Electric Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Electric Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_electadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Electric Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for medical advance ded

		 if ld_medadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Medical Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Medical Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Medical Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_medadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Medical Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for festival advance ded

		 if ld_festadvded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Festival Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Festival Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"Festival Advance Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_festadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour Festival Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	


//////////////////////////////////////////////


//////////////////////////////////////////////insert into Voucher Detail for lpg subsidy ded

		 if ld_lpg_subs_ded >0 then	// (Credit)
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL= 'LPG Subsidy Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LPG Subsidy Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','"LPG Subsidy Deduction" Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_lpg_subs_ded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Labour LPG Subsidy Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			if not isnull(ls_acesubhead) and len(ls_acesubhead) > 0 then
				if wf_upd_mes(fs_ac_dt,ls_acesubhead,(-1) * ld_lpg_subs_ded,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if		
           end if;	


//////////////////////////////////////////////


				
		 // insert into Voucher Detail for electded_val
		 if ld_electded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Electric Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_electded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Electric Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
			
//			//Update DailyExpense in expense subhead 'ESUB0054'
//			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_electded,'C','N')  = -1 then 
//				rollback using sqlca;
//				return 1;
//			end if;
            end if;

		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employee Contibution');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	

      				
		// insert into Voucher Detail for employer_contribution_val		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,'C',(:ld_pfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Dedn Employer Contibution');
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					

			//debit
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',(:ld_pfded) ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Deduction');
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead, (ld_pfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
          end if;
			 
		if  (ld_lwfded)  >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LWF/PUJA';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LWF/PUJA Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LWF/PUJA Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_lwfded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LWF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
			
		 // insert into Voucher Detail for pfadvded_val
		 if ld_pfadvded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Advance Deductionn Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfadvded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;	
		 // insert into Voucher Detail for pfintded_val
		 if ld_pfintded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PF Intrest Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Intrest Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Intrest Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_pfintded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PF Intrest Advance Deduction' );
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;			
				
//MR 4 garden addition
		 // insert into Voucher Detail for electded_val
		 if ld_ACMS01 >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='ACMS Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ACMS Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ACMS Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_ACMS01,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'ACMS Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; //ld_ACMS01 
			  
		 if ld_BPUJA >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='BPUJA Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select BPUJA Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','BPUJA Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_BPUJA,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'BPUJA Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; //ld_BPUJA 

		 if ld_BMASAN >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='BMASAN Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select BMASAN Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','BMASAN Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_BMASAN,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'BMASAN Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; // ld_BMASAN, ld_CBME, ld_CHURCH, ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL

		 if ld_CBME >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='CBME Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select CBME Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','CMBE Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_CBME,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'CBME Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; // ld_CBME, ld_CHURCH, ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL
		  
		 if ld_CHURCH >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='CHURCH Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select CHURCH Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','CHURCH Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_CHURCH,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'CHURCH Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; // ld_CHURCH, ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL

		 if ld_COOPERATIVE >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='COOPERATIVE Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select COOPERATIVE Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','COOPERATIVE Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_COOPERATIVE,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'COOPERATIVE Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; // ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL
			  
		 if ld_ICICI >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='ICICI Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ICICI Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ICICI Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_ICICI,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'ICICI Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; //  ld_ICICI, ld_PUJA, ld_MEDICAL
			  
		 if ld_PUJA >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PUJA Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PUJA Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PUJA Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_PUJA,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PUJA Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
           end if; //   ld_PUJA, ld_MEDICAL
			  
		 if ld_MEDICAL >0 then		

			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='MEDICAL Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select MEDICAL Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','MEDICAL Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_MEDICAL,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'MEDICAL Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			//Update DailyExpense in expense subhead ''
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(fs_ac_dt,ls_acesubhead, (ld_MEDICAL * (-1)) ,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if
			
           end if; //   ld_MEDICAL
			  
			  
//MR 4 garden addition
				
		 // insert into Voucher Detail for rationded_val
		 if ld_rationded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_rationded,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;		
				
	 // insert into Voucher Detail for ld_attninc_amt  for tripura
		 if ld_attninc_amt >0 and gs_garden_state = '03'then		
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Weekly Incentive';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_attninc_amt,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Weekly Incentive Addition');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_attninc_amt ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
		// end attendance incentive for tripura		
		 if ld_lip_amt >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='LIP Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_lip_amt,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'LIP Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
            end if;						
				
		// For Fulbari Ration Compensation in case of Tremporary labour should be debit		
		 if ld_rationded < 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Ledger/subledger Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',((-1) * nvl(:ld_rationded,0)),'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Ration Dr) ',sqlca.sqlerrtext);
			end if;	
			
			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(fs_ac_dt,ls_acesubhead,(ld_rationded * (-1)),'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;					
				
		if  (ld_subsded)  > 0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Subscription';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Subscription Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Subscription Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,(:ld_subsded) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Subscription Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if
		
		//insert into voucher detail for ptax
		
		if ld_ptax >0 then		

			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_gl,:ls_sgl,:ls_acesubhead from fb_acautoprocess 
			where  AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='PTAX';
		
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PTAX Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Mapping for PTAX Not Present, Please Create First !!!');
					return -1;		
				end if
		
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),(:ld_ptax) ,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'PTax Deduction');
						
				 if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
				
			if not isnull(ls_acesubhead) and len(ls_acesubhead) > 0 then
				if wf_upd_mes(fs_ac_dt,ls_acesubhead,(-1) * ld_ptax,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if			
		end if;				
		
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_gl,:ls_sgl from fb_acautoprocess 
			where AC_PROCESS='Wages To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
			
			//ls_cgl='LEG0001'  //ls_csgl='SLEG0420'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_netpayable,'C','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Net Payable');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
		end if;
						
	// insert into Voucher Detail for Pary Week wages value
	
		if  right(left(fs_frdt,5),2)  <> right(left(fs_todt,5),2) then		
			
			declare c3 cursor for	
			select lwwid,:fs_frdt  ATTENDATE,'Provision For Wages' acsubledgername,ACLEDGER_ID,acsubledgerid,sum(dkw.wages) grwages
		  	   from (select lda.lww_id LWWID,lda.lda_date ATTENDATE,kam.kamsub_id KAMSUB_ID,sum(lda.lda_status) NODAYS,
							  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
						from fb_labourdailyattendance lda,fb_kamsubhead kam
					  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'
					  group by (lda.lww_id,lda.lda_date,kam.kamsub_id)) dkw,
					  (select CR_ACLEDGER_ID ACLEDGER_ID, CR_ACSUBLEDGER_ID acsubledgerid from fb_acautoprocess 
			             where AC_PROCESS='Partweek Wages To Account' and AC_PROCESS_DETAIL='Provision For Wages')
			where lwwid=:fs_transid and dkw.attendate>=to_date(:fs_frdt,'DD/MM/YYYY') and dkw.attendate<=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY')) 
			 group by lwwid,:fs_frdt,ACLEDGER_ID,acsubledgerid ;			
			
			open c3; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C3 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'D','JV For Part Week Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Part Week Reverse');
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	
								
					end if;	
                  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl)
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ld_amt;
					 
				loop;	 
				close c3;
			end if;	
		end if	
	end if	
	// Wages Posting
		declare c2 cursor for 
				select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID,
	   				 sum(dkw.wages) grwages
  			   from (select lda.lww_id LWWID,kamsub_id KAMSUB_ID,
               			 		  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) WAGES
						from fb_labourdailyattendance lda
		 			  where lww_id=:fs_transid and 
	   							((to_char(to_date(:fs_frdt,'dd/mm/yyyy'),'mm')<>to_char(to_date(:fs_todt,'dd/mm/yyyy'),'mm') and 
											trunc(lda_date) >=LAST_DAY(to_date(:fs_frdt,'DD/MM/YYYY'))+1) or
	   							 (to_char(to_date(:fs_frdt,'dd/mm/yyyy'),'mm')=to_char(to_date(:fs_todt,'dd/mm/yyyy'),'mm') and 
									 		trunc(lda_date) >=to_date(:fs_frdt,'DD/MM/YYYY'))) and
								trunc(lda_date) <=to_date(:fs_todt,'DD/MM/YYYY')  	   
						group by lda.lww_id,kamsub_id ) dkw,
			   		fb_expenseacsubhead eacsub, fb_acsubledger acsub 
 			where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
 			group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
			
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		     
			do while sqlca.sqlcode <> 100 							
				// insert into Voucher Detail		
				
			  if ld_amt > 0 then
				
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Kamjari Wages');
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	

			 end if
			  	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
			  	ld_amt = 0;
			  
		  		fetch c2 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
		 
		 	loop;	 	
				close c2;
	  	end if;	

// not for tripura
if gs_garden_state <> '03' then
// Attendance Incentive
	if gs_garden_snm <> 'FB' then
		long ll_adoleage;string ls_attn_inc_ind
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)) into :ll_adoleage from fb_param_detail 
		where pd_doc_type in ('ADOLEAGE') and to_date(:fs_frdt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return -1
		end if;
		
		select distinct AI_RATERANGE into :ls_attn_inc_ind from fb_attendanceincentive
		where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Rate Range checking ',sqlca.sqlerrtext)
			return -1
		end if;
	// Daily Attendance Incentive	
	 if ls_attn_inc_ind='D' and gs_garden_snm <> 'BE' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP' and gs_garden_snm <> 'SP' and gs_garden_snm <> 'AD' and gs_garden_snm <> 'MH' and gs_garden_snm <> 'DR' then
			declare c4 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)))
									where emp_type = AI_LABOURTYPE(+)) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4;
			end if;	
			
	elseif ls_attn_inc_ind='D' and (gs_garden_snm = 'BE' or gs_garden_snm = 'AB' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP' or gs_garden_snm = 'SP'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR')  then
		
			declare c4b cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
						 			     where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) 
										 group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and lda.labour_id = c.emp_id and 
						  			lda_date between to_date(:fs_frdt,'dd/mm/yyyy') and (to_date(:ls_w2_stdt,'dd/mm/yyyy') -1) and nvl(lda_wages,0)>0 and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id union all
						  select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(1 * nvl(atinc_rt,0)) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									    (select labour_id,count(1) nod from fb_labourdailyattendance 
							 			  where lww_id=:fs_transid and  nvl(lda_wages,0)>0 and lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') 
									     group by labour_id) l
									where emp_type = AI_LABOURTYPE(+) and emp_id = labour_id and nod >= nvl(AI_MINDAYS,0) ) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									lda_date between to_date(:ls_w2_stdt,'dd/mm/yyyy') and to_date(:fs_todt,'dd/mm/yyyy') and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
			open c4b; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 							
					// insert into Voucher Detail	
				  if ld_amt > 0 then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'W',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'W','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
				
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c4b into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c4b;
			end if;	
			
	elseif ls_attn_inc_ind='W' then	// Weekly Attendance Incentive
		
			declare c5 cursor for 
					select lwwid,:fs_frdt  ATTENDATE,acsub.acsubledger_name acsubledgername,acsub.ACLEDGER_ID,acsubledger_id acsubledgerid,KAMSUB_ID, sum(dkw.wages) grwages
					from (select lda.lww_id LWWID,lda.kamsub_id KAMSUB_ID,sum(nvl(atinc_rt,0)/nodays) WAGES
							from fb_labourdailyattendance lda, fb_kamsubhead b ,
									(select emp_id, nvl(decode(sign(get_diff(to_date(:fs_frdt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,nodays
										 from fb_employee c,(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE from fb_attendanceincentive
																	where to_date(:fs_frdt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate))),
									  			(select labour_id,count(lda_status) nodays from fb_labourdailyattendance a,fb_kamsubhead b
									  		     where a.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and 
														 trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
												  group by labour_id) c
									where emp_type = AI_LABOURTYPE(+) and emp_id = c.labour_id) c
						  where  lda.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lww_id=:fs_transid and nvl(lda_wages,0)>0 and lda.labour_id = c.emp_id and 
									(lww_id,labour_id) in (select lww_id,labour_id from fb_labourweeklywages where lww_id=:fs_transid and LABOUR_ATTN_INC>0)
									and trim(KAMSUB_NAME) <> 'SUS' and kamsub_nkamtype <> 'SUBSTINANCEALLOWANCE'
						  group by lda.lww_id,lda.kamsub_id ) dkw,
							fb_expenseacsubhead eacsub, fb_acsubledger acsub 
				where dkw.kamsub_id=eacsub.eacsubhead_id and eacsub.eachead_id=acsub.acsubledger_id 
				group by lwwid,:fs_frdt ,acsub.acsubledger_name,ACLEDGER_ID,acsub.acsubledger_id,KAMSUB_ID;		  
				
		  
			open c5; 
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 	
				setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
				ld_amt = 0;
				
				fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
				  
				do while sqlca.sqlcode <> 100 		
				  if ld_amt > 0 then
					// insert into Voucher Detail							
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'C',:ld_amt ,'D','JV For Wages To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),'Attendance Incentive');
							
					if sqlca.sqlcode = -1 then 		 
						messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						rollback using sqlca;
						return -1;
					end if;	
	
					//Update DailyExpense in expense subhead 'ESUB0068'
					if wf_upd_mes(fs_ac_dt,ls_acesubhead,ld_amt,'C','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
				end if
					setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_gl);setnull(ls_sgl);setnull(ls_acesubhead);
					ld_amt = 0;
	
					fetch c5 into :ls_ref_no,:ls_ref_dt,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt;
	
				loop;	 	
					close c5;
			end if;	
		end if		// End Attendance Incentive Para
		//END not for tripura
	  end if
	end if
		setnull(ls_ref_no);setnull(ls_ref_dt);
		ld_pfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_attninc_amt=0;ld_lip_amt=0
		ld_ACMS01 = 0; ld_BPUJA = 0; ld_BMASAN = 0; ld_CBME = 0; ld_CHURCH = 0; ld_COOPERATIVE = 0; ld_ICICI = 0; ld_PUJA = 0; ld_MEDICAL = 0; ld_mandir = 0;  ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_ptax = 0; ld_lpg_subs_ded = 0;
		
		fetch c1 into :ls_ref_no,:ls_ref_dt,:ld_lastcoinbf,:ld_coinbfded,:ld_advanceded,:ld_electded,:ld_pfded,:ld_lwfded,:ld_pfadvded,:ld_pfintded,:ld_rationded,:ld_subsded,:ld_netpayable,:ld_attninc_amt,:ld_lip_amt, :ld_ACMS01, :ld_BPUJA, :ld_BMASAN, :ld_CBME, :ld_CHURCH, :ld_COOPERATIVE, :ld_ICICI, :ld_PUJA, :ld_MEDICAL, :ld_mandir, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_ptax, :ld_lpg_subs_ded ;
		 
loop;	 
		 ///update last no
	if ll_vou_no > 0 then							
		if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
			rollback using sqlca;			
			return -1
		end if	
	end if
	
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_servicepurchase_to_ac_gst (string fs_transid, string fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_supp_id,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_rev_chg, ls_revinvno, ls_revchg_catg, ls_esub_head
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_ac_period,ll_dcno
double ld_amt ,ld_otheramt,ld_supp_val, ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_bill_amt,ld_ttax

ls_ym = 	string(date(fs_ac_dt),'yyyymm')


declare c1 cursor for 
SELECT pi.LPI_ID,To_char(LPI_DATE,'dd/mm/yyyy') LPI_DATE,SUP_ID, SUM(nvl(LPI_CGST_AMT,0)) LPI_CGST_AMT, SUM(nvl(LPI_SGST_AMT,0)) LPI_SGST_AMT, SUM(nvl(LPI_IGST_AMT,0)) LPI_IGST_AMT,SUM((lpi_effectiveunitprice* lpi_QUANTITY)) amt, 
    (SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0))))) store_catg_val,
    (SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0))))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt)) other_val,
    totamt+(nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0)) supplier_val,
    a.acledger_id ac_ledger,a.acsubledger_id ac_subledger, b.EACSUBHEAD_ID, a.ACSUBLEDGER_NAME, LPI_REV_CHRG,nvl(LPI_REV_CAT,'I') LPI_REV_CAT
FROM fb_servicepurchaseinvoice pi,fb_spidetails pid,fb_service_master sp,fb_acsubledger a, fb_expenseacsubhead b , 
    (select lpi_id,  round(SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)))),2) totamt from fb_spidetails group by lpi_id) x
WHERE pi.lpi_id = pid.lpi_id AND pid.sm_id = sp.sm_id AND
    pi.LPI_ID = x.LPI_ID and pi.LPI_ID = :fs_transid and LPI_VOU_NO is null and pid.EACSUBHEAD_ID = b.EACSUBHEAD_ID and b.EACHEAD_ID = a.ACSUBLEDGER_ID
GROUP BY pi.LPI_ID,LPI_DATE,a.acledger_id,a.acsubledger_id,SUP_ID,totamt,nvl(LPI_FREIGHT,0),nvl(LPI_INSURANCE,0),nvl(LPI_OTHERAMO,0),LPI_REV_CHRG,nvl(LPI_REV_CAT,'I') ,b.EACSUBHEAD_ID,
a.ACSUBLEDGER_NAME
order by 1,2;
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_rev_chg);setnull(ls_revinvno);setnull(ls_revchg_catg);setnull(ls_esub_head);
	ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; ld_bill_amt = 0; ld_ttax = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt, :ld_bill_amt, :ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_esub_head,:ls_name,:ls_rev_chg,:ls_revchg_catg;

	do while sqlca.sqlcode <> 100 
       
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
						  
				 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
				
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	

				select min(AP_PERIOD_ID) into :ll_ac_period
				from fb_ac_year a,fb_acyear_period b where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and 
						to_date(:fs_ac_dt,'dd/mm/yyyy') between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
	
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During A/c Period Select ',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
										   
			// insert into Voucher Head
				insert into fb_vou_head(VH_CO_ID,VH_UNIT_ID,VH_DOC_SRL,VH_VOU_NO,VH_VOU_DATE,VH_VOU_TYPE,VH_AC_YEAR,VH_ENTRY_DT,VH_ENTRY_BY,VH_APPROVED_BY,VH_APPROVED_DT,VH_AC_PERIOD,VH_LEDGER_TYPE)
					 values(:gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,to_date(:fs_ac_dt,'dd/mm/yyyy'),'JV',to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate,:ll_ac_period,'G');
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if;
			
			  //Update Voucher No /Date
				Update fb_servicepurchaseinvoice set LPI_VOU_NO=:ls_vou_no , LPI_VOU_DT=to_date(:fs_ac_dt,'dd/mm/yyyy')
				where LPI_VOU_NO is null and LPI_ID= :ls_ref_no ; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
			
			if ls_rev_chg = 'Y'  then
				
		//-- Getting The Serial No
				 select nvl(sn_srl_no,0)+1 into :ll_dcno from fb_serial_no  where sn_doc_type = 'RCIN' and SN_ACCT_YEAR = to_number(:ls_ym) for update;
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Getting Reverse Charge No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;		
				
				select 'RC/'||:gs_garden_snm||'/'||decode(sign(to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm')) - 04),-1,to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))-1||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'),to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'))||'/'||lpad(:ll_dcno,3,'0') into :ls_revinvno
				from dual;
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Getting Reverse Charge Serial No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				update fb_serial_no set sn_srl_no = nvl(sn_srl_no,0) + 1   where sn_doc_type = 'RCIN' and  SN_ACCT_YEAR = to_number(:ls_ym);
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Updating Reverse Charge No ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
				
				insert into FB_REVCHARGE_INVOICE (RCI_CO_CD, RCI_UNITCD, RCI_HSN_CODE, RCI_UOM, RCI_QNTY, RCI_RATE, RCI_AMOUNT, 
                                                                 RCI_SGST_RATE, RCI_CGST_RATE, RCI_IGST_RATE, RCI_SGST_AMT, RCI_CGST_AMT, RCI_IGST_AMT, RCI_TOTAL_AMT, 
                                                                 RCI_INVOICE_NO, RCI_INVOICE_DT, RCI_REF_NO, RCI_REF_DT, RCI_PARTY_CD, rci_item_catg)
                select :gs_CO_ID,:gs_garden_snm,LPI_HSN_NO,'PCS',nvl(LPI_QUANTITY,0),nvl(LPI_EFFECTIVEUNITPRICE,0),((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100)) , 
                         LPI_sgst_per,LPI_CGST_PER,LPI_igst_per, LPI_sgst_amt,LPI_cgst_amt,LPI_igst_amt,
                              (nvl(LPI_cgst_amt,0) + nvl(LPI_sgst_amt,0) + nvl(LPI_igst_amt,0) + ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100))), 
                              :ls_revinvno,to_date(:fs_ac_dt,'dd/mm/yyyy'),:ls_vou_no,to_date(:ls_vou_dt,'dd/mm/yyyy'),sup_id, LPI_REV_CAT
                from fb_spidetails a, fb_service_master b, fb_servicepurchaseinvoice c
                where a.lpi_id = c.lpi_id  and a.sm_id = b.sm_id and a.lpi_id = :fs_transid; 
				
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Inserting Reverse Charge Details ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				
				If ld_cgst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='CGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 1: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
							
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl( :ld_cgst_amt,0) ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
					
				If ld_sgst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 2: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_sgst_amt,0),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if

				If ld_igst_amt > 0 then
				// Find Credit CGST payable

					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='IGST PAYABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 3: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_igst_amt,0),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
				end if
			else
				insert into FB_GST_PAYABLE (GP_VOU_NO, GP_VOU_DT, GP_CO_CD, GP_UNIT_SN, GP_HSN_CODE, GP_UOM, GP_QNTY, GP_RATE, GP_PARTY, GP_BILL_NO, GP_BILL_DT, GP_AMOUNT, 
													   GP_SGST_RATE, GP_CGST_RATE, GP_IGST_RATE, GP_SGST_AMT, GP_CGST_AMT, GP_IGST_AMT,  GP_TOTAL_AMOUNT, gp_item_catg)
				select :ls_vou_no,to_date(:ls_vou_dt,'dd/mm/yyyy'),:gs_CO_ID,:gs_garden_snm,LPI_HSN_NO,'PCS',nvl(LPI_QUANTITY,0),nvl(LPI_EFFECTIVEUNITPRICE,0), sup_id, LPI_BILLNO, LPI_BILLDATE,
						  ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100)) , 
						 LPI_sgst_per,LPI_CGST_PER,LPI_igst_per, LPI_sgst_amt,LPI_cgst_amt,LPI_igst_amt,
							  (nvl(LPI_cgst_amt,0) + nvl(LPI_sgst_amt,0) + nvl(LPI_igst_amt,0) + ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) - ((nvl(LPI_QUANTITY,0) * nvl(LPI_EFFECTIVEUNITPRICE,0)) * nvl(a.LPI_DISCOUNT,0) /100))), LPI_REV_CAT
				from fb_spidetails a, fb_service_master b, fb_servicepurchaseinvoice c
				where a.lpi_id = c.lpi_id and a.sm_id = b.sm_id and a.lpi_id = :fs_transid; 
			
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Inserting GST Payable Details ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;			
				
				if ls_revchg_catg = 'I' then
				// Find Credit Sundry Creditors Gst payable
				
//					select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
//					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SUNDRY CREDITORS GST PAYABLE';
//			
//					if sqlca.sqlcode = -1 then
//						messagebox('SQL Error 4: During Select Ledger',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return -1
//					end if;
// change on 30/05/2018
// Sundry Creditors Gst payable will be credited in party account
					select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
						 where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 6: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
					
					select SUM(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)) into :ld_ttax  from fb_spidetails where  LPI_ID = :fs_transid;
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 5: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;					
					
		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd,VD_SPAY_IND)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_ttax,0),'C','JV For Service Purchase To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id,'S');
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
					end if

			end if;  //if ls_rev_chg = 'Yes'  then
			
	
		// Find Credit GL/SGL
			select a.acledger_id ac_ledger,b.ACSUBLEDGER_ID ac_subledger into :ls_cgl,:ls_csgl from fb_acledger a,fb_acsubledger b,fb_supplier c 
             where a.ACLEDGER_ID=b.ACLEDGER_ID(+) and  b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID and  c.SUP_ID= :ls_supp_id;
	
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error 6: During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
			select SUM(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)) into :ld_ttax  from fb_spidetails where  LPI_ID = :fs_transid;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error 5: During Select Ledger',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;					

		
			if ls_revchg_catg = 'I' then 
			// insert into Voucher Detail for supplier_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(nvl(:ld_supp_val,0) - nvl(:ld_ttax,0)),'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		  	   
			    if sqlca.sqlcode = -1 then 		 
				  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				  rollback using sqlca;
				  return -1;
				end if;	
			elseif ls_revchg_catg = 'N' then 
			// insert into Voucher Detail for supplier_val
				if ls_rev_chg = 'Y'  then
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,(nvl(:ld_supp_val,0) - nvl(:ld_ttax,0)) ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
			
					
					 if sqlca.sqlcode = -1 then 		 
					  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					  rollback using sqlca;
					  return -1;
					end if;
				else
					insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
					values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_supp_val ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
			
					
					 if sqlca.sqlcode = -1 then 		 
					  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
					  rollback using sqlca;
					  return -1;
					end if;					
				end if
			elseif ls_revchg_catg = 'E' then 
			// insert into Voucher Detail for supplier_val
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,:ld_supp_val ,'C','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		
		  	   
			    if sqlca.sqlcode = -1 then 		 
				  messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				  rollback using sqlca;
				  return -1;
				end if;		
			end if
	       			
       end if; //if (ls_ref_no <> ls_old_ref) then
				
		// Debit
			
			if ls_revchg_catg = 'I' then
				
			// insert into Voucher Detail
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_EXPSUBHEAD,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,'C',:ls_esub_head,round((:ld_amt + :ld_otheramt),2) - (nvl( :ld_cgst_amt,0) + nvl( :ld_sgst_amt,0) + nvl( :ld_igst_amt,0)),'D','JV For Service Purchase To Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
		         
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;
				
				If ld_cgst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='CGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 7: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
					
					select distinct 'X' into :ls_temp from fb_vou_det where vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error: During checking CGST records(Dr)',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1;
					elseif sqlca.sqlcode = 0 then
						update fb_vou_det set vd_amount = vd_amount+:ld_cgst_amt where  vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl ;
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error: During updating CGST records(Dr)',sqlca.sqlerrtext)
							rollback using sqlca;
							return -1;
						end if
					elseif sqlca.sqlcode = 100 then
						// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl( :ld_cgst_amt,0) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
						 if sqlca.sqlcode = -1 then 		 
							  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
							  rollback using sqlca;
							  return -1;
						end if;	
					end if
				end if
					
				If ld_sgst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='SGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 8: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;
					
					select distinct 'X' into :ls_temp from fb_vou_det where vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error: During checking SGST records(Dr)',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1;
					elseif sqlca.sqlcode = 0 then
						update fb_vou_det set vd_amount = vd_amount+:ld_sgst_amt where  vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl ;
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error: During updating CGST records(Dr)',sqlca.sqlerrtext)
							rollback using sqlca;
							return -1;
						end if
					elseif sqlca.sqlcode = 100 then		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_sgst_amt,0),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;	
					end if
				end if
	
				If ld_igst_amt > 0 then
				// Find Credit CGST payable
	
					select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
					where AC_PROCESS='GST TO ACCOUNT' and AC_PROCESS_DETAIL='IGST RECOVERABLE';
			
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error 9: During Select Ledger',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1
					end if;

					select distinct 'X' into :ls_temp from fb_vou_det where vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error: During checking SGST records(Dr)',sqlca.sqlerrtext)
						rollback using sqlca;
						return -1;
					elseif sqlca.sqlcode = 0 then
						update fb_vou_det set vd_amount = vd_amount+:ld_igst_amt where  vd_doc_srl =  :ll_doc_no and vd_gl_cd = :ls_cgl and vd_sgl_cd = :ls_csgl ;
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error: During updating CGST records(Dr)',sqlca.sqlerrtext)
							rollback using sqlca;
							return -1;
						end if
					elseif sqlca.sqlcode = 100 then		
					// insert into Voucher Detail for supplier_val
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,vd_party_cd)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_cgl,:ls_csgl,null,null,nvl(:ld_igst_amt,0),'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
				
						
						 if sqlca.sqlcode = -1 then 		 
						  messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
						  rollback using sqlca;
						  return -1;
						end if;
					end if
				end if
			elseif ls_revchg_catg = 'N' then
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_EXPSUBHEAD,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,'C',:ls_esub_head,round((:ld_amt + :ld_otheramt),2) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
			elseif ls_revchg_catg = 'E' then
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_SECTION_ID,VD_PREFERRED_MES,VD_EXPSUBHEAD,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_PARTY_CD)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(to_date(:fs_ac_dt,'dd/mm/yyyy'),'yyyymm')),:ls_gl,:ls_sgl,null,'C',:ls_esub_head,round((:ld_amt + :ld_otheramt),2) ,'D','JV For Purchase To Store Account',:ls_ref_no,to_date(:ls_ref_dt,'dd/mm/yyyy'),:ls_supp_id);
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;				
			end if

	setnull(ls_ref_no);setnull(ls_ref_dt);setnull(ls_supp_id);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_csgl);isnull(ls_name);setnull(ls_dc_ind);setnull(ls_rev_chg);setnull(ls_revinvno);setnull(ls_revchg_catg);setnull(ls_esub_head);
	ld_amt = 0; ld_otheramt = 0;ld_supp_val = 0;ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; ld_bill_amt = 0; ld_ttax = 0;
	
	fetch c1 into :ls_ref_no,:ls_ref_dt,:ls_supp_id, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt, :ld_bill_amt, :ld_amt,:ld_otheramt,:ld_supp_val,:ls_gl,:ls_sgl,:ls_esub_head,:ls_name,:ls_rev_chg,:ls_revchg_catg;

	loop;
	 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
	//commit using sqlca;		
	close c1;
end if;	
	
return 1;	

end function

public function integer wf_salary_to_account_mr (string fs_transdt, date fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_acesubhead
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_year,ll_month
double ld_amt,ld_grosswages,ld_cointhisweek,ld_coingiven,ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction,ld_lip,ld_ptax,ld_revst
double ld_ACMS01, ld_BPUJA, ld_ACKS, ld_CLUB, ld_ITAX, ld_COOPERATIVE, ld_ICICI, ld_PUJA, ld_MEDICAL,ld_GROUPINSU, ld_canteen, ld_LPG, ld_electadvded, ld_medadvded, ld_festadvded, ld_rd, ld_koil ;
double ld_volpf,ld_othded
date ld_ref_date
ls_ym = 	string(fs_ac_dt,'yyyymm')
 ll_year = long(left(fs_transdt,4))
 ll_month = long(right(fs_transdt,2))
 
//  select 'Salary' lww_id, last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) salary_date,
//           sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)) grosswages,
//       	sum(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)) cointhisweek,
//		sum((mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT ,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0))-mod(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)
//		-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl(EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0),10)) coingiven,
//		sum(nvl(EP_PFCONTDEDAMOUNT,0)) pfded,
//		sum(nvl(EP_PENSIONFUNDDEDAMOUNT,0)) fpfded,
//		sum(nvl(EP_LWFDEDAMOUNT,0)) lwfded,
//		sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,
//		sum(nvl(EP_ELECTRICDEDAMOUNT,0)) electded,
//		sum(nvl(EP_RATIONDEDAMOUNT,0)) rationded,
//		sum(nvl(EP_COINBF,0)) coinbfded,
//		sum(nvl(EP_LASTCOINBF,0)) lastcoinbf,		
//		0 subsded,sum(nvl(EP_PFADVANCEDEDAMOUNT,0)) pfadvded,0  pfintded,
//         sum(nvl(EP_LIPDEDAMOUNT,0)) lipamt,
//         sum(nvl(EP_PTAXDEDAMOUNT,0)) ptax,
//         sum(nvl(EP_REVENUESTAMPDEDAMOUNT,0)) revenuestamp	
//   from fb_emppayment
//  where EP_YEAR=:ll_year and EP_MONTH=:ll_month and  ep_vou_no is null 
//  group by 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm'));
// 
 
declare c1 cursor for 
 
  select 'Salary' lww_id, last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) salary_date,
           sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl(EP_ADHOC,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)+ nvl(EP_ALLOWWPF,0) + nvl(EP_ALLOWWOPF,0)+ nvl(OT_AMOUNT,0)+ nvl(LIGHTALOW,0)+ nvl(SEASONALOW,0)+ nvl(CHARGEALOW,0)+ nvl(COMPUTERALOW,0)+nvl(EP_EB_AMT,0)) grosswages,
           sum(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)+nvl(EP_EB_AMT,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)) cointhisweek,
        sum((mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT ,0)+nvl(EP_EB_AMT,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0))-mod(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)+nvl(EP_EB_AMT,0)
        -nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl(EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0),10)) coingiven,
        sum(nvl(EP_PFCONTDEDAMOUNT,0)) pfded,
        sum(nvl(EP_PENSIONFUNDDEDAMOUNT,0)) fpfded,
        sum(nvl(EP_LWFDEDAMOUNT,0)) lwfded,
        sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,
        sum(nvl(EP_ELECTRICDEDAMOUNT,0) + nvl(ELECTRICDED2,0) + nvl(ELECTRICDED3,0) + nvl(ELECTRICDED4,0)) electded,
        sum(nvl(EP_RATIONDEDAMOUNT,0)) rationded,
        sum(nvl(EP_COINBF,0)) coinbfded,
        sum(nvl(EP_LASTCOINBF,0)) lastcoinbf,        
        0 subsded,sum(nvl(EP_PFADVANCEDEDAMOUNT,0)) pfadvded,sum(nvl(EP_PFINTADVANCEDED,0))  pfintded,
         sum(nvl(EP_LIPDEDAMOUNT,0)) lipamt,
         sum(nvl(EP_PTAXDEDAMOUNT,0)) ptax,
         sum(nvl(EP_REVENUESTAMPDEDAMOUNT,0)) revenuestamp,
         sum(nvl(ACMS01,0)) ACMS01, sum(nvl(BPUJA1,0) + nvl(BPUJA2,0)) BPUJA, sum(nvl(ACKS,0)) ACKS, sum(nvl(CLUB,0)) CLUB, sum(nvl(ITAX,0)) ITAX, 
         sum(nvl(COOPERATIVE,0)) COOPERATIVE, sum(nvl(ICICI,0)) ICICI, sum(nvl(PUJA1,0) + nvl(PUJA2,0) + nvl(PUJA3,0) + nvl(PUJA4,0) + nvl(PUJA5,0)) PUJA, 
         sum(nvl(MEDICAL,0)) MEDICAL, sum(nvl(GROUPINSU,0)) GROUPINSU, sum(nvl(CANTEEN,0)) CANTEEN, sum(nvl(LPG,0)) LPG, sum(nvl(EP_ELECTADVANCEDED,0)) electadvanceded, sum(nvl(EP_MEDICALADVANCEDED,0)) medadvanceded,
	    sum(nvl(EP_FESTIVALADVANCEDED,0)) festadvanceded, sum(nvl(EP_RD,0)), sum(nvl(EP_KOIL,0)), sum(nvl(ep_netpayable,0)),sum(nvl(ep_vol_pfamt,0)) VolPF, sum(nvl(EP_RD ,0))othded
   from fb_emppayment
  where EP_YEAR=:ll_year and EP_MONTH=:ll_month and  ep_vou_no is null 
  group by 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm'));

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ld_ref_date);
	ld_grosswages= 0;ld_cointhisweek= 0;ld_coingiven= 0;ld_pfded= 0;ld_fpfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_netdeduction=0;
	ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_netdeduction=0;
	ld_lip = 0; ld_ptax = 0; ld_revst = 0; ld_canteen = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_rd = 0; ld_koil = 0;
	ld_ACMS01 = 0;  ld_BPUJA = 0;  ld_ACKS = 0;  ld_CLUB = 0;  ld_ITAX = 0;  ld_COOPERATIVE = 0;  ld_ICICI = 0;  ld_PUJA = 0;  ld_MEDICAL = 0; ld_GROUPINSU = 0;  ld_LPG = 0; ld_volpf=0;ld_othded=0;
	
	fetch c1 into :ls_ref_no,:ld_ref_date,:ld_grosswages,:ld_cointhisweek,:ld_coingiven,:ld_pfded,:ld_fpfded,:ld_lwfded,:ld_advanceded,:ld_electded,:ld_rationded,:ld_coinbfded,:ld_lastcoinbf,:ld_subsded,:ld_pfadvded,:ld_pfintded,:ld_lip,:ld_ptax,:ld_revst,:ld_ACMS01, :ld_BPUJA, :ld_ACKS, :ld_CLUB, :ld_ITAX, :ld_COOPERATIVE, :ld_ICICI, :ld_PUJA, :ld_MEDICAL,:ld_GROUPINSU, :ld_canteen, :ld_LPG, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_rd, :ld_koil, :ld_netpayable,:ld_volpf,:ld_othded;

	  if isnull(ld_lwfded) then ld_lwfded = 0;
	  if isnull(ld_advanceded) then ld_advanceded = 0;
	  if isnull(ld_electded) then ld_electded = 0;
	  if isnull(ld_rationded) then ld_rationded = 0;
	  if isnull(ld_coinbfded ) then ld_coinbfded = 0;
	  if isnull(ld_subsded) then ld_subsded = 0;
	  if isnull(ld_pfadvded) then ld_pfadvded = 0;
	  if isnull(ld_pfintded) then ld_pfintded = 0;
	  if isnull(ld_pfded) then ld_pfded = 0;
	  if isnull(ld_fpfded ) then ld_fpfded = 0;
	  if isnull(ld_ptax) then ld_ptax = 0;
	  if isnull(ld_lip) then ld_lip = 0;
	  if isnull(ld_revst) then ld_revst = 0;
	  if isnull(ld_ACMS01) then ld_ACMS01 = 0;
	  if isnull(ld_BPUJA) then ld_BPUJA = 0;
	  if isnull(ld_ACKS) then ld_ACKS = 0;
	  if isnull(ld_CLUB) then ld_CLUB = 0;
	  if isnull(ld_ITAX) then ld_ITAX = 0;
	  if isnull(ld_COOPERATIVE) then ld_COOPERATIVE = 0;
	  if isnull(ld_ICICI) then ld_ICICI = 0;
	  if isnull(ld_PUJA) then ld_PUJA = 0;
	  if isnull(ld_MEDICAL) then ld_MEDICAL = 0;
	  if isnull(ld_GROUPINSU) then ld_GROUPINSU = 0;
	  if isnull(ld_LPG) then ld_LPG = 0;
	  if isnull(ld_canteen) then ld_canteen = 0;
	  if isnull(ld_electadvded) then ld_electadvded = 0;
	  if isnull(ld_medadvded) then ld_medadvded= 0;
	  if isnull(ld_festadvded) then ld_festadvded = 0;
	  if isnull(ld_volpf) then ld_volpf = 0;
	  if isnull(ld_othded) then ld_othded = 0;
	  
	  
	  ld_netdeduction= ld_lwfded + ld_advanceded + ld_electded + ld_rationded + ld_coinbfded + ld_subsded + ld_pfadvded + ld_pfintded + ld_pfded+ld_fpfded + ld_ptax + ld_lip + ld_revst + ld_ACMS01 + ld_BPUJA + ld_ACKS + ld_CLUB + ld_ITAX + ld_COOPERATIVE + ld_ICICI + ld_PUJA + ld_MEDICAL +ld_GROUPINSU + ld_canteen + ld_LPG + ld_electadvded + ld_medadvded + ld_festadvded + ld_rd + ld_koil
	 // ld_netpayable=(ld_grosswages+ld_lastcoinbf ) - ld_netdeduction
	  		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
				
				 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
					
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID, VH_UNIT_ID, VH_DOC_SRL, VH_VOU_NO, VH_VOU_DATE, VH_VOU_TYPE, VH_AC_YEAR, VH_ENTRY_DT, VH_ENTRY_BY, VH_APPROVED_BY, VH_APPROVED_DT)
                values( :gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,trunc(:fs_ac_dt),'JV',to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),sysdate,:gs_user,:gs_user,sysdate);   
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_emppayment set ep_vou_no=:ls_vou_no , ep_vou_dt=trunc(:fs_ac_dt)
			where ep_vou_no is null and EP_YEAR=:ll_year and EP_MONTH=:ll_month ;  
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			update fb_emppaymentstatus set EPS_PAIDFLAG='1' where eps_year = :ll_year and  eps_month = :ll_month and nvl(EPS_PAIDFLAG,'0')='0' ;
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Paidflag in Payment status ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
	
		// Credit GL/SGL
            
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0001'		//ls_csgl='SLEG0420'
			//messagebox('Test','gs_garden_snm - '+gs_garden_snm + ' ll_doc_no - ' + string(ll_doc_no) + ' gs_CO_ID - '+gs_CO_ID+ ' VD_AC_YEAR - ' +string(fs_ac_dt,'yyyymm') + ' ls_cgl - '+ls_cgl + ' ls_csgl - '+ ls_csgl + ' ld_netpayable' + string (ld_netpayable)+ ' ls_ref_no - '+ls_ref_no+ ' VD_REF_DATE - '+ string(ld_ref_date,'dd/mm/yyyy'))
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_netpayable,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Net Payable');
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) 1',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
		end if;
		
		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded+ld_fpfded)  >0 then	
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,(:ld_pfded+:ld_fpfded) ,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Employee Contribution');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
      				
		// insert into Voucher Detail for employer_contribution_val		
			//credit
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  	//ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,'C',(:ld_pfded+:ld_fpfded) ,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Employer Contribution');
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//debit
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'    //ls_csgl='SLEG0004'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,(:ld_pfded+:ld_fpfded) ,'D','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Providend Fund');
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead, (ld_pfded+ld_fpfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;		
				
		 // insert into Voucher Detail for electded_val
		 if ld_electded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Electric Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_electded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Electric Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

			//Update DailyExpense in expense subhead 'ESUB0054'
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_electded,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if
            end if;			
		 // insert into Voucher Detail for rationded_val
		 if ld_rationded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
				
			//ls_cgl='LEG0015'    //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,'C',:ld_rationded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Ration Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_rationded,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;	
		 // insert into Voucher Detail for pfadvded_val
		 if ld_pfadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PF Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_pfadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'PF Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	
			  
			  
////////////////////////////////////////insert into Voucher Detail for electric advance ded



		 if ld_electadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Electric Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_electadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Electric Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	





//////////////////////////////////////////////

////////////////////////////////////////insert into Voucher Detail for medical advance ded



		 if ld_medadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Medical Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Medical Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Medical Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_medadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Medical Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	





//////////////////////////////////////////////


////////////////////////////////////////insert into Voucher Detail for festival advance ded



		 if ld_festadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Festival Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Festival Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Festival Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_festadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Festival Advance Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	





//////////////////////////////////////////////

		 // insert into Voucher Detail for pfintded_val
		 if ld_pfintded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PF Intrest Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Intrest Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Intrest Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'    //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_pfintded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'PF Intrest Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_coinbfded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Coin CF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin CF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin CF Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_coinbfded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Coin CF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_lastcoinbf >0 then		
			
			 select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Coin BF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin BF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin BF Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_lastcoinbf,'D','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Coin BF Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;	
				
//		  ==============
		 if ld_lip >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='LIP';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LIP Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LIP Not Present, Please Create First !!!');
					return -1;		
				end if

			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_lip,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'LIP');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
		end if;
				
		 if ld_ptax >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PTAX';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PTAX Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PTAX Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ptax,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'PTAX');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
//====== MORAN

		 if ld_ACMS01 >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'ACMS Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ACMS Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ACMS Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ACMS01,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'ACMS Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		

		 if ld_BPUJA >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'BPUJA Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select BPUJA Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','BPUJA Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_BPUJA,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'BPUJA Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;					

		 if ld_ACKS >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'ACKS Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ACKS Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ACKS Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ACKS,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'ACKS Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;					

		 if ld_CLUB >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'CLUB Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select CLUB Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','CLUB Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_CLUB,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'CLUB Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		


		 if ld_ITAX >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'ITAX Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ITAX Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ITAX Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ITAX,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'ITAX Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		

//		 ld_ICICI, ld_PUJA, ld_MEDICAL,ld_GROUPINSU, ld_LPG, ld_ot_amount	

		 if ld_COOPERATIVE >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'COOPRATIVE Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select COOPERATIVE Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','COOPERATIVE Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_COOPERATIVE,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'COOPRATIVE Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		

//		 , ld_PUJA, ld_MEDICAL,ld_GROUPINSU, ld_LPG, ld_ot_amount	

		 if ld_ICICI >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'ICICI Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select ICICI Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ICICI Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ICICI,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'ICICI Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		

//		 , , ld_MEDICAL,ld_GROUPINSU, ld_LPG, ld_ot_amount	

		 if ld_PUJA >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'PUJA Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PUJA Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PUJA Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_PUJA,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'PUJA Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
				
		 if ld_canteen >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'CANTEEN Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select CANTEEN Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','CANTEEN Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_canteen,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'CANTEEN Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;					
//		 , , ,ld_GROUPINSU, ld_LPG, ld_ot_amount	

		 if ld_MEDICAL >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'MEDICAL Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select MEDICAL Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','MEDICAL Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_MEDICAL,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'MEDICAL Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			//Update DailyExpense in expense subhead 
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead, (-1)*ld_MEDICAL ,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			END IF
			
            end if;		

//		 , , ,, ld_LPG, ld_ot_amount	

		 if ld_GROUPINSU >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'GROUPINSU Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select GROUPINSU Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','GROUPINSU Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_GROUPINSU,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'GROUPINSU Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		

//		 , , ,, , ld_ot_amount	

		 if ld_LPG >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL= 'LPG Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LPG Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LPG Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_LPG,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'LPG Deduction');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
				
				
				
		//// Voluntary PF
		if ld_volpf >0 then		
			
		
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),'LEG0002','SLEG0720',:ld_volpf,null,null,:ld_volpf,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Voluntary PF');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
        end if;	
		  
		  // ctd gslis deduction
		  if ld_othded >0 then		
			
		
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),'LEG0002','SLEG1229',:ld_othded,null,null,:ld_othded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'CTD GSLIS DEDUCTION');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
        end if;	
		  
				
	////
				
				
				
				
//====== MORAN		
		  if ld_revst >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='REVSTAMP';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select REVSTAMP Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','REVSTAMP Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_revst,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'REVSTAMP');
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		   
			
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_revst,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if
            end if;		
//		  ==============
	// insert into Voucher Detail for Employee Advance value
	
		if  ld_advanceded>0 then		
			
			declare c3 cursor for	

                   select 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) sal_date,ACSUBLEDGER_NAME, c.ACLEDGER_ID,c.ACSUBLEDGER_ID,
       				   sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,'C' dc_ind        
   				from fb_emppayment a,FB_EMPLOYEE b,fb_acsubledger c
			  where a.EMP_ID=b.EMP_ID(+) and b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID(+) and EP_YEAR=:ll_year and EP_MONTH=:ll_month and nvl(EP_ADVANCEDEDAMOUNT,0)>0
			  group by last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')),c.ACSUBLEDGER_ID, c.ACLEDGER_ID,ACSUBLEDGER_NAME,'C' ;
			
			open c3; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C3 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Advance Deduction');
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	

					end if;	
                  	setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
					 
				loop;	 
				close c3;
			end if;	
		end if	
			
		declare c2 cursor for 

         select 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) sal_date,ACSUBLEDGER_NAME, c.ACLEDGER_ID,c.ACSUBLEDGER_ID,b.EACSUBHEAD_ID,
                sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0) + nvl(EP_ADHOC,0) +nvl(EP_HRAMOUNT,0)+ nvl(EP_ELECTRICAMOUNT,0)+ nvl(EP_FUELAMOUNT,0)+ nvl(EP_ALLOWWPF,0)+ nvl(a.ep_allowwopf,0)+ nvl(OT_AMOUNT,0) + nvl(LIGHTALOW,0) + nvl(SEASONALOW,0) + nvl(CHARGEALOW,0) + nvl(COMPUTERALOW,0) + nvl(EP_EB_AMT,0) ) grosswages,
                      decode(sign(sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0) + nvl(EP_ADHOC,0) +nvl(EP_HRAMOUNT,0)+ nvl(EP_ELECTRICAMOUNT,0)+ nvl(EP_FUELAMOUNT,0)+ nvl(EP_ALLOWWPF,0)+ nvl(a.ep_allowwopf,0)+ nvl(OT_AMOUNT,0) + nvl(LIGHTALOW,0) + nvl(SEASONALOW,0) + nvl(CHARGEALOW,0) + nvl(COMPUTERALOW,0) + nvl(EP_EB_AMT,0) )),-1,'C','D') dc_ind        
         from fb_emppayment a,FB_EMPLOYEE b,fb_acsubledger c,FB_EXPENSEACSUBHEAD d
         where a.EMP_ID=b.EMP_ID(+) and d.EACHEAD_ID=c.ACSUBLEDGER_ID(+) and b.EACSUBHEAD_ID=d.EACSUBHEAD_ID(+) and EP_YEAR=:ll_year and EP_MONTH=:ll_month
         group by last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')),c.ACSUBLEDGER_ID, c.ACLEDGER_ID,ACSUBLEDGER_NAME,'D',b.EACSUBHEAD_ID;
			
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
					
		     
			do while sqlca.sqlcode <> 100 							
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE,VD_NARR_FREE_TEXT)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(trunc(:fs_ac_dt),'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'S',abs(:ld_amt) ,:ls_dc_ind,'JV For Salary To Account',:ls_ref_no,:ld_ref_date,'Salary');
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
// modified 310714
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,ld_amt,'S','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
// modified 310714				
			  setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			  ld_amt = 0;
			  
		  fetch c2 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
		 
		 loop;	 	
		close c2;
	  end if;	
	end if;	
//end if;	
	
	setnull(ls_ref_no);setnull(ld_ref_date);
	ld_grosswages= 0;ld_cointhisweek= 0;ld_coingiven= 0;ld_pfded= 0;ld_fpfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_netdeduction=0;
	ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;
	ld_lip = 0; ld_ptax = 0; ld_revst = 0; ld_canteen = 0;
	ld_ACMS01 = 0;  ld_BPUJA = 0;  ld_ACKS = 0;  ld_CLUB = 0;  ld_ITAX = 0;  ld_COOPERATIVE = 0;  ld_ICICI = 0;  ld_PUJA = 0;  ld_MEDICAL = 0; ld_GROUPINSU = 0;  ld_LPG = 0;  ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_rd = 0; ld_koil = 0;ld_volpf=0;ld_othded=0;
	
	fetch c1 into :ls_ref_no,:ld_ref_date,:ld_grosswages,:ld_cointhisweek,:ld_coingiven,:ld_pfded,:ld_fpfded,:ld_lwfded,:ld_advanceded,:ld_electded,:ld_rationded,:ld_coinbfded,:ld_lastcoinbf,:ld_subsded,:ld_pfadvded,:ld_pfintded,:ld_lip,:ld_ptax,:ld_revst,:ld_ACMS01, :ld_BPUJA, :ld_ACKS, :ld_CLUB, :ld_ITAX, :ld_COOPERATIVE, :ld_ICICI, :ld_PUJA, :ld_MEDICAL,:ld_GROUPINSU, :ld_canteen, :ld_LPG, :ld_electadvded, :ld_medadvded, :ld_festadvded, :ld_rd, :ld_koil, :ld_netpayable,:ld_volpf,:ld_othded;
	  if isnull(ld_lwfded) then ld_lwfded = 0;
	  if isnull(ld_advanceded) then ld_advanceded = 0;
	  if isnull(ld_electded) then ld_electded = 0;
	  if isnull(ld_rationded) then ld_rationded = 0;
	  if isnull(ld_coinbfded ) then ld_coinbfded = 0;
	  if isnull(ld_subsded) then ld_subsded = 0;
	  if isnull(ld_pfadvded) then ld_pfadvded = 0;
	  if isnull(ld_pfintded) then ld_pfintded = 0;
	  if isnull(ld_pfded) then ld_pfded = 0;
	  if isnull(ld_fpfded ) then ld_fpfded = 0;
	  if isnull(ld_ptax) then ld_ptax = 0;
	  if isnull(ld_lip) then ld_lip = 0;
	  if isnull(ld_revst) then ld_revst = 0;
	  if isnull(ld_ACMS01) then ld_ACMS01 = 0;
	  if isnull(ld_BPUJA) then ld_BPUJA = 0;
	  if isnull(ld_ACKS) then ld_ACKS = 0;
	  if isnull(ld_CLUB) then ld_CLUB = 0;
	  if isnull(ld_ITAX) then ld_ITAX = 0;
	  if isnull(ld_COOPERATIVE) then ld_COOPERATIVE = 0;
	  if isnull(ld_ICICI) then ld_ICICI = 0;
	  if isnull(ld_PUJA) then ld_PUJA = 0;
	  if isnull(ld_MEDICAL) then ld_MEDICAL = 0;
	  if isnull(ld_GROUPINSU) then ld_GROUPINSU = 0;
	  if isnull(ld_LPG) then ld_LPG = 0;
	  if isnull(ld_canteen) then ld_canteen = 0;
	  if isnull(ld_electadvded) then ld_electadvded = 0;
	  if isnull(ld_medadvded) then ld_medadvded= 0;
	  if isnull(ld_festadvded) then ld_festadvded = 0;
	   if isnull(ld_volpf) then ld_volpf = 0;
	  if isnull(ld_othded) then ld_othded = 0;
	  
	  ld_netdeduction= ld_lwfded + ld_advanceded + ld_electded + ld_rationded + ld_coinbfded + ld_subsded + ld_pfadvded + ld_pfintded + ld_pfded+ld_fpfded + ld_ptax + ld_lip + ld_revst + ld_ACMS01 + ld_BPUJA + ld_ACKS + ld_CLUB + ld_ITAX + ld_COOPERATIVE + ld_ICICI + ld_PUJA + ld_MEDICAL +ld_GROUPINSU + ld_canteen + ld_LPG + ld_electadvded + ld_medadvded + ld_festadvded + ld_rd + ld_koil
	  //ld_netpayable=(ld_grosswages+ld_lastcoinbf ) - ld_netdeduction
		 
		loop;	 
		 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
		close c1;
	end if;	
	
return 1;	

end function

public function integer wf_salary_to_account (string fs_transdt, date fs_ac_dt);string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_last,ls_vou_no,ls_name,ls_cgl,ls_csgl,ls_ym,ls_acesubhead
long  ll_vou_no,fymm,ll_last,ll_doc_no,ll_year,ll_month
double ld_amt,ld_grosswages,ld_cointhisweek,ld_coingiven,ld_pfded,ld_fpfded,ld_lwfded,ld_advanceded,ld_electded,ld_rationded,ld_coinbfded,ld_lastcoinbf,ld_subsded,ld_pfadvded,ld_pfintded,ld_netpayable,ld_netdeduction,ld_lip,ld_ptax,ld_revst
double ld_electadvded, ld_medadvded, ld_festadvded,ld_acks,ld_otherallow,ld_amtallow
string ls_expensehead
date ld_ref_date

ls_ym = 	string(fs_ac_dt,'yyyymm')
 ll_year = long(left(fs_transdt,4))
 ll_month = long(right(fs_transdt,2))
 
//   select 'Salary' lww_id, last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) salary_date,
//           sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl(EP_CVRFORPFAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)) grosswages,
//       	sum(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl(EP_CVRFORPFAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)) cointhisweek,
//		sum((mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl(EP_CVRFORPFAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT ,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0))-mod(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl(EP_CVRFORPFAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)
//		-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl(EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0),10)) coingiven,
//		sum(nvl(EP_PFCONTDEDAMOUNT,0)) pfded,
//		sum(nvl(EP_PENSIONFUNDDEDAMOUNT,0)) fpfded,
//		sum(nvl(EP_LWFDEDAMOUNT,0)) lwfded,
//		sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,
//		sum(nvl(EP_ELECTRICDEDAMOUNT,0)) electded,
//		sum(nvl(EP_RATIONDEDAMOUNT,0)) rationded,
//		sum(nvl(EP_COINBF,0)) coinbfded,
//		sum(nvl(EP_LASTCOINBF,0)) lastcoinbf,		
//		0 subsded,sum(nvl(EP_PFADVANCEDEDAMOUNT,0)) pfadvded,0  pfintded,
//         sum(nvl(EP_LIPDEDAMOUNT,0)) lipamt,
//         sum(nvl(EP_PTAXDEDAMOUNT,0)) ptax,
//         sum(nvl(EP_REVENUESTAMPDEDAMOUNT,0)) revenuestamp	
//   from fb_emppayment
//  where EP_YEAR=:ll_year and EP_MONTH=:ll_month and  ep_vou_no is null 
//  group by 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm'));
// 
 
declare c1 cursor for 
 
  select 'Salary' lww_id, last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) salary_date,
           sum(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)) grosswages,
       	sum(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)) cointhisweek,
		sum((mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+ nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT ,0)-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl( EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0))-mod(mod(nvl(EP_BASICAMOUNT,0)+nvl(EP_DAAMOUNT,0)+nvl(EP_VDAAMOUNT,0)+nvl( EP_HRAMOUNT,0)+nvl( EP_ELECTRICAMOUNT,0)+nvl( EP_FUELAMOUNT,0)
		-nvl(EP_PENSIONFUNDDEDAMOUNT,0)-nvl( EP_PFCONTDEDAMOUNT,0)-nvl( EP_LIPDEDAMOUNT,0)-nvl(EP_PTAXDEDAMOUNT,0)-nvl( EP_REVENUESTAMPDEDAMOUNT,0)-nvl( EP_LWFDEDAMOUNT,0)-nvl( EP_ELECTRICDEDAMOUNT,0)-nvl( EP_ADVANCEDEDAMOUNT,0)-nvl( EP_RATIONDEDAMOUNT,0),10)+nvl(EP_LASTCOINBF,0),10)) coingiven,
		sum(nvl(EP_PFCONTDEDAMOUNT,0)) pfded,
		sum(nvl(EP_PENSIONFUNDDEDAMOUNT,0)) fpfded,
		sum(nvl(EP_LWFDEDAMOUNT,0)) lwfded,
		sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,
		sum(nvl(EP_ELECTRICDEDAMOUNT,0)) electded,
		sum(nvl(EP_RATIONDEDAMOUNT,0)) rationded,
		sum(nvl(EP_COINBF,0)) coinbfded,
		sum(nvl(EP_LASTCOINBF,0)) lastcoinbf,		
		0 subsded,sum(nvl(EP_PFADVANCEDEDAMOUNT,0)) pfadvded,sum(nvl(EP_PFINTADVANCEDED,0))  pfintded,
         sum(nvl(EP_LIPDEDAMOUNT,0)) lipamt,
         sum(nvl(EP_PTAXDEDAMOUNT,0)) ptax,
         sum(nvl(EP_REVENUESTAMPDEDAMOUNT,0)) revenuestamp, sum(nvl(EP_ELECTADVANCEDED,0)) electadvanceded, sum(nvl(EP_MEDICALADVANCEDED,0)) medadvanceded,
	    sum(nvl(EP_FESTIVALADVANCEDED,0)) festadvanceded,
        sum(nvl(EP_RD,0)) ACKS,
        sum(nvl(ep_adhoc,0)) + sum(nvl(ep_allowwopf,0)) Other_allow
   from fb_emppayment
  where EP_YEAR=:ll_year and EP_MONTH=:ll_month and  ep_vou_no is null 
  group by 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm'));

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(ls_ref_no);setnull(ld_ref_date);
	ld_grosswages= 0;ld_cointhisweek= 0;ld_coingiven= 0;ld_pfded= 0;ld_fpfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_netdeduction=0;
	ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;ld_netdeduction=0;
	ld_lip = 0; ld_ptax = 0; ld_revst = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_acks=0;ld_otherallow=0;
	
	fetch c1 into :ls_ref_no,:ld_ref_date,:ld_grosswages,:ld_cointhisweek,:ld_coingiven,:ld_pfded,:ld_fpfded,:ld_lwfded,:ld_advanceded,:ld_electded,:ld_rationded,:ld_coinbfded,:ld_lastcoinbf,:ld_subsded,:ld_pfadvded,:ld_pfintded,:ld_lip,:ld_ptax,:ld_revst, :ld_electadvded, :ld_medadvded, :ld_festadvded,:ld_acks,:ld_otherallow;
	  ld_netdeduction= ld_lwfded + ld_advanceded + ld_electded + ld_rationded + ld_coinbfded + ld_subsded + ld_pfadvded + ld_pfintded + ld_pfded+ld_fpfded + ld_ptax + ld_lip + ld_revst + ld_electadvded + ld_medadvded + ld_festadvded  +ld_acks
	  ld_netpayable=(ld_grosswages+ld_lastcoinbf ) - ld_netdeduction + ld_otherallow
	  		  
	do while sqlca.sqlcode <> 100        
		if (ls_ref_no <> ls_old_ref) then
			ls_old_ref = ls_ref_no
			
			/// Generate reference no
				 select nvl(MAX(vh_doc_srl),0) into :ll_doc_no from fb_vou_head ;
					ll_doc_no = ll_doc_no + 1
               ///Generate voucher no
     				   ll_vou_no = 0
				
				 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
				where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm');
				
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ym,'dd/mm/yyyy'),'yyyymm')); 
					commit using sqlca;
				end if
					
				   ll_vou_no = f_get_lastno('JV',ls_ym)						
				   if ll_vou_no < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				end if
				if ll_vou_no >= 0 then
					ls_vou_no = string(ll_vou_no,'0000')
					ls_vou_no ='JV'+string(ls_ym)+"-"+ls_vou_no					
				end if 	
					
		// insert into Voucher Head
			insert into fb_vou_head(VH_CO_ID, VH_UNIT_ID, VH_DOC_SRL, VH_VOU_NO, VH_VOU_DATE, VH_VOU_TYPE, VH_AC_YEAR, VH_ENTRY_DT, VH_ENTRY_BY, VH_APPROVED_BY, VH_APPROVED_DT)
                values( :gs_CO_ID,:gs_garden_snm,:ll_doc_no,:ls_vou_no,:fs_ac_dt,'JV',to_number(to_char(:fs_ac_dt,'yyyymm')),sysdate,:gs_user,:gs_user,sysdate);   
										
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Voucher Head',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
		  //Update Voucher No /Date
			Update fb_emppayment set ep_vou_no=:ls_vou_no , ep_vou_dt=:fs_ac_dt
			where ep_vou_no is null and EP_YEAR=:ll_year and EP_MONTH=:ll_month ;  
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Voucher No and Date ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
			
			update fb_emppaymentstatus set EPS_PAIDFLAG='1' where eps_year = :ll_year and  eps_month = :ll_month and nvl(EPS_PAIDFLAG,'0')='0' ;
			
			if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Update Paidflag in Payment status ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
	
		// Credit GL/SGL
            
		// insert into Voucher Detail for netpayable_val		
		if ld_netpayable >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Netpayable';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Netpayable Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Netpayable Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0001'		//ls_csgl='SLEG0420'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_netpayable,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
				if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
		end if;
		
		// insert into Voucher Detail for employee_contribution_val   (ld_pfded+ld_fpfded) 
		 if  (ld_pfded+ld_fpfded)  >0 then	
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Employee Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employee Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employee Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0187'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,(:ld_pfded+:ld_fpfded) ,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
      				
		// insert into Voucher Detail for employer_contribution_val		
			//credit
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Employer Contribution';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Employer Contribution Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Employer Contribution Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  	//ls_csgl='SLEG0186'
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,'C',(:ld_pfded+:ld_fpfded) ,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			  if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//debit
			
			select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID,DR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Providend Fund';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Providend Fund Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Providend Fund Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0015'    //ls_csgl='SLEG0004'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,(:ld_pfded+:ld_fpfded) ,'D','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
				
		     if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;	
					
			//Update DailyExpense in expense subhead 'ESUB0049'
			if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead, (ld_pfded+ld_fpfded) ,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;		
				
		 // insert into Voucher Detail for electded_val
		 if ld_electded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Electric Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
			//ls_cgl='LEG0015'  //ls_csgl='SLEG0005' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_electded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

			//Update DailyExpense in expense subhead 'ESUB0054'
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_electded,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if
            end if;			
		 // insert into Voucher Detail for rationded_val
		 if ld_rationded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Ration Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Ration Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Ration Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
				
			//ls_cgl='LEG0015'    //ls_csgl='SLEG0005'  
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,'C',:ld_rationded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

			//Update DailyExpense in expense subhead 'ESUB0068'
			if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_rationded,'C','N')  = -1 then 
				rollback using sqlca;
				return 1;
			end if;
            end if;	
		 // insert into Voucher Detail for pfadvded_val
		 if ld_pfadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PF Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_pfadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	


////////////////////////////////////////insert into Voucher Detail for electric advance ded



		 if ld_electadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Electric Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Electric Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Electric Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_electadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	
			  
			  /////////////////////////////////////////////

////////////////////////////////////////insert into Voucher Detail for LWF //190923 --Piyush

			  if ld_lwfded>0 then 
				select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
				where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='LWF';
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LWF Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LWF Not Present, Please Create First !!!');
					return -1;		
				end if
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_lwfded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) LWF',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		 
			  end if;
			  
			    /////////////////////////////////////////////

////////////////////////////////////////insert into Voucher Detail for ACKS //190923 --Piyush

			  if ld_acks>0 then 
				
				select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
				where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='ACKS';
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LWF Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','ACKS Not Present, Please Create First !!!');
					return -1;		
				end if
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_acks,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ACKS',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		 
			  end if;
			  
			  
			     /////////////////////////////////////////////

////////////////////////////////////////insert into Voucher Detail for OTHER ALLOWance //190923 --Piyush

			  if ld_otherallow>0 then 
				 
				declare c4 cursor for	

                  SELECT 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) sal_date,ACSUBLEDGER_NAME, d.ACLEDGER_ID,d.ACSUBLEDGER_ID,c.EACSUBHEAD_ID,
       				   sum(nvl(a.ep_adhoc,0)+nvl(ep_allowwopf,0)) advanceded,'D' dc_ind     
  				FROM fb_emppayment a ,  fb_employee b , FB_EXPENSEACSUBHEAD c ,fb_acsubledger d
  				where a.emp_id=b.emp_id and b.EACSUBHEAD_ID = c.EACSUBHEAD_ID and c.EACHEAD_ID=d.ACSUBLEDGER_ID and  EP_YEAR=:ll_year and EP_MONTH=:ll_month 
                and (a.ep_adhoc<>0 or ep_allowwopf<>0) 
  				group by  last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) ,ACSUBLEDGER_NAME, d.ACLEDGER_ID,d.ACSUBLEDGER_ID,'D' ,c.EACSUBHEAD_ID;	
			
			open c4; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C4 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_expensehead);
				ld_amt= 0;
				
				fetch c4 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_expensehead,:ld_amt,:ls_dc_ind;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_gl,:ls_sgl,:ls_expensehead,null,'S',:ld_amt,'D','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	
						
						//Update DailyExpense in expense subhead 
						if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_expensehead, ld_amt ,'C','N')  = -1 then 
							rollback using sqlca;
							return 1;
						end if;

					end if;	
                  	setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);setnull(ls_expensehead);
				ld_amt= 0;
				
				fetch c4 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_expensehead,:ld_amt,:ls_dc_ind;
					 
				loop;	 
				close c4;
			end if;	
				
			
			  end if;





//////////////////////////////////////////////

////////////////////////////////////////insert into Voucher Detail for medical advance ded



		 if ld_medadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Medical Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Medical Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Medical Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_medadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	





//////////////////////////////////////////////


////////////////////////////////////////insert into Voucher Detail for festival advance ded



		 if ld_festadvded >0 then
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Festival Advance Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Festival Advance Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Festival Advance Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'   //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_festadvded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

           end if;	





//////////////////////////////////////////////


		 // insert into Voucher Detail for pfintded_val
		 if ld_pfintded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PF Intrest Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PF Intrest Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PF Intrest Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'    //ls_csgl='SLEG0467' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_pfintded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_coinbfded >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Coin BF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin BF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin BF Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_coinbfded,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;		
		// insert into Voucher Detail for coinbfded_val
		 if ld_lastcoinbf >0 then		
			
			 select DR_ACLEDGER_ID, DR_ACSUBLEDGER_ID into :ls_cgl,:ls_csgl from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='Coin CF Deduction';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select Coin CF Deduction Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','Coin CF Deduction Not Present, Please Create First !!!');
					return -1;		
				end if
				
			//ls_cgl='LEG0002'  //ls_csgl='SLEG0188' 
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,null,null,null,:ld_lastcoinbf,'D','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			

            end if;	
				
//		  ==============
			
		 if ld_lip >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='LIP';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select LIP Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','LIP Not Present, Please Create First !!!');
					return -1;		
				end if

			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_lip,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
		end if;
				
		 if ld_ptax >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='PTAX';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select PTAX Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','PTAX Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,null,:ld_ptax,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;		       			
            end if;		
		
		  if ld_revst >0 then		
			
			select CR_ACLEDGER_ID, CR_ACSUBLEDGER_ID,CR_EACSUBHEAD_ID into :ls_cgl,:ls_csgl,:ls_acesubhead from fb_acautoprocess 
			where AC_PROCESS='Salary To Account' and AC_PROCESS_DETAIL='REVSTAMP';
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Select REVSTAMP Ledger/subledger : ',sqlca.sqlerrtext);
					return -1;
				elseif sqlca.sqlcode = 100 then
					messagebox('Information !','REVSTAMP Not Present, Please Create First !!!');
					return -1;		
				end if
			
			insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
			values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_cgl,:ls_csgl,:ls_acesubhead,null,decode(nvl(:ls_acesubhead,'x'),'x',null,'C'),:ld_revst,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
					
			 if sqlca.sqlcode = -1 then 		 
				messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
				rollback using sqlca;
				return -1;
			end if;
			
			if not isnull(ls_acesubhead) then
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,(-1) * ld_revst,'C','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if
            end if;		
//		  ==============
	// insert into Voucher Detail for Employee Advance value
	
		if  ld_advanceded>0 then		
			
			declare c3 cursor for	

                   select 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) sal_date,ACSUBLEDGER_NAME, c.ACLEDGER_ID,c.ACSUBLEDGER_ID,
       				   sum(nvl(EP_ADVANCEDEDAMOUNT,0)) advanceded,'C' dc_ind        
   				from fb_emppayment a,FB_EMPLOYEE b,fb_acsubledger c
			  where a.EMP_ID=b.EMP_ID(+) and b.ACSUBLEDGER_ID=c.ACSUBLEDGER_ID(+) and EP_YEAR=:ll_year and EP_MONTH=:ll_month and nvl(EP_ADVANCEDEDAMOUNT,0)>0
			  group by last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')),c.ACSUBLEDGER_ID, c.ACLEDGER_ID,ACSUBLEDGER_NAME,'C' ;
			
			open c3; 
		
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Opening Cursor C3 : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			else 
				setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
						  
				do while sqlca.sqlcode <> 100       				

					// insert into Voucher Detail for netamt_val		
					if ld_amt >0 then					
						insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
						values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_gl,:ls_sgl,null,null,null,:ld_amt,'C','JV For Salary To Account',:ls_ref_no,:ld_ref_date);
								
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Insertion Of Voucher Detail (Cr) ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	

					end if;	
                  	setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_name);setnull(ls_gl);setnull(ls_sgl);setnull(ls_dc_ind);
				ld_amt= 0;
				
				fetch c3 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ld_amt,:ls_dc_ind;
					 
				loop;	 
				close c3;
			end if;	
		end if	
			
		declare c2 cursor for 

		 select 'Salary',last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')) sal_date,ACSUBLEDGER_NAME, c.ACLEDGER_ID,c.ACSUBLEDGER_ID,b.EACSUBHEAD_ID,
				sum(EP_BASICAMOUNT+EP_DAAMOUNT+EP_VDAAMOUNT+ EP_HRAMOUNT+ EP_ELECTRICAMOUNT+ EP_FUELAMOUNT) grosswages,
					  decode(sign(sum(EP_BASICAMOUNT+EP_DAAMOUNT+EP_VDAAMOUNT+ EP_HRAMOUNT+ EP_ELECTRICAMOUNT+ EP_FUELAMOUNT)),-1,'C','D') dc_ind        
		 from fb_emppayment a,FB_EMPLOYEE b,fb_acsubledger c,FB_EXPENSEACSUBHEAD d
		 where a.EMP_ID=b.EMP_ID(+) and d.EACHEAD_ID=c.ACSUBLEDGER_ID(+) and b.EACSUBHEAD_ID=d.EACSUBHEAD_ID(+) and EP_YEAR=:ll_year and EP_MONTH=:ll_month
		 group by last_day(to_date(((EP_YEAR*100)+EP_MONTH),'yyyymm')),c.ACSUBLEDGER_ID, c.ACLEDGER_ID,ACSUBLEDGER_NAME,'D',b.EACSUBHEAD_ID;
			
		open c2; 
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return -1; 
		else 	
			setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			ld_amt = 0;
			
			fetch c2 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
					
		     
			do while sqlca.sqlcode <> 100 							
				// insert into Voucher Detail
				insert into  fb_vou_det (vd_functions,vd_business_segment,VD_DOC_SRL,VD_CO_ID,VD_UNIT_ID,VD_AC_YEAR,VD_GL_CD,VD_SGL_CD,VD_EXPSUBHEAD,VD_SECTION_ID,VD_PREFERRED_MES,VD_AMOUNT,VD_DC_IND,VD_DETAIL,VD_REF_NO,VD_REF_DATE)
				values ('PLT',:gs_garden_snm,:ll_doc_no,:gs_CO_ID,:gs_garden_snm,to_number(to_char(:fs_ac_dt,'yyyymm')),:ls_gl,:ls_sgl,:ls_acesubhead,null,'S',abs(:ld_amt) ,:ls_dc_ind,'JV For Salary To Account',:ls_ref_no,:ld_ref_date);
						
				if sqlca.sqlcode = -1 then 		 
					messagebox('Sql Error: During Insertion Of Voucher Detail (Dr) ',sqlca.sqlerrtext);
					rollback using sqlca;
					return -1;
				end if;	
// modified 310714
				if wf_upd_mes(string(fs_ac_dt,'dd/mm/yyyy'),ls_acesubhead,ld_amt,'S','N')  = -1 then 
					rollback using sqlca;
					return 1;
				end if;
// modified 310714				
			  setnull(ls_ref_no);setnull(ld_ref_date);setnull(ls_gl);setnull(ls_sgl);setnull(ls_cgl);setnull(ls_dc_ind);setnull(ls_acesubhead);
			  ld_amt = 0;
			  
		  fetch c2 into :ls_ref_no,:ld_ref_date,:ls_name,:ls_gl,:ls_sgl,:ls_acesubhead,:ld_amt,:ls_dc_ind;
		 
		 loop;	 	
		close c2;
	  end if;	
	end if;	
//end if;	
	
	setnull(ls_ref_no);setnull(ld_ref_date);
	ld_grosswages= 0;ld_cointhisweek= 0;ld_coingiven= 0;ld_pfded= 0;ld_fpfded= 0;ld_lwfded= 0;ld_advanceded= 0;ld_netdeduction=0;
	ld_electded= 0;ld_rationded= 0;ld_coinbfded= 0;ld_lastcoinbf= 0;ld_subsded= 0;ld_pfadvded= 0;ld_pfintded= 0;ld_netpayable=0;
	ld_lip = 0; ld_ptax = 0; ld_revst = 0;   ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_acks=0;ld_otherallow=0;
	
	fetch c1 into :ls_ref_no,:ld_ref_date,:ld_grosswages,:ld_cointhisweek,:ld_coingiven,:ld_pfded,:ld_fpfded,:ld_lwfded,:ld_advanceded,:ld_electded,:ld_rationded,:ld_coinbfded,:ld_lastcoinbf,:ld_subsded,:ld_pfadvded,:ld_pfintded,:ld_lip,:ld_ptax,:ld_revst, :ld_electadvded, :ld_medadvded, :ld_festadvded,:ld_acks,:ld_otherallow;
	  ld_netdeduction= ld_lwfded + ld_advanceded + ld_electded + ld_rationded + ld_coinbfded + ld_subsded + ld_pfadvded + ld_pfintded + ld_pfded+ld_fpfded  + ld_ptax + ld_lip + ld_revst + ld_electadvded + ld_medadvded + ld_festadvded +ld_acks
	  ld_netpayable=(ld_grosswages+ld_lastcoinbf ) - ld_netdeduction + ld_otherallow
		 
		loop;	 
		 ///update last no
		if ll_vou_no > 0 then
			if f_upd_lastno('JV',ls_ym,ll_vou_no) = -1 then
				rollback using sqlca;			
				return -1
			end if	
		end if
		close c1;
	end if;	
	
return 1;	
end function

on n_fames.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_fames.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

