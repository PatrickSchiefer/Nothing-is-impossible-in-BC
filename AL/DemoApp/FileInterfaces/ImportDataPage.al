namespace PatrickSchiefer.IO;

page 50403 ImportData
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ImportData;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Content; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Clear)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.DeleteAll();
                end;
            }
            action(Import)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Import: Codeunit ImportData;
                begin
                    Import.ImportData();
                end;
            }
        }
    }
}