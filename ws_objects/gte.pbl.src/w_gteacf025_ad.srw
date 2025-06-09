$PBExportHeader$w_gteacf025_ad.srw
forward
global type w_gteacf025_ad from window
end type
type cb_2 from commandbutton within w_gteacf025_ad
end type
type cb_1 from commandbutton within w_gteacf025_ad
end type
type dw_1 from datawindow within w_gteacf025_ad
end type
end forward

global type w_gteacf025_ad from window
integer width = 3730
integer height = 1448
boolean titlebar = true
string title = "(w_ltcacf061_ad) Advance Deduction Detail"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf025_ad w_gteacf025_ad

type variables
long ll_doc_no, ll_cnt
string ls_sup_id, ls_dt, ls_piid
double ld_sel_amt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_lab_nm, string fl_lab_add)
public function integer wf_check_duplicate_emp (string fs_emp)
public function integer wf_check_duplicate_rec_id (string fs_spid)
public function integer check_duplicate_fields (string fl_field, string fl_value, string fl_message)
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

public function integer wf_check_duplicate_rec (string fl_lab_nm, string fl_lab_add);long fl_row
string ls_emp_nm1, ls_emp_add1

//employee_details.tabpage_1.dw_1.SelectRow(0, FALSE)
//if employee_details.tabpage_1.dw_1.rowcount() > 1 then
//	for fl_row = 1 to (employee_details.tabpage_1.dw_1.rowcount() - 1)
//		ls_emp_nm1 = employee_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_name')
//		ls_emp_add1 = employee_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_add')
//		
//		if ls_emp_nm1 = fl_lab_nm and ls_emp_add1 = fl_lab_add then
//			employee_details.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 

return 1
end function

public function integer wf_check_duplicate_emp (string fs_emp);//long fl_row
//string ls_emp1, ls_spid1
//
//employee_details.tabpage_2.dw_2.SelectRow(0, FALSE)
//if employee_details.tabpage_2.dw_2.rowcount() > 1 then
//	for fl_row = 1 to (employee_details.tabpage_2.dw_2.rowcount() - 1)
//		ls_emp1 = employee_details.tabpage_2.dw_2.getitemstring(fl_row,'emp_id')
//		ls_spid1 = employee_details.tabpage_2.dw_2.getitemstring(fl_row,'emps_id')
//		
//		if ls_emp1 = fs_emp or ls_spid1 = fs_emp then
//			employee_details.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Labour Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 
return 1
end function

public function integer wf_check_duplicate_rec_id (string fs_spid);//long fl_row
//string ls_dpid1, ls_emp1
//
//
//employee_details.tabpage_2.dw_2.SelectRow(0, FALSE)
//if employee_details.tabpage_2.dw_2.rowcount() > 1 then
//	for fl_row = 1 to (employee_details.tabpage_2.dw_2.rowcount() - 1)
//		ls_dpid1 = employee_details.tabpage_2.dw_2.getitemstring(fl_row,'emps_id')
//		ls_emp1 = employee_details.tabpage_2.dw_2.getitemstring(fl_row,'emp_id')
//		
//		if ls_dpid1 = fs_spid or ls_emp1 = fs_spid then
//			employee_details.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Spouse ID Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
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

on w_gteacf025_ad.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacf025_ad.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;
string ls_temp1

ls_temp1 = Message.StringParm

//ll_doc_srl = long(left(ls_temp1,len(ls_temp1)-4))


ls_dt=left(ls_temp1,10)

ls_sup_id = mid(ls_temp1,11,9)

dw_1.settransobject(sqlca)

dw_1.Retrieve(ls_dt,ls_sup_id)


end event

event key;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

type cb_2 from commandbutton within w_gteacf025_ad
integer x = 3287
integer y = 1252
integer width = 302
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacf025_ad
boolean visible = false
integer x = 2985
integer y = 1252
integer width = 302
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Post"
end type

