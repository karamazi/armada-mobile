#ifndef CLUSTERLOGIC_H
#define CLUSTERLOGIC_H

#include <QObject>
#include "source/utils/autoproperty.h"
#include "clustermodel.h"
#include "instancemodel.h"
#include "source/sharedStructs/instanceslistdata.h"
#include "source/sharedStructs/clusterconfigdata.h"

class ClusterLogic : public QObject
{
    Q_OBJECT
    LIST_PROPERTY(ClusterModel, models)
    LIST_PROPERTY(InstanceModel, instances)
    AUTO_PROPERTY(ClusterModel*, editModel)

    AUTO_PROPERTY_D(bool, requestPending, false)

public:
    explicit ClusterLogic(QObject *parent = 0);
    Q_INVOKABLE void qmlAddCluster(QString name, QString address);

signals:
    void clusterInstancesListRequested(QString address);
    void saveClustersRequested(MultipleClustersConfigData data);

    void qmlInstancesLoaded();
    void qmlError(QString error);

public slots:
    void onClusterInstancesListLoaded(InstancesListData data); void onClusterRequestError(QString error);
    void onSavedClustersConfigLoaded(MultipleClustersConfigData data);

private:
    Q_SLOT void onRequestStarted();
    Q_SLOT void saveConfig();
    Q_SLOT void onDeleteNeeded(int index);

    Q_SLOT void updateIndexes();

    ClusterModel* createModel(QString name, QString address);
};

#endif // CLUSTERLOGIC_H
