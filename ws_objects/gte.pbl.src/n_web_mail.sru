$PBExportHeader$n_web_mail.sru
forward
global type n_web_mail from nonvisualobject
end type
end forward

global type n_web_mail from nonvisualobject
end type
global n_web_mail n_web_mail

forward prototypes
public function boolean of_send_webmail_chilkat (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment)
public function boolean of_send_webmail (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment, string as_addattachment2)
public function boolean of_send_webmail_single (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment)
public function boolean of_send_webmail_noattachment (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc)
end prototypes

public function boolean of_send_webmail_chilkat (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment);
integer li_rc
oleobject loo_Mailman
oleobject loo_Email
integer li_Success

// This example requires the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

// The mailman object is used for sending and receiving email.
loo_Mailman = create oleobject
li_rc = loo_Mailman.ConnectToNewObject("Chilkat_9_5_0.MailMan")
if li_rc < 0 then
    destroy loo_Mailman
    MessageBox("Error","Connecting to COM object failed")
    return false
end if

// Set the SMTP server.
loo_Mailman.SmtpHost = "smtp.gmail.com"

loo_Mailman.SmtpUsername = "erpsupport@luxmigroup.in"
loo_Mailman.SmtpPassword = "12345@erp"

loo_Mailman.SmtpSsl = 1
loo_Mailman.SmtpPort = 465

// Create a new email object
loo_Email = create oleobject
li_rc = loo_Email.ConnectToNewObject("Chilkat_9_5_0.Email")

//olemessage.From = as_from
//olemessage.To = as_to
//if as_cc <> "" then
//	olemessage.cc = as_cc
//end if
//
////if trim(as_bcc) <> "" then
////	as_bcc = as_bcc + ";" + "sanjay.singh@obeetee.com"
////else
////	as_bcc  = "sanjay.singh@obeetee.com"
////end if
//
//olemessage.bcc = as_bcc 
//
//
//olemessage.addAttachment(as_addAttachment)
//
////("c:\reports\Etaexcp01.pdf")
//
//olemessage.Subject = as_sub
//olemessage.TextBody = as_mesg

loo_Email.Subject = "This is a test"
loo_Email.Body = "This is a test"
loo_Email.From = as_from
li_Success = loo_Email.AddTo(as_to)

li_Success = loo_Mailman.SendEmail(loo_Email)
if li_Success <> 1 then
//    Write-Debug loo_Mailman.LastErrorText
    destroy loo_Mailman
    destroy loo_Email
    return false
end if

li_Success = loo_Mailman.CloseSmtpConnection()
if li_Success <> 1 then
    messagebox ('Information',"Connection to SMTP server not closed cleanly.")
end if

messagebox ('Information !',"Mail Sent!")


destroy loo_Mailman
destroy loo_Email

