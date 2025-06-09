$PBExportHeader$w_gtedsf015.srw
forward
global type w_gtedsf015 from window
end type
type cb_10 from commandbutton within w_gtedsf015
end type
type cb_4 from commandbutton within w_gtedsf015
end type
type cb_2 from commandbutton within w_gtedsf015
end type
type dw_1 from datawindow within w_gtedsf015
end type
end forward

global type w_gtedsf015 from window
integer width = 2473
integer height = 2344
boolean titlebar = true
string title = "(w_gtedsf015) TCS Net Sales Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_10 cb_10
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
end type
global w_gtedsf015 w_gtedsf015

type variables
long ll_ctr, ll_last,ll_from,ll_to,ll_ac_year, ll_lotno, ll_season,ll_user_level, ll_cnt
string ls_temp,ls_del_ind,ls_tmp_id, ls_tmp_id1,ls_entry_user,ls_cons,ls_last,ls_count, ls_tpc_id,ls_ref,ls_ltno,ls_licenseno,ls_licensenotmp
string ls_inv_no, ls_prefix, ls_grade,ls_count1,ls_id1,ls_id, ls_spid, ls_hocus_id, ls_hocus_name, ls_cus_id
boolean lb_neworder, lb_query
double ld_hrs, ld_gross, ld_tear, ld_net, ld_sostk, ld_balance
datetime ld_rundt,ld_maxpackdt, ld_dt, ld_expdt, ld_impdt
date ld_issue_tmp,ld_exp_tmp
string ls_hocus_add, ls_hocus_desc, ls_hocus_lsaletaxno, ls_hocus_csaletaxno, ls_hocity_id, ls_hocus_stateid, ls_hocus_email, ls_hocus_fax, ls_hocus_telephone, ls_hocus_website, ls_hocus_contactperson, ls_hocus_mobile, ls_hocus_tinno, ls_hocus_contactno, ls_hocus_gstnno, ls_hocus_panno, ls_hocus_gstncd, ls_hocus_tcsind
long ll_hocus_zip
datawindowchild idw_grade
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_cat, string fs_grade)
end prototypes

event ue_option();	choose case gs_ueoption
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'ld_licenseno')) or  len(dw_1.getitemstring(fl_row,'ld_licenseno'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'ld_particular')) or  len(dw_1.getitemstring(fl_row,'ld_particular'))=0)  then
	    messagebox('Warning: One Of The Following Fields Are Blank','License/Certificate Number, Particular, Please Check !!!')
		 return -1
	end if
	date ld_dt_1, ld_dt_2
	ld_dt_1 = date(dw_1.getitemdatetime(fl_row,'ld_exp_dt'))
	//ld_dt_2 = date('00/00/0000')
	if isnull(ld_dt_1) then
		 messagebox('Warning','Please Enter Expiry Date')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_cat, string fs_grade);long fl_row
string ls_tpc_id1, ls_grade1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tpc_id1 = dw_1.getitemstring(fl_row,'tpc_id')
		ls_grade1 = dw_1.getitemstring(fl_row,'tmp_id')
		
		if ls_tpc_id1 = fs_cat and ls_grade1 = fs_grade then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtedsf015.create
this.cb_10=create cb_10
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_10,&
this.cb_4,&
this.cb_2,&
this.dw_1}
end on

on w_gtedsf015.destroy
destroy(this.cb_10)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type cb_10 from commandbutton within w_gtedsf015
integer x = 32
integer y = 12
integer width = 521
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Import && Process"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_sn,ls_dt,ls_sild, ls_oldmail
string l_field0,l_field1,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9,l_field10,l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field20,l_field21,l_field22

//import start

setnull(ls_oldmail)
l_count = 0
l_fexit = GetFileOpenName("Select File", &
		+ ls_filename, lf_fnamed, "CSV", &
		+ "CSV Files (*.CSV),*.CSV")

lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

