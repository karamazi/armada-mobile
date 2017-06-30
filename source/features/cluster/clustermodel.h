#ifndef CLUSTERMODEL_H
#define CLUSTERMODEL_H

#include <QObject>
#include "source/utils/autoproperty.h"

class ClusterModel : public QObject
{
    Q_OBJECT
    AUTO_PROPERTY(QString, name)
    AUTO_PROPERTY(QString, address)

public:
    explicit ClusterModel(QObject *parent = 0);
    explicit ClusterModel(QString clusterName, QString clusterAddress, QObject *parent);

    Q_INVOKABLE void qmlConnectToCluster(QString address);

signals:
    void clusterInstancesListRequested(QString address);

public slots:
};

#endif // CLUSTERMODEL_H
