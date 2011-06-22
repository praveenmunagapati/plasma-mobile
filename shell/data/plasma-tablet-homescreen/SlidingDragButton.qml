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
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.mobilecomponents 0.1 as MobileComponents

 MobileComponents.MouseEventListener {
    id: panelDragButton

    PlasmaCore.Svg {
        id: iconSvg
        imagePath: "icons/dashboard"
    }

    PlasmaCore.SvgItem {
        svg: iconSvg
        elementId: "dashboard-show"
        width: height
        height: 32
        anchors {
            left: parent.left
            bottom:parent.bottom
        }
    }


    property int startY
    property int lastY
    property bool dragging: false

    onPressed: {
        if (mouse.y < height-200) {
            dragging = false
            return
        }
        dragging = true
        startY = mouse.screenY
        lastY = mouse.screenY
    }
    onPositionChanged: {
        if (dragging) {
            slidingPanel.y += (mouse.screenY - lastY)
            lastY = mouse.screenY
        }
    }
    onReleased: {
        if (!dragging) {
            dragging = false
            return
        }

        dragging = false
        slidingPanel.state = "none"
        //click on the handle area, hide
        if (mouse.y >= height-32 && Math.abs(mouse.screenY - startY) < 8) {
            slidingPanel.state = "Hidden"
        //more than 2/3 of the screen uncovered, full
        } else if (slidingPanel.height+slidingPanel.y > 2*slidingPanel.height/3) {
            slidingPanel.state = "Full"
        //more then 1/4 of the screen uncovered, taskbar
        } else if (slidingPanel.height+slidingPanel.y > slidingPanel.height/4) {
            slidingPanel.state = "Tasks"
        //screen mostly hidden: hide
        } else {
            slidingPanel.state = "Hidden"
        }
    }
}
