/***************************************************************************
 *   Copyright 2011 Marco Martin <mart@kde.org>                            *
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

#ifndef PLASMA_ACTIVITYCONFIG_H
#define PLASMA_ACTIVITYCONFIG_H

#include <Plasma/DeclarativeWidget>

class QDeclarativeItem;

class PlasmaAppletItemModel;
class BackgroundListModel;

namespace Plasma
{
    class Containment;
}

class ActivityConfiguration : public Plasma::DeclarativeWidget
{
    Q_OBJECT
    Q_PROPERTY(QString activityName READ activityName WRITE setActivityName)
    Q_PROPERTY(QObject *wallpaperModel READ wallpaperModel NOTIFY modelChanged)
    Q_PROPERTY(int wallpaperIndex READ wallpaperIndex WRITE setWallpaperIndex)
    Q_PROPERTY(QSize screenshotSize READ screenshotSize WRITE setScreenshotSize)

public:
    ActivityConfiguration(QGraphicsWidget *parent = 0);
    ~ActivityConfiguration();

    void setContainment(Plasma::Containment *cont);
    Plasma::Containment *containment() const;

    void setActivityName(const QString &name);
    QString activityName() const;

    QObject *wallpaperModel();

    int wallpaperIndex();
    void setWallpaperIndex(const int index);

    QSize screenshotSize();
    void setScreenshotSize(const QSize &size);

Q_SIGNALS:
    void modelChanged();

private:
    Plasma::Containment *m_containment;
    QDeclarativeItem *m_mainWidget;
    BackgroundListModel *m_model;
    int m_wallpaperIndex;
};

#endif //PLASMA_ACTIVITYCONFIG_H