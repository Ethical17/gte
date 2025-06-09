$PBExportHeader$w_login_rights.srw
forward
global type w_login_rights from window
end type
type rb_3 from radiobutton within w_login_rights
end type
type rb_2 from radiobutton within w_login_rights
end type
type rb_1 from radiobutton within w_login_rights
end type
type cb_6 from commandbutton within w_login_rights
end type
type cb_5 from commandbutton within w_login_rights
end type
type cb_4 from commandbutton within w_login_rights
end type
type cb_3 from commandbutton within w_login_rights
end type
type cb_2 from commandbutton within w_login_rights
end type
type cb_1 from commandbutton within w_login_rights
end type
type dw_1 from datawindow within w_login_rights
end type
type gb_1 from groupbox within w_login_rights
end type
type dw_2 from datawindow within w_login_rights
end type
end forward

global type w_login_rights from window
integer width = 5390
integer height = 2376
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
dw_2 dw_2
end type
global w_login_rights w_login_rights

type variables
boolean lb_neworder, lb_query,lb_del

string ls_emp_name, ls_application,ls_npassword
long ll_emp_cd, ll_level,ll_row
datawindowchild dwc_screen
end variables

forward prototypes
protected function long wf_set_user_rights ()
public function long wf_get_rights (string fs_user)
public function integer wf_checked (string fs_application, string fs_module, string fs_screen, string fs_ind)
end prototypes

protected function long wf_set_user_rights ();string fs_apps,fs_module,fs_menu_name,fs_screen,fs_temp,fs_emp_cd
long fl_perm

setnull(fs_emp_cd); fl_perm = 0;
setnull(fs_apps);setnull(fs_module);setnull(fs_menu_name);setnull(fs_screen);setnull(fs_temp)

DECLARE c1 CURSOR FOR  
select RT_USER_ID,RT_APPLICATION,RT_MODULE,RT_MENU_NAME,RT_SCREEN,RT_PERMISSION  
  from fb_login_temp where nvl(RT_PERMISSION,0) <> 0;

open c1;
if sqlca.sqlcode = 0 then
	fetch c1 into :fs_emp_cd,:fs_apps,:fs_module,:fs_menu_name,:fs_screen,:fl_perm;
	do while sqlca.sqlcode <> 100
		
		select distinct 'x' into :fs_temp from fb_login_detail
		 where LD_USER_ID = :fs_emp_cd and LD_APPS = trim(:fs_apps) and
		 		 nvl(trim(LD_SCREEN),'x') = nvl(trim(:fs_screen),'x') ;


		if sqlca.sqlcode = 0 then
	
			update fb_login_detail 
			      set LD_MODULE = :fs_module,LD_MENU_DETAIL =:fs_menu_name,LD_PERMISSION = :fl_perm
			   where LD_USER_ID = :fs_emp_cd and LD_APPS = trim(:fs_apps) and nvl(trim(LD_SCREEN),'x') = nvl(trim(:fs_screen),'x') ;
					 
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error at : Rights Update',sqlca.sqlerrtext)
				return -1	
			end if
			
		elseif sqlca.sqlcode = 100 then
		
			insert into fb_login_detail (LD_USER_ID,LD_APPS,LD_MODULE,LD_SCREEN,LD_MENU_DETAIL,LD_PERMISSION)
			values (:fs_emp_cd,trim(:fs_apps),trim(:fs_module),trim(:fs_screen),trim(:fs_menu_name),:fl_perm);

			if sqlca.sqlcode = -1 then
				messagebox('Sql Error at : Rights Insert',sqlca.sqlerrtext)
				return -1	
			end if
		elseif sqlca.sqlcode = -1 then
			messagebox('Sql Error at : Rights Select',sqlca.sqlerrtext)
			return -1	
		end if
		
				setnull(fs_emp_cd); fl_perm = 0;
			setnull(fs_apps);setnull(fs_module);setnull(fs_menu_name);setnull(fs_screen);setnull(fs_temp)
			
		fetch c1 into :fs_emp_cd,:fs_apps,:fs_module,:fs_menu_name,:fs_screen,:fl_perm;
	loop
	close c1;
	
