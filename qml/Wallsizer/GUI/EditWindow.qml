import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

import "Theme"

Window {
    id: editWindow
    minimumWidth: vars.span12+vars.span1
    minimumHeight: vars.column(20)
    color: vars.bodyBackground

    title: qsTr("Edit Resolution")
    modality: Qt.ApplicationModal

    property variant resolution
    property int itemRow: -1
    property alias itemTitle: editItemTitle.text
    property alias itemWidth: editItemWidth.text
    property alias itemHeight: editItemHeight.text
    property alias itemCompression: editItemCompressionLevel.value
    property alias itemLowFilter: editItemLowFilter.currentIndex
    property alias itemMediumFilter: editItemMedFilter.currentIndex
    property alias itemHighFilter: editItemHigFilter.currentIndex
    property alias itemEnabled: editItemEnabled.checked
    property variant itemData

    signal saveClicked(variant data);

    ColumnLayout{
        id: mainLayout
        spacing: vars.em(1)
        anchors.margins: vars.column(1)
        anchors.fill: parent
        MyUIHeading{
            text: qsTr("Resolution Details")
            Layout.fillWidth: true
        }

        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Enabled")
                Layout.fillWidth: true
            }
            CheckBox {
                id: editItemEnabled
                style: MyUICheckBoxStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Title")
                Layout.fillWidth: true
            }
            TextField {
                id: editItemTitle
                placeholderText: qsTr("Resolution Title (VGA etc.)")
                width: vars.span6
                horizontalAlignment: TextInput.AlignRight
                style: MyUITextFieldStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Width:")
                Layout.fillWidth: true
            }
            TextField {
                id: editItemWidth
                placeholderText: qsTr("Resolution Width (1024 etc.)")
                width: vars.span6
                horizontalAlignment: TextInput.AlignRight
                style: MyUITextFieldStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Height:")
                Layout.fillWidth: true
            }
            TextField {
                id: editItemHeight
                placeholderText: qsTr("Resolution Height (768 etc.)")
                width: vars.span6
                horizontalAlignment: TextInput.AlignRight
                style: MyUITextFieldStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                Layout.fillWidth: true
                text: qsTr("JPEG quality")
            }
            MyUILabel{
                Layout.fillWidth: true
                text: editItemCompressionLevel.value+"%"
                width: vars.span6
                horizontalAlignment: TextInput.AlignRight
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Slider {
                id: editItemCompressionLevel
                stepSize: 5
                maximumValue: 100
                tickmarksEnabled: true
                Layout.fillWidth: true
                style: MyUISliderStyle{

                }
            }
        }

        MyUIAlert{
            Layout.fillWidth: true
            text: qsTr("0% - worst quality / 100% - best quality")
            iconName: "circle_info"
        }

        MyUIHeading{
            text: qsTr("Scaling Algorithm")
            Layout.fillWidth: true
        }

        MyUIAlert{
            Layout.fillWidth: true
            text: qsTr("Each image is analyzed prior to scaling to determine the detail level and apply the scaling accordigly")
            iconName: "circle_info"
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Low Detail")
                Layout.fillWidth: true
            }
            ComboBox {
                id: editItemLowFilter
                model: myThread.scalingMethodsModel()
                width: vars.span6
                style: MyUIComboBoxStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("Medium Detail")
                Layout.fillWidth: true
            }
            ComboBox {
                id: editItemMedFilter
                model: myThread.scalingMethodsModel()
                width: vars.span6
                style: MyUIComboBoxStyle{

                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            MyUILabel{
                text: qsTr("High Detail")
                Layout.fillWidth: true
            }
            ComboBox {
                id: editItemHigFilter
                model: myThread.scalingMethodsModel()
                width: vars.span6
                style: MyUIComboBoxStyle{

                }
            }
        }
        MyUISpacer{

        }

        RowLayout{
            Layout.alignment: Qt.AlignRight
            Button {
                text: qsTr("Cancel")
                onClicked: editWindow.close()
                style: MyUIButtonStyle{

                }
            }
            Button {
                id: settingsSave
                text: qsTr("Save")
                style: MyUIButtonStyle{

                }

                onClicked: {
                    var item = new Object;
                    item.title = editItemTitle.text;
                    item.width=editItemWidth.text*1;
                    item.height=editItemHeight.text*1;
                    item.compression=editItemCompressionLevel.value*1;
                    item.detailLow= editItemLowFilter.currentIndex;
                    item.detailMedium= editItemMedFilter.currentIndex;
                    item.detailHigh= editItemHigFilter.currentIndex;
                    item.enabled= editItemEnabled.checked;

                    editWindow.saveClicked(item)
                }


                isDefault: true
            }
        }
    }
}
