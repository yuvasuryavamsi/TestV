<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Reset_Password_Doctor_Alert</fullName>
        <description>Reset Password Doctor Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>info@healthultimatecorp.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Doctor_Forgot_Password_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>IsResetPasswordFalse</fullName>
        <field>isResetPassword__c</field>
        <literalValue>0</literalValue>
        <name>IsResetPasswordFalse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Doctor%3A Reset Password</fullName>
        <actions>
            <name>Reset_Password_Doctor_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>IsResetPasswordFalse</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Doctor__c.isResetPassword__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