elseif sqlca.sqlcode = -1 then
	messagebox('Sql Error at Rights delete Of Emp',sqlca.sqlerrtext)
	return -1
end if

delete from fb_login_detail
 where (LD_USER_ID, LD_APPS, nvl(LD_SCREEN,'x')) in
 		 (select RT_USER_ID,rt_APPLICATION, nvl(RT_SCREEN,'x')
		    from fb_login_temp where nvl(Rt_PERMISSION,0) = 0 ) and
		  nvl(Ld_PERMISSION,0) > 0;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error at : Rights Delete',sqlca.sqlerrtext)
	return -1
end if

execute immediate "truncate table fb_login_temp" using sqlca;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error at Rights delete Of Emp',sqlca.sqlerrtext)
	return -1
end if

commit using sqlca;

return 1
end function

public function long wf_get_rights (string fs_user);execute immediate "truncate table fb_login_temp" using sqlca;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error at Rights delete Of Emp',sqlca.sqlerrtext)
	return -1
end if

insert into fb_login_temp (RT_USER_ID,RT_APPLICATION,RT_MODULE_IND,RT_MODULE,RT_MENU_NAME,RT_SCREEN_IND,  RT_SCREEN,RT_PERMISSION)
select :fs_user,LD_APPS,'Y',LD_MODULE,LD_MENU_DETAIL,'Y',LD_SCREEN,LD_PERMISSION  
    from fb_login_detail a
   where Ld_USER_ID = trim(upper(:fs_user)) ;

	if sqlca.sqlcode = -1 then
		messagebox('Sql Error at Rights Insert Of Emp',sqlca.sqlerrtext)
		return -1
	end if

 insert into fb_login_temp (RT_USER_ID,RT_APPLICATION,RT_MODULE_IND,RT_MODULE,RT_MENU_NAME,RT_SCREEN_IND,  RT_SCREEN,RT_PERMISSION)
 select :fs_user,LD_APPS,'N',LD_MODULE,LD_MENU_DETAIL,'N',LD_SCREEN,0
    from fb_login_detail a
   where Ld_USER_ID = 'ADMIN' and not exists (select * from fb_login_detail b
															 where Ld_USER_ID = trim(upper(:fs_user)) and nvl(a.Ld_APPs,'x') = nvl(b.Ld_APPs,'x') and 
																	 nvl(a.LD_SCREEN,'x') = nvl(b.LD_SCREEN,'x'));

	if sqlca.sqlcode = -1 then
		messagebox('Sql Error at Rights Insert Of All',sqlca.sqlerrtext)
		return -1
	end if

	commit using sqlca;

return 1

end function

public function integer wf_checked (string fs_application, string fs_module, string fs_screen, string fs_ind);long fl_row

if dw_2.rowcount() > 1 then 
   for fl_row = 1 to dw_2.rowcount()
		if ((dw_2.getitemstring(fl_row,'rt_application') = fs_application and dw_2.getitemstring(fl_row,'rt_module') = fs_module and fs_screen = 'ALL' ) or &
			 (dw_2.getitemstring(fl_row,'rt_application') = fs_application and dw_2.getitemstring(fl_row,'rt_module') = fs_module and dw_2.getitemstring(fl_row,'rt_screen') = fs_screen)) then
			  dw_2.setitem(fl_row,'rt_module_ind',fs_ind) 
			  dw_2.setitem(fl_row,'rt_screen_ind',fs_ind)
			
			if fs_ind = 'Y' then
				if (isnull(dw_2.getitemnumber(fl_row,'rt_permission')) or  dw_2.getitemnumber(fl_row,'rt_permission') = 0) then
					dw_2.setitem(fl_row,'rt_permission',3)
				end if
			else
				dw_2.setitem(fl_row,'rt_permission',0)
			end if
	   end if
   next 
end if

return 1
end function

on w_login_rights.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.dw_2=create dw_2
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1,&
this.dw_2}
end on

on w_login_rights.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
cb_2.enabled = false	
dw_2.settransobject(sqlca)
lb_del=false

cb_5.enabled = false
cb_6.enabled = false

gb_1.visible = false
rb_1.visible = false 
rb_2.visible = false
rb_3.visible = false
end event

type rb_3 from radiobutton within w_login_rights
integer x = 1161
integer y = 596
integer width = 197
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

