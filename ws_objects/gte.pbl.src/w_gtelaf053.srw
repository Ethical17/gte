$PBExportHeader$w_gtelaf053.srw
forward
global type w_gtelaf053 from window
end type
type dw_1 from datawindow within w_gtelaf053
end type
type cb_10 from commandbutton within w_gtelaf053
end type
type cb_8 from commandbutton within w_gtelaf053
end type
type cb_7 from commandbutton within w_gtelaf053
end type
type cb_9 from commandbutton within w_gtelaf053
end type
type cb_4 from commandbutton within w_gtelaf053
end type
type cb_3 from commandbutton within w_gtelaf053
end type
type cb_2 from commandbutton within w_gtelaf053
end type
type cb_1 from commandbutton within w_gtelaf053
end type
end forward

global type w_gtelaf053 from window
integer width = 5952
integer height = 2684
boolean titlebar = true
string title = "(w_gtelaf053) Birth Death Register Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_1 dw_1
cb_10 cb_10
cb_8 cb_8
cb_7 cb_7
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_gtelaf053 w_gtelaf053

type variables
long ll_ctr, ll_cnt,ll_year,ll_user_level,ll_count,ll_pfno,ll_paybook,ll_retage,ll_agediff
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id, ls_name,ls_fname, ls_nname, ls_add, ls_phone, ls_fax, ls_mobile, ls_email, ls_count, ls_last
string ls_contactp,ls_contacno,ls_cst,ls_lst,ls_field, ls_ele,ls_house,lab,ls_empno,ls_ref,ls_autopf
string ls_labour_id,ls_child_name,ls_child_gender,ls_dob, ls_sex, ls_house_no
string ls_sp_id,ls_spouse_name,ls_emp, ls_line_no
boolean lb_neworder, lb_query
datetime ld_dob, ld_doj, ld_dt, ld_dol,ld_dobpre,ld_labdob,ld_childdob
datawindowchild idw_paybook,idw_sptype,idw_labournm
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_house_no, string fs_line_no, long rownum)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0  then
	if (isnull(dw_1.getitemstring(fl_row,'emp_no')) or len(dw_1.getitemstring(fl_row,'emp_no')) = 0  or & 
	isnull(dw_1.getitemstring(fl_row,'line_no')) or len(dw_1.getitemstring(fl_row,'line_no')) = 0  or & 
	isnull(dw_1.getitemstring(fl_row,'divison')) or len(dw_1.getitemstring(fl_row,'divison')) = 0  or & 
	isnull(dw_1.getitemstring(fl_row,'status')) or len(dw_1.getitemstring(fl_row,'status')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'first_name')) or len(dw_1.getitemstring(fl_row,'first_name')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'last_name')) or len(dw_1.getitemstring(fl_row,'last_name')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'sex')) or len(dw_1.getitemstring(fl_row,'sex')) = 0  or &
	isnull(dw_1.getitemdatetime(fl_row,'dob')) or &
	isnull(dw_1.getitemstring(fl_row,'relation_of_emp')) or len(dw_1.getitemstring(fl_row,'relation_of_emp')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'cast_race')) or len(dw_1.getitemstring(fl_row,'cast_race')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'resident')) or len(dw_1.getitemstring(fl_row,'resident')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'physically_disabl')) or len(dw_1.getitemstring(fl_row,'physically_disabl')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'outside_add1')) or len(dw_1.getitemstring(fl_row,'outside_add1')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'outside_state')) or len(dw_1.getitemstring(fl_row,'outside_state')) = 0  or &
	isnull(dw_1.getitemdatetime(fl_row,'date_of_reg'))  or &
	isnull(dw_1.getitemstring(fl_row,'religion')) or len(dw_1.getitemstring(fl_row,'religion')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'maritial')) or len(dw_1.getitemstring(fl_row,'maritial')) = 0  or &
	isnull(dw_1.getitemstring(fl_row,'type_of_reg')) or len(dw_1.getitemstring(fl_row,'type_of_reg')) = 0  or &
	isnull(dw_1.getitemdatetime(fl_row,'status_as_on_dt')) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Emp No., Line No., Divison , Status, First Name, Last Name, Sex, D.O.B., Relation of Employee, Cast/Race, Resident, Physical Disability, Outside Address, '+ &
		 'Outsider State, Date Of Reg., Religion, Marital, Status as on Date. Please Check !!!')
		 return -1
	elseif dw_1.getitemstring(fl_row,'resident') = 'Y' and isnull(dw_1.getitemstring(fl_row,'house_no')) then
		messagebox('Warning','Resident Indicator is set to Yes but House No. is blank')
		return -1
	elseif dw_1.getitemstring(fl_row,'fath_wrkr') = 'Y' and isnull(dw_1.getitemstring(fl_row,'fath_wrkr_no')) then
		messagebox('Warning','Father Worker Indicator is set to Yes but Father Worker ID is blank')
		return -1
	elseif dw_1.getitemstring(fl_row,'moth_wrkr') = 'Y' and isnull(dw_1.getitemstring(fl_row,'moth_wrkr_no')) then
		messagebox('Warning','Mother Worker Indicator is set to Yes but Mother Worker ID is blank')
		return -1		
	elseif dw_1.getitemstring(fl_row,'relation_of_emp') = 'Other' and isnull(dw_1.getitemstring(fl_row,'oth_relation_emp')) then
		messagebox('Warning','Relation Of Employee set to Other but Other Relation is blank')
		return -1		
	end if  
