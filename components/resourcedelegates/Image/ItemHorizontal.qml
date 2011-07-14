/*
 *   Copyright 2011 Marco Martin <mart@kde.org>
 *   Copyright 2011 Sebastian Kügler <sebas@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import Qt 4.7
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.qtextracomponents 0.1
import org.kde.plasma.mobilecomponents 0.1 as MobileComponents
 
Item {
    id: resourceItem
    anchors.fill: parent

    PlasmaCore.DataSource {
        id: pmSource
        engine: "preview"
       // connectedSources: [ url ]
        interval: 0
        Component.onCompleted: {
            pmSource.connectedSources = [url]
            previewFrame.visible = data[url]["status"] == "done"
            iconItem.visible = !previewFrame.visible
            previewImage.image = data[url]["thumbnail"]
        }
        onDataChanged: {
            previewFrame.visible = data[url]["status"] == "done"
            iconItem.visible = !previewFrame.visible
            previewImage.image = data[url]["thumbnail"]
        }
    }

    Item {
        id: itemFrame
        anchors {   bottom: parent.bottom;
                    top: parent.top;
                    left: parent.left;
                    right: parent.right;
                    margins: 0;
        }
        //height: 128
        height: resourceItem.height

        QIconItem {
            id: iconItem
            height: 64
            width: 64
            anchors.margins: 0
            anchors.horizontalCenter: parent.horizontalCenter

            function resourceIcon(resourceTypes) {
                if (mimeType) {
                    return mimeType.replace("/", "-")
                }
                return "nepomuk"
            }

            Component.onCompleted: {
                // FIXME: remove this crap, fix icon in metadata data set
                try {
                    if (!model["hasSymbol"]) {
                        icon = decoration
                        return
                    }
                    var _l = hasSymbol.toString().split(",");
                    if (_l.length == 1) {
                        icon = QIcon(hasSymbol);
                    } else if (_l.length > 1) {
                        // pick the last one
                        var _i = _l[_l.length-1];
                        icon = QIcon(_i);
                    } else {
                        //print("HHH types" + types.toString());
                        resourceIcon(types.toString())
                    }
                    //print("icon:" + hasSymbol);
                } catch(e) {
                    var _i = resourceIcon(className);
                    print("fallback icon: " + _i + e);
                    icon = QIcon(_i);
                    print("icon2:" + _i);
                }
            }
        }
        PlasmaCore.FrameSvgItem {
            imagePath: "widgets/media-delegate"
            prefix: "picture"
            id: previewFrame
            //height: width/1.6
            width: height*1.6
            visible: false
            anchors {
                /*left: parent.left
                right: parent.right*/
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: iconItem.bottom
            }
            QImageItem {
                id: previewImage
                anchors.fill: parent
                anchors.margins: previewFrame.margins.left
            }
        }


        Text {
            id: previewLabel
            text: label

            font.pixelSize: 14
            //wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            anchors.top: iconItem.bottom
            anchors.horizontalCenter: itemFrame.horizontalCenter
            width: 130
            style: Text.Outline
            styleColor: Qt.rgba(1, 1, 1, 0.6)
        }

        Text {
            id: infoLabel
            //image: metadataSource.data[DataEngineSource]["fileName"]
            //text: "the long and winding road..."
            text: className
            opacity: 0.8
            //font.pixelSize: font.pixelSize * 1.8
            font.pixelSize: 12
            height: 14
            width: parent.width - iconItem.width
            //wrapMode: Text.Wrap
            anchors.top: previewLabel.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: infoLabelVisible
        }
    }
}