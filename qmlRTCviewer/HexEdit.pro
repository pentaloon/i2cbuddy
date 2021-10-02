TARGET = hexedit
QT += qml quick widgets

SOURCES += main.cpp binarydata.cpp loader.cpp \
    i2cdriver.c
HEADERS += binarydata.h loader.h \
    i2cdriver.h
OTHER_FILES += qml/HexEdit/main.qml qml/HexEdit/HexEdit.qml

RESOURCES += resources.qrc
