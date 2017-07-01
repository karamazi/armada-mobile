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

    AUTO_PROPERTY_D(bool, requestPending, false)
public:
    explicit ClusterLogic(QObject *parent = 0);


signals:
    void clusterInstancesListRequested(QString address);
    void qmlInstancesLoaded();
    void qmlError(QString error);

public slots:
    void onClusterInstancesListLoaded(InstancesListData data);
    void onClusterRequestError(QString error);

private:
    Q_SLOT void onRequestStarted();

    ClusterModel* createModel(QString name, QString address);
};

#endif // CLUSTERLOGIC_H
