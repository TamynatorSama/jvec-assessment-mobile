import 'package:azlistview/azlistview.dart';
import 'package:contact_app/app_provider.dart';
import 'package:contact_app/auth/requests/auth_request.dart';
import 'package:contact_app/contacts/contact_details.dart';
import 'package:contact_app/contacts/create_contact.dart';
import 'package:contact_app/contacts/reusables/contact_list_Card.dart';
import 'package:contact_app/homepage.dart';
import 'package:contact_app/model/user_data.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:contact_app/utils/feedbacktoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  late AppProvider provider;
  GlobalKey<RefreshIndicatorState> refresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    provider = Provider.of<AppProvider>(context, listen: false);
    getData(shouldShowRefresh: true);
    super.initState();
  }

  Future<void> getData({bool shouldShowRefresh = false}) async {
    if (shouldShowRefresh && refresh.currentState != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        refresh.currentState?.show();
      });
    }
    await provider.getAllContacts(context, shouldShowToast: shouldShowRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, value) {
      SuspensionUtil.sortListBySuspensionTag(provider.contacts);
      SuspensionUtil.setShowSuspensionStatus(provider.contacts);
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: RefreshIndicator(
          key: refresh,
          onRefresh: getData,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.of(context).padding.top + 5,
                24,
                MediaQuery.of(context).padding.top + 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contacts",
                    style: AppTheme.headerTextStyle.override(fontSize: 32),
                  ),
                  InkWell(
                      onTap: () async {
                        CustomLoader.showLoader(context);
                        await AuthRequest.logout().then((value) {
                          CustomLoader.dismissLoader().then((_) async {
                            if (value["status"]) {
                              showFeedbackToast(context, value["message"],type: ToastType.success);
                              await UserData.storage.deleteAll().then((_) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (route) => false);
                                provider.contacts = [];
                              });

                              return;
                            }
                            showFeedbackToast(context, value["message"]);
                          });
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // if (provider.contacts.isNotEmpty)
              //   Column(
              //     children: [
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       TextFormField(
              //         decoration: InputDecoration(
              //             filled: true,
              //             fillColor: AppTheme.btnColor,
              //             hintText: "Search...",
              //             hintStyle:
              //                 AppTheme.headerTextStyle.override(fontSize: 16),
              //             prefixIcon: Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: SvgPicture.string(
              //                 '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="none"><path fill="grey" d="M19 11a8 8 0 1 1-16 0a8 8 0 0 1 16 0Z" opacity=".16"/><path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m21 21l-4.343-4.343m0 0A8 8 0 1 0 5.343 5.343a8 8 0 0 0 11.314 11.314Z"/></g></svg>',
              //                 color: const Color.fromARGB(255, 199, 199, 199),
              //               ),
              //             ),
              //             contentPadding: const EdgeInsets.symmetric(
              //                 horizontal: 15, vertical: 10),
              //             border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(8),
              //                 borderSide: const BorderSide(
              //                     width: 1.5,
              //                     color: Color.fromARGB(255, 222, 222, 222))),
              //             focusedBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(8),
              //                 borderSide: const BorderSide(
              //                     width: 1.5,
              //                     color: Color.fromARGB(255, 222, 222, 222))),
              //             enabledBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(8),
              //                 borderSide: const BorderSide(
              //                     width: 1.5,
              //                     color: Color.fromARGB(255, 222, 222, 222)))),
              //         style: AppTheme.headerTextStyle.override(fontSize: 16),
              //       ),
              //       const SizedBox(
              //         height: 40,
              //       ),
              //     ],
              //   ),

              Expanded(
                  child: provider.contacts.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                                opacity: 0.5,
                                child: SvgPicture.asset(
                                  'assets/images/Empty-pana.svg',
                                  fit: BoxFit.contain,
                                  height: 400,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                "You haven't added any contact yet, click the + icon at the buttom to get started",
                                style: AppTheme.headerTextStyle
                                    .override(fontSize: 15, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      : AzListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          indexBarOptions: IndexBarOptions(
                              needRebuild: true,
                              indexHintAlignment: Alignment.centerRight,
                              selectTextStyle: AppTheme.headerTextStyle),
                          indexBarWidth: 10,
                          data: provider.contacts,
                          itemCount: provider.contacts.length,
                          itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (provider.contacts[index].isShowSuspension)
                                    Column(
                                      children: [
                                        Text(
                                          provider.contacts[index]
                                              .getSuspensionTag(),
                                          style: AppTheme.headerTextStyle
                                              .override(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ContactListCard(
                                    image: provider.contacts[index]
                                            .profilePicture.isNotEmpty
                                        ? provider
                                            .contacts[index].profilePicture
                                        : null,
                                    label:
                                        "${provider.contacts[index].firstName} ${provider.contacts[index].lastName}",
                                    value: provider.contacts[index].phoneNumber,
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactDetails(
                                                  contactId: provider
                                                      .contacts[index]
                                                      .identifier,
                                                ))),
                                  )
                                ],
                              )))
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.btnColor,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateContact())),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
