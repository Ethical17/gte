$PBExportHeader$gte.sra
$PBExportComments$Generated Application Object
forward
global type gte from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_filtertext,gs_sorttext,gs_ueoption,gs_path,gs_opt,gs_opt1, gs_emp_type,gs_inc_dt,gs_gstn_stcd,gs_gstnno, gs_opt2
string GS_USER_fname,gs_user_lname,GS_USER,gs_CO_ID, gs_unit,gs_garden_nm, gs_garden_snm,gs_garden_mail,gs_CO_name,gs_garden_nameadd,gs_garden_add,gs_supid,gs_storeid,gs_garden_state,gs_loginuser
boolean gb_validuserid,gb_retval, gb_retvalg
long gl_temp
string  gs_lfcr = char(13)
string gs_email_signature = "LUXMI TEA CO. LTD.,  "+gs_lfcr+"17, R.N. Mukherjee Road, "+gs_lfcr+"'Kishore Bhavan', "+gs_lfcr+"Kolkata - 700001 "+gs_lfcr+"W.B., India "+gs_lfcr+"Cell      : +91 9903804036 "+gs_lfcr+"Work  : +91 33 2248 9091 / 4437 / 4227 "+gs_lfcr+"Fax: +91 33 2243 0177 "+gs_lfcr+"Url: www.luxmigroup.in "
//+gs_lfcr+gs_lfcr+"===========================================================  "+gs_lfcr+"This is an auto generated mail.  "+gs_lfcr+ gs_lfcr+"For further assistance please contact vijay.pandey@obeetee.com ."+gs_lfcr+gs_lfcr+"This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. They may contain legally privileged information, and may not be disclosed to anyone else. If you have received this email in error please notify admin@obeetee.com and delete all copies from your system. This email has been scanned for all viruses by the Norton Antivirus. "

string gs_emp_pfno,gs_dedn_dt,gs_apr_ind,gs_emp_id,gd_loan_type,gs_vou_no,gs_dc_ind,gs_option,gs_db_pass,gs_db_id
double gd_int_rate,gd_int_amt,gd_amount,gd_loan_bal,gd_dedn_emi,ld_prorata_hours, gd_adv_amt
datetime gd_dt, gd_date
double gd_BILL_AMT, gd_CGST_PRCNT, gd_SGST_PRCNT, gd_IGST_PRCNT, gd_CGST_AMT, gd_SGST_AMT, gd_IGST_AMT
string gs_co_gstnno, gs_co_gstn_stcd, gs_party_gstin, gs_party_gstin_stcd, gs_revchg_ind, gs_revcatg, gs_panno
string gs_hsn_cd,gs_CGST_RECGL,gs_SGST_RECGL, gs_IGST_RECGL, gs_CGST_PAYGL, gs_SGST_PAYGL, gs_IGST_PAYGL,  gs_GST_SUNDRY_PAY	
string gs_CGST_RECSGL,gs_SGST_RECSGL, gs_IGST_RECSGL, gs_CGST_PAYSGL, gs_SGST_PAYSGL, gs_IGST_PAYSGL,  gs_GST_SUNDRY_PAYSGL,gs_party_sgl, gs_party_gl, gs_party_cd
double gd_selev_amt, gd_selpv_amt, gd_selav_amt
end variables

global type gte from application
string appname = "gte"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "22.2.0.3397"
boolean manualsession = false
boolean unsupportedapierror = true
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global gte gte

type variables
string ls_temp
integer li_flag
end variables

on gte.create
appname="gte"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on gte.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;string ls_username,ls_password,ls_option

string ls_sys_dt_format
 
RegistryGet("HKEY_CURRENT_USER\Control Panel\International","sShortDate", RegString!, ls_sys_dt_format)
if ls_sys_dt_format='dd/MM/yyyy' then
else
RegistrySet("HKEY_CURRENT_USER\Control Panel\International","sShortDate", RegString!, 'dd/MM/yyyy')
end if

//ls_option = 'HO'
//ls_option = 'MANUVALLEY'
//ls_option = 'GOLOKPUR'
//ls_option = 'MAKAIBARI'
ls_option = 'OTHERS'
//ls_option = 'KALAYANI'

choose case ls_option
	case  "MANUVALLEY" 
			open(w_manuvalley)
	case  "GOLOKPUR" 
			open(w_golokpur)
	case  "MAKAIBARI" 
//			ls_username = 'mkote' ; 	ls_password = 'mkote'    //	Makaibari Tea Estate	
			ls_username = 'msote' ; 	ls_password = 'msote'    //	Makaibari Tea Estate	Copy For Non PF
			
			gs_loginuser = ls_username
//			SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
			SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
//			SQLCA.DBMS = "ORA Oracle"
			SQLCA.LogPass = ls_username
              SQLCA.ServerName = "ltcdb"
//			SQLCA.ServerName = "ltcdbho"
			SQLCA.LogId = ls_password
			SQLCA.AutoCommit = False
			SQLCA.DBParm = ""
			
			connect using sqlca;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During Connect',sqlca.sqlerrtext);
				rollback using sqlca;
				return 
			end if
			
			open(w_welcome);
			
	case  "KALAYANI" 
		
			SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
			SQLCA.LogPass = "ltc"
			SQLCA.ServerName = "ltcdb"
			SQLCA.LogId = "ltc"
			SQLCA.AutoCommit = False
			SQLCA.DBParm = ""
			
			connect using sqlca;
			open(w_hologin)			
	case  "HO" 
			SQLCA.DBMS = "ORA Oracle"
			//SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
			SQLCA.LogPass = "luxmi"
			SQLCA.ServerName = "ltcdb"
 // 		SQLCA.ServerName = "ltcdbho"
			SQLCA.LogId = "luxmi"
			SQLCA.AutoCommit = False
			SQLCA.DBParm = ""
			
			connect using sqlca;
      	open(w_hologin)
			open(w_selectgarden)
			
	case else
			setnull(gs_db_id);setnull(gs_db_pass)
			RegistryGet("HKEY_LOCAL_MACHINE\Software\GTE", "id", RegString!,gs_db_id )
			RegistryGet("HKEY_LOCAL_MACHINE\Software\GTE", "pass", RegString!, gs_db_pass)
			
//			if len(gs_db_id) = 0 or isnull(gs_db_id) or gs_db_id="" then
				open(w_registered_garden)
//				if len(gs_db_id) = 0 or isnull(gs_db_id) or gs_db_id="" then
//					halt
//				end if
//			end if
				

			gs_loginuser = gs_db_id

			SQLCA.DBMS = "ORA Oracle"
			//SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
			SQLCA.LogPass = gs_db_pass
			SQLCA.ServerName = "ltcdb"
//			SQLCA.ServerName = "ltcdbo"
//			SQLCA.ServerName = "ltcdbho"
			SQLCA.LogId = gs_db_id
			SQLCA.AutoCommit = False
			SQLCA.DBParm = ""
			

			
			connect using sqlca;
			if sqlca.sqlcode = -1 then
				if messagebox('SQL Error : During Connect',sqlca.sqlerrtext+' Do you want to unregister the machine ?',question!,yesno!,1) = 1 then
					ls_temp = ""
					li_flag = RegistryDelete ("HKEY_LOCAL_MACHINE\Software\GTE",ls_temp)
					if li_flag = 1 then
						messagebox('Message','Machine unregistered successfully')
					elseif li_flag = -1 then
						messagebox('Message','Error occured while unregistering machine')
					end if
				end if
				rollback using sqlca;
				return 
			end if
			
			open(w_welcome);
	end choose

end event

