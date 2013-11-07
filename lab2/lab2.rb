require 'socket'
require 'timeout'
begin
server = Socket.new(Socket::PF_INET, Socket::SOCK_STREAM, 0)
#server.setsockopt(:SOCKET, :REUSEADDR, true)
server_addr = Socket.pack_sockaddr_in(1234, "127.0.0.1")
server.bind(server_addr)
server.listen(1)


while server
    active_socket, info = server.accept
  while message = active_socket.gets.chomp  
    puts "coming message: '#{message}'"
  end
end

trap ("SIGINT") do
  exit!
  end

server.close if server
active_socket.close if active_socket  
rescue Interrupt, IOError
  server.close
  active_socket.close
end