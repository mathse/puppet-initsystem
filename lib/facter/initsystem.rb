# Fact: init_daemon
#
# Purpose: Determine the name of initsystem (init daemon)

Facter.add(:initsystem) do
  confine :kernel => %w(Linux)
  setcode do
    os = Facter.value(:os)

    case os['name']
    when /(CentOS|Scientific|RedHat)/
      case os['release']['major'].to_i
      when 5
        'sysvinit'
      when 6
        'redhat'
      when 7
        'systemd'
      else
        'systemd'
      end
    when 'Fedora'
      'systemd'
    when 'Debian'
      case os['release']['major'].to_i
      when 8
        'systemd'
      else
        'sysvinit'
      end
    when 'Ubuntu'
      case os['release']['major']
      when '15.04', '15.10', '16.04'
        'systemd'
      else
        'upstart'
      end
    when 'SLES'
      if os['release']['major'].to_i > 11
        'systemd'
      else
        'redhat'
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