event clicked;if dw_1.rowcount() > 0 then 
 	ld_sel_amt = dw_1.getitemnumber(1,'selected_amt')
	for ll_cnt = 1 to dw_1.rowcount()
		 ls_piid = dw_1.getitemstring(ll_cnt,'ad_vou_no')
		if dw_1.getitemstring(ll_cnt,'ad_payment_adv_ind') = 'Y' then
			update Fb_GRN_ADJ_DET set ad_payment_adv_ind = 'Y',ad_PAYMENT_ADV_NO = :ll_doc_no where ad_vou_no = :ls_piid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error During Update det:',sqlca.sqlerrtext)
				return 1
			end if
		else
			update Fb_GRN_ADJ_DET set ad_payment_adv_ind = 'N', AD_PAYMENT_ADV_NO = :ll_doc_no where ad_vou_no = :ls_piid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error During Update det1:',sqlca.sqlerrtext)
				return 1
			end if
		end if
	next
//	if ld_sel_amt > 0 then
//		update fb_vou_head set VH_PAYMENT_ADV_NO = :ll_doc_no where vh_doc_srl = :ll_doc_srl;
//		if sqlca.sqlcode = -1 then
//			messagebox('Sql Error During Update Head:',sqlca.sqlerrtext)
//			return 1
//		end if
//		commit using sqlca;
//	end if
end if
gd_selpv_amt = ld_sel_amt

close(parent)

//SELECT  c.SUP_NAME,  b.PI_SUPINVNO, b.PI_RECEIVEDATE bill_dt, invoice_amt,a.ADVOUTAMT, a.PI_ID       
//   FROM         
//       ( SELECT MAX (pp.sup_id) sup_id, pi.pi_id pi_id,
//                          MAX (pc.ppc_paymentdate) ppc_paymentdate, MAX (pi.pi_netamo) invoice_amt, NVL (SUM (pp.pp_paidamt), 0) paid_amt,
//                          (MAX (pi.pi_netamo) - NVL (SUM (pp.pp_paidamt), 0)) advoutamt,
//                          '0' advflag, MAX (pi.pi_confirm) confirm
//               FROM fb_purpayment pp, fb_purpaycheque pc, fb_purinvoice pi
//            WHERE pc.ppc_id = pp.ppc_id AND pp.pi_id = pi.pi_id AND pc.ppc_active = '1' and
//			trunc(pc.PPC_PAYMENTDATE) > to_date(:ls_dt,'dd/mm/yyyy') 
//            GROUP BY pi.pi_id
//            HAVING ROUND (MAX (pi.pi_netamo) - NVL (SUM (pp.pp_paidamt), 0), 0) > 1
//            UNION ALL
//        SELECT sup.sup_id, pi.pi_id, pi.pi_rcdate, pi.pi_netamo invoice_amt, 0 paid_amt, pi.pi_netamo, '0' advflag,pi.pi_confirm
//           FROM fb_purinvoice pi, fb_supplier sup, fb_purorder po
//          WHERE po.sup_id = sup.sup_id AND po.po_id = pi.po_id AND pi.pi_active = '1'  
//          and not exists (select PI_ID from fb_purpayment pp, fb_purpaycheque pc where pp.ppc_id = pc.ppc_id and 
//		trunc(pc.PPC_PAYMENTDATE) > to_date(:ls_dt,'dd/mm/yyyy') and
//	 	pp.pi_id = pi.pi_id)
//         group by sup.sup_id, pi.pi_id, pi.pi_rcdate, pi.pi_netamo, '0' ,pi.pi_confirm )  a,
//          FB_PURINVOICE b,FB_SUPPLIER c
//  WHERE a.PI_ID=b.PI_ID  AND a.SUP_ID = c.SUP_ID AND a.SUP_ID = :ra_SUP_ID and 
//			trunc(b.PI_RECEIVEDATE) > to_date(:ls_dt,'dd/mm/yyyy')
end event

type dw_1 from datawindow within w_gteacf025_ad
integer x = 27
integer y = 20
integer width = 3666
integer height = 1220
integer taborder = 90
string title = "none"
string dataobject = "dw_gteacf025_ad"
boolean vscrollbar = true
boolean livescroll = true
end type

