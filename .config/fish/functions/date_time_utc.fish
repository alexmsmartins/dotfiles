function date_time_utc
  switch (uname)
    case Darwin
      set date_cmd gdate
      gdate -u +"%Y-%m-%dT%H:%M:%S.%6NZ"
    case '*'
      set date_cmd date
  end
  if hash $date_cmd;
    $date_cmd -u +"%Y-%m-%dT%H:%M:%S.%6NZ"
  else;
    echo "Unsupported configuration. Please install GNU Date"
  end
end
