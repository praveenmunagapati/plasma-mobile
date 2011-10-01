/***************************************************************************
 *                                                                         *
 *   Copyright 2011 Sebastian Kügler <sebas@kde.org>                       *
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


#ifndef ABOUTAPP_H
#define ABOUTAPP_H

#include <KMainWindow>
#include "view.h"
//#include <kxmlguiwindow.h>


class AboutApp : public KMainWindow
{
    Q_OBJECT
public:
    AboutApp();
    virtual ~AboutApp();
    QString name();
    QIcon icon();
    KConfigGroup config(const QString &group = "Default");

    void setUseGL(const bool on);
    bool useGL() const;

private:
    AppView *m_widget;
};

#endif // ABOUTAPP_H