//if (gs_attn_locn = 'DSR' or gs_attn_locn = 'PNPT' or gs_attn_locn= 'PDPP' or pos(as_to,'vrsharma@obeetee.com') > 0 or &
//	pos(as_to,'rajesh.kumar@obeetee.com') > 0 or pos(as_to,'sanjiva.gupta@obeetee.com') > 0 or &
//     pos(as_to,'mithilesh.kumar@obeetee.com') > 0 or pos(as_to,'malay.majumdar@obeetee.com') > 0 or &
//     pos(as_to,'rajesh.kapoor@obeetee.com') > 0 or pos(as_to,'manvinder.khera@obeetee.com') > 0 or &
//	pos(as_to,'mohd.khan@obeetee.com') > 0  ) then
//	olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "216.157.33.76"
//else
//	olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "192.168.201.92"
//	olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "smtp.gmail.com"
//	
////end if
//
////'Type of authentication, NONE, Basic (Base64 encoded), NTLM 
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").Value = 1 // Mean Basic 
//
////'Your UserID on the SMTP server 
////olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'obl.issue@obeetee.com'
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'erpsupport@luxmigroup.in'
//
//
////'Your password on the SMTP server 
////olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = 'obl.issue'
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = '12345@erp'
//
////'Server port (typically 25) 
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 25
////olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 465 
//
////'Use SSL for the connection (False or True) 
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl").Value = True 
//
//olefields.Update
//
//olemessage.Configuration = oleconfig 
//olemessage.From = as_from
//olemessage.To = as_to
//if as_cc <> "" then
//	olemessage.cc = as_cc
//end if
//
////if trim(as_bcc) <> "" then
////	as_bcc = as_bcc + ";" + "sanjay.singh@obeetee.com"
////else
////	as_bcc  = "sanjay.singh@obeetee.com"
////end if
//
//olemessage.bcc = as_bcc 
//
//
//olemessage.addAttachment(as_addAttachment)
//
////("c:\reports\Etaexcp01.pdf")
//
//olemessage.Subject = as_sub
//olemessage.TextBody = as_mesg
//olemessage.Fields.Update 
//
//olemessage.Send() 
//rtncode = olemessage.DisconnectObject() 
//messagebox("rtncode", rtncode) 
//
////try
////catch (OLERuntimeError myOLEError)
////messagebox("Error", string(myOLEError)+"OLERuntimeError~n~nThe notificationmail has not been sent")
////
////end try
//
//DESTROY oleconfig 
//DESTROY olemessage 
//
//MessageBox ( 'Information!', "Email Has Been Sucessfully Sent" )
//
Return True
end function

public function boolean of_send_webmail (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment, string as_addattachment2);setpointer(hourglass!)
OLEObject olemessage, oleconfig, olefields 
CONSTANT Long CDOSendUsingPort = 2 
int rtncode // return code 

// If your running this from the Mail Server then: 
// CDOSendUsingPort = 1 
// Change MailServer (name of your Mail Server) to localhost 

 olemessage = CREATE OLEObject 
 olemessage.ConnectToNewObject("CDO.Message") 

if rtncode <> 0 then 
	DESTROY oleconfig 
	messagebox("Error!", "Error has been occurred in creating CDO OLEObject, Check if the OS is Windows XP / Windows 2000") 
	return  False
end if 

oleconfig = CREATE OLEObject 
oleconfig.ConnectToNewObject("CDO.Configuration") 
olefields = oleconfig.Fields 

//olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing").Value = CDOSendUsingPort
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "smtp.office365.com"
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").Value = 1
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'erpsupport@luxmigroup.in'
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = 'Erp2024##'
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 25
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl").Value = true
//olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusetls").Value = true


olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing").Value = CDOSendUsingPort
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "smtp.office365.com"
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing").Value = CDOSendUsingPort
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").Value = 1 // Mean Basic
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'erpsupport@Luxmigroup.in'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = 'Erp2024##'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 25
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl").Value = true

olefields.Update

olemessage.Configuration = oleconfig 
olemessage.From = as_from
olemessage.To = as_to
if as_cc <> "" then
	olemessage.cc = as_cc
end if

olemessage.bcc = as_bcc 

//olemessage.addAttachment(as_addAttachment)
//olemessage.addAttachment(as_addAttachment2)

if not isnull(as_addAttachment) then
	olemessage.addAttachment(as_addAttachment)
end if 

if not isnull(as_addAttachment2) then
	olemessage.addAttachment(as_addAttachment2)
end if

olemessage.Subject = as_sub
olemessage.TextBody = as_mesg
olemessage.Fields.Update 

//olemessage.Send() 

try 
	olemessage.Send() 
catch(OLERuntimeError myOLEError)	
	messagebox("Error", myOLEError.description+"~nThe mail has not been sent")
	return false
end try

rtncode = olemessage.DisconnectObject() 

DESTROY oleconfig 
DESTROY olemessage 

MessageBox ( 'Information!', "Email Has Been Sucessfully Sent" )
setpointer(arrow!)

Return True
end function

public function boolean of_send_webmail_single (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc, string as_addattachment);setpointer(hourglass!)
OLEObject olemessage, oleconfig, olefields 
CONSTANT Long CDOSendUsingPort = 2 
int rtncode // return code 

