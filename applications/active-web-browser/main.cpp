/***************************************************************************
 *                                                                         *
 *   Copyright 2011 Sebastian Kügler <sebas@kde.org>                       *
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

#include <iostream>

// KDE
#include <KApplication>
#include <KAboutData>
#include <KCmdLineArgs>
#include <KDebug>
#include <KDE/KLocale>
#include <KToolBar>

// Own
#include "rekonqactive.h"

static const char description[] = I18N_NOOP("Web browser for Plasma Active");

static const char version[] = "0.1";
static const char HOME_URL[] = "http://community.kde.org/Plasma/Active";

void output(const QString &msg)
{
    std::cout << msg.toLocal8Bit().constData() << std::endl;
}

int main(int argc, char **argv)
{
    // FIXME: selkie icon instead of internet-web-browser
    KAboutData about("internet-web-browser", 0, ki18n("Rekonq Active"), version, ki18n(description),
                     KAboutData::License_GPL, ki18n("Copyright 2011 Sebastian Kügler"), KLocalizedString(), 0, "sebas@kde.org");
                     about.addAuthor( ki18n("Sebastian Kügler"), KLocalizedString(), "sebas@kde.org" );
    KCmdLineArgs::init(argc, argv, &about);

    KService::Ptr service = KService::serviceByDesktopName("active-web-browser");
    const QString homeUrl = service ? service->property("X-KDE-PluginInfo-Website", QVariant::String).toString() : HOME_URL;
    KCmdLineOptions options;
    options.add("+[url]", ki18n( "URL to open" ), homeUrl.toLocal8Bit());
    KCmdLineArgs::addCmdLineOptions(options);
    KApplication app;

    KCmdLineArgs *args = KCmdLineArgs::parsedArgs();

    //kDebug() << "ARGS:" << args << args->count();
    const QString url = args->count() ? args->arg(0) : homeUrl;
    output("Starting Rekonq Active..." + url);
    RekonqActive *mainWindow = new RekonqActive(url);
    mainWindow->show();
    args->clear();
    return app.exec();
}