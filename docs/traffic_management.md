# Traffic Management Commands

## View Revisions
```bash
gcloud run revisions list \
  --service stratos-app \
  --region us-central1 \
  --sort-by=~createTime \
  --limit=10 \
  --format="table(name, createTime, author)"
```

## Traffic Splitting

### Split traffic 50/50 (Canary)
```bash
gcloud run services update-traffic stratos-app \
    --region us-central1 \
    --to-revisions [NEW-REVISION]=50,[OLD-REVISION]=50
```

### Promote Latest to 100%
```bash
gcloud run services update-traffic stratos-app --region us-central1 --to-latest
```

### Rollback (100% to specific revision)
```bash
gcloud run services update-traffic stratos-app --region us-central1 --to-revisions [OLD-REVISION]=100
```