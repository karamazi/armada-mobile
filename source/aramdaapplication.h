#ifndef ARMADAAPPLICATION_H
#define ARMADAAPPLICATION_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "features/rootlogic.h"
#include "dataSources/clusterconnection.h"
#include "dataSources/offlinestorage.h"

class ArmadaApplication : public QGuiApplication
{
public:
    explicit ArmadaApplication(int &argc, char **argv);
    ~ArmadaApplication();

private:
    QQmlApplicationEngine* mQmlEngine;
    RootLogic* mRootLogic;
    ClusterConnection* mClusterConnection;
    OfflineStorage* mOfflineStorage;

    void connectComponents();
};

#endif // ARMADAAPPLICATION_H
