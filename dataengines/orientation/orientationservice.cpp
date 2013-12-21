/*
 *   Copyright 2012 Jeremy Whiting <jpwhiting@kde.org>
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

#include "orientationservice.h"
#include "orientationjob.h"

OrientationService::OrientationService(Plasma::DataContainer *source)
    : m_source(source)
{
    setName("orientation");
}

Plasma::ServiceJob *OrientationService::createJob(const QString &operation, QMap<QString, QVariant> &parameters)
{
    Plasma::ServiceJob *sjob = new OrientationJob(
                                          m_source->data().value("orientation").toInt(),
                                          operation,
                                          parameters,
                                          this);
    connect(sjob, SIGNAL(dataChanged(int)),
            this, SLOT(onDataChanged(int)));
    return sjob;
}

void OrientationService::onDataChanged(int value)
{
    m_source->setData("Rotation", value);
    m_source->forceImmediateUpdate();
}

#include "orientationservice.moc"