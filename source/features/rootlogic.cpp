#include "rootlogic.h"

RootLogic::RootLogic(QObject *parent) : QObject(parent)
{
    clusterLogic(new ClusterLogic(this));

    QML_REGISTER_UNCREATABLE_TYPE(ClusterLogic)
    QML_REGISTER_UNCREATABLE_TYPE(ClusterModel)
    QML_REGISTER_UNCREATABLE_TYPE(InstanceModel)
}
