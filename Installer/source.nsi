; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Flow"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Flow"
!define PRODUCT_WEB_SITE "https://github.com/CLiF-1593/Flow"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Flow.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "..\Icon\Logo.ico"
!define MUI_UNICON "..\Icon\Logo.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\main.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Korean"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Flow"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "..\PyGUI\dist\main\base_library.zip"
  File "..\PyGUI\dist\main\flow.cur"
  File "..\PyGUI\dist\main\Flow.exe"
  File "..\PyGUI\dist\main\libcrypto-1_1-x64.dll"
  File "..\PyGUI\dist\main\libssl-1_1-x64.dll"
  File "..\PyGUI\dist\main\logo.png"
  File "..\PyGUI\dist\main\main.exe"
  CreateDirectory "$SMPROGRAMS\Flow"
  CreateShortCut "$SMPROGRAMS\Flow\Flow.lnk" "$INSTDIR\main.exe"
  CreateShortCut "$DESKTOP\Flow.lnk" "$INSTDIR\main.exe"
  SetOutPath "$INSTDIR\PyQt6\Qt6\bin"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\MSVCP140.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\MSVCP140_1.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\MSVCP140_2.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\opengl32sw.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Core.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Gui.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Network.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Pdf.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Svg.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\Qt6Widgets.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\bin\VCRUNTIME140_1.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\plugins\generic"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\generic\qtuiotouchplugin.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\plugins\iconengines"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\iconengines\qsvgicon.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\plugins\imageformats"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qgif.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qicns.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qico.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qjpeg.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qpdf.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qsvg.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qtga.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qtiff.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qwbmp.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\imageformats\qwebp.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\plugins\platforms"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\platforms\qminimal.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\platforms\qoffscreen.dll"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\platforms\qwindows.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\plugins\styles"
  File "..\PyGUI\dist\main\PyQt6\Qt6\plugins\styles\qwindowsvistastyle.dll"
  SetOutPath "$INSTDIR\PyQt6\Qt6\translations"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_ar.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_bg.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_ca.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_cs.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_da.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_de.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_en.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_es.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_fa.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_fi.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_fr.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_gd.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_he.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_hr.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_hu.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_it.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_ja.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_ko.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_lv.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_nl.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_nn.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_pl.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_pt_BR.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_ru.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_sk.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_tr.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_uk.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_zh_CN.qm"
  File "..\PyGUI\dist\main\PyQt6\Qt6\translations\qtbase_zh_TW.qm"
  SetOutPath "$INSTDIR\PyQt6"
  File "..\PyGUI\dist\main\PyQt6\QtCore.pyd"
  File "..\PyGUI\dist\main\PyQt6\QtGui.pyd"
  File "..\PyGUI\dist\main\PyQt6\QtWidgets.pyd"
  File "..\PyGUI\dist\main\PyQt6\sip.cp37-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "..\PyGUI\dist\main\python3.dll"
  File "..\PyGUI\dist\main\python37.dll"
  File "..\PyGUI\dist\main\select.pyd"
  File "..\PyGUI\dist\main\style.st"
  File "..\PyGUI\dist\main\unicodedata.pyd"
  File "..\PyGUI\dist\main\VCRUNTIME140.dll"
  File "..\PyGUI\dist\main\_bz2.pyd"
  File "..\PyGUI\dist\main\_hashlib.pyd"
  File "..\PyGUI\dist\main\_lzma.pyd"
  File "..\PyGUI\dist\main\_socket.pyd"
  File "..\PyGUI\dist\main\_ssl.pyd"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Flow\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Flow\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Flow.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Flow.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\_ssl.pyd"
  Delete "$INSTDIR\_socket.pyd"
  Delete "$INSTDIR\_lzma.pyd"
  Delete "$INSTDIR\_hashlib.pyd"
  Delete "$INSTDIR\_bz2.pyd"
  Delete "$INSTDIR\VCRUNTIME140.dll"
  Delete "$INSTDIR\unicodedata.pyd"
  Delete "$INSTDIR\style.st"
  Delete "$INSTDIR\select.pyd"
  Delete "$INSTDIR\python37.dll"
  Delete "$INSTDIR\python3.dll"
  Delete "$INSTDIR\PyQt6\sip.cp37-win_amd64.pyd"
  Delete "$INSTDIR\PyQt6\QtWidgets.pyd"
  Delete "$INSTDIR\PyQt6\QtGui.pyd"
  Delete "$INSTDIR\PyQt6\QtCore.pyd"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_zh_TW.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_zh_CN.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_uk.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_tr.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_sk.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_ru.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_pt_BR.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_pl.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_nn.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_nl.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_lv.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_ko.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_ja.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_it.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_hu.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_hr.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_he.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_gd.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_fr.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_fi.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_fa.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_es.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_en.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_de.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_da.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_cs.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_ca.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_bg.qm"
  Delete "$INSTDIR\PyQt6\Qt6\translations\qtbase_ar.qm"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\styles\qwindowsvistastyle.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\platforms\qwindows.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\platforms\qoffscreen.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\platforms\qminimal.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qwebp.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qwbmp.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qtiff.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qtga.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qsvg.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qpdf.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qjpeg.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qico.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qicns.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\imageformats\qgif.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\iconengines\qsvgicon.dll"
  Delete "$INSTDIR\PyQt6\Qt6\plugins\generic\qtuiotouchplugin.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\VCRUNTIME140_1.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Widgets.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Svg.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Pdf.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Network.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Gui.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\Qt6Core.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\opengl32sw.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\MSVCP140_2.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\MSVCP140_1.dll"
  Delete "$INSTDIR\PyQt6\Qt6\bin\MSVCP140.dll"
  Delete "$INSTDIR\main.exe"
  Delete "$INSTDIR\logo.png"
  Delete "$INSTDIR\libssl-1_1-x64.dll"
  Delete "$INSTDIR\libcrypto-1_1-x64.dll"
  Delete "$INSTDIR\Flow.exe"
  Delete "$INSTDIR\flow.cur"
  Delete "$INSTDIR\base_library.zip"

  Delete "$SMPROGRAMS\Flow\Uninstall.lnk"
  Delete "$SMPROGRAMS\Flow\Website.lnk"
  Delete "$DESKTOP\Flow.lnk"
  Delete "$SMPROGRAMS\Flow\Flow.lnk"

  RMDir "$SMPROGRAMS\Flow"
  RMDir "$INSTDIR\PyQt6\Qt6\translations"
  RMDir "$INSTDIR\PyQt6\Qt6\plugins\styles"
  RMDir "$INSTDIR\PyQt6\Qt6\plugins\platforms"
  RMDir "$INSTDIR\PyQt6\Qt6\plugins\imageformats"
  RMDir "$INSTDIR\PyQt6\Qt6\plugins\iconengines"
  RMDir "$INSTDIR\PyQt6\Qt6\plugins\generic"
  RMDir "$INSTDIR\PyQt6\Qt6\bin"
  RMDir "$INSTDIR\PyQt6"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd