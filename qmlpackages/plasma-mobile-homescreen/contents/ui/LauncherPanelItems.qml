/***************************************************************************
 *   Copyright 2010 Alexis Menard <menard@kde.org>                         *
 *   Copyright 2010 Artur Duque de Souza <asouza@kde.org>                  *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import Qt 4.7

Flow {
    id: shortcuts;
    spacing: 45;

    anchors.horizontalCenter: parent.horizontalCenter;
    anchors.bottom: parent.bottom;

    Item {
        id: spacer1
        width: internet.width/2;
        height: internet.height;
        visible:false
    }
    Item {
        objectName: "2";
        id: icon
        signal clicked;

        width: internet.width;
        height: internet.height;

        Image {
            id: internet;
            source: homeScreenPackage.filePath("images", "internet.png")
        }
    }

    Item {
        objectName: "3";
        signal clicked;

        width: instantmessaging.width;
        height: instantmessaging.height;

        Image {
            id: instantmessaging;
            source: homeScreenPackage.filePath("images", "im.png")
        }

    }
    
    Item {
        id: spacer2
        width: internet.width/2;
        height: internet.height;
        visible:false
    }

    Item {
        objectName: "4";
        signal clicked;

        width: phone.width;
        height: phone.height;

        Image {
            id: phone;
            source: homeScreenPackage.filePath("images", "phone.png")
        }

    }

    Item {
        objectName: "5";
        signal clicked;

        width: social.width;
        height: social.height;

        Image {
            id: social;
            source: homeScreenPackage.filePath("images", "internet.png")
        }

    }

    Item {
        objectName: "6";
        signal clicked;

        width: games.width;
        height: games.height;

        Image {
            id: games;
            source: homeScreenPackage.filePath("images", "games.png")
        }

    }

    states: [
        State {
            name: "expanded";
            PropertyChanges {
                target: shortcuts
                //FIXME: hardcoded values
                width: 750
            }
            PropertyChanges {
                target: spacer1
                visible: false
            }
            PropertyChanges {
                target: spacer2
                visible: false
            }
        },
        State {
            name: "compact";
            PropertyChanges {
                target: shortcuts
                width: 475
            }
            PropertyChanges {
                target: spacer1
                visible: true
            }
            PropertyChanges {
                target: spacer2
                visible: true
            }
        }
    ]
}