#include "aramdaapplication.h"
#include <QQmlContext>

ArmadaApplication::ArmadaApplication(int& argc, char** argv)
    : QGuiApplication(argc, argv)
{
    qDebug() << "App initializing";
    mQmlEngine = new QQmlApplicationEngine;
    mRootLogic = new RootLogic;
    mClusterConnection = new ClusterConnection;
    mOfflineStorage = new OfflineStorage;

    connectComponents();
    mOfflineStorage->loadSavedConfig();

    mQmlEngine->rootContext()->setContextProperty("_root_logic", mRootLogic);
    mQmlEngine->load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    qDebug() << "App started";
}

ArmadaApplication::~ArmadaApplication()
{
    delete mQmlEngine;
    delete mRootLogic;
    delete mClusterConnection;
}

void ArmadaApplication::connectComponents()
{
    connect(mRootLogic->clusterLogic(), SIGNAL(clusterInstancesListRequested(QString)),
            mClusterConnection, SLOT(onClusterInstancesListRequested(QString)));
    connect(mClusterConnection, SIGNAL(clusterInstancesListLoaded(InstancesListData)),
            mRootLogic->clusterLogic(), SLOT(onClusterInstancesListLoaded(InstancesListData)));
    connect(mClusterConnection, SIGNAL(clusterRequestError(QString)),
            mRootLogic->clusterLogic(), SLOT(onClusterRequestError(QString)));
    connect(mRootLogic->clusterLogic(), SIGNAL(saveClustersRequested(MultipleClustersConfigData)),
            mOfflineStorage, SLOT(onSaveClustersConfigRequested(MultipleClustersConfigData)));
    connect(mOfflineStorage, SIGNAL(savedClustersConfigLoaded(MultipleClustersConfigData)),
            mRootLogic->clusterLogic(), SLOT(onSavedClustersConfigLoaded(MultipleClustersConfigData)));
}