end if
return 1   
end function

public function integer wf_check_duplicate_rec (string fs_house_no, string fs_line_no, long rownum);long fl_row
string ls_houseno, ls_lineno

//dw_1.SelectRow(0, FALSE)
//if dw_1.rowcount() > 1 then
//	for fl_row = 1 to (dw_1.rowcount())
//		IF fl_row <> rownum then
//			ls_houseno = dw_1.getitemstring(fl_row,'house_no')
//			ls_lineno = dw_1.getitemstring(fl_row,'line_no')
//			if ls_houseno = fs_house_no and ls_lineno = fs_line_no then
//				dw_1.SelectRow(fl_row, TRUE)
//				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
//				return -1
//			end if
//		end if
//	next
//end if
return 1

end function

on w_gtelaf053.create
this.dw_1=create dw_1
this.cb_10=create cb_10
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_10,&
this.cb_8,&
this.cb_7,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_gtelaf053.destroy
destroy(this.dw_1)
destroy(this.cb_10)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
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

type dw_1 from datawindow within w_gtelaf053
event key_down pbm_dwnrowchanging
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 140
integer width = 3790
integer height = 2404
integer taborder = 90
string title = "none"
string dataobject = "dw_gtelaf053"
boolean livescroll = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() and dw_1.rowcount() > 1 then	
		 ls_house_no = dw_1.getitemstring(currentrow,'house_no')
		 ls_line_no = dw_1.getitemstring(currentrow,'line_no')
//		IF wf_check_fillcol(currentrow) = -1 or wf_check_duplicate_rec(ls_house_no,ls_line_no,currentrow) = -1 THEN
//			return 1
//		END IF
		
		IF wf_check_fillcol(currentrow) = -1  THEN
			return 1
		END IF
		
//		select distinct 'x' into :ls_temp from fb_house_master where house_no = :ls_house_no and line_no = :ls_line_no;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Parameter Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox('Warning!','There~'s already house with House No. :'+ls_house_no+' in line : '+ls_line_no+'!!!')
//			return 1
//		end if
		
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'entry_by',gs_user)
		dw_1.setitem(newrow,'entry_dt',datetime(today()))
		
		dw_1.setcolumn('emp_no')
	end if
 end if
