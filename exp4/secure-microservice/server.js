const express = require('express');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    const uid = process.getuid ? process.getuid() : null;
    const gid = process.getgid ? process.getgid() : null;
    const userInfo = os.userInfo();

    const isRoot = uid === 0 || userInfo.username === 'root';

    const securityStatus = isRoot
        ? 'INSECURE: Container process running with privileged ROOT access (UID 0)'
        : 'SECURE: Container process running under unprivileged NON-ROOT boundaries';

    res.json({
        status: isRoot ? 'VULNERABLE' : 'HEALTHY',

        security_assessment: {
            status: securityStatus,
            is_root_user: isRoot,
            uid: uid !== null ? uid : 'N/A',
            gid: gid !== null ? gid : 'N/A',
            effective_username: userInfo.username,
            execution_directory: process.cwd()
        },

        system_diagnostics: {
            hostname: os.hostname(),
            platform: os.platform(),
            architecture: os.arch(),
            kernel_release: os.release(),
            node_version: process.version,
            uptime_seconds: Math.floor(process.uptime())
        },

        timestamp: new Date().toISOString()
    });
});

app.listen(PORT, () => {
    console.log(`[MICROSERVICE] Server listening on port ${PORT}`);
});