#! /usr/bin/env nix-shell
#! nix-shell -i python -p python3 -p python3Packages.requests -p python3Packages.lxml

# Reads the master Oracle corporate proxy config file and outputs an (almost) equivalent
# configuration for squid

from lxml import etree
import requests
from ipaddress import ip_address, ip_network

def getip():
    import socket
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip = s.getsockname()[0]
    s.close()
    return ip_address(ip)

def split_host(url):
    parts = url.split(':')
    host = parts[0]
    port = parts[1] if len(parts) > 1 else '80'
    return (host, port)

def print_acl(domain):
    if domain == 'localhost': return
    if domain[0] == '(': return

    if '/' in domain:
        print('acl {0} dst -n {0}'.format(domain))
    else:
        print('acl {0} dstdom_regex -n \.{1}\.?$|^{1}\.?$'.format(domain, domain.replace('.', '\.')))
    return domain

def get_region(tree):
    subnets = tree.xpath('/proxyconf/subnet')
    ip = getip()
    region = next(subnet for subnet in subnets if ip in ip_network(subnet.get('network'))).get('region')
    if region is None:
        region = 'EMEA'
    return region

def get_all_proxies(tree):
    proxies = set()
    for entry in tree.xpath('//server/text()'):
        for proxy in entry.split(','):
            proxies.add(proxy)
    return proxies

def get_specific_proxy_map(tree):
    specific_proxy = tree.xpath('/proxyconf/global/server[@domain]')
    specific_map = dict()
    for specific in specific_proxy:
        (host, port) = split_host(specific.text)
        if host not in specific_map: specific_map[host] = set()
        specific_map[host].add(specific.get('domain'))
    return specific_map

def print_specific_proxies(proxies, our_proxies, specific_map):
    for peer in proxies:
        if peer not in our_proxies and peer != 'DIRECT':
            (host, port) = split_host(peer)
            print('cache_peer {0} parent {1} 0 proxy-only'.format(host, port))
            if host in specific_map:
                for server in specific_map[host]:
                    acl = print_acl(server)
                    if acl is not None:
                        print('cache_peer_access {0} allow {1}'.format(host, server))
            print('cache_peer_access {0} deny all'.format(host))

def print_direct_hosts(no_proxy):
    for direct in no_proxy:
        acl = print_acl(direct.text)
        if acl is not None:
            print('always_direct allow {0}'.format(acl))

def print_forced_hosts(force_proxy):
    for force in force_proxy:
        acl = print_acl(force.text)
        if acl is not None:
            print('never_direct allow {0}'.format(acl))

def print_our_proxies(our_proxies):
    for peer in our_proxies:
        (host, port) = split_host(peer)
        print('cache_peer {0} parent {1} 0 default proxy-only'.format(host, port))

def main():
    # Read and parse master file
    raw = requests.get("http://wpad-admin.oraclecorp.com/master.xml").text
    tree = etree.fromstring(raw)

    # Where are we?
    region = get_region(tree)

    # Munge the data
    our_proxies = tree.xpath('/proxyconf/region[@name="' + region + '"]/server')[0].text.split(',')
    all_proxies = get_all_proxies(tree)
    force_proxy = sorted(tree.xpath('/proxyconf/global/forceproxy'),key=lambda x: x.text.count('.'), reverse=True)
    no_proxy = sorted(tree.xpath('/proxyconf/global/noproxy'), key=lambda x: x.text.count('.'), reverse=True)
    specific_map = get_specific_proxy_map(tree)

    # Print the config
    print_specific_proxies(all_proxies, our_proxies, specific_map)
    print_direct_hosts(no_proxy)
    print_forced_hosts(force_proxy)
    print_our_proxies(our_proxies)

main()
