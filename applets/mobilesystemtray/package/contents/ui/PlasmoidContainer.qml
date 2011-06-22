/*
 *   Copyright 2011 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
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

Item {
    id: plasmoidContainer
    width: 24
    anchors.top: tasksRow.top
    anchors.bottom: tasksRow.bottom

    property QGraphicsWidget applet
    onAppletChanged: {
        print(plasmoidContainer.applet)
        plasmoidContainer.applet.parent = plasmoidContainer
        plasmoidContainer.applet.x=0
    }

    onHeightChanged: {
        var ratio = plasmoidContainer.applet.size.width/plasmoidContainer.applet.size.height
        plasmoidContainer.applet.height = plasmoidContainer.height
        applet.width = ratio * height
        plasmoidContainer.width = plasmoidContainer.applet.width
    }
}