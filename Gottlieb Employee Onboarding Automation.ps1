#Defining path of current script (self)
if ($psISE)
{
    $path = Split-Path -Path $psISE.CurrentFile.FullPath        
}
else
{
    $path = $global:PSScriptRoot
}

#Importing Modules
Write-Output "Importing Modules..."
Import-Module ActiveDirectory

#Importing CSV containing list of users to be setup
Write-Output "Importing CSV..."
$users = Import-Csv `
-Delimiter "," `
-Path "$path\user_list.csv"

#Creating AD User Account(s)
$i = 1
foreach ($user in $users)
{
Write-Output "Creating AD User Account..." $i

#Checking CSV for User Type
#Defining User Type Variables
#Defining User AD Creation Path
#Defining AD GroupMembership Variables
if (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_APP_AR')
    {
        $search_base = "CN=Generic APP AR,OU=Insurance AR,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'genappar'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_AR')
    {
        $search_base = "CN=Generic AR,OU=Insurance AR,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Insurance AR,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'argeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Chart_Research')
    {
        $search_base = "CN=Generic Chart Research,OU=Chart Research,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Chart Research,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'crgeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Client_Serv_Support')
    {
        $search_base = "CN=Generic Client Serv Support,OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'Generic Client Serv'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_ClientServAdministrator')
    {
        $search_base = "CN=Generic ClientServAdministrator,OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'ClientServAdmin'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Coding')
    {
        $search_base = "CN=Generic Coding,OU=Coding,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Coding,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'codinggeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Contract_Analyst')
    {
        $search_base = "CN=Generic Contract Analyst,OU=Managed Care,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Managed Care,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'ContractAnalyst'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Contract_Specialist')
    {
        $search_base = "CN=Generic Contract Specialist,OU=Managed Care,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Managed Care,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'ContractSpecialist'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Correspondence')
    {
        $search_base = "CN=Generic Correspondence,OU=Correspondence,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Correspondence,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'corrgeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Credentialing')
    {
        $search_base = "CN=Generic Credentialing,OU=Credentialing,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Credentialing,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'credgeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_DevOps')
    {
        $search_base = "CN=Generic DevOps,OU=Development Operations,OU=IT,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Development Operations,OU=IT,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GenericDevOps'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_E4E_Coder')
    {
        $search_base = "CN=Generic E4E Coder,OU=Disabled - All Accounts,DC=MGADM"
        $path = "OU=Disabled - All Accounts,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GenE4ECoder'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Finance')
    {
        $search_base = "CN=Generic Finance,OU=Client Finance,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Client Finance,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'fingeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_FinanceAR')
    {
        $search_base = "CN=Generic FinanceAR,OU=Finance AR,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Finance AR,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'finargeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Front_End')
    {
        $search_base = "CN=Generic Front End,OU=Front End,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Front End,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'frontendgeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_HR')
    {
        $search_base = "CN=GenericHR,OU=Human Resources,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Human Resources,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GenericHR'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_ITOPS')
    {
        $search_base = "CN=Generic ITOPS,OU=IT Operations,OU=IT,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=IT Operations,OU=IT,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GenericITOPS'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Posting')
    {
        $search_base = "CN=Generic Posting,OU=Posting,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Posting,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'genericposting'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_PTSS')
    {
        $search_base = "CN=Generic PTSS,OU=PTSS,OU=MG2,DC=MGADM"
        $path = "OU=PTSS,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'genericptss'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Receptionist')
    {
        $search_base = "CN=GenericReceptionist,OU=Receptionist,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Receptionist,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GenericReceptionist'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Reconciliation')
    {
        $search_base = "CN=Generic Reconciliation,OU=Reconciliation,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Reconciliation,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'recongeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Refunds')
    {
        $search_base = "CN=Generic Refunds,OU=Refunds,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Refunds,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'genericrefunds'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Reg_Pract_Admin')
    {
        $search_base = "CN=Generic Reg Pract Admin,OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Client Services,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'regpractadmin'"
    }
elseif (@($users.PSObject.Properties)[4].Value-eq 'Gottlieb_Sorting')
    {
        $search_base = "CN=Generic Sorting,OU=Sorting,OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $path = "OU=Departments,OU=Jacksonville HQ,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'sortinggeneric'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'MLZ_Coder')
    {
        $search_base = "CN=Generic MLZ,OU=MLZ CODING,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=MLZ CODING,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'Generic MLZ'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'nTHRIVE_AR')
    {
        $search_base = "CN=genericARE4E,OU=AR,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=AR,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'genericARE4E'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'nTHRIVE_Bank_Reconciliation')
    {
        $search_base = "CN=GennthriveBRecon,OU=Bank Reconciliation,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Bank Reconciliation,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'GennthriveBRecon'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'nTHRIVE_Coder')
    {
        $search_base = "CN=Generic nTHRIVE Coding,OU=Coder,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Coder,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'Generic nTHRIVE Coding'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'nTHRIVE_Correspondence')
    {
        $search_base = "CN=Generic nTHRIVE Correspondence,OU=Correspondence,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Correspondence,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'CN=Generic nTHRIVE Correspondence'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'nTHRIVE_Poster')
    {
        $search_base = "N=Generic nTHRIVE Posters,OU=Posters,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Posters,OU=nTHRIVE,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'Generic nTHRIVE Posters'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'OMEGA_Coder')
    {
        $search_base = "CN=Generic OmegaCoder,OU=Coder,OU=OMEGA,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Coder,OU=OMEGA,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $user_type_memberships = Get-ADPrincipalGroupMembership "'Generic OmegaCoder'"
    }
elseif (@($users.PSObject.Properties)[4].Value -eq 'OMEGA_Poster')
    {
        $search_base = "CN=Generic Omega Posting,OU=Posters,OU=OMEGA,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = "OU=Posters,OU=OMEGA,OU=OFFSHORE,OU=MG2,DC=MGADM"
        $path = $search_base -split ',')[1..]
        $user_memberships = Get-ADPrincipalGroupMembership "'Generic Omega Posting'"
    }

$user_type = Get-ADUser -Filter * -SearchBase "$search_base" `
-Properties Enabled, Department, Title, Company, Manager, CannotChangePassword | `
select Enabled, Department, Title, Company, Manager, CannotChangePassword    

#Defining User variables
$enabled = $user_type.Enabled
$department = $user_type.Department
$title = $user_type.Title
$company = $user_type.Company
$manager = $user_type.Manager
$cannot_change_password = $user_type.CannotChangePassword
$GivenName = $users.Firstname
$Surname = $users.Lastname
$name = $GivenName + ' ' + $Surname
$sam_account_name = $Surname + $GivenNam.Substring(0,1)
$userprinciplename = $sam_account_name + '@gottlieb.com'

#Defining Password Policy
$alphabet = 'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
$numbers = 0..9
$special_characters = '!,#,*,(,),>,<,\,/'
$array = @()
$array += $alphabet.Split(',') | Get-Random -Count 4
$array[0] = $array[0].ToUpper()
$array[-1] = $array[-1].ToUpper()
$array += $numbers | Get-Random -Count 2
$array += $special_characters.Split(',') | Get-Random -Count 2
$password_policy = ($array | Get-Random -Count $array.Count) -join ""
$password = (ConvertTo-SecureString ($password_policy) -AsPlainText -Force)

#Write-Output "Checking if '$sam' SAMAccountName Exist..."
#$existing_sam_check = Get-ADUser $sam -LDAPFilter "(SamAccountName=$sam)"
    #if ($existing_sam_check -eq $null)
        #{
            #Write-Output "SamAccountName = Non-Existing, script will proceed..."
        #}
    #elseif ($sam = $ln + $fn.Substring(0,2) -eq $null)
        #{
            #Write-Output "SamAccountName = Existing, script correcting attempt #1..."
            #$sam = $ln + $fn.Substring(0,2)
        #}
    #elseif ($sam = $ln + $fn.Substring(0,3) -eq $null)
        #{
            #Write-Output "SamAccountName = Existing, script correcting attempt #2..."
            #$sam = $ln + $fn.Substring(0,3)
        #}

New-ADUser `
-Name $name `
-GivenName $GivenName `
-Surname $Surname `
-AccountPassword $password `
-CannotChangePassword $cannot_change_password `
-ChangePasswordAtLogon $True `
-SamAccountName $sam_account_name `
-Enabled $enabled `
-Path $path `
-UserPrincipalName $userprinciplename `
-DisplayName $name `
-Title $title `
-Department $dep `
-Company $company `
-Manager $mgr `

#Appending AD GroupMembership(s) to User
if (@($users.PSObject.Properties)[3].Value -eq '1-MLZ_Coder')
    {
        $mlz_coding_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '2-nTHRIVE_AR')
    {
        $nthrive_ar_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '3-nTHRIVE_Bank_Reconciliation')
    {
        $nthrive_bank_reconciliation_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '4-nTHRIVE_Coder')
    {
        $nthrive_coder_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '5-nTHRIVE_Correspondence')
    {
        $nthrive_correspondence_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '6-nTHRIVE_Poster')
    {
        $nthrive_poster_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '7-OMEGA_Coder')
    {
        $omega_coder_group_membership.name[1..10] | Add-ADGroupMember -Members $sam
    }
elseif (@($users.PSObject.Properties)[3].Value -eq '8-OMEGA_Poster')
    {
        $omega_poster_group_membership.name[1..10] | Add-ADGroupMember -Members $sam 
    }
$i = $i + 1
}
Write-Host 'Done! You may now exit'
