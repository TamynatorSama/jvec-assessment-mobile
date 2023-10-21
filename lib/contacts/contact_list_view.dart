import 'package:azlistview/azlistview.dart';
import 'package:contact_app/contacts/reusables/contact_list_Card.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key});

  @override
  Widget build(BuildContext context) {

    List<ContactInfo> data = [ContactInfo(name: "Segun Kolawole",phoneNumber: "09063976031",),ContactInfo(name: "Bisi Law",phoneNumber: "08063473051"),ContactInfo(name: "Abdullai akanbi",phoneNumber: "07083436031"),ContactInfo(name: "Zen nitsu",phoneNumber: "01062936431"),];
     SuspensionUtil.sortListBySuspensionTag(data);
     SuspensionUtil.setShowSuspensionStatus(data);


    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top+5, 24, MediaQuery.of(context).padding.top+10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Contacts",style: AppTheme.headerTextStyle.override(fontSize: 32),),
        const SizedBox(height: 20,),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.btnColor,
            hintText: "Search...",
            hintStyle: AppTheme.headerTextStyle.override(fontSize: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="none"><path fill="grey" d="M19 11a8 8 0 1 1-16 0a8 8 0 0 1 16 0Z" opacity=".16"/><path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m21 21l-4.343-4.343m0 0A8 8 0 1 0 5.343 5.343a8 8 0 0 0 11.314 11.314Z"/></g></svg>',color: const Color.fromARGB(255, 199, 199, 199),),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5,color: Color.fromARGB(255, 222, 222, 222))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5,color: Color.fromARGB(255, 222, 222, 222))
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5,color: Color.fromARGB(255, 222, 222, 222))
            )
          ),
        style: AppTheme.headerTextStyle.override(fontSize: 16),
        ),
        const SizedBox(height: 40,),
Expanded(child:
        AzListView(
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            indexHintAlignment: Alignment.centerRight,
            selectTextStyle: AppTheme.headerTextStyle
          ),
          indexBarWidth: 10,
          data: data, itemCount: data.length, itemBuilder: (context,index)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(data[index].isShowSuspension)
                Column(
                  children: [
                    Text(data[index].getSuspensionTag(),style: AppTheme.headerTextStyle.override(fontSize: 16),),
                    const SizedBox(height: 10,)
                  ],
                ),
              ContactListCard(label: data[index].name, value: data[index].phoneNumber!)
            ],
          )))
      ]),),
      
    );
  }
}