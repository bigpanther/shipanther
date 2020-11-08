import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(
        pubName: 'trober_api', pubAuthor: 'Big Panther Inc.'),
    inputSpecFile: 'lib/trober/trober.yaml',
    generatorName: Generator.DART2_API,
    outputDirectory: 'api/trober_api')
class Trober extends OpenapiGeneratorConfig {}
