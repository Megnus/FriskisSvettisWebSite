<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .hiddencol { display: none; }
    </style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Fornamn, Vikarie.Efternamn, Traningsform .Namn FROM Pass INNER JOIN Vikarie ON Vikarie.VikarieID = Pass.OrdinarieLedare JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID WHERE Pass.PassID = @Id">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int64"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
    
    <asp:GridView style="margin-top:20px" ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True"  DataKeyNames="PassID">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"/>
            <asp:BoundField DataField="Datum" HeaderText="Datum"/>
            <asp:BoundField DataField="Namn" HeaderText="Namn" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Namn1" SortExpression="Namn1" />
            <asp:ButtonField ButtonType="Button" CommandName="NejCommand" Text="Nej" />
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


        <div style="height:300px; top:20%; left:0px; background-color:#EEEEEE; position:fixed; width:100%; opacity:0.8; border:1px solid black;"></div>
        <div style="top:20%; position:fixed; width:650px; margin: 0 auto;">
            <div style=" display:block; width:350px;  margin: 0 auto;">
                <asp:Login ID="Login1" runat="server" display="inline"  BorderPadding="4" Font-Names="Verdana" Font-Size="1.0em" >
                    <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                    <LoginButtonStyle BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" />
                    <TextBoxStyle Font-Size="1.2em" BorderStyle="Solid" BorderWidth="1px" />
                    <TitleTextStyle Font-Bold="False" Font-Size="1.4em" ForeColor="White"/>
                </asp:Login>
            </div>
            <div style=" display:none; width:350px; margin: 0 auto; opacity:1.0;">
                <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" style="display:inline;">
                    <WizardSteps>
                        <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" />
                        <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
                    </WizardSteps>
                </asp:CreateUserWizard>
            </div>
        </div>
</asp:Content>


