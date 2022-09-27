source_path=$1

mkdir -p ./lib/genus/generated

protoc --dart_out=grpc:./lib/genus/generated \
  -I $source_path \
  $source_path/types.proto \
  $source_path/filters.proto \
  $source_path/transactions_query.proto \
  $source_path/blocks_query.proto \
  $source_path/transactions_subscription.proto \
  $source_path/blocks_subscription.proto \
  $source_path/services_types.proto


