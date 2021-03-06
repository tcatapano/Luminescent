<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:lmnl="http://lmnl-markup.net/ns/xproc-extensions"
  name="LMNL-wf-check" type="lmnl:LMNL-wf-check">

  <p:import href="LMNL-xLMNL.xpl"/>

  <p:option name="lmnl-file" required="true"/>
  
  <p:input port="source"/>

  <p:input kind="parameter" port="parameters" primary="true"/>
  
  <!--<p:output port="raw-svrl" primary="false">
    <p:pipe port="report" step="validate-wf-tagging"/>
  </p:output>-->

  <p:serialization port="wf-check" method="text"
    omit-xml-declaration="true" indent="false"/>
  
  <p:output port="wf-check" primary="true">
    <p:pipe port="result" step="wf-report"/>
  </p:output>
  
  <lmnl:LMNL-xLMNL name="xLMNL">
    <p:input port="source">
      <p:inline><lmnl><!-- dummy document --></lmnl></p:inline>
    </p:input>
    <p:with-option name="lmnl-file" select="$lmnl-file"/>
  </lmnl:LMNL-xLMNL>
  
  <p:sink/>
  
  <p:validate-with-schematron assert-valid="false"
    name="validate-tags">
    <p:input port="source">
      <p:pipe port="step3-tag-sawteeth" step="xLMNL"/>
    </p:input>
    <p:input port="schema">
      <p:document href="lib/wf-check/validate-tags.sch"/>
    </p:input>
  </p:validate-with-schematron>
  
  <p:sink/>
  
  <p:validate-with-schematron assert-valid="false"
    name="validate-typing">
    <p:input port="source">
      <p:pipe port="step7-infer-annotations" step="xLMNL"/>
    </p:input>
    <p:input port="schema">
      <p:document href="lib/wf-check/validate-typing.sch"/>
    </p:input>
  </p:validate-with-schematron>
 
  <p:sink/>
  
  <!-- =================================================== -->

  <p:wrap-sequence name="validate-wf-tagging" wrapper="svrl">
    <p:input port="source">
      <p:pipe port="report" step="validate-tags"/>
      <p:pipe port="report" step="validate-typing"/>
    </p:input>
  </p:wrap-sequence>
  
<!--  <p:identity name="wf-report"/>-->
  
  <p:xslt name="wf-report" version="2.0">
    <p:input port="stylesheet">
      <p:document href="lib/support/svrl-plaintext.xsl"/>
    </p:input>
  </p:xslt>

</p:declare-step>