end if
end event

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event itemchanged;if lb_query = false then
	if dwo.name = 'fath_wrkr_no' then
		select distinct emp_name into :ls_temp from fb_employee where emp_id = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking Employee Master'+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning','No records found for this employee.')
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'father_nm',ls_temp)
		end if 
	end if
	
	if dwo.name = 'moth_wrkr_no' then
		select distinct emp_name into :ls_temp from fb_employee where emp_id = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking Employee Master'+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning','No records found for this employee.')
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'mother_nm',ls_temp)
		end if 
	end if
	
	if dwo.name = 'resident' then
		if data = 'N' then
			setnull(ls_temp)
			dw_1.setitem(row,'house_no',ls_temp)
		end if
	end if
	
	if dwo.name = 'fath_wrkr' then
		if data = 'N' then
			setnull(ls_temp)
			dw_1.setitem(row,'fath_wrkr_no',ls_temp)
			dw_1.setitem(row,'father_nm',ls_temp)
		end if
	end if
	
	if dwo.name = 'moth_wrkr' then
		if data = 'N' then
			setnull(ls_temp)
			dw_1.setitem(row,'moth_wrkr_no',ls_temp)
			dw_1.setitem(row,'mother_nm',ls_temp)
		end if
	end if
	
	if dwo.name = 'relation_of_emp' then
		if data <> 'Other' then
			setnull(ls_temp)
			dw_1.setitem(row,'oth_relation_emp',ls_temp)
		end if
	end if
	
	dw_1.setitem(row,'entry_by',gs_user)
	dw_1.setitem(row,'entry_dt',datetime(today()))
	cb_3.enabled = true
end if	


if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_birth_death_master');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_birth_death_master',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;

end event

type cb_10 from commandbutton within w_gtelaf053
integer x = 3264
integer y = 40
integer width = 142
integer height = 80
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrolltoRow(1)
end if
end event

type cb_8 from commandbutton within w_gtelaf053
integer x = 3401
integer y = 40
integer width = 142
integer height = 80
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollPriorRow()
end if
end event

type cb_7 from commandbutton within w_gtelaf053
integer x = 3538
integer y = 40
integer width = 142
integer height = 80
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gtelaf053
integer x = 3675
integer y = 40
integer width = 142
integer height = 80
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_4 from commandbutton within w_gtelaf053
integer x = 827
integer y = 28
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0  then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtelaf053
integer x = 562
integer y = 28
integer width = 265
integer height = 100
integer taborder = 40
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'house_no')) ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if lb_neworder = true then
		select nvl(MAX(bd_reg_id),0) into :ls_last from fb_birth_death_master;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			//ls_house_no = dw_1.getitemstring(ll_ctr,'house_no')
			//ls_line_no = dw_1.getitemstring(ll_ctr,'line_no')
			
//			IF wf_check_fillcol(ll_ctr) = -1 or wf_check_duplicate_rec(ls_house_no,ls_line_no,ll_ctr) = -1 THEN
//				return 1
//			END IF
			
			IF wf_check_fillcol(ll_ctr) = -1 THEN
				return 1
			END IF
			
//			select distinct 'x' into :ls_temp from fb_house_master where house_no = :ls_house_no and line_no = :ls_line_no;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Parameter Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 0 then
//				messagebox('Warning!','There~'s already house with House No. :'+ls_house_no+' in line : '+ls_line_no+'!!!')
//				return 1
//			end if
			

			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,5,'0') into :ls_count from dual;
				ls_tmp_id = 'BD'+ls_count
				dw_1.setitem(ll_ctr,'bd_reg_id',ls_tmp_id)
			end if

		next	
	end if

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtelaf053
integer x = 297
integer y = 28
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

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	//dw_1.settaborder('dtp_lotno',4)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('emp_no')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
	lb_neworder = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_garden_snm)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('emp_no',5)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf053
integer x = 32
integer y = 28
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

event clicked;
if lb_neworder = false then
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


if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.setcolumn('emp_no')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.setcolumn('emp_no')
end if


end event

