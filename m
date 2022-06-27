Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82591C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 16:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiF0QLZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiF0QLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:11:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8A14006;
        Mon, 27 Jun 2022 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656346281; x=1687882281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nuW/Nl3Rprk95o9e3+rgXmx/Ru5jeKTj43CR1+bei/4=;
  b=iylWxZJplG44A3EvJtpNcPUW5cGVhTI9RH19WCB2qUosFcjPwK7X55kh
   IjWjVKy7SnsYVL4Sr0L+kDRpL6RHquEoQ37s21OOc4AwLJSqPwnfl97jw
   eYajqJpixXm+DlQTP+Cz4m0p7IycIStWUD3mhNEBAHC1Nn8hyr2fBJbOp
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jun 2022 09:11:21 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:11:21 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 09:11:21 -0700
Date:   Mon, 27 Jun 2022 09:11:20 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     David Heidelberg <david@ixit.cz>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <~okias/devicetree@lists.sr.ht>,
        Robert Marko <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: extend scm compatible strings
Message-ID: <20220627161119.GA6690@quicinc.com>
References: <20220626114634.90850-1-david@ixit.cz>
 <20220626114634.90850-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220626114634.90850-2-david@ixit.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 26 2022 13:46, David Heidelberg wrote:
> Follow scheme where device specific compatible is first,
> then general compatible string.
> 
> Cc: Robert Marko <robimarko@gmail.com>
> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
