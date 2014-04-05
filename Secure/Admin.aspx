<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
    <asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, Traningsform .Namn FROM Pass INNER JOIN Vikarie ON Vikarie.VikarieID = Pass.OrdinarieLedare JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID WHERE Pass.PassID = @Id">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int64"/>
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
    <asp:GridView ID="GridView2" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="True">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" InsertVisible="False" ReadOnly="True" Visible="True"/>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn" HeaderText="Namn" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Namn1" SortExpression="Namn1" />
            <asp:ButtonField ButtonType="Button" CommandName="NejCommand" Text="Nej" />
        </Columns>
    </asp:GridView>
</asp:Content>


