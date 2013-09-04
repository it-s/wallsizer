import QtQuick 2.1
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import com.Likalo.MyThread 1.0

import "GUI/Theme/Fonts"
import "GUI/Theme"
import "GUI"

ApplicationWindow {
    id:app
    title: "Wallsizer"
    visible: true
    width: 360
    height: 360
    Fonts{}
    Variables{id:vars}
    Component.onCompleted:showIntro()

    function showIntro(){
        message.show(qsTr("Drag and drop images you wish to resize onto the window drop target"),999999)
        //message.show("images/WallpaperResizerHelpBanner.png",120000)
    }

    function pause(){
        indicator.show("PROCESS");
    }
    function resume(){
        indicator.hide();
    }
    function showConfig(){
        //        configWindow.saveIntoSameFolder = app.saveIntoSameFolder;
        //        configWindow.defaultSavePath = app.defaultSavePath;
        //        configWindow.alwaysAskWhereToSave = app.alwaysAskWhereToSave;
        if(!configWindow.visible)
            configWindow.show();
        //        configWindow.focusListAt(0);
    }
    Image {
        anchors.fill: parent
        fillMode: Image.Tile
        source: "images/diagonal-noise.png"
    }

    DropTargetArea {
        id:dropTargetArea
        anchors.fill: parent

    }

    IndicatorOverlay{
        id: indicator
        anchors.fill: parent
    }
    MessageOverlay{
        id: message
    }
    MyToolBar{
        id: toolbar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        onSettingsClicked: configWindow.show()
        onProcessClicked: {
            myThread.setUrls(dropTargetArea.urls);
            myThread.start();
        }


    }

        ConfigWindow{
            id: configWindow
        }

        MyThread{
            id:myThread
            onStarted:  indicator.show("PROCESS");
            onFinished: indicator.hide();
        }

    }

    //Wallsizer {
    //    id: app
    //    width: vars.span12
    //    height: vars.span12

    //    urlsToProcess: dropTargetArea.urls

    //    function showIntro(){
    //        message.show(qsTr("Drag and drop images you wish to resize onto the window drop target"),999999)
    //        //message.show("images/WallpaperResizerHelpBanner.png",120000)
    //    }

    //    function showConfig(){
    //        configWindow.saveIntoSameFolder = app.saveIntoSameFolder;
    //        configWindow.defaultSavePath = app.defaultSavePath;
    //        configWindow.alwaysAskWhereToSave = app.alwaysAskWhereToSave;
    //        if(!configWindow.visible)configWindow.show();
    //        configWindow.focusListAt(0);
    //    }

    //    function processImages(path){
    //        if(path==undefined&&app.alwaysAskWhereToSave&&!app.saveIntoSameFolder){
    //            fileDialog.open();
    //            return;
    //        }
    //        if(path!==undefined)app.tempSavePath = path;
    //        app.pricessUrls();
    //    }
    //    function pause(){
    //        enabled=false;
    //        indicator.show("PROCESS");
    //    }
    //    function resume(){
    //        enabled=true;
    //        indicator.hide();
    //    }

    //    Fonts{}
    //    Variables{id:vars}

    //    FileDialog {
    //        id: fileDialog
    //        selectFolder: true
    //        title: qsTr("Select Distanation Folder")
    //        onAccepted: processImages(fileUrl)
    //    }

    //    Image {
    //        anchors.fill: parent
    //        fillMode: Image.Tile
    //        source: "images/diagonal-noise.png"
    //    }

    //    DropTargetArea{
    //        id: dropTargetArea
    //        anchors.right: parent.right
    //        anchors.bottom: toolbar.top
    //        anchors.top: parent.top
    //        anchors.left: parent.left

    //        onCountChanged: if(count==0)showIntro()

    //        IndicatorOverlay{
    //            id: indicator
    //            anchors.fill: parent
    //        }
    //        MessageOverlay{
    //            id: message
    //        }
    //    }
    //    ToolBar{
    //        id: toolbar
    //        anchors.right: parent.right
    //        anchors.left: parent.left
    //        anchors.bottom: parent.bottom

    //    }

    //    ConfigWindow{
    //        id: configWindow
    //    }

    //    Component.onCompleted: showIntro()
    //    onResolutionsModelAdded: configWindow.focusListAt(app.resolutionsModelCount()-1)
    //    onResolutionsModelRemoved: configWindow.focusListAt(index)
    //    onProcessUrlsError: {resume(); message.show(qsTr("Error processing images.\nDescription: ")+error);}
    //    onProcessUrlsComplete: {resume(); message.show(qsTr("Images processed successfully."));}
    //}
