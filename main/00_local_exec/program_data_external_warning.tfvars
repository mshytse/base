# Allocates 400 MiB RSS over ~2s (20×20 MiB, page-touched), holds for 30s, then outputs required JSON.
program_for_data_external = "python3 -c \"import time,json; chunks=[]; exec('for _ in range(20):\\n b=bytearray(20*1024*1024)\\n for i in range(0,len(b),4096): b[i]=1\\n chunks.append(b)\\n time.sleep(0.1)\\ntime.sleep(30)'); print(json.dumps({'status': 'ok', 'allocated_mb': '400'}))\""
