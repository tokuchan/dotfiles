function hostIsProxied(host) {
    if(
           shExpMatch(host, "*.corp.maystreet.com")
        || shExpMatch(host, "*.staging.maystreet.com")
        || shExpMatch(host, "*confluence.svc.maystreet.com")
        || shExpMatch(host, "*jira.svc.maystreet.com")
        || shExpMatch(host, "*.uat.staging.maystreet.com")
        || shExpMatch(host, "*.maystreet-dev.com")
        || shExpMatch(host, "*.thesystech.com")
    ) {
        return true;
    }
}
 
function FindProxyForURL(url, host) {
    PROXY = "PROXY mst-proxy.corp.maystreet.com:3128; SOCKS mst-proxy.corp.maystreet.com:9876"
 
    // certain maystreet URLs via proxy
    if (hostIsProxied(host)) {
        return PROXY;
    }
    // Everything else directly!
    return "DIRECT";
}
