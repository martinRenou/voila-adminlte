const widgetResolveFns = {};
const widgetPromises = {};

function provideWidget(mountId, widgetView) {
    if (widgetResolveFns[mountId]) {
        widgetResolveFns[mountId](widgetView);
    } else {
        widgetPromises[mountId] = Promise.resolve(widgetView);
    }
}

function requestWidget(mountId) {
    if (!widgetPromises[mountId]) {
        widgetPromises[mountId] = new Promise(resolve => widgetResolveFns[mountId] = resolve);
    }
    return widgetPromises[mountId];
}

window.init = async (voila) => {
    const kernel = await voila.connectKernel();
    window.addEventListener('beforeunload', () => kernel.shutdown());

    const widgetManager = new voila.WidgetManager(kernel);
    await widgetManager.build_widgets();

    // Create views for widgets that needs to be mount on the page
    Object.values(widgetManager._models)
        .forEach(async (modelPromise) => {
            const model = await modelPromise;
            const mountId = model.get('mount_id');
            if (mountId && model.get('_view_name')) {
                const view = await widgetManager.create_view(model);
                provideWidget(mountId, view);
            }
        });

    // Then mount them on the page
    const containers = document.querySelectorAll('[data-mount-id]');
    containers.forEach((container) => {
        requestWidget(container.getAttribute('data-mount-id')).then((view) => {
            container.appendChild(view.el);
        });
    });
};
