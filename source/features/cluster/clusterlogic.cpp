#include "clusterlogic.h"

ClusterLogic::ClusterLogic(QObject *parent) : QObject(parent)
{
    QList<ClusterModel*> initialModels;
    initialModels.append(createModel("Arena", "http://arena.gd:8900"));
    initialModels.append(createModel("Office", "http://office.gd:8900"));
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
        m->env(i.env);
        m->appId(i.appId);
        newInstances.append(m);
    }
    std::sort(newInstances.begin(), newInstances.end(),
              [](const InstanceModel* a, const InstanceModel* b)
              -> bool { return a->name() < b->name(); }
    );
    instances(newInstances);
    emit qmlInstancesLoaded();
    requestPending(false);
}

void ClusterLogic::onClusterRequestError(QString error)
{
    emit qmlError(error);
    requestPending(false);
}


/* Private */

void ClusterLogic::onRequestStarted()
{
    requestPending(true);
}

ClusterModel* ClusterLogic::createModel(QString name, QString address){
    ClusterModel* m = new ClusterModel(name, address, this);
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SIGNAL(clusterInstancesListRequested(QString)));
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SLOT(onRequestStarted()));
    return m;
}
