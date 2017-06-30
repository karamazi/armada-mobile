#include "clusterlogic.h"

ClusterLogic::ClusterLogic(QObject *parent) : QObject(parent)
{
    ClusterModel* m;
    QList<ClusterModel*> initialModels;

    m = new ClusterModel("Arena", "http://arena.gd:8900", this);
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SIGNAL(clusterInstancesListRequested(QString)));
    initialModels.append(m);

    m = new ClusterModel("Office", "http://office.gd:8900", this);
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SIGNAL(clusterInstancesListRequested(QString)));
    initialModels.append(m);

    models(initialModels);
}


void ClusterLogic::onClusterInstancesListLoaded(InstancesListData data)
{
    //TODO Free memory
    QList<InstanceModel*> newInstances;
    InstanceModel* m;
    for(InstanceData i : data.instances)
    {
        m = new InstanceModel(this);
        m->name(i.microserviceName);
        m->id(i.microserviceId);
        m->status(i.status);
        newInstances.append(m);
    }
    std::sort(newInstances.begin(), newInstances.end(),
              [](const InstanceModel* a, const InstanceModel* b)
              -> bool { return a->name() < b->name(); }
    );
    instances(newInstances);

    emit qmlInstancesLoaded();
}
