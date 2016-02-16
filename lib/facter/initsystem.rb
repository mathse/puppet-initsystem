Facter.add(:initsystem) do
  confine :kernel => %w(Linux)
  setcode do
    os = Facter.value(:os)

    case os['name']
    when /(CentOS|Scientific|RedHat)/
      os['release']['major'].to_i >= 7 ? 'systemd' : 'sysvinit'
    when 'Fedora'
      'systemd'
    when 'Debian'
      os['release']['major'].to_i >= 8 ? 'systemd' : 'sysvinit'
    when 'Ubuntu'
      case os['release']['major']
      when '15.04', '15.10', '16.04'
        'systemd'
      else
        'upstart'
      end
    else
      nil
    end
  end
end

Facter.add(:init_daemon) do
  setcode do
    Facter.value(:initsystem)
  end
end