event clicked;dw_2.setfilter('')
dw_2.filter()
end event

type rb_2 from radiobutton within w_login_rights
integer x = 1701
integer y = 596
integer width = 411
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Non-Permited"
end type

event clicked;dw_2.setfilter('rt_permission = 0')
dw_2.filter()
end event

type rb_1 from radiobutton within w_login_rights
integer x = 1358
integer y = 596
integer width = 343
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Permited"
end type

event clicked;dw_2.setfilter('rt_permission > 0')
dw_2.filter()
end event

type cb_6 from commandbutton within w_login_rights
integer x = 576
integer y = 576
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Update"
end type

event clicked;if dw_2.accepttext() = -1 then return;

if dw_2.update(true,false) = 1 then
	commit using sqlca;
	dw_2.resetupdate()
ELSE 
	ROLLBACK USING SQLCA;
	return
end if

dw_2.settransobject(sqlca)
dw_2.Retrieve()
CB_5.POSTEVENT(CLICKED!)
CB_5.POSTEVENT(CLICKED!)
cb_6.enabled = false

end event

type cb_5 from commandbutton within w_login_rights
integer x = 293
integer y = 576
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

event clicked;if cb_5.text = "&Query" then
	if dw_2.modifiedcount() > 0 then
	   if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
	      return 1
		end if
	end if
	lb_neworder = False
	dw_2.reset()
	lb_query = true
	dw_2.modify("datawindow.queryclear= yes")
	dw_2.Object.datawindow.querymode= 'yes'
	dw_2.modify('rt_module_ind.visible = false')
	dw_2.modify('rt_section_ind.visible=false')
	dw_2.modify('rt_screen_ind.visible=false')
	dw_2.settaborder('rt_application',5)
//	dw_2.settaborder('rt_menu_level',10)
	dw_2.settaborder('rt_menu_name',20)
	dw_2.SetFocus()
   cb_1.enabled = false
	cb_6.enabled = false
	cb_5.text = "&Run"
else
	lb_query = false
   dw_2.settransobject(sqlca)
	dw_2.Retrieve()
	dw_2.Object.datawindow.querymode = 'no'
//	dw_2.settaborder('rt_menu_level',0)
	dw_2.settaborder('rt_menu_name',0)
	dw_2.settaborder('rt_application',0)
	dw_2.modify('rt_module_ind.visible = true')
	dw_2.modify('rt_section_ind.visible=true')
	dw_2.modify('rt_screen_ind.visible=true')
	
//	dw_2.settaborder('rt_menu_level_ind',10)
//	dw_2.settaborder('rt_menu_ind',20)
//	dw_2.modify('rt_menu_level_ind.visible = true')
//	dw_2.modify('rt_menu_ind.visible = true')
//	dw_2.modify('rt_menu_detail_ind.visible = true')
	cb_1.enabled = true	
	cb_5.text = "&Query"
end if

end event

type cb_4 from commandbutton within w_login_rights
integer x = 279
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

event clicked;if cb_4.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
	   if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
	      return 1
		end if
	end if
	lb_neworder = False
	dw_1.reset()
	dw_2.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus()
   cb_1.enabled = false
	cb_2.enabled = false
	cb_4.text = "&Run"
else
	lb_query = false
   dw_1.settransobject(sqlca)
	dw_1.Retrieve()
	dw_1.Object.datawindow.querymode = 'no'
	if dw_1.rowcount() > 0 then
		dw_2.settransobject(sqlca)
	end if
	cb_1.enabled = true	
	cb_4.text = "&Query"
end if

end event

type cb_3 from commandbutton within w_login_rights
integer x = 818
integer y = 4
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

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_login_rights
integer x = 549
integer y = 4
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then return;
if dw_2.accepttext() = -1 then return;

if (isnull(dw_1.getitemstring(dw_1.getrow(),'user_id')) or isnull(dw_1.getitemstring(dw_1.getrow(),'password'))) then 
	messagebox('In Case Of New User','Following Fields Must Be Entered~rEmployee Name, Password')
	return
end if