// If your running this from the Mail Server then: 
// CDOSendUsingPort = 1 
// Change MailServer (name of your Mail Server) to localhost 

 olemessage = CREATE OLEObject 
 olemessage.ConnectToNewObject("CDO.Message") 

if rtncode <> 0 then 
	DESTROY oleconfig 
	messagebox("Error!", "Error has been occurred in creating CDO OLEObject, Check if the OS is Windows XP / Windows 2000") 
	return  False
end if 

oleconfig = CREATE OLEObject 
oleconfig.ConnectToNewObject("CDO.Configuration") 
olefields = oleconfig.Fields 

olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing").Value = CDOSendUsingPort
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "smtp.office365.com"
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").Value = 1
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'erpsupport@luxmigroup.in'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = 'Erp2024##'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 25
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl").Value = true


olefields.Update

olemessage.Configuration = oleconfig 
olemessage.From = as_from
olemessage.To = as_to
if as_cc <> "" then
	olemessage.cc = as_cc
end if

olemessage.bcc = as_bcc 

//olemessage.addAttachment(as_addAttachment)
//olemessage.addAttachment(as_addAttachment2)

if not isnull(as_addAttachment) then
	olemessage.addAttachment(as_addAttachment)
end if 

//if not isnull(as_addAttachment2) then
//	olemessage.addAttachment(as_addAttachment2)
//end if

olemessage.Subject = as_sub
olemessage.TextBody = as_mesg
olemessage.Fields.Update 

//olemessage.Send() 

try 
	olemessage.Send() 
catch(OLERuntimeError myOLEError)	
	messagebox("Error", myOLEError.description+"~nThe mail has not been sent")
	return false
end try

rtncode = olemessage.DisconnectObject() 

DESTROY oleconfig 
DESTROY olemessage 

MessageBox ( 'Information!', "Email Has Been Sucessfully Sent" )
setpointer(arrow!)

Return True
end function

public function boolean of_send_webmail_noattachment (string as_from, string as_to, string as_cc, string as_sub, string as_mesg, string as_bcc);setpointer(hourglass!)
OLEObject olemessage, oleconfig, olefields 
CONSTANT Long CDOSendUsingPort = 2 
int rtncode // return code 

// If your running this from the Mail Server then: 
// CDOSendUsingPort = 1 
// Change MailServer (name of your Mail Server) to localhost 

 olemessage = CREATE OLEObject 
 olemessage.ConnectToNewObject("CDO.Message") 

if rtncode <> 0 then 
	DESTROY oleconfig 
	messagebox("Error!", "Error has been occurred in creating CDO OLEObject, Check if the OS is Windows XP / Windows 2000") 
	return  False
end if 

oleconfig = CREATE OLEObject 
oleconfig.ConnectToNewObject("CDO.Configuration") 
olefields = oleconfig.Fields 

olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing").Value = CDOSendUsingPort
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value = "smtp.office365.com"
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").Value = 1
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername").Value = 'erpsupport@luxmigroup.in'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword").Value = 'Erp2024##'
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport").Value = 25
olefields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl").Value = true


olefields.Update

olemessage.Configuration = oleconfig 
olemessage.From = as_from
olemessage.To = as_to
if as_cc <> "" then
	olemessage.cc = as_cc
end if

olemessage.bcc = as_bcc 



olemessage.Subject = as_sub
olemessage.TextBody = as_mesg
olemessage.Fields.Update 

//olemessage.Send() 

try 
	olemessage.Send() 
catch(OLERuntimeError myOLEError)	
	messagebox("Error", myOLEError.description+"~nThe mail has not been sent")
	return false
end try

rtncode = olemessage.DisconnectObject() 

DESTROY oleconfig 
DESTROY olemessage 

MessageBox ( 'Information!', "Email Has Been Sucessfully Sent" )
setpointer(arrow!)

Return True
end function

on n_web_mail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_web_mail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

