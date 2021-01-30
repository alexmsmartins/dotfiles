import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 0))
addr = s.getsockname()
print("Open port={}\n".format(addr[1]))
s.close()
