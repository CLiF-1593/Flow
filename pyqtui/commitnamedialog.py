import sys
from PyQt6 import QtGui

from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *

import mainui

import flow


class CommitDialog(QMainWindow):
    def __init__(self, parent):
        super(CommitDialog, self).__init__()

        self.centralwidget = QWidget()

        self.parent : mainui.Ui_MainWindow = parent

        self.bool = False
        self.resize(300, 200)
        self.verticalLayoutWidget = QWidget()
        self.verticalLayoutWidget.setObjectName(u"verticalLayoutWidget")
        self.verticalLayoutWidget.setGeometry(QRect(100, 100, 100, 100))

        self.verticalLayout = QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setObjectName(u"verticalLayout")
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)

        # For displaying confirmation message along with user's info.
        self.label = QLabel(self.centralwidget)

        # Keeping the text of label empty initially.
        self.label.setText("Please enter a summary and \ndescription for progress storage.")
        self.verticalLayout.addWidget(self.label)

        self.pushButton = QPushButton(self.centralwidget)
        self.pushButton.clicked.connect(self.takeinputs)
        self.verticalLayout.addWidget(self.pushButton)

        self.setCentralWidget(self.verticalLayoutWidget)
        self.retranslateUi(self)
        QMetaObject.connectSlotsByName(self)

    def hideEvent(self, event):
        self.bool = False
        self.label.setText("Please enter a summary and \ndescription for progress storage.")
        self.parent.setEnabled(True)
        

    def retranslateUi(self, MainWindow):
        _translate = QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.pushButton.setText(_translate("MainWindow", "Proceed"))

    def takeinputs(self):
        ###########################
        ###########################
        # ADD ADDITIONAL CODE HERE!#
        ###########################
        ###########################
        # summary, description stores as str
        _translate = QCoreApplication.translate

        if self.bool:
            flow.command(["commit", self.name, self.description])
            self.parent.SetUIData()
            self.hide()
        else:
            self.name, done1 = QInputDialog.getText(
                self, 'Input Dialog', 'Enter Name:')

            self.description, done2 = QInputDialog.getText(
                self, 'Input Dialog', 'Enter Description')

            self.bool = True
            self.pushButton.setText(_translate("MainWindow", "Done"))
            if done1 and done2:
                # Showing confirmation message along
                # with information provided by user.
                self.label.setText('Progress Saved Successfully\nName: '
                                   + str(self.name) + ', Description: ' + str(self.description))






    ################must replace space with _
