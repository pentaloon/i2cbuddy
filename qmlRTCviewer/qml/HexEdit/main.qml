import QtQuick 2.0
import HexEditor 1.0
import QtQuick.Controls
import QtQuick.Layouts 1.0

ApplicationWindow {
    width: 800
    height: 600
    title: "I2C Buddy"

    LoadData { id: load }

    Action {
        id: i2cRead
        shortcut: "Ctrl+R"
        onTriggered: {
            load.i2cRead(port.text, address.text, offset.text, length.text, hexModel)
        }
    }

    Action {
        id: searchFirstAction
        onTriggered: {
            hexModel.search(pattern.text, true)
        }
    }

    Action {
        id: searchNextAction
        onTriggered: {
            hexModel.search(pattern.text, false)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        RowLayout {
            width: parent.width
            TextField {
                id: port
                Layout.fillWidth: true
                placeholderText: "serial port"
                text: "/dev/ttyUSB0";
                onAccepted:  i2cRead.trigger()
                ToolTip.visible: hovered
                ToolTip.text:"serial port"
            }

            TextField {
                id: address
                Layout.fillWidth: true
                placeholderText: "address"
                text: "0x68";
                onAccepted:  i2cRead.trigger()
                ToolTip.visible: hovered
                ToolTip.text:"device address"
            }

            TextField {
                id: offset
                Layout.fillWidth: true
                placeholderText: "offset"
                text: "0";
                onAccepted:  i2cRead.trigger()
                ToolTip.visible: hovered
                ToolTip.text:"register offset"
            }

            TextField {
                id: length
                Layout.fillWidth: true
                placeholderText: "length"
                text: "64";
                onAccepted:  i2cRead.trigger()
                ToolTip.visible: hovered
                ToolTip.text:"data length"
            }

            Button {
                text: "read"
                action: i2cRead
                ToolTip.visible: hovered
                ToolTip.text:"read I2C bus (Ctrl+R)"
            }
        }

        GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            implicitWidth: 10

            HexEdit {
                id: editor
                anchors.fill: parent
                hexModel: HexModel {id: hexModel}
                visibleLines: 16
            }
        }

        RowLayout {
            CheckBox {
                text: "InsertMode"
                onClicked : {
                    if (checked)
                        hexModel.mode = HexModel.InsertMode
                    else
                        hexModel.mode = HexModel.BrowseMode
                }
            }
            Label{ text: "search: " }
            TextField {
                id: pattern
                placeholderText: "regular expression pattern"
                Layout.fillWidth: true
                onAccepted: {
                    searchFirstAction.trigger()
                }
            }

            Button {
                text: "FindFirst"
                action: searchFirstAction
            }
            Button {
                text: "FindNext"
                action: searchNextAction
            }
        }
    }
}
