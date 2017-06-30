#include "clustermodel.h"
#include <QDebug>

ClusterModel::ClusterModel(QObject *parent) : QObject(parent)
{

}

ClusterModel::ClusterModel(QString clusterName, QString clusterAddress, QObject *parent) :
    QObject(parent)
{
    name(clusterName);
    address(clusterAddress);
}

void ClusterModel::qmlConnectToCluster(QString address)
{
    emit clusterInstancesListRequested(address);
}
