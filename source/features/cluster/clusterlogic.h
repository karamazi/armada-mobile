#ifndef CLUSTERLOGIC_H
#define CLUSTERLOGIC_H

#include <QObject>
#include "source/utils/autoproperty.h"
#include "clustermodel.h"
#include "instancemodel.h"
#include "source/sharedStructs/instanceslistdata.h"

class ClusterLogic : public QObject
{
    Q_OBJECT
    LIST_PROPERTY(ClusterModel, models)
    LIST_PROPERTY(InstanceModel, instances)
    //TODO: Osobna logika

public:
    explicit ClusterLogic(QObject *parent = 0);


signals:
    void clusterInstancesListRequested(QString address);
    void qmlInstancesLoaded();

public slots:
    void onClusterInstancesListLoaded(InstancesListData data);
};

#endif // CLUSTERLOGIC_H
