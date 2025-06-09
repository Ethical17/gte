$PBExportHeader$w_gteinf003.srw
forward
global type w_gteinf003 from window
end type
type cb_13 from commandbutton within w_gteinf003
end type
type cb_12 from commandbutton within w_gteinf003
end type
type cb_11 from commandbutton within w_gteinf003
end type
type cb_10 from commandbutton within w_gteinf003
end type
type cb_9 from commandbutton within w_gteinf003
end type
type cb_8 from commandbutton within w_gteinf003
end type
type cb_7 from commandbutton within w_gteinf003
end type
type cb_5 from commandbutton within w_gteinf003
end type
type cb_6 from commandbutton within w_gteinf003
end type
type cbx_1 from checkbox within w_gteinf003
end type
type em_1 from editmask within w_gteinf003
end type
type st_1 from statictext within w_gteinf003
end type
type dw_2 from datawindow within w_gteinf003
end type
type cb_4 from commandbutton within w_gteinf003
end type
type cb_3 from commandbutton within w_gteinf003
end type
type cb_2 from commandbutton within w_gteinf003
end type
type cb_1 from commandbutton within w_gteinf003
end type
type dw_1 from datawindow within w_gteinf003
end type
end forward

global type w_gteinf003 from window
integer width = 5225
integer height = 2096
boolean titlebar = true
string title = "(w_gteinf003) Stock Transfer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cb_6 cb_6
cbx_1 cbx_1
em_1 em_1
st_1 st_1
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteinf003 w_gteinf003

type variables
long ll_cnt,ll_last,ll_user_level,ll_ctr2, ll_dlcno, ll_tino,ll_fymm
string ls_temp,ls_sp_id,ls_spc_id,ls_tmp_id,ls_appr_ind,ls_ac_dt,ls_div,ls_sup_id,ls_issuereq_id,ls_spname,ls_rec_locn,ls_hsn_cd,ls_iss_locn, ls_iss_gstn, ls_rec_gstn, ls_count,ls_tinvno, ls_count1, ls_dlcno
boolean lb_neworder, lb_query
double ld_efunit_price,ld_stock,ld_req_qty,ld_tot_val,ld_qnty,ld_cgst_per, ld_sgst_per,ld_igst_per
datawindowchild idw_prod,idw_spcid
datetime ld_reqdt,ld_stock_dt,ld_dt
string ls_transferto_ind
date ld_date
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_check_duplicate_rec (string fs_con_id)
end prototypes

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

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemstring(fl_row,'sp_id')) or  len(dw_2.getitemstring(fl_row,'sp_id'))=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'pris_reqquantity')) or dw_2.getitemnumber(fl_row,'pris_reqquantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, required Quantity Please Check !!!')
	    return -1
	end if
end if
return 1



end function

public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt);double ld_hrs1

select round(((:fd_todt - :fd_frdt) * 24),2) into :ld_hrs1 from dual;

return ld_hrs1
end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_con_id1 = dw_2.getitemstring(fl_row,'sp_id')
		
		if ls_con_id1 = fs_con_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteinf003.create
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_13,&
this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteinf003.destroy
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false

dw_2.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

dw_1.GetChild ("sup_id", idw_spcid)
idw_spcid.settransobject(sqlca)


this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level =1 then
	em_1.visible = true
     cbx_1.visible = true
	cb_6.visible = true
	st_1.visible = true	  
else
	em_1.visible = false
     cbx_1.visible = false
	cb_6.visible = false
	st_1.visible = false	  	
end if	
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_13 from commandbutton within w_gteinf003
integer x = 3360
integer y = 8
integer width = 457
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Delivery Challan"
end type

event clicked;opensheetwithparm(w_gtedsr003ds,this.tag,w_mdi,0,layered!)
end event

type cb_12 from commandbutton within w_gteinf003
integer x = 3013
integer y = 8
integer width = 343
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Tax Invoice"
end type

event clicked;opensheetwithparm(w_gtedsr003gs,this.tag,w_mdi,0,layered!)
end event

type cb_11 from commandbutton within w_gteinf003
boolean visible = false
integer x = 3429
integer y = 12
integer width = 421
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process Exp"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text 
end if;	

/*select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	*/


select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