IF l_fexit = 1 THEN 	
	open(w_import_rows_information)
	l_flen = filelength(ls_filename) 
	l_fnum = fileopen(ls_filename)
	l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
			l_rec_val = l_byte
			l_rec_len = len(l_rec_val)
			l_rec_val = right(l_rec_val,l_rec_len)
			l_field0  = f_get_string_position(l_rec_val,',')
			l_field1    = f_get_string_position(l_rec_val,',')
			l_field2    = f_get_string_position(l_rec_val,',')
			l_field3    = f_get_string_position(l_rec_val,',')			
			l_field4    = f_get_string_position(l_rec_val,',')	
			l_field5    = f_get_string_position(l_rec_val,',')	
			l_field6    = f_get_string_position(l_rec_val,',')	
			l_field7    = f_get_string_position(l_rec_val,',')	
			l_field8    = f_get_string_position(l_rec_val,',')	
			l_field9    = f_get_string_position(l_rec_val,',')	
			l_field10    = f_get_string_position(l_rec_val,',')	
			l_field11    = f_get_string_position(l_rec_val,',')	
			l_field12    = f_get_string_position(l_rec_val,',')	
			l_field13    = f_get_string_position(l_rec_val,',')	
			l_field14    = f_get_string_position(l_rec_val,',')	
			l_field15    = f_get_string_position(l_rec_val,',')	
			l_field16    = f_get_string_position(l_rec_val,',')	
			l_field17    = f_get_string_position(l_rec_val,',')	
			l_field18    = f_get_string_position(l_rec_val,',')	
			l_field19    = f_get_string_position(l_rec_val,',')	
			l_field20    = f_get_string_position(l_rec_val,',')	
			l_field21    = f_get_string_position(l_rec_val,',')	
			l_field22    = f_get_string_position(l_rec_val,',')	
			 
			if l_count > 0 then 
				if len(l_field1) > 0 then
					select distinct 'x' into :ls_temp from fb_tcs_salebalance_imp where tsi_hocus_id = trim(:l_field20) and TSI_HOCUS_NAME = trim(:l_field0) and 
					TSI_BALANCE = to_number(trim(:l_field21)) and TSI_EXP_DATE = to_date(trim(:l_field22),'dd/mm/yyyy hh24:mi:ss');
					if sqlca.sqlcode = -1 then
						messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
					elseif sqlca.sqlcode = 0 then
						messagebox('Warning','Record no. '+ string(l_count)+ ' already exist in system') 
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
					end if
					insert into fb_tcs_salebalance_imp (TSI_HOCUS_ID, TSI_HOCUS_NAME, TSI_BALANCE, TSI_EXP_DATE, TSI_IMP_DATE, TSI_PST_IND, TSI_HOCUS_ADD, TSI_HOCUS_DESC, TSI_HOCUS_LSALETAXNO, TSI_HOCUS_CSALETAXNO, TSI_HOCITY_ID, TSI_HOCUS_STATEID, TSI_HOCUS_ZIP, TSI_HOCUS_EMAIL, TSI_HOCUS_FAX, TSI_HOCUS_TELEPHONE, TSI_HOCUS_WEBSITE, TSI_HOCUS_CONTACTPERSON, TSI_HOCUS_MOBILE, TSI_HOCUS_TINNO, TSI_HOCUS_CONTACTNO, TSI_HOCUS_GSTNNO, TSI_HOCUS_PANNO, TSI_HOCUS_GSTN_STCD, TSI_HOCUS_TCS_IND, TSI_ENTRY_BY, TSI_ENTRY_DT)
					values (trim(:l_field20),trim(:l_field0),to_number(trim(:l_field21)),to_date(:l_field22,'dd/mm/yyyy hh24:mi:ss'),sysdate,'N',trim(:l_field1),trim(:l_field2),trim(:l_field3),trim(:l_field4),trim(:l_field5),trim(:l_field6),to_number(trim(:l_field7)),trim(:l_field8),trim(:l_field9),trim(:l_field10),trim(:l_field11),trim(:l_field12),trim(:l_field13),trim(:l_field14),trim(:l_field15),trim(:l_field16),trim(:l_field17),trim(:l_field18),trim(:l_field19),:gs_user,sysdate);
								
					if sqlca.sqlcode = -1 then
						messagebox("SQL Error : At Insert ",SQLCA.SQLErrtext,Information!)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1
					end if
				end if		
			end if
			 
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
			
	loop
	//commit using sqlca;
	fileclose(l_fnum)
	close(w_import_rows_information)
else
	setpointer(arrow!) 
	messagebox("file","File Does Not Exists -> " + ls_filename)
	return 1
end if

//import complete

//process start

