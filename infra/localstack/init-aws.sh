#!/bin/bash
# infra/localstack/init-aws.sh
# Executado automaticamente pelo LocalStack após startup (ready.d).
# Cria os recursos AWS que o projeto usa em desenvolvimento local.

set -e

echo "==> [LocalStack init] Criando recursos AWS..."

AWS="aws --endpoint-url=http://localhost:4566 --region us-east-1 --no-cli-pager"

# ── S3 ───────────────────────────────────────────────────────────────────────
echo "--> S3: criando bucket de auditoria..."
$AWS s3api create-bucket --bucket fap-audit-events

# ── SQS ──────────────────────────────────────────────────────────────────────
echo "--> SQS: criando filas..."
$AWS sqs create-queue --queue-name fap-auth-events
$AWS sqs create-queue --queue-name fap-payment-events
$AWS sqs create-queue --queue-name fap-audit-events

# ── SNS ──────────────────────────────────────────────────────────────────────
echo "--> SNS: criando tópicos..."
AUTH_TOPIC_ARN=$($AWS sns create-topic --name fap-auth-notifications --query TopicArn --output text)
PAYMENT_TOPIC_ARN=$($AWS sns create-topic --name fap-payment-notifications --query TopicArn --output text)

# ── SNS → SQS subscriptions ──────────────────────────────────────────────────
echo "--> SNS: inscrevendo filas SQS nos tópicos..."
AUTH_QUEUE_ARN=$($AWS sqs get-queue-attributes \
  --queue-url http://localhost:4566/000000000000/fap-auth-events \
  --attribute-names QueueArn \
  --query Attributes.QueueArn --output text)

$AWS sns subscribe \
  --topic-arn "$AUTH_TOPIC_ARN" \
  --protocol sqs \
  --notification-endpoint "$AUTH_QUEUE_ARN"

echo "==> [LocalStack init] Concluído."
echo "    S3 buckets  : fap-audit-events"
echo "    SQS queues  : fap-auth-events, fap-payment-events, fap-audit-events"
echo "    SNS topics  : fap-auth-notifications, fap-payment-notifications"