Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2033C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 04:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiFGEiU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 00:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiFGEiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:38:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543EE2126A;
        Mon,  6 Jun 2022 21:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654576692; x=1686112692;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=BLQzm4ANOPyOqQWpgZxl6tFyVP4G/i6sNgt5raxU3t4=;
  b=FsgNdOUpFB7SjkksjtiVnIn3fvTG7Q5T6wBT2D6TvM7eg6yUVgjtPHYy
   32VQGlQpxpAsA6/GN7Aj3KWiRW/2cxDzV6oZLOT/XvJmQrJwr+LZx3qx1
   fYbYqCVmREujn8pdTE21DRmxBAMI+LyrxfnMuazwCBDg3W0f1Xl6T0/fI
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2022 21:38:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 21:38:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 21:38:10 -0700
Received: from [10.50.51.61] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 21:38:06 -0700
Message-ID: <29289523-6779-9a57-8dea-f6108b362062@quicinc.com>
Date:   Tue, 7 Jun 2022 10:08:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv15 5/9] lib: Add register read/write tracing support
Content-Language: en-US
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <quic_psodagud@quicinc.com>, <quic_tsoni@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>
References: <cover.1652891705.git.quic_saipraka@quicinc.com>
 <f6d1b9e9d70968b506bdfd1b77129cb751b9df9d.1652891705.git.quic_saipraka@quicinc.com>
 <5544ba12-8a7a-3bc5-1416-c8c707500c9d@quicinc.com>
In-Reply-To: <5544ba12-8a7a-3bc5-1416-c8c707500c9d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 5/24/2022 9:29 AM, Sai Prakash Ranjan wrote:
> Hi Steve,
>
> On 5/18/2022 10:14 PM, Sai Prakash Ranjan wrote:
>> From: Prasad Sodagudi <psodagud@codeaurora.org>
>>
>> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
>> are typically used to read/write from/to memory mapped registers
>> and can cause hangs or some undefined behaviour in following few
>> cases,
>>
<snip>...
> How does this version look?
>

Gentle ping!!

Thanks,
Sai
