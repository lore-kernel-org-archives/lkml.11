Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 07:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiESHXS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiESHXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:23:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04F7E1C0;
        Thu, 19 May 2022 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652944988; x=1684480988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxbLuMz58MBE06mxZyfDaoaxhC1jJmaC+aMjMGLGOes=;
  b=Fb+vtBHZWM4YcRxRuomea4EyeoktSQhtNTu6S6u95bMcXpJNUQWve982
   3lDw3qRs2pNgIkpYY016g0Ogr6457iqIKdFokBclnZBtSF+8qZUR69SnY
   bqiaIO9GVI4wvR0+rCxDbv5MDZcZCtSMr2h+6lw/vj8veEqVhzgs52gy/
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 00:23:08 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:23:07 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 00:23:05 -0700
Date:   Thu, 19 May 2022 15:23:02 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <mst@redhat.com>,
        <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, <jasowang@redhat.com>,
        <robh+dt@kernel.org>, <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220519071958.GA24236@mingxue-gv.qualcomm.com>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
 <20220329074610.GA20342@mingxue-gv.qualcomm.com>
 <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:31AM +0200, Krzysztof Kozlowski wrote:
> On 29/03/2022 09:46, Minghao Xue wrote:
> > On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> >>> Some systems want to set the interrupt of virtio_mmio device
> >>> as a wakeup source. On such systems, we'll use the existence
> >>> of the "wakeup-source" property as a signal of requirement.
> >>>
> >>> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> >>
> >> I don't have enough of a clue about dt to review this.
> >> Pls get some acks from people with DT expertise.
> >>
> > Hi Michael,
> > I had a discussion with Krzysztof on the first version of patch. And we've
> > got aligned. 
> > 
> 
> I thought I reviewed this and provided an ack, but apparently I did not.
> Sorry for late response.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Hi Michael and Jason,
As this patch has been reviewed by Krzysztof. Would you help upstream
these two patches? And is there any progress on it?

Regards,
Minghao
