module.exports = async ({ getNamedAccounts, deployments }) => {
    const { log, deploy } = deployments;
    const { deployer } = await getNamedAccounts();

    const chainId = network.config.chainId;
};
