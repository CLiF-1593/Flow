import sys

from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *

import happyhappyhappy
import branchselection
from branchselection import *
import conflictdialog
import branchselectionforreplace
import newsubdialog



class branch_menu(QMainWindow):
    def __init__(self):
        super(branch_menu, self).__init__()
        with open(
                file="./style.txt", mode="r"
        ) as f:
            self.setStyleSheet(f.read())
        self.fuckyeah = happyhappyhappy.happy()
        self.brepsel = branchselectionforreplace.branch_selection()

        self.r = newsubdialog.newsubDialog()

        self.bselection = branchselection.branch_selection()

        self.cd = conflictdialog.conflictDialog()

        self.centralwidget = QWidget()

        self.resize(300, 400)
        self.verticalLayoutWidget = QWidget()
        self.verticalLayoutWidget.setObjectName(u"verticalLayoutWidget")
        self.verticalLayoutWidget.setGeometry(QRect(100, 100, 100, 100))
        self.verticalLayout = QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setObjectName(u"verticalLayout")
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)

        # For displaying confirmation message along with user's info.
        self.label = QLabel(self.centralwidget)
        self.label.setText("Select an action.")
        self.verticalLayout.addWidget(self.label)

        self.NewSubBranchButton = QPushButton(self.centralwidget)
        self.NewSubBranchButton.clicked.connect(self.NewSubBranchButtonClicked)
        self.verticalLayout.addWidget(self.NewSubBranchButton)

        self.horizontalLayout = QHBoxLayout()
        self.horizontalLayout.setObjectName(u"horizontalLayout")

        self.MergeButton = QPushButton(self.centralwidget)
        self.MergeButton.clicked.connect(self.MergeButtonClicked)
        self.horizontalLayout.addWidget(self.MergeButton)

        self.ReplaceButton = QPushButton(self.centralwidget)
        self.ReplaceButton.clicked.connect(self.ReplaceButtonClicked)
        self.horizontalLayout.addWidget(self.ReplaceButton)

        self.verticalLayout.addLayout(self.horizontalLayout)

        self.DeleteButton = QPushButton(self.centralwidget)
        self.DeleteButton.clicked.connect(self.DeleteButtonClicked)
        self.verticalLayout.addWidget(self.DeleteButton)

        self.RenameButton = QPushButton(self.centralwidget)
        self.RenameButton.clicked.connect(self.RenameButtonClicked)
        self.verticalLayout.addWidget(self.RenameButton)




        self.setCentralWidget(self.verticalLayoutWidget)
        self.retranslateUi(self)
        QMetaObject.connectSlotsByName(self)

    def retranslateUi(self, MainWindow):
        _translate = QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Flow"))
        self.NewSubBranchButton.setText(_translate("MainWindow", "New Sub Branch"))
        self.MergeButton.setText(_translate("MainWindow", "Merge"))
        self.ReplaceButton.setText(_translate("MainWindow", "Replace"))
        self.DeleteButton.setText(_translate("MainWindow", "Delete"))
        self.RenameButton.setText(_translate("MainWindow", "Rename"))

    def NewSubBranchButtonClicked(self):
        ###########################
        ###########################
        # ADD ADDITIONAL CODE HERE!#
        ###########################
        ###########################
        print("NewSubBranchButtonClicked")
        self.r.show()
        self.hide()
    def MergeButtonClicked(self):
        ###########################
        ###########################
        # ADD ADDITIONAL CODE HERE!#
        ###########################
        ###########################
        print("MergeButtonClicked")
        self.bselection.show()
        self.hide()
    def ReplaceButtonClicked(self):
        ###########################
        ###########################
        # ADD ADDITIONAL CODE HERE!#
        ###########################
        ###########################
        print("ReplaceButtonClicked")
        self.brepsel.show()
        self.hide()
    def DeleteButtonClicked(self):
        ###########################
        ###########################
        # ADD ADDITIONAL CODE HERE!#
        ###########################
        ###########################
        print("DeleteButtonClicked")
        self.fuckyeah.show()
        self.hide()

    def RenameButtonClicked(self):
        name, done1 = QInputDialog.getText(
            self, 'Input Dialog', 'Enter New Name:')

        if done1:
            self.label.setText('Progress Saved Successfully\nName: '+str(name))

        print("RenameButtonClicked")
        self.fuckyeah.show()
        self.hide()


if __name__ == '__main__':
    # Create the QApplication
    app = QApplication(sys.argv)
    window = branch_menu()
    window.show()

    sys.exit(app.exec())