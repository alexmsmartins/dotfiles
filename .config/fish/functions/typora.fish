function typora
  switch (uname)
      case Darwin
        open -a typora $argv
        # FIXME: handle typora not being installed
  end
end
