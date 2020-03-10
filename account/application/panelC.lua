--[[
iu = exports.interface

        applicationRequestPanel = guiCreateWindow(382, 76, 602, 181, "Application Request", false)
        guiWindowSetSizable(applicationRequestPanel, false)

        questionOne = guiCreateRadioButton(10, 50, 582, 15, "Question 1", false, applicationRequestPanel)
        guiRadioButtonSetSelected(qust1, true)
        questionTow = guiCreateRadioButton(10, 79, 582, 15, "Question 2", false, applicationRequestPanel)
        questionThree = guiCreateRadioButton(10, 109, 582, 15, "Question 3", false, applicationRequestPanel)
        theQuestion = guiCreateLabel(10, 33, 582, 17, "The question", false, applicationRequestPanel)
        guiSetFont(theQuestion, "default-bold-small")
        guiLabelSetHorizontalAlign(theQuestion, "center", false)
        guiLabelSetVerticalAlign(theQuestion, "center")
        nextBnt = guiCreateButton(254, 139, 94, 32, "Next", false, applicationRequestPanel)
        guiSetFont(nextBnt, "default-bold-small")  

        iu:convertUI(applicationRequestPanel)
        guiSetVisible( applicationRequestPanel, false )


        applicationMaker = guiCreateWindow(383, 259, 606, 272, "Application Question maker", false)
        guiWindowSetSizable(applicationMaker, false)

        TheQuestionEdit = guiCreateEdit(107, 35, 491, 28, "", false, applicationMaker)
        TheQuestlabel = guiCreateLabel(9, 35, 95, 22, "The QUESTION", false, applicationMaker)
        guiSetFont(TheQuestlabel, "default-bold-small")
        guiLabelSetHorizontalAlign(TheQuestlabel, "center", false)
        guiLabelSetVerticalAlign(TheQuestlabel, "center")
        qust1 = guiCreateLabel(55, 79, 106, 24, "Question1 :", false, applicationMaker)
        guiSetFont(qust1, "default-bold-small")
        guiLabelSetVerticalAlign(qust1, "center")
        qust1Edit = guiCreateEdit(125, 79, 473, 28, "", false, applicationMaker)
        qust2Edit = guiCreateEdit(125, 124, 473, 28, "", false, applicationMaker)
        qust3Edit = guiCreateEdit(125, 172, 473, 28, "", false, applicationMaker)
        qust2 = guiCreateLabel(55, 124, 106, 24, "Question2 :", false, applicationMaker)
        guiSetFont(qust2, "default-bold-small")
        guiLabelSetVerticalAlign(qust2, "center")
        qust3 = guiCreateLabel(55, 172, 106, 24, "Question3 :", false, applicationMaker)
        guiSetFont(qust3, "default-bold-small")
        guiLabelSetVerticalAlign(qust3, "center")
        createQustBnt = guiCreateButton(451, 210, 147, 48, "Create", false, applicationMaker)
        guiSetFont(createQustBnt, "default-bold-small")
        CloseBnt = guiCreateButton(9, 227, 36, 28, "Close", false, applicationMaker)    

        iu:convertUI(applicationMaker)
        guiSetVisible( applicationMaker, false )


        QustApplectionCreate = guiCreateWindow(190, 285, 277, 144, "Qust Create", false)
        guiWindowSetSizable(QustApplectionCreate, false)

        newBnt = guiCreateButton(19, 35, 113, 40, "New Qust", false, QustApplectionCreate)
        removeBnt = guiCreateButton(150, 35, 113, 40, "Remove Qust", false, QustApplectionCreate)
        closeCreateBnt = guiCreateButton(234, 101, 29, 32, "close", false, QustApplectionCreate)    

        iu:convertUI(QustApplectionCreate)
        guiSetVisible( QustApplectionCreate, false )


function openCreatePanel(  )
        guiSetVisible( QustApplectionCreate, true )
end
addCommandHandler( "createq", openCreatePanel)

function onClick ()

end
addEventHandler( "onClientGUIClick", root, onClick )

]]--