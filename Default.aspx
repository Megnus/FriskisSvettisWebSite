<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<style type="text/css">
  .hiddencol
  {
    display: none;
  }
</style>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Fornamn, Vikarie.Efternamn, Traningsform .Namn FROM Pass INNER JOIN Vikarie ON Vikarie.VikarieID = Pass.OrdinarieLedare JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID WHERE Pass.PassID = @Id">
            <SelectParameters>

            <asp:Parameter Name="Id" Type="Int64"/>

            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
        <asp:GridView style="margin-top:20px" ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" OnRowCommand="GridView2_RowCommand" DataKeyNames="PassID" OnRowDataBound="GridView2_RowDataBound">
        
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
</asp:Content>


