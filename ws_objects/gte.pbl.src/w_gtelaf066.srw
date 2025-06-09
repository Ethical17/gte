$PBExportHeader$w_gtelaf066.srw
forward
global type w_gtelaf066 from window
end type
type cb_2 from commandbutton within w_gtelaf066
end type
type cb_1 from commandbutton within w_gtelaf066
end type
type dw_2 from datawindow within w_gtelaf066
end type
type dw_1 from datawindow within w_gtelaf066
end type
end forward

global type w_gtelaf066 from window
integer width = 3776
integer height = 2300
boolean titlebar = true
string title = "(w_gtelaf066) Employee Master Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_gtelaf066 w_gtelaf066

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_user_level,l_count
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id
boolean lb_neworder, lb_query
double ld_price
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_field_id, datetime fl_frdt, datetime fl_todt, long rownum)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'field_id')) or  len(dw_1.getitemstring(fl_row,'field_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'fr_dt')) or  isnull(dw_1.getitemdatetime(fl_row,'to_dt')) or &
		 (isnull(dw_1.getitemnumber(fl_row,'no_of_entitled')))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Field ID, From Date, To Date, No. of Entitlement, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_field_id, datetime fl_frdt, datetime fl_todt, long rownum);return 1
end function

on w_gtelaf066.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_gtelaf066.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

type cb_2 from commandbutton within w_gtelaf066
integer x = 389
integer y = 24
integer width = 293
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Process"
end type

event clicked;dw_1.settransobject(sqlca)
string ls_emp_id,ls_ls_id,ls_old_ls_id

IF MessageBox("Employee Master  Alert", 'Do You Want To Process ....?' ,Exclamation!, YesNo!, 2) = 1 THEN
	setpointer(hourglass!)	
	
	setnull(ls_emp_id);setnull(ls_ls_id);setnull(ls_old_ls_id);
	DECLARE c1 CURSOR FOR  
	
	select a.EMP_ID, a.LS_ID,b.ls_id from fb_emp_temp a,fb_employee b where a.emp_id=b.emp_id and nvl(pst_ind,'N')='N';
	
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		
		fetch c1 into :ls_emp_id,:ls_ls_id,:ls_old_ls_id;
		
		do while sqlca.sqlcode <> 100
				
				update fb_employee set ls_id=:ls_ls_id where emp_id=:ls_emp_id;
				 if sqlca.sqlcode = -1 then
						messagebox("SQL Error",SQLCA.SQLErrtext,Information!)
						rollback;
						return -1
				end if
				
				insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
										('fb_employee',:ls_emp_id,'U','ls_Id',:ls_old_ls_id,:ls_ls_id,:gs_user,sysdate,'Bonus purpose');
				if sqlca.sqlcode = -1 then
						messagebox("SQL Error",SQLCA.SQLErrtext,Information!)
						rollback;
						return -1
				end if
				
				update fb_emp_temp set pst_ind='Y' where EMP_ID=:ls_emp_id and nvl(pst_ind,'N')='N';
				if sqlca.sqlcode = -1 then
						messagebox("SQL Error",SQLCA.SQLErrtext,Information!)
						rollback;
						return -1
				end if	
					
		setnull(ls_emp_id);setnull(ls_ls_id);setnull(ls_old_ls_id);
		fetch c1 into :ls_emp_id,:ls_ls_id,:ls_old_ls_id;
		loop
	END IF
	close c1;
	commit; 
	messagebox('Success',"DATA has been processed ...!")
end if
end event

type cb_1 from commandbutton within w_gtelaf066
integer x = 59
integer y = 20
integer width = 293
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Import"
end type

event clicked;integer l_fnum,l_loops,l_x
long l_flen,l_bytes_read,l_newpos,l_rec_len,l_max_ref_no,l_fexit
string l_byte,l_rec_val,ls_filename,lf_fnamed
string l_field1, lf_fnext

string             ls_pathname
long               ll_rc
oleobject        loo_excel
string lstr_currdata
integer c1
string ls_dsgncd
string ls_employee, ls_ls_id
 
l_fexit = GetFileOpenName("Select Product File", &
+ ls_filename, lf_fnamed, "CSV", & 
+ "All Files (*.*),*.*")

lf_fnext = upper(right(lf_fnamed, 4))
lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

if(lf_fnext = ".CSV") then  
	
	open(w_import_rows_information)
	
	 l_flen = filelength(ls_filename)
	 l_fnum = fileopen(ls_filename)
	 l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
		l_rec_val = l_byte
		l_rec_len = len(l_rec_val)
		l_rec_val = right(l_rec_val,l_rec_len)
				
		ls_employee	=	trim(f_get_string_position(l_rec_val,','))
		ls_ls_id	=	trim(f_get_string_position(l_rec_val,','))
				
		if(len(ls_employee)>0) then				 
			select distinct 'x' into :ls_temp from fb_employee where emp_id=:ls_employee ;
						if sqlca.sqlcode = 0 then		
							select distinct 'x' into :ls_temp from fb_laboursheet where LS_ID=:ls_ls_id and nvl(LS_ACTIVE_IND,'N') ='Y';
							if sqlca.sqlcode = 0 then
								
								insert into fb_emp_temp(EMP_ID, LS_ID, ENTRY_BY, ENTRY_DT,PST_IND) values (:ls_employee,:ls_ls_id,:gs_user,sysdate,'N');
								if sqlca.sqlcode = -1 then
									messagebox("SQL Error During Insert",SQLCA.SQLErrtext,Information!)
									close(w_import_rows_information)
									fileclose(l_fnum)
									rollback using sqlca ;
									return -1
								end if;
							else
								messagebox("Warning","Paybook is wrong for employee "+ls_employee + " Paybook No. "+ls_ls_id)
							end if
						else
							 messagebox("Warning","Employee code is wrong : "+ls_employee)
						end if;
			end if		
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
	loop
		commit using sqlca;
		close(w_import_rows_information)
		fileclose(l_fnum)
		messagebox("file","File Imported " + ls_filename + " Completed")
		dw_1.settransobject(sqlca)
		dw_1.retrieve('N')				
else 
	     loo_excel = CREATE OLEObject
		loo_excel.ConnectToNewObject( "excel.application" )
		loo_excel.visible = false
		loo_excel.workbooks.open( ls_filename )
		loo_excel.ActiveCell.CurrentRegion.Select()
		loo_excel.Selection.Copy()
		ll_rc = dw_2.ImportClipBoard ()
		ClipBoard('')
		loo_excel.workbooks.close()
		loo_excel.disconnectobject()
		DESTROY loo_excel
//		dw_1.settransobject(sqlca)
		dw_2.settransobject(sqlca)
			 if(dw_2.RowCount() > 0) then		 
			 	open(w_import_rows_information)
				  for c1 = 1 to dw_2.RowCount()
					
				 	ls_employee = trim(dw_2.GetItemString( c1 ,"EMP_ID" ))
					ls_ls_id = trim(dw_2.GetItemString( c1 ,"LS_ID" ))
					
					if len(ls_employee)>0 then
						
						select distinct 'x' into :ls_temp from fb_employee where emp_id=:ls_employee ;
						if sqlca.sqlcode = 0 then							
							
							select distinct 'x' into :ls_temp from fb_laboursheet where LS_ID=:ls_ls_id and nvl(LS_ACTIVE_IND,'N') ='Y';
							if sqlca.sqlcode = 0 then
								
								insert into fb_emp_temp(EMP_ID, LS_ID, ENTRY_BY, ENTRY_DT,PST_IND) values (:ls_employee,:ls_ls_id,:gs_user,sysdate,'N');
								if sqlca.sqlcode = -1 then
									messagebox("SQL Error During Insert",SQLCA.SQLErrtext,Information!)
									rollback using sqlca ;
									return -1
								end if;
							else
								messagebox("Warning","Paybook is wrong for employee "+ls_employee + " Paybook No. "+ls_ls_id)
							end if
						else
							 messagebox("Warning","Employee code is wrong : "+ls_employee)
						end if;
					end if
				 next
				 commit using sqlca;
				 close(w_import_rows_information)
				 messagebox("file","File Imported " + ls_filename + " Completed")
			else
				messagebox("file","File Does Not Exists -> " + ls_filename)
			end if
			dw_1.retrieve('N')
end if
end event

type dw_2 from datawindow within w_gtelaf066
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 132
integer width = 3698
integer height = 2052
integer taborder = 40
string dataobject = "dw_gtelaf066a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

type dw_1 from datawindow within w_gtelaf066
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 132
integer width = 3698
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf066"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