//if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_cnt,'pris_vou_no'))=true then
//			//update stock			
//				dw_1.setitem(ll_cnt,'pris_stockind','Y')	
//				setnull(ls_issuereq_id)
//				ls_issuereq_id = dw_1.getitemstring(ll_cnt,'pris_id')
//	
//				if isnull(gs_storeid) or len(gs_storeid) = 0 then
//					messagebox('Warning','Main Store Division Not Define, Please Check')
//					rollback using sqlca;
//					return 1;
//				end if;
//				
//				if f_stocktransfer_fifo(ls_issuereq_id,gs_storeid) = -1 then 
//					return 1
//				end if;
//
//				string ls_rowid
//				double ld_PRIS_qty,ld_PRIS_value
//				
//				declare c1 cursor for 
//				select rowid,SP_ID,pris_issuequantity,PRIS_VALUE from fb_producttransferdetails  where PRIS_ID = :ls_issuereq_id;
//
//				open c1;
//			
//				if sqlca.sqlcode = -1 then 
//					messagebox('Error At Cursor','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
//					return 1
//				else
//					setnull(ls_rowid);setnull(ls_SP_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;
//					fetch c1 into :ls_rowid,:ls_SP_ID,:ld_PRIS_qty,:ld_PRIS_value;
//					
//					do while sqlca.sqlcode <> 100
//					
//						//update Stock Quantity
//						// for issue
//						if luo_fames.wf_upd_dailystock(ls_issuereq_id,string(dw_1.getitemdatetime(ll_cnt,'pris_date'),'dd/mm/yyyy'),ls_SP_ID,ld_PRIS_qty,ld_PRIS_value/ld_PRIS_qty,ld_PRIS_value,'Stock Transfer','I','N',gs_storeid) = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;		
//						// for Received from Division
//						if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='D'  then
//							if luo_fames.wf_upd_dailystock(ls_issuereq_id,string(dw_1.getitemdatetime(ll_cnt,'pris_date'),'dd/mm/yyyy'),ls_SP_ID,ld_PRIS_qty,ld_PRIS_value/ld_PRIS_qty,ld_PRIS_value,'Stock Transfer','R','N',dw_1.getitemstring(ll_cnt,'sup_id')) = -1 then 
//								rollback using sqlca;
//								return 1;
//							end if;		
//						end if;
//					setnull(ls_rowid);setnull(ls_SP_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;
//					fetch c1 into :ls_rowid,:ls_SP_ID,:ld_PRIS_qty,:ld_PRIS_value;
//					
//				loop
//				close c1;
//			end if
			////
			  if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='U'  then
				if luo_fames.wf_store_transfer_ac(dw_1.getitemstring(ll_cnt,'pris_id'),ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;	
			  else
					dw_1.setitem(ll_cnt,'pris_vou_no','99999')	
					dw_1.setitem(ll_cnt,'pris_vou_dt',datetime(today()))	
			  end if;
		end if
	next	
	
dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()
dw_2.reset()
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cb_10 from commandbutton within w_gteinf003
boolean visible = false
integer x = 3031
integer y = 8
integer width = 343
integer height = 104
integer taborder = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "store to ac"
boolean default = true
end type

event clicked;string ls_ref_no,ls_ref_dt,ls_gl,ls_sgl,ls_dc_ind,ls_VOU_DT,ls_old_ref,ls_vou_no,ls_ym,fs_transid,fs_ac_dt 
long  ll_vou_no,ll_doc_no,ll_ac_period
double ld_amt 

fs_transid = 'TRN0000000029'
fs_ac_dt = '11/05/2013'

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
commit using sqlca;	
end event

type cb_9 from commandbutton within w_gteinf003
integer x = 4347
integer y = 24
integer width = 123
integer height = 88
integer taborder = 130
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_8 from commandbutton within w_gteinf003
integer x = 4229
integer y = 24
integer width = 123
integer height = 88
integer taborder = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_7 from commandbutton within w_gteinf003
integer x = 4110
integer y = 24
integer width = 123
integer height = 88
integer taborder = 110
integer textsize = -9
integer weight = 700
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

type cb_5 from commandbutton within w_gteinf003
integer x = 3991
integer y = 24
integer width = 123
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_6 from commandbutton within w_gteinf003
integer x = 2487
integer y = 8
integer width = 343
integer height = 104
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text 
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	


select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_cnt,'pris_vou_no'))=true then
			//update stock			
				dw_1.setitem(ll_cnt,'pris_stockind','Y')	
				setnull(ls_issuereq_id)
				ls_issuereq_id = dw_1.getitemstring(ll_cnt,'pris_id')
	
				if isnull(gs_storeid) or len(gs_storeid) = 0 then
					messagebox('Warning','Main Store Division Not Define, Please Check')
					rollback using sqlca;
					return 1;
				end if;
				
				
				setnull(ls_transferto_ind);
				ls_transferto_ind=dw_1.getitemstring(ll_cnt,'pris_transferto_ind')
				
				ld_dt=datetime(ls_ac_dt)
				
				declare p2 procedure for up_stk_trf( :ls_issuereq_id, :gs_storeid,:ld_dt ,'Stock Transfer','N',:ls_transferto_ind);
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Procedure Declare of up_stk_trf',sqlca.sqlerrtext)
				
					return 1
				end if

				execute p2;		
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Procedure Execute of up_stk_trf',sqlca.sqlerrtext)
					return 1
				end if
				
				// Commented on 13-09-2024 cloud Piyush
