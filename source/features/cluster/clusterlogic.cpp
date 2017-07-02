#include "clusterlogic.h"

ClusterLogic::ClusterLogic(QObject *parent) : QObject(parent)
{
    connect(this, SIGNAL(modelsChanged(QQmlListProperty<ClusterModel>)),
            this, SLOT(updateIndexes()));

    QList<ClusterModel*> initialModels;
    initialModels.append(createModel("Arena", "http://arena.gd:8900"));
    initialModels.append(createModel("Office", "http://office.gd:8900"));
    models(initialModels);

    editModel(new ClusterModel(this));
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

void ClusterLogic::qmlAddCluster(QString name, QString address)
{
    QList<ClusterModel*> prev = modelsRaw();
    prev.append(createModel(name, address));
    models(prev);
    saveConfig();
}

void ClusterLogic::onSavedClustersConfigLoaded(MultipleClustersConfigData data)
{
    QList<ClusterModel*> newModels;
    for(auto clusterConfig : data.clusters)
    {
        newModels.append(createModel(clusterConfig.name, clusterConfig.address));
    }
    models(newModels);
}

/* Private */

void ClusterLogic::saveConfig()
{
    MultipleClustersConfigData data;
    for(ClusterModel* m: modelsRaw()){
        ClusterConfigData ccd;
        ccd.address = m->address();
        ccd.name = m->name();
        data.clusters.append(ccd);
    }
    emit saveClustersRequested(data);
}

void ClusterLogic::updateIndexes()
{
    for(int i = 0; i < modelsRaw().length(); i++ )
    {
        modelsRaw()[i]->index(i);
    }
}

void ClusterLogic::onDeleteNeeded(int index)
{
    QList<ClusterModel*> currentModels = modelsRaw();
    ClusterModel* removed = currentModels.takeAt(index);
    models(currentModels);
    removed->deleteLater();
    saveConfig();
}

void ClusterLogic::onRequestStarted()
{
    requestPending(true);
}

ClusterModel* ClusterLogic::createModel(QString name, QString address)
{
    ClusterModel* m = new ClusterModel(name, address, this);
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SIGNAL(clusterInstancesListRequested(QString)));
    connect(m, SIGNAL(clusterInstancesListRequested(QString)), this, SLOT(onRequestStarted()));
    connect(m, SIGNAL(saveNeeded()), this, SLOT(saveConfig()));
    connect(m, SIGNAL(deleteNeeeded(int)), this, SLOT(onDeleteNeeded(int)));
    return m;
}