declare c1 cursor for
select TSI_HOCUS_ID, TSI_HOCUS_NAME, TSI_BALANCE, TSI_EXP_DATE, TSI_IMP_DATE, TSI_HOCUS_ADD, TSI_HOCUS_DESC, TSI_HOCUS_LSALETAXNO, TSI_HOCUS_CSALETAXNO, TSI_HOCITY_ID, TSI_HOCUS_STATEID, TSI_HOCUS_ZIP, TSI_HOCUS_EMAIL, TSI_HOCUS_FAX, TSI_HOCUS_TELEPHONE, TSI_HOCUS_WEBSITE, TSI_HOCUS_CONTACTPERSON, TSI_HOCUS_MOBILE, TSI_HOCUS_TINNO, TSI_HOCUS_CONTACTNO, TSI_HOCUS_GSTNNO, TSI_HOCUS_PANNO, TSI_HOCUS_GSTN_STCD, TSI_HOCUS_TCS_IND from 
fb_tcs_salebalance_imp where nvl(TSI_PST_IND,'N') = 'N' order by TSI_HOCUS_NAME ;

open c1;

if sqlca.sqlcode = 0 then
	setnull(ls_hocus_id); setnull(ls_hocus_name); ld_balance = 0; setnull(ld_expdt); setnull(ld_impdt) ; setnull(ls_hocus_add); setnull(ls_hocus_desc); setnull(ls_hocus_lsaletaxno); setnull(ls_hocus_csaletaxno); setnull(ls_hocity_id); setnull(ls_hocus_stateid); setnull(ll_hocus_zip); setnull(ls_hocus_email); setnull(ls_hocus_fax); setnull(ls_hocus_telephone); setnull(ls_hocus_website); setnull(ls_hocus_contactperson); setnull(ls_hocus_mobile); setnull(ls_hocus_tinno); setnull(ls_hocus_contactno);setnull(ls_hocus_gstnno);setnull(ls_hocus_panno);setnull(ls_hocus_gstncd);setnull(ls_hocus_tcsind);
	fetch c1 into :ls_hocus_id, :ls_hocus_name, :ld_balance, :ld_expdt, :ld_impdt, :ls_hocus_add, :ls_hocus_desc, :ls_hocus_lsaletaxno, :ls_hocus_csaletaxno, :ls_hocity_id, :ls_hocus_stateid, :ll_hocus_zip, :ls_hocus_email, :ls_hocus_fax, :ls_hocus_telephone, :ls_hocus_website, :ls_hocus_contactperson, :ls_hocus_mobile, :ls_hocus_tinno, :ls_hocus_contactno, :ls_hocus_gstnno, :ls_hocus_panno, :ls_hocus_gstncd, :ls_hocus_tcsind;
	
	if sqlca.sqlcode = 100 then
		messagebox('Warning','No records available for processing')
		rollback using sqlca;
		return 1;
	end if
	
	do while sqlca.sqlcode <> 100 	
		select distinct 'x' into :ls_temp from fb_customer where cus_hocusid = :ls_hocus_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking customer master' + sqlca.sqlerrtext)
			rollback using sqlca;
			return 1;
		elseif sqlca.sqlcode = 0 then 
			declare c2 cursor for 
			select cus_id from fb_customer where CUS_HOCUSID =  :ls_hocus_id;
		
			open c2;
			
			if sqlca.sqlcode = 0 then
				setnull(ls_cus_id);
				fetch c2 into :ls_cus_id;
				
					do while sqlca.sqlcode <> 100 
						insert into fb_tcs_limit_log(TL_CUS_CD, TL_DATE, TL_SALE_AMT) values(:ls_cus_id, :ld_impdt, :ld_balance);
						if sqlca.sqlcode = -1 then
							messagebox('Error','Error ocurred while inserting records : '+sqlca.sqlerrtext)
							rollback using sqlca;
							return 1;
						end if
						if ld_balance >= 5000000 then
							update fb_customer set CUS_TCS_IND = 'Y' where cus_id = :ls_cus_id;
							if sqlca.sqlcode = -1 then
								messagebox('Error','Error ocurred while updating records(tcs indicator) : '+sqlca.sqlerrtext)
								rollback using sqlca;
								return 1;
							end if				
						end if
						setnull(ls_cus_id);
						fetch c2 into :ls_cus_id;				
					loop
			end if
			close c2;
		elseif sqlca.sqlcode = 100 then
			setnull(ls_cus_id)
			select nvl(MAX(CUS_ID),0) into :ls_last from fb_customer;
			ls_last = right(ls_last,5)
			ll_cnt = long(ls_last) 
			select lpad(:ll_cnt + 1,5,'0') into :ls_count from dual;
			ls_cus_id = 'CUS'+ls_count
			insert into fb_customer(CUS_ID, CUS_NAME, CUS_DESC, CUS_ADD, CUS_TELEPHONE, CUS_MOBILE, CUS_FAX, CUS_EMAIL, CUS_WEBSITE, CUS_TYPE, CUS_ACTIVE, CITY_ID, CUS_REGISTERED, CUS_CONTACTPERSON, CUS_CONTACTNO, CUS_LSALETAXNO, CUS_CSALETAXNO, CUS_TINNO, CUS_STATEID, CUS_ZIP, CUS_ENTRY_BY, CUS_ENTRY_DT, CUS_PANNO, CUS_GSTNNO, CUS_GSTN_STCD, CUS_TCS_IND, CUS_HOCUSID)
			values(:ls_cus_id, :ls_hocus_name, :ls_hocus_desc, nvl(:ls_hocus_add,'x'), :ls_hocus_telephone, :ls_hocus_mobile, :ls_hocus_fax, :ls_hocus_email, :ls_hocus_website, '1','1',:ls_hocity_id,0,nvl(:ls_hocus_contactperson,'x'),:ls_hocus_contactno, nvl(:ls_hocus_lsaletaxno,'x'), nvl(:ls_hocus_csaletaxno,'x'), :ls_hocus_tinno, :ls_hocus_stateid, :ll_hocus_zip, :gs_user, sysdate, :ls_hocus_panno, :ls_hocus_gstnno, :ls_hocus_gstncd, :ls_hocus_tcsind, :ls_hocus_id);
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error occured while inserting into customer master : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
			end if
			
			insert into fb_tcs_limit_log(TL_CUS_CD, TL_DATE, TL_SALE_AMT) values(:ls_cus_id, :ld_impdt, :ld_balance);
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error ocurred while inserting records in tcs log : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
			end if
		end if
		
		setnull(ls_hocus_id); setnull(ls_hocus_name); ld_balance = 0; setnull(ld_expdt); setnull(ld_impdt) ; setnull(ls_hocus_add); setnull(ls_hocus_desc); setnull(ls_hocus_lsaletaxno); setnull(ls_hocus_csaletaxno); setnull(ls_hocity_id); setnull(ls_hocus_stateid); setnull(ll_hocus_zip); setnull(ls_hocus_email); setnull(ls_hocus_fax); setnull(ls_hocus_telephone); setnull(ls_hocus_website); setnull(ls_hocus_contactperson); setnull(ls_hocus_mobile); setnull(ls_hocus_tinno); setnull(ls_hocus_contactno);setnull(ls_hocus_gstnno);setnull(ls_hocus_panno);setnull(ls_hocus_gstncd);setnull(ls_hocus_tcsind);
		fetch c1 into :ls_hocus_id, :ls_hocus_name, :ld_balance, :ld_expdt, :ld_impdt, :ls_hocus_add, :ls_hocus_desc, :ls_hocus_lsaletaxno, :ls_hocus_csaletaxno, :ls_hocity_id, :ls_hocus_stateid, :ll_hocus_zip, :ls_hocus_email, :ls_hocus_fax, :ls_hocus_telephone, :ls_hocus_website, :ls_hocus_contactperson, :ls_hocus_mobile, :ls_hocus_tinno, :ls_hocus_contactno, :ls_hocus_gstnno, :ls_hocus_panno, :ls_hocus_gstncd, :ls_hocus_tcsind;
	loop
end if
close c1;

update fb_tcs_salebalance_imp set tsi_pst_ind = 'Y' where nvl(tsi_pst_ind,'N') = 'N';
if sqlca.sqlcode = -1 then
	messagebox('Error','Error ocurred while updating records(pst indicator) : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
end if		
commit using sqlca;
setpointer(arrow!) 
messagebox("Import File Information",'Total ' + string(l_count - 1) + ' Rows Imported and processed.....')
dw_1.retrieve()
	


end event

type cb_4 from commandbutton within w_gtedsf015
integer x = 827
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
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

type cb_2 from commandbutton within w_gtedsf015
integer x = 558
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
string text = "Run"
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

dw_1.retrieve()

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found, Please Check !!!')
	return 1
end if


end event

type dw_1 from datawindow within w_gtedsf015
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 116
integer width = 2373
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtedsf015"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

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