//				if f_stocktransfer_fifo(ls_issuereq_id,gs_storeid) = -1 then 
//					return 1
//				end if;
//
//				string ls_rowid
//				double ld_PRIS_qty,ld_PRIS_value
//				
//				declare c1 cursor for 
//				select rowid,SP_ID,pris_issuequantity,PRIS_VALUE from fb_producttransferdetails  where PRIS_ID = :ls_issuereq_id;
//
//				open c1;
//			
//				if sqlca.sqlcode = -1 then 
//					messagebox('Error At Cursor','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
//					return 1
//				else
//					setnull(ls_rowid);setnull(ls_SP_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;
//					fetch c1 into :ls_rowid,:ls_SP_ID,:ld_PRIS_qty,:ld_PRIS_value;
//					
//					do while sqlca.sqlcode <> 100
//					
//						//update Stock Quantity
//						// for issue
//						if luo_fames.wf_upd_dailystock(ls_issuereq_id,string(dw_1.getitemdatetime(ll_cnt,'pris_date'),'dd/mm/yyyy'),ls_SP_ID,ld_PRIS_qty,ld_PRIS_value/ld_PRIS_qty,ld_PRIS_value,'Stock Transfer','I','N',gs_storeid) = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;		
//						// for Received from Division
//						if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='D'  then
//							if luo_fames.wf_upd_dailystock(ls_issuereq_id,string(dw_1.getitemdatetime(ll_cnt,'pris_date'),'dd/mm/yyyy'),ls_SP_ID,ld_PRIS_qty,ld_PRIS_value/ld_PRIS_qty,ld_PRIS_value,'Stock Transfer','R','N',dw_1.getitemstring(ll_cnt,'sup_id')) = -1 then 
//								rollback using sqlca;
//								return 1;
//							end if;		
//						end if;
//					setnull(ls_rowid);setnull(ls_SP_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;
//					fetch c1 into :ls_rowid,:ls_SP_ID,:ld_PRIS_qty,:ld_PRIS_value;
//					
//				loop
//				close c1;
//			end if
			////
			  if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='U'  then
				if luo_fames.wf_store_transfer_ac(dw_1.getitemstring(ll_cnt,'pris_id'),ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;	
			  else
					dw_1.setitem(ll_cnt,'pris_vou_no','99999')	
					dw_1.setitem(ll_cnt,'pris_vou_dt',datetime(today()))	
			  end if;
		end if
	next	
	
dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()
dw_2.reset()
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cbx_1 from checkbox within w_gteinf003
integer x = 1102
integer y = 24
integer width = 439
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

type em_1 from editmask within w_gteinf003
integer x = 2053
integer y = 20
integer width = 411
integer height = 84
integer taborder = 80
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
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_1.text
	if cb_3.enabled = true then
		messagebox('Warning!','You Have Made Some Changes, Please Save First !!!');
		return 1
	end if
	if dw_1.getitemstring(dw_1.getrow(),'appr_flag') = 'Y' then
		cb_6.enabled = true
	end if
	
	IF gs_user='USER' then
		cb_10.enabled = true
	    cb_11.enabled = true
     end if; 
	  
end if;	
end event

type st_1 from statictext within w_gteinf003
integer x = 1541
integer y = 32
integer width = 498
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_gteinf003
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 976
integer width = 5166
integer height = 1160
integer taborder = 50
string dataobject = "dw_gteinf003a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if dwo.name = 'spc_id' then
	ls_spc_id = data
	idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
	idw_prod.filter( )
end if

if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		  dw_2.insertrow(0)
end if


if dwo.name = 'sp_id' then
	ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'pris_date')
	ls_sp_id = trim(data)
	
	ld_stock = 0;
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock where  DS_ITEM_CD = :ls_sp_id;
	
	select sp_name into :ls_spname from fb_storeproduct where sp_id = :ls_sp_id;

	 if date(ld_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy')+' Of Item '+ls_spname+' ('+ls_sp_id+')')
		return 1;
	end if;

	ls_div=dw_1.getitemstring(dw_1.getrow(),'pris_from_sup_id')
	
	//current stock Shyamguri T.E. = :gs_storeid 
	select sum(decode(ds_rec_ind,'I',-1,1)*ds_QTY) into  :ld_stock
	   from fb_daily_stock
	 where trunc(ds_date) <= trunc(sysdate) and ds_item_cd=:ls_sp_id and DS_SECTION_ID=:ls_div
	  group by ds_item_cd;
	
	if sqlca.sqlcode = -1 then 
	   messagebox('Error During Select Of Available Stock',sqlca.sqlerrtext)
	   rollback using sqlca;
	   return 1
	elseif sqlca.sqlcode = 100 then
		ld_stock = 0
	end if	

	if  wf_check_duplicate_rec(data) = -1 then return 1
	if isnull(ld_stock) then ld_stock = 0
	dw_2.setitem(row,'avl_stock',ld_stock)	
	
//	select spp_effectiveunitprice into  :ld_efunit_price from fb_storeproductprice 
//     where spp_stock > 0 and sp_id=(select sp_id from FB_storeproduct where sp_id=:ls_sp_id);
//	  
//	 if sqlca.sqlcode = -1 then
//	   messagebox('Error During Select Of Unit Price',sqlca.sqlerrtext)
//	   rollback using sqlca;
//	   return 1
//	end if	

	ld_efunit_price =100
	
	dw_2.setitem(row,'unitprice',ld_efunit_price)	 
	
	if ld_efunit_price=0 then
		messagebox('Error:','Please Check unit price of this item not present in master')
		return 1;
	end if;	
	
	if date(ld_dt) > date('30/06/2017') then
		
//		select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
//		if sqlca.sqlcode = -1 then 
//			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//			return 1
//		end if;			
//
		ls_rec_locn = dw_1.getitemstring(dw_1.getrow(),'pris_rec_locn')
		
		select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code Missing, Please Check !!!')
//			return 1
		end if;	
		dw_2.setitem(row,'pris_hsn_no',ls_hsn_cd)
		
		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
			messagebox('Error','Supplier State Code Not Update, Please Update Now !!!')
			return 1
		end if
			
		if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
			messagebox('Error','Garden State Code Not Update, Please Update Now !!!')
			return 1
		end if	
		
		ls_iss_locn = gs_gstn_stcd
		
		select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
		from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_dt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code Missing, Please Check !!!')
//			return 1
		end if;	
	end if
	
end if;	

if dwo.name = 'pris_reqquantity' then
	ld_req_qty = double(data)
	dw_2.setitem(row,'pris_issuequantity',ld_req_qty)	
	
	ld_efunit_price =dw_2.getitemnumber(row,'unitprice')
	ld_tot_val = truncate((ld_req_qty * ld_efunit_price),2)
	
		select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
		from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_dt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code Missing, Please Check !!!')
//			return 1
		end if;	


	
	if ls_iss_locn = ls_rec_locn then
		ld_igst_per = 0
	elseif ls_iss_locn <> ls_rec_locn then
		ld_cgst_per = 0; ld_sgst_per = 0;
	end if
	
	if ld_igst_per > 0 then
		ld_cgst_per = 0
		ld_sgst_per = 0
		dw_2.setitem(row,'pris_cgst_per',0)
		dw_2.setitem(row,'pris_sgst_per',0)
		dw_2.setitem(row,'pris_igst_amt',truncate((ld_tot_val *(ld_igst_per/100)),2)) 
		dw_2.setitem(row,'pris_igst_per',ld_igst_per)
		dw_2.setitem(row,'pris_cgst_amt',0) 
		dw_2.setitem(row,'pris_sgst_amt',0) 								
	elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
		ld_igst_per = 0
		dw_2.setitem(row,'pris_igst_per',0)
		dw_2.setitem(row,'pris_igst_amt',0) 
		dw_2.setitem(row,'pris_cgst_amt',truncate((ld_tot_val *(ld_cgst_per/100)),2)) 
		dw_2.setitem(row,'pris_sgst_amt',truncate((ld_tot_val *(ld_sgst_per/100)),2)) 
		dw_2.setitem(row,'pris_cgst_per',ld_cgst_per)
		dw_2.setitem(row,'pris_sgst_per',ld_sgst_per)				
	end if	
	
	dw_2.setitem(row,'pris_value',ld_tot_val)
end if;	

if dwo.name = 'pris_issuequantity' then
	ld_qnty = double(data)
	
	ld_stock = dw_2.getitemnumber(row,'avl_stock')
	ld_req_qty = dw_2.getitemnumber(row,'pris_reqquantity')
		
	if ld_qnty > ld_stock then
		messagebox('Error:','Issue quantity should be less or equal to Stock quantity')
		return 1;
	end if;	
	
	if ld_qnty > ld_req_qty then
		messagebox('Error:','Issue quantity should be less than Required quantity')
		return 1;
	end if;	
	
	ld_tot_val =0
	ld_efunit_price =dw_2.getitemnumber(row,'unitprice')
	ld_tot_val = truncate((ld_qnty * ld_efunit_price),2)
	
	if ls_iss_locn = ls_rec_locn then
		ld_igst_per = 0
	elseif ls_iss_locn <> ls_rec_locn then
		ld_cgst_per = 0; ld_sgst_per = 0;
	end if
	
	if ld_igst_per > 0 then
		ld_cgst_per = 0
		ld_sgst_per = 0
		dw_2.setitem(row,'pris_cgst_per',0)
		dw_2.setitem(row,'pris_sgst_per',0)
		dw_2.setitem(row,'pris_igst_amt',truncate((ld_tot_val *(ld_igst_per/100)),2)) 
		dw_2.setitem(row,'pris_igst_per',ld_igst_per)
		dw_2.setitem(row,'pris_cgst_amt',0) 
		dw_2.setitem(row,'pris_sgst_amt',0) 								
	elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
		ld_igst_per = 0
		dw_2.setitem(row,'pris_igst_per',0)
		dw_2.setitem(row,'pris_igst_amt',0) 
		dw_2.setitem(row,'pris_cgst_amt',truncate((ld_tot_val *(ld_cgst_per/100)),2)) 
		dw_2.setitem(row,'pris_sgst_amt',truncate((ld_tot_val *(ld_sgst_per/100)),2)) 
		dw_2.setitem(row,'pris_cgst_per',ld_cgst_per)
		dw_2.setitem(row,'pris_sgst_per',ld_sgst_per)				

	end if
	dw_2.setitem(row,'pris_value',ld_tot_val)	
end if;

cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gteinf003
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteinf003
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'pris_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'pris_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	for ll_cnt = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_cnt,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_cnt,'sel_row') then
			dw_2.deleterow(ll_cnt)
		end if
	next	
	
	if dw_1.rowcount() > 0 then	
		if (isnull(dw_1.getitemstring(dw_1.getrow(),'sup_id')) or len(dw_1.getitemstring(dw_1.getrow(),'sup_id'))=0 ) then
			messagebox('Warning:','One Of The Fields Are Blank : To Unit/Division, Please Check !!!')
			dw_1.setfocus()
			dw_1.setcolumn('sup_id')
			return 1
		end if
		ls_sup_id = dw_1.getitemstring(dw_1.getrow(),'sup_id')
	
		select distinct 'x' into :ls_temp from fb_supplier  where SUP_ID = :ls_sup_id and ACSUBLEDGER_ID is not null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Subledger For The Supplier Is Blank, Please Update First !!!')
			setnull(ls_temp)
			dw_1.setitem(dw_1.getrow(),'sup_id',ls_temp)					
			rollback using sqlca;
			return 1
		end if	
	end if	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Required/Issue Date !!!')
		dw_1.setfocus()
		dw_1.setcolumn('pris_reqdate')
		return
	end if
	
	if dw_2.rowcount() > 0 then
		for ll_cnt = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_cnt) = -1 THEN 
				return 1
			end if
		next	
	end if
	
	if lb_neworder = true then
		ll_last=0
		if ll_last=0 then
			select nvl(MAX(substr(pris_id,4,10)),0) into :ll_last from fb_producttransfer;
		end if
			ls_sup_id = dw_1.getitemstring(dw_1.getrow(),'sup_id')
			
			ll_last = ll_last + 1
			ls_tmp_id = 'TRN'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'pris_id',ls_tmp_id)	
		//	dw_1.setitem(dw_1.getrow(),'pris_date',datetime(today()))
		else
			ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'pris_id')
		end if;		
		
		for ll_cnt = 1 to dw_2.rowcount()		
			 dw_2.setitem(ll_cnt,'pris_id',ls_tmp_id)		
		next
		
	end if		
	
	if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then
		ls_iss_gstn = dw_1.getitemstring(dw_1.getrow(),'pris_iss_gstnno')
		ls_rec_gstn =  dw_1.getitemstring(dw_1.getrow(),'pris_rec_gstnno')
