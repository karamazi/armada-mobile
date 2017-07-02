#ifndef CLUSTERMODEL_H
#define CLUSTERMODEL_H

#include <QObject>
#include "source/utils/autoproperty.h"

class ClusterModel : public QObject
{
    Q_OBJECT
    AUTO_PROPERTY_D(QString, name, "")
    AUTO_PROPERTY_D(QString, address, "")

public:
    explicit ClusterModel(QObject *parent = 0);
    explicit ClusterModel(QString clusterName, QString clusterAddress, QObject *parent);

    Q_INVOKABLE void qmlConnectToCluster(QString address);
    Q_INVOKABLE void qmlSave();
    Q_INVOKABLE void qmlDelete();

    int index() { return mIndex; }
    void index(int value) { mIndex = value; }

signals:
    void clusterInstancesListRequested(QString address);
    void saveNeeded();
    void deleteNeeeded(int index);

public slots:

private:
    int mIndex = 0;
};

#endif // CLUSTERMODEL_H
