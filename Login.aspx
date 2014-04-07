<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .hiddencol { display: none; }

        #radio-demo input[type="radio"] {
           position:absolute;
           opacity: 0;

           -moz-opacity: 0;
           -webkit-opacity: 0;
           -o-opacity: 0;
        }

        #radio-demo input[type="radio"] + label {
           position:relative;
           padding: 5px 0 5px 30px;
           font-size: 16px;
           font: 12px Verdana;
           line-height: 50px;
           height: 40px;
           background-color: none;

           /*padding: 25px;*/
        }
        #radio-demo input[type="radio"] + label:before {
           content:"";
           display:block;
           position:absolute;
           top:1px;
           height: 20px;
           width: 20px;
           background: white;
           border: 1px solid black;
           box-shadow: inset 0px 0px 0px 5px white;
           -webkit-box-shadow: inset 0px 0px 0px 5px white;
           -moz-box-shadow: inset 0px 0px 0px 5px white;
           -o-box-shadow: inset 0px 0px 0px 5px white;
           -webkit-border-radius: 50%;
           -moz-border-radius: 50%;
           -o-border-radius: 50%;
           border-radius: 50%;
           /*box-shadow: 0 0 30px black;*/
        }
        #radio-demo input[type="radio"]:checked + label:before {
           background: #606060;
        }


        .round-button {
            display:block;
            width:50px;
            height:50px;
            line-height:50px;
            border: 1px solid #999999;
            border-radius: 50%;
            color:#444444;
            text-align:center;
            text-decoration:none;
            background: #EEEEEE;
            box-shadow: 0 0 8px black;
            font-size:40px;
            font-weight:bold;
        }
        p.round-button {
            width:52px;
            height:52px;
            border: 1px solid ;
            padding: 3px;
        }

        a.round-button:hover {

            box-shadow: 0 0 6px black;
            color:#222222;
        }
    </style>


    <script>

            window.onload = function () {

                if (window.location.href.indexOf('loginfailure') > 0) {
                    $(".xxx").css({ top: '100px' });
                    
                } else {
                    $(".xxx").animate({ "top": "+=400px" }, "slow");
                }

 
                //alert(document.URL);
                //alert(window.location.);

        
               // alert(window.location.href);
                //parent.location.hash = "loaded";
                //alert(this.href.toString());
                //var second = getUrlVars()["ReturnUrl"];
                //window.location = window.location + '?loaded';

                $('input:radio[name="radio-group"]').change( function () {

                    if ($(this).val() == 'login-user') {
                       
                        
                        $("#create-user").fadeOut("fast", function () {
                           // $("#create-user").css({ display: 'none' });
                            $("#login-user").fadeIn("slow").css("display", "inline-block");;
                            $("#kkk").animate({ "height": "220px" }, "fast");
                        });

                        
                    }
                    if ($(this).val() == 'create-user') {
                        //$("#login-user").css({ display: 'none' });
                        //$("#create-user").css({ display: 'inline-block' });
                        $("#login-user").fadeOut("fast", function () {

                            $("#create-user").fadeIn('slow').css("display", "inline-block");
                            $("#kkk").animate({ "height": "280px" }, "fast");
                        });
                        
                    }
                });

            
            }

            window.onbeforeunload = function () {
               // $(".xxx").animate({ "top": "-=400px" }, "slow");
            };
    </script>

   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Anvandarnamn, Traningsform.Namn FROM Pass LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID">

    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
    
    <asp:GridView style="margin-top:20px" ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True"  DataKeyNames="PassID">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"/>
            <asp:BoundField DataField="Datum" HeaderText="Datum"/>
            <asp:BoundField DataField="Namn" HeaderText="Namn" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Namn1" SortExpression="Namn1" />

        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle  Font-Bold="False" ForeColor="#444444" HorizontalAlign="Left" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="False" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="Silver" />
        <SortedDescendingCellStyle BackColor="#F7F7F7" />
        <SortedDescendingHeaderStyle BackColor="Silver" />
    </asp:GridView>

    <div id="kkk" class="xxx" style="height:220px; top:-300px; left:0px; background-color:#FEFEFE; position:fixed; width:100%; opacity:0.8; border:1px solid #AAAAAA; border-left:none; border-right:none;">
        <%--<asp:Button ID="Button2" runat="server" Text="Button" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" />
        <asp:LinkButton ID="LinkButton1" runat="server">LinkButton</asp:LinkButton>
        <input id="Button3" type="button" value="button" /><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/logga.png" OnClick="ImageButton1_Click" PostBackUrl="~/Default.aspx" />--%>
    </div>
    <div class="xxx" style="top:-300px; position:fixed; width:650px; margin: 0 auto;">
        <div id="login-user" style="padding-top:40px; background-color:none; display:inline-block; padding-left:20px; width:300px; height:240px; background-color:none; vertical-align:middle;">
            <asp:Login ID="Login1" runat="server" display="inline"  BorderPadding="4" Font-Names="Verdana" Font-Size="1.0em" DestinationPageUrl="~/User.aspx" TitleText="" FailureAction="RedirectToLoginPage" OnLoggedIn="loggedin" LoginButtonText="Logga in">
                <CheckBoxStyle Font-Size="Small" Height="30px" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                
                <LoginButtonStyle BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Width="150px" Height="24px"/>
                <TextBoxStyle BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" width="150px"/>
                <TitleTextStyle Font-Bold="False" Font-Size="1.4em"/>
                <LabelStyle Font-Size="Small" width="100px" />

            </asp:Login>
        </div>
        <div id="create-user" style="padding-top:40px; display:none; width:320px; height:240px; background-color:none; vertical-align:middle; ">
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" Font-Names="Verdana" OnCreatedUser="CreateUserWizard1_CreatedUser" style="display:inline;" CreateUserButtonText="Skapa användare">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" title=""/>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
                </WizardSteps>
                <CreateUserButtonStyle BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Width="150px" Height="24px" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
      
                <LabelStyle Font-Size="Small" width="130px"/>
      
                <TextBoxStyle BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" width="150px"/>
                <TitleTextStyle Font-Bold="False" Font-Size="1.4em" ForeColor="White"/>
            </asp:CreateUserWizard>
        </div>
        <div style="display:inline-block; position:relative; height:210px; background-color:none; vertical-align:middle;" id="radio-demo"> 
	        <input type="radio" name="radio-group" id="first-choice" value="login-user" checked="checked"/>
	        <label for="first-choice">Logga in</label><br/>
	        <input type="radio" name="radio-group" id="second-choice" value="create-user"/>
	        <label for="second-choice">Skapa användare</label><br/><br/>
            <asp:Button ID="Button1" runat="server" Text="Hoppa över" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Width="150px" Height="24px" OnClick="Button1_Click" />
        </div>
        
    </div>
</asp:Content>