//======
		if ls_iss_gstn <> ls_rec_gstn then		
			if ll_tino = 0 then
				ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'pris_date'),'yyyymm'))
				
				select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('TI') and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'TI', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
					commit using sqlca;
				end if
					
				ll_tino = f_get_lastno('TI',string(ll_fymm))
				
				if ll_tino < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					return 1
				end if
			else
				ll_tino = ll_tino + 1
			end if
	
			if ll_tino >= 0 then
				ls_count = string(ll_tino,'000')
				ls_tinvno =gs_garden_snm+"/TI/"+string(ll_fymm)+"-"+ls_count					
				dw_1.setitem(dw_1.getrow(),'pris_TAXINVNO',ls_tinvno)	
			end if 
		end if
//		elseif ls_iss_gstn = ls_rec_gstn then		
		if ll_dlcno = 0 then
			ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'pris_date'),'yyyymm'))
			
			select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('DC') and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
			if sqlca.sqlcode = 100 then
				INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'DC', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
				commit using sqlca;
			end if
				
			ll_dlcno = f_get_lastno('DC',string(ll_fymm))
			
			if ll_dlcno < 0 then
				messagebox('Error At Last No Getting',sqlca.sqlerrtext)
				return 1
			end if
		else
			ll_dlcno = ll_dlcno + 1
		end if

		if ll_dlcno >= 0 then
			ls_count1 = string(ll_dlcno,'000')
			ls_dlcno =gs_garden_snm+"/DC/"+string(ll_fymm)+"-"+ls_count1					
			dw_1.setitem(dw_1.getrow(),'pris_delvchno',ls_dlcno)	
		end if 
	end if
	
