import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ribn/models/images/ribn_file_model.dart';
import 'package:ribn/models/jira/jira_createissue_response_model.dart';
import 'package:ribn/models/jira/jira_description_model.dart';
import 'package:ribn/models/jira/jira_fields_model.dart';
import 'package:ribn/models/jira/jira_issue_assignee_model.dart';
import 'package:ribn/models/jira/jira_issue_model.dart';
import 'package:ribn/models/jira/jira_project_model.dart';
import 'package:ribn/presentation/feedback/widgets/buttons/ribn_upload_file_button.dart';
import 'package:ribn/presentation/feedback/widgets/cards/ribn_feedback_file_card.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/dropdowns/ribn_dropdown.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font10_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font19_text_widget.dart';
import 'package:ribn_toolkit/widgets/input/ribn_text_field_with_title.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

import '../../../constants/assets.dart';
import '../../../constants/environment_config.dart';
import '../../../constants/keys.dart';
import '../../../constants/routes.dart';
import '../../../constants/strings.dart';
import '../../../models/jira/jira_content_model.dart';
import '../../../models/jira/jira_content_type_model.dart';
import '../../../services/jira/jira_service.dart';

class RibnFeedbackForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {
        // ignore: invalid_use_of_protected_member
        _formKey.currentState?.dispose();
      };
    }, []);

    final ValueNotifier<List<XFile>> _imageFileList = useState(<XFile>[]);
    final ValueNotifier<List<String>> _imageSizes = useState(<String>[]);
    final ImagePicker _imagePicker = ImagePicker();
    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _descriptionController = useTextEditingController();

    JiraService _jiraService = JiraService();
    final String _assigneeID = EnvironmentConfig.ASSIGNEE_ID;
    final String _issueType = EnvironmentConfig.ISSUE_TYPE;
    final String _projectKey = EnvironmentConfig.PROJECT_KEY;

    final ValueNotifier<String?> _selectedTitle = useState(null);

    final List<String> _issueLabels = <String>["Ribnform"];
    List<String> _dropDownItems = ["Report Bugs or major incident", "Product improvements/suggestions"];
    final ValueNotifier<bool> _isLoading = useState(false);

    // TODO: implement build
    return LoadingOverlay(
        color: RibnColors.primary,
        isLoading: _isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomPageTextTitle(
                    title: Strings.feedbackForm,
                    hideBackArrow: true,
                    hideCloseCross: true,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 10),
                                child: RibnDropdown(
                                  dropDownIcon: RibnAssets.chevronDown,
                                  dropDownHintText: Strings.iWouldLiketTo,
                                  title: Strings.iWouldLiketTo,
                                  titleColor: RibnColors.greyText,
                                  titleWeight: FontWeight.w500,
                                  dropDownItems: _dropDownItems,
                                  dropDownValue: _selectedTitle.value,
                                  onChanged: (String? item) {
                                    _selectedTitle.value = item;
                                  },
                                  dropDownIconColor: RibnColors.defaultText,
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: RibnTextFieldWithTitle(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                inputFormatters: [],
                                hintColor: RibnColors.greyedOut.withOpacity(0.5),
                                controller: _emailController,
                                hintText: 'Henryfields@gmail.com',
                                title: 'Email',
                                titleColor: RibnColors.defaultText,
                                titleFontWeight: FontWeight.w400,
                                validator: (String? text) {
                                  print('QQQQ validation email $text');
                                  if (!EmailValidator.validate(_emailController.text)) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: NoteField(
                                    onChanged: (String item) {},
                                    height: 150,
                                    width: 350,
                                    maxNoteLength: 500,
                                    hintTitle: Strings.description,
                                    hintText: Strings.ribnSupportDescriptionHint,
                                    controller: _descriptionController,
                                    noteLength: _descriptionController.text.length,
                                    validator: (String? text) {
                                      print('QQQQ validating note $text');
                                      if (_descriptionController.text.length < 50) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    tooltipIcon: Image.asset(
                                      RibnAssets.greyHelpBubble,
                                      width: 18,
                                      // QQQQ check
                                      color: RibnColors.redColor,
                                    ),
                                  ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: RibnUploadFeedbackFileButton(
                                    onTap: _imageFileList.value.length > 4
                                        ? null
                                        : () async {
                                            List<XFile> tempImages =
                                                await _imagePicker.pickMultiImage(requestFullMetadata: true);
                                            List<String> tempImagesSizes = [];
                                            for (int i = 0; i < tempImages.length; i++) {
                                              tempImagesSizes.add((await tempImages[i].length()).toStringAsFixed(0));
                                            }
                                            _imageFileList.value = [..._imageFileList.value, ...tempImages];
                                            _imageSizes.value = [..._imageSizes.value, ...tempImagesSizes];
                                          },
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            child: Container(
                              height: 200,
                              width: 350,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _imageFileList.value.length > 4
                                        ? RibnColors.redColor
                                        : RibnColors.greyedOut.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(4))),
                              child: _imageFileList.value.isEmpty
                                  ? Center(
                                      child: RibnFont10TextWidget(
                                        text: 'No Images uploaded',
                                        textAlign: TextAlign.center,
                                        textColor: RibnColors.greyedOut,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  : Align(
                                      alignment: FractionalOffset.topCenter,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: _imageFileList.value.length,
                                          itemBuilder: (context, index) {
                                            return RibnFeedbackFileCard(
                                              file: _imageFileList.value[index],
                                              fileSize: _imageSizes.value[index],
                                              onPressed: () {
                                                final _modifiedImageFileList = [..._imageFileList.value];
                                                _modifiedImageFileList.removeAt(index);
                                                _imageFileList.value = _modifiedImageFileList;

                                                final _modifiedImageSizes = [..._imageSizes.value];
                                                _modifiedImageSizes.removeAt(index);
                                                _imageSizes.value = _modifiedImageSizes;
                                              },
                                            );
                                          }),
                                    ),
                            ),
                          ),
                          if (_imageFileList.value.length > 4)
                            Padding(
                              padding: EdgeInsets.only(bottom: 25, top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: RibnColors.redColor.withOpacity(0.3),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                child: Center(
                                  child: RibnFont10TextWidget(
                                    text: 'Max of 4 images allowed',
                                    textAlign: TextAlign.center,
                                    textColor: RibnColors.redColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                width: 350,
                                height: 23,
                              ),
                            ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 100),
                              child: Center(
                                child: LargeButton(
                                  // QQQQ update
                                  // disabled: !_validForm,
                                  buttonChild: RibnFont19TextWidget(
                                    text: Strings.submitForm,
                                    textAlign: TextAlign.justify,
                                    textColor: RibnColors.whiteColor,
                                    fontWeight: FontWeight.normal,
                                    wordSpacing: 0,
                                  ),
                                  onPressed: () async {
                                    List<RibnFileModel> files = [];
                                    _isLoading.value = true;
                                    _imageFileList.value.forEach((XFile file) {
                                      files.add(new RibnFileModel(filePath: file.path, fileType: ""));
                                    });
                                    final JiraCreateIssueResponseModel response =
                                        await _jiraService.createJiraIssue(new JiraIssueModel(
                                            fields: new JiraFieldsModel(
                                                assignee: new JiraAssigneeModel(id: _assigneeID),
                                                labels: _issueLabels,
                                                summary: _selectedTitle.value,
                                                issuetype: new JiraAssigneeModel(id: _issueType),
                                                project: new JiraProjectModel(key: _projectKey),
                                                description: JiraDescriptionModel(content: <JiraContentModel>[
                                                  new JiraContentModel(content: <JiraContentTypeModel>[
                                                    JiraContentTypeModel(
                                                        text: 'User email: ${_emailController.text}\n\n'),
                                                    JiraContentTypeModel(
                                                        text: 'Description\n${_descriptionController.text}')
                                                  ])
                                                ]),
                                                attachments: files)));
                                    _isLoading.value = false;
                                    if (response.success) {
                                      Keys.navigatorKey.currentState?.pushNamed(Routes.feedbackSuccess);
                                    } else {
                                      Keys.navigatorKey.currentState?.pushNamed(Routes.feedbackError);
                                    }
                                  },
                                ),
                              ))
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