if DW_1.UPDATE(true,false) = 1 then
	if dw_2.update(true,false) = 1 then
		dw_1.resetupdate()
		dw_2.resetupdate()
		if wf_set_user_rights() = -1 then
			rollback using sqlca;
		end if
		commit using sqlca;
	ELSE 
		ROLLBACK USING SQLCA;
		return
	END IF
end if

dw_1.reset()
dw_2.reset()

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

cb_2.enabled = false
cb_5.enabled = false
cb_6.enabled = false
gb_1.visible = false
rb_1.visible = false
rb_2.visible = false
rb_3.visible = false
end event

type cb_1 from commandbutton within w_login_rights
integer x = 9
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
	dw_2.reset()
end if

dw_1.settransobject(sqlca)
lb_neworder = true
cb_2.enabled = false	

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setcolumn('user_id')
else
	if (isnull(dw_1.getitemnumber(dw_1.getrow(),'user_id')) or isnull(dw_1.getitemstring(dw_1.getrow(),'USER_PASSWORD')) or isnull(dw_1.getitemstring(dw_1.getrow(),'USER_FIRST_NAME'))) then 
		messagebox('In Case Of New User','Following Fields Must Be Entered~rUser ID, Name, Password')
		return
	end if
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setcolumn('user_id')
end if


end event

type dw_1 from datawindow within w_login_rights
event ue_tab_to_enter pbm_dwnprocessenter
event key-down pbm_dwnrowchanging
integer x = 9
integer y = 112
integer width = 5294
integer height = 436
string dataobject = "dw_login_rights_head"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event itemchanged;if lb_neworder = true or lb_query = false then

	if dwo.name = 'user_id' then
		ls_emp_name = data
		
		select user_id into :ls_emp_name from fb_login where USER_ID = :ls_emp_name;
		
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error At Emp Code',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Error At Emp Code','Employee Not Is Already Present , Pls Check')
			return 1
		end if		
	elseif dwo.name = 'password' then
		ls_npassword=trim(data)
		
		if f_check_alphanumeric(ls_npassword) = -1 then 			
			return 1
		end if

		if len(ls_npassword) < 8 then
			Messagebox('Warning!','New Password Should Be Of Atleast 8 Characters !!!')			
			return 1
		end if
		
		
	else
		ls_emp_name = dw_1.getitemstring(dw_1.getrow(),'user_id')
	end if	
	
	if(lb_neworder = true) then
		dw_1.setitem( row, 'user_entry_by', gs_user)
		dw_1.setitem( row, 'user_entry_date', today())
	end if
	
	dw_1.setitem( row, 'USER_LAST_PASS_CHANGED', today())
	
	cb_2.enabled = true
	  
end if


end event

event doubleclicked;if row > 0 then
	wf_get_rights(dw_1.getitemstring(row,'user_id'))
	
		dw_2.visible = true
		dw_2.settransobject(sqlca)
		dw_2.retrieve()
		cb_5.enabled = true
		cb_6.enabled = true
		gb_1.visible = true
		rb_1.visible = true
		rb_2.visible = true
		rb_3.visible = true		
end if

end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()


DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_login');

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
												('fb_login',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

type gb_1 from groupbox within w_login_rights
integer x = 1138
integer y = 544
integer width = 992
integer height = 136
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Option"
end type

type dw_2 from datawindow within w_login_rights
event ue_tab_to_enter pbm_dwnprocessenter
event key-down2 pbm_dwnrowchanging
integer x = 9
integer y = 708
integer width = 4279
integer height = 1648
integer taborder = 40
string dataobject = "dw_login_rights_detail"
boolean vscrollbar = true
boolean livescroll = true
end type

event type long ue_tab_to_enter();Send(Handle(this),256,9,Long(0,0))
return 1
end event

event itemchanged;if lb_query = false then

if (dwo.name = 'rt_module_ind' ) then
	wf_checked(dw_2.getitemstring(row,'rt_application'),dw_2.getitemstring(row,'rt_module'),'ALL',data)
end if	

if dwo.name = 'rt_screen_ind' then
	if data = 'Y' then
		dw_2.setitem(row,'rt_permission',2)
	else
		dw_2.setitem(row,'rt_permission',0)
	end if
end if
	cb_2.enabled = true
	cb_6.enabled = true
end if	
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_login_temp');

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
												('fb_login_temp',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