//	if dw_1.update(true,false) = 1 then
//		if dw_2.update(true,false) = 1 then
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then			
			if ll_tino > 0 then
				///update last no
				if ls_iss_gstn <> ls_rec_gstn then	
					if f_upd_lastno('TI',string(ll_fymm),ll_tino) = -1 then
						rollback using sqlca;			
						return 1
					end if	
				end if
			end if
			if ll_dlcno > 0 then
				if f_upd_lastno('DC',string(ll_fymm),ll_dlcno) = -1 then
					rollback using sqlca;			
					return 1
				end if						
			end if
		end if			
			
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
			dw_1.reset()
			dw_2.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if

end event

type cb_2 from commandbutton within w_gteinf003
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	dw_1.settaborder('pris_reqdate',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('pris_reqdate')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteinf003
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
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
	dw_2.reset()
end if

///check Issue for previous date A/c posting	
//	select distinct 'x' into :ls_temp from fb_producttransfer
//	where  trunc(PRIS_DATE) < trunc(sysdate) and nvl(PRIS_VOU_NO,'N')='N' and PRIS_TRANSFERTO_IND='U'  ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Stock Transfer for previous date A/c posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous Date Stock Transfer Already Available for  A/c Posting ....Please check ')
//		return 1
//	end if;		
//
///check Issue for Stock/MES posting	
//	select distinct 'x' into :ls_temp from fb_producttransfer where  nvl(PRIS_STOCKIND,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Stock Transfer for Stock/MES Posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error',' Stock Transfer Already Available for  Stock/MES Posting...Please Check ')
//		return 1
//	end if;	

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pris_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pris_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_from_sup_id',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pris_rec_type','T')
	dw_1.setitem(dw_1.getrow(),'pris_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'pris_iss_gstnno',gs_gstnno)
	dw_1.setcolumn('pris_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pris_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pris_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_from_sup_id',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pris_rec_type','T')
	dw_1.setitem(dw_1.getrow(),'pris_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'pris_iss_gstnno',gs_gstnno)
	dw_1.setcolumn('pris_date')
end if


end event

type dw_1 from datawindow within w_gteinf003
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 5
integer y = 116
integer width = 4901
integer height = 856
integer taborder = 40
string dataobject = "dw_gteinf003"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'pris_entry_by',gs_user)
		dw_1.setitem(newrow,'pris_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'pris_from_sup_id',gs_storeid)
	     dw_1.setitem(newrow,'pris_rec_type','T')
		dw_1.setcolumn('pris_reqdate')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('pris_date')		
	end if;
	
	if dwo.name = 'pris_date'  and lb_query = false then
	ld_dt = datetime(data)
	select distinct 'x' into :ls_temp from fb_producttransfer
	where  trunc(PRIS_DATE) < trunc(:ld_dt) and nvl(PRIS_VOU_NO,'N')='N' and PRIS_TRANSFERTO_IND='U'  ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Stock Transfer for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Stock Transfer Already Available for  A/c Posting ....Please check ')
		return 1
	end if;		
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Issue date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1
	end if

	 if date(ld_dt) > date(today()) then
		MESSAGEBOX('Error:','The Required date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1
	end if
	
end if

if dwo.name = 'pris_reqdate'  and lb_query = false then
	ld_reqdt = datetime(data)
	select distinct 'x' into :ls_temp from fb_producttransfer
	where  trunc(PRIS_DATE) < trunc(:ld_reqdt) and nvl(PRIS_VOU_NO,'N')='N' and PRIS_TRANSFERTO_IND='U'  ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Stock Transfer for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Stock Transfer Already Available for  A/c Posting ....Please check ')
		return 1
	end if		
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_reqdt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Issue date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1
	end if
	
	 if date(ld_reqdt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1
	end if
	
end if

if dwo.name = 'pris_transferto_ind' then
	idw_spcid.SetFilter ("transfer_type  = '"+trim(data)+"'") 
	idw_spcid.filter( )
end if

if dwo.name = 'sup_id'  then
	ls_sup_id = data
	
	select SUP_GSTN_STCD, SUP_GSTNNO into :ls_rec_locn, :ls_rec_gstn from fb_supplier  where SUP_ID = :ls_sup_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error During Select Of Supplier GSTIN Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','Supplier Is GSTIN Details Not Found, Please Update First !!!')
		rollback using sqlca;
//		return 1
	end if	
	if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
		messagebox('Warning!','Unit/Division GSTIN State Code Not Found, Please Update First !!!')
		return 1
	end if 
	if isnull(ls_rec_gstn) or len(ls_rec_gstn) = 0 then
		messagebox('Warning!','Unit/Division GSTIN No Not Found, Please Update First !!!')
		return 1
	end if 	
	dw_1.setitem(row,'pris_rec_locn',ls_rec_locn)
	dw_1.setitem(row,'pris_rec_gstnno',ls_rec_gstn)
//	ls_iss_locn = 
//	ls_iss_gstn = 
	
end if;
if dwo.name = 'appr_flag' then
	if data = 'N' or isnull(data) then
		cb_6.enabled = false
	end if
end if

dw_1.setitem(row,'pris_entry_by',gs_user)
dw_1.setitem(row,'pris_entry_dt',datetime(today()))

//cb_3.enabled = true

if dwo.name<>'appr_flag' then
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve( dw_1.getitemstring(dw_1.getrow(),'pris_id'))
		end if
	end if
end if
end